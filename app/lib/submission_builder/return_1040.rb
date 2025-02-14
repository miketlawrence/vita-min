module SubmissionBuilder
  class Return1040 < SubmissionBuilder::Base
    @schema_file = File.join(Rails.root, "vendor", "irs", "unpacked", "2020v5.1", "IndividualIncomeTax", "Ind1040", "Return1040.xsd")
    @root_node = "Return"

    def root_node_attrs
      super.merge(returnVersion: "2020v5.1")
    end

    def adv_ctc_irs1040
      SubmissionBuilder::Documents::AdvCtcIrs1040.build(@submission, validate: false).as_fragment
    end

    def return_header
      SubmissionBuilder::ReturnHeader1040.build(@submission, validate: false).as_fragment
    end

    def document
      document = Nokogiri::XML::Builder.new do |xml|
        xml['efil'].Return(root_node_attrs)
      end.doc
      document.at("Return").add_child(return_header)
      document.at("Return").add_child("<ReturnData documentCnt='#{@documents.length}'></ReturnData>")
      @documents.each do |attached|
        document.at("ReturnData").add_child(send(attached))
      end
      document
    end
  end
end