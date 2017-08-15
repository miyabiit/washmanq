require "rails_helper"

RSpec.describe FaxMailer, type: :mailer do
  describe '#receive' do
    context 'simple mail' do
      it do
        FaxMailer.receive(File.read(Rails.root.join('spec', 'data', 'simple_mail.eml').to_s))

        expect(MailInfo.count).to eq(1)
        expect(MailFile.count).to eq(0)
      end
    end

    context 'mail with attachment' do
      it do
        FaxMailer.receive(File.read(Rails.root.join('spec', 'data', 'mail_with_attachments.eml').to_s))

        expect(MailInfo.count).to eq(1)
        expect(MailFile.count).to eq(2)
      end
    end
  end
end
