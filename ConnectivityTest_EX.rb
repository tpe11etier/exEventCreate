require "rest_client"
require "logger"

FILE = open('output.log', File::WRONLY | File::APPEND | File::CREAT)
LOGGER = Logger.new(FILE)
LOGGER.level = Logger::DEBUG

#Dev URL
#URL = "https://developer3.envoyww.com/ea/bin/pwisapi.dll"
#New Prod URL
URL = "https://xpress-api.vrli.com/mb/bin/pwisapi.dll"

#Embedded XML to send for submission.
XML = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>
<Request errorstyle=\"separate\" version=\"EXAPI 2.0\" prunelist=\"//DeliveryBlock,//Sequence,//Block,//DeliveryRequest,//Contact\">
  <domain>EA</domain>
  <username>EXCHANGEtarget</username>
  <password>EXCHANGEtarget</password>
  <oemid>xxx</oemid>
  <oempassword>xxx</oempassword>
  <requestType>Commit</requestType>
  <Job><UserReference>775847</UserReference>
    <Message>
      <subject><![CDATA[Testing Profiles API Connectivity]]></subject>
      <MessageArg>
        <Name>EMAIL_ADDR</Name>
        <Ordinal>0</Ordinal>
        <Value>support@varolii.com</Value>
      </MessageArg>
      <MessageArg>
        <Name>BODY</Name>
        <Ordinal>0</Ordinal>
        <Value>This is just a test.</Value>
      </MessageArg>
      <MessageArg>
        <Name>PRE_THEME</Name>
        <Value>EXCHANGE:general;EXCHANGE:;VOICETALENT:DAVID;SON:M_ENG_4</Value>
      </MessageArg>
      <MessageArg>
        <Name><![CDATA[THEME]]></Name>
        <Value><![CDATA[EXCHANGE:general;EXCHANGE:;VOICETALENT:DAVID;SON:M_ENG_4;NotifyApp\EXCHANGE\EXCHANGE\general;NotifyApp\EXCHANGE\EXCHANGE;NotifyApp\EXCHANGE;NotifyApp]]></Value>
      </MessageArg>
      <MessageArg>
        <Name>SENDER</Name>
        <Value>Varolii</Value>
      </MessageArg>
    </Message>
    <Contact Label=\"7419868\">
      <FirstName><![CDATA[Professional]]></FirstName>
      <LastName><![CDATA[Services Admin]]></LastName>
      <Company><![CDATA[Varolii Corporation]]></Company>
      <ContactMethod Label=\"19453943\">
        <Transport>email</Transport>
        <Ordinal>0</Ordinal>
        <Qualifier>office</Qualifier>
        <EmailAddress><![CDATA[BC_Postmaster@varolii.com]]></EmailAddress>
      </ContactMethod>
    </Contact>
    <Block>
      <DeliveryRequest>
        <MessagePath>Message[1]</MessagePath>
        <ContactMethodPath>Contact[@Label=\"7419868\"]/ContactMethod[@Label=\"19453943\"]</ContactMethodPath>
        <DeliveryRequestArg>
          <Name><![CDATA[USER_USERIDENTIFIER]]></Name>
          <Value><![CDATA[2181]]></Value>
          <Ordinal>0</Ordinal>
        </DeliveryRequestArg>
        <DeliveryRequestArg>
          <Name><![CDATA[Role]]></Name>
          <Value><![CDATA[Private]]></Value>
          <Ordinal>0</Ordinal>
        </DeliveryRequestArg>
      </DeliveryRequest>
    </Block>
  </Job>
</Request>"


def ex_event_create
  RestClient.post( URL,
                    {
                        :PWFORM => '38',
                        :PWF_MBML => XML,
                        :multipart => true
                    }
  )
end



if __FILE__ == $0
  begin
    response = ex_event_create
    #I'm starting at character 464 to exclude the creds.
    LOGGER.debug {response[464..-1]}
    LOGGER.debug {"SUCCESS:  Event sent successfully."}
    puts response[464..-1]
    puts "SUCCESS Event sent successfully."
  rescue => fault
    LOGGER.debug {"ERROR: An error has occurred: " + fault.to_s}
    puts fault
  end
  LOGGER.close

end