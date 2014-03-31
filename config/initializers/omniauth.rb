Rails.application.config.middleware.use OmniAuth::Builder do
    provider :saml,
       :assertion_consumer_service_url     => "http://localhost:3000.com/auth/saml/callback/",
       :issuer                             => "Innovation Platform Initiative",
       :idp_sso_target_url                 => "https://thoughtworks.oktapreview.com/app/template_saml_2_0/k24bmo43RKFXFPLQGFJU/sso/saml",
       :idp_cert                           => "MIICozCCAgygAwIBAgIGAT+fauIOMA0GCSqGSIb3DQEBBQUAMIGUMQswCQYDVQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDHRob3VnaHR3b3JrczEcMBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTAeFw0xMzA3MDIxMjQ0NDlaFw00MzA3MDIxMjQ1NDlaMIGUMQswCQYDVQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEUMBIGA1UECwwLU1NPUHJvdmlkZXIxFTATBgNVBAMMDHRob3VnaHR3b3JrczEcMBoGCSqGSIb3DQEJARYNaW5mb0Bva3RhLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAkAYqmCS63DBsav/zhCMNW38JQxW4hNgO15DCo2RvnkEN1jDK+pnAlRu6pGKJmpvVVx3K0zgSxNBMXFvWCPfWdk1RaRoo+P/4pcMBAry/ysbVAJ3r1tpUuP9nMt4zuGkwL+TpnFUKVsS690fwID+mRydxAb1hTa3EcG5gXdu7pD0CAwEAATANBgkqhkiG9w0BAQUFAAOBgQAXWO+wxM6WSZ6MTZvdh2g1wF0dGvZhS5LO3q2PUvq4qHx1SchiKbxje+CUHCqOOODOjQeD+SVcUBUPJ8I9OWi9aDiQjKnmpr87h8PH+Ni1yB2C2KRHdxxSR6SfRjkyNeVEwzTyh2Y2zu+hghddKvllWQoSfwXhIcSrLKtsL71NrQ==",
       :idp_cert_fingerprint               => "D6:7F:A3:16:43:DF:5A:CA:5B:81:4C:4C:B4:4B:DB:D2:57:36:F0:AD",
       :name_identifier_format             => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
end
