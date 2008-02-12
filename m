From: Erik Slagter <erik@slagter.name>
Subject: Re: event devices not released
Date: Tue, 12 Feb 2008 12:27:00 +0100
Message-ID: <47B18284.3020209@slagter.name>
References: <47B043ED.3020309@slagter.name> <Pine.LNX.4.64.0802112245290.7699@twin.jikos.cz> <47B1626A.6000507@slagter.name> <Pine.LNX.4.64.0802121151010.7699@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070900050003000204010008"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eriks.xs4all.nl ([83.160.41.216]:39127 "EHLO eriks.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbYBLL1D (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Feb 2008 06:27:03 -0500
In-Reply-To: <Pine.LNX.4.64.0802121151010.7699@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-input@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070900050003000204010008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jiri Kosina wrote:
> On Tue, 12 Feb 2008, Erik Slagter wrote:
> 
>> Negative ;-)
>> A few moments ago I rebooted with HAL disabled and without going into X. I
>> unplugged the hub that has the mouse and keyboard attached and plugged it back
>> in again, a few times. Once again every time higher event handlers were
>> assigned.
> 
> That is OK. But you shouldn't run into the situation when you run out of 
> the free evdev devices.

I was under the impression that increasing event device handlers implied 
that it would run out of them eventually.

Are you saying that event handlers are normally ever increasing and that 
they are being reused when the upper limit has been reached?

In that case I'd probably best test this with a decreased EVDEV_MINORS 
value.

How is hald triggering the out-of-devices condition then? Do you mean 
that if the condition occurs, restarting hald would free up the 
"removed" event devices?

--------------ms070900050003000204010008
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJUTCC
AwMwggJsoAMCAQICEDGJsD9UPajwBl+GeyaBWA0wDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDkxNzEwMzAwM1oX
DTA4MDkxNjEwMzAwM1owajEQMA4GA1UEBBMHU2xhZ3RlcjEVMBMGA1UEKhMMRXJpayBNYXJ0
aWpuMR0wGwYDVQQDExRFcmlrIE1hcnRpam4gU2xhZ3RlcjEgMB4GCSqGSIb3DQEJARYRZXJp
a0BzbGFndGVyLm5hbWUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC4bkf+nXAx
akUjjwscSMjaKSUFQiJPxTgOUEh+uKVsBVGvY7CB8XcCmU7+oO1s9NaTL7BVy7Lwpj5SJV/B
v8gZWrHwsR3D7U2rcKUW81v7dkTu9GTAUt5Qc8b7+GehjZuZKZPjMdH6vJK9G7YnZu1gG9b0
CoEC4jOdIR4+4di2ZUN9M5JLlVKofOP4fo8MKFny88ThmxHLGzzQGsshfs7wuYB2hivouPCf
kmc+tnTI90mLrV748Yc6M9gq1brUajcy+tL0wdTS0NOJ2FVa/0HFlxaMrt88nko2J7wA+yPM
RY1L+ziU+Qr45JxoCE6pI/6lZNlMtHeYvdveQZs/3n5HAgMBAAGjLjAsMBwGA1UdEQQVMBOB
EWVyaWtAc2xhZ3Rlci5uYW1lMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAZrik
whMvx+aaj7gXQDVuy+zs7eqq1zJilrNS1130Hrq0JeLC6Rnl6a1gE52gap2O6uLyfpdGBmXu
loCzA9OPYKcZT6EtcZKF3+TCP0m9L3G1scQPPrxZt/oA4uZ4MDTvLElPJH2ONOvCoRPrp5aD
YHD5NlsDjs+kG6559873oTwwggMDMIICbKADAgECAhAxibA/VD2o8AZfhnsmgVgNMA0GCSqG
SIb3DQEBBQUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAo
UHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QTAeFw0wNzA5MTcxMDMwMDNaFw0wODA5MTYxMDMwMDNaMGoxEDAOBgNVBAQTB1NsYWd0ZXIx
FTATBgNVBCoTDEVyaWsgTWFydGlqbjEdMBsGA1UEAxMURXJpayBNYXJ0aWpuIFNsYWd0ZXIx
IDAeBgkqhkiG9w0BCQEWEWVyaWtAc2xhZ3Rlci5uYW1lMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAuG5H/p1wMWpFI48LHEjI2iklBUIiT8U4DlBIfrilbAVRr2OwgfF3AplO
/qDtbPTWky+wVcuy8KY+UiVfwb/IGVqx8LEdw+1Nq3ClFvNb+3ZE7vRkwFLeUHPG+/hnoY2b
mSmT4zHR+rySvRu2J2btYBvW9AqBAuIznSEePuHYtmVDfTOSS5VSqHzj+H6PDChZ8vPE4ZsR
yxs80BrLIX7O8LmAdoYr6Ljwn5JnPrZ0yPdJi61e+PGHOjPYKtW61Go3MvrS9MHU0tDTidhV
Wv9BxZcWjK7fPJ5KNie8APsjzEWNS/s4lPkK+OScaAhOqSP+pWTZTLR3mL3b3kGbP95+RwID
AQABoy4wLDAcBgNVHREEFTATgRFlcmlrQHNsYWd0ZXIubmFtZTAMBgNVHRMBAf8EAjAAMA0G
CSqGSIb3DQEBBQUAA4GBAGa4pMITL8fmmo+4F0A1bsvs7O3qqtcyYpazUtdd9B66tCXiwukZ
5emtYBOdoGqdjuri8n6XRgZl7paAswPTj2CnGU+hLXGShd/kwj9JvS9xtbHEDz68Wbf6AOLm
eDA07yxJTyR9jjTrwqET66eWg2Bw+TZbA47PpBuueffO96E8MIIDPzCCAqigAwIBAgIBDTAN
BgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTES
MBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UE
CxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0
aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMC
WkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GN
ADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAK
MNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYB
Af8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBl
cnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYD
VQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2as
Zw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSe
JVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHT
HUb/XV9lTzGCA2QwggNgAgEBMHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAhAxibA/VD2o8AZfhnsmgVgNMAkGBSsOAwIaBQCgggHDMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDIxMjExMjcwMFowIwYJKoZI
hvcNAQkEMRYEFAiI0X4v0RU2m+4Z2FbcUNGkSGXZMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZI
hvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3
DQMCAgEoMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJl
ZW1haWwgSXNzdWluZyBDQQIQMYmwP1Q9qPAGX4Z7JoFYDTCBhwYLKoZIhvcNAQkQAgsxeKB2
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQMYmwP1Q9
qPAGX4Z7JoFYDTANBgkqhkiG9w0BAQEFAASCAQCuGrcH7pbWJFRatZQD6FjGhn6dfhve4SBL
byzAHFxA4K9qQdqXm8XPsvnfWlSR99fUudqSgGAL1QHjNOrGP3G190dy4TCrunWz69bEq+Mp
ZmE5qsLIyb8yLX1oRdh/zdnoi6Hs3gymMTgqv9oYTmL1sgNgNTOB3Y7A/wjowzmpFV2zrFVa
Yn1i333S7ocaEtn8lDmyigdKypeig/s/SEU7/JJAn75vgfRLIZgFEeRnHZiimbmy3pWCpsK/
uXb2R9KaJihpT6pwglSACyHYmqe3qnb20LFQh3NWi9BM+kjSmzS3JZTun9FdbBpKjGVTYwlz
QYTvteL7PU3USrtQIk+/AAAAAAAA
--------------ms070900050003000204010008--
