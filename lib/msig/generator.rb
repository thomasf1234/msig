require "json"

module Msig
  class Generator
    attr_reader :params

    def initialize(params)
      set_defaults(params)
      validate(params)
      @params = params
    end

    def set_defaults(params)
      params["args"] ||= []
      params["return"] ||= []
      params["exception"] ||= []
      params["examples"] ||= []
      params["deprecated"] ||= false
      params["see"] ||= []
    end

    def validate(params)
      validate_keys(params, ["name", "author", "description"])

      params["args"].each do |hash|
        validate_keys(hash, ["name", "type", "description"])
      end

      params["return"].each do |hash|
        validate_keys(hash, ["type", "description"])
      end

      params["exception"].each do |hash|
        validate_keys(hash, ["type", "reason"])
      end

      raise ArgumentError.new("see must be an array of references") unless params["see"].kind_of?(Array)
    end

    def generate
      doc = []

      doc << "==== Description"
      doc << ""
      doc << wrap(format_description(@params["description"]))
      doc << ""

      if !@params["examples"].empty?
        doc << "==== Examples"
        doc << ""

        @params["examples"].each do |example|
          doc << example
        end
        doc << ""
      end

      doc << "==== Signature"
      doc << ""

      signature_table_lines = signature_table.to_lines.map(&:strip)
      doc += signature_table_lines

      raw = doc.join($/)
      comment(raw)
    end

    private
    def validate_keys(hash, keys)
      raise ArgumentError.new("must be a hash") unless hash.kind_of?(Hash)
      keys.each do |key|
        raise ArgumentError.new("entries must include key '#{key}'") unless hash.has_key?(key)
      end
    end

    def format_description(description)
      desc = description

      if description.kind_of?(Array)
        desc = description.map(&:strip).join(" ")
      end

      desc
    end

    def signature_table
      rows = []
      rows << ["@author", @params["author"]]
      rows << ["@version", @params["version"]] if @params.has_key?("version")
      @params["args"].each_with_index do |hash, index|
        rows << ["@arg#{index+1}", "[#{hash["type"]}]", format_description(hash["description"])]
      end

      if @params["return"].one?
        hash = @params["return"].first
        rows << ["@return", "[#{hash["type"]}]", format_description(hash["description"])]
      else
        @params["return"].each_with_index do |hash, index|
          rows << ["@return#{index+1}", "[#{hash["type"]}]", format_description(hash["description"])]
        end
      end

      @params["exception"].each do |hash|
        rows << ["@exception", "[#{hash["type"]}]", format_description(hash["reason"])]
      end

      @params["see"].each do |reference|
        rows << ["@see", reference]
      end

      rows << ["@since", @params["since"]] if @params.has_key?("since")
      rows << ["@deprecated"] if @params["deprecated"] == true

      table = Table.new(" ")

      rows.each do |row|
        table.add_row(row)
      end

      table
    end

    def comment(raw)
      raw.lines.map {|line| line.insert(0, "# ")}.join
    end

    def wrap(string, indent=0, width=78, prefix="")
      indentation = " " * indent
      string.gsub(/(.{1,#{width}})(\s+|\Z)/, "#{prefix+indentation}\\1#{$/}").strip
    end
  end
end