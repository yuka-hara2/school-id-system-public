module FileUtils
  class CsvFile
    BOM_CODE = "\xEF\xBB\xBF"
    ZERO_WITH_NON_JOINER_CODE = "\u200C"
    private_constant :BOM_CODE, :ZERO_WITH_NON_JOINER_CODE

    class << self
      def set_bom(csv_string)
        BOM_CODE + csv_string
      end

      def remove_zwnj_from_str(str)
        str.gsub(ZERO_WITH_NON_JOINER_CODE, "")
      end
    end
  end
end