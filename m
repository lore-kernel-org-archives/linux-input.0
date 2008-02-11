From: Erik Slagter <erik@slagter.name>
Subject: event devices not released
Date: Mon, 11 Feb 2008 13:47:41 +0100
Message-ID: <47B043ED.3020309@slagter.name>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060000000504040004070001"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eriks.xs4all.nl ([83.160.41.216]:59718 "EHLO eriks.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbYBKMzc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2008 07:55:32 -0500
Received: from artemis.slagter.name (localhost.localdomain [127.0.0.1])
	by artemis.slagter.name (Postfix) with ESMTP id 30E8E1434003
	for <linux-input@vger.kernel.org>; Mon, 11 Feb 2008 13:47:42 +0100 (CET)
Received: from [10.8.2.26] (autemslap.sys.pc.wlz.nl [10.8.2.26])
	by artemis.slagter.name (Postfix) with ESMTP
	for <linux-input@vger.kernel.org>; Mon, 11 Feb 2008 13:47:42 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060000000504040004070001
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I think I've found a bug :-/

Symptoms: when I remove (unplug) a USB keyboard or mouse, the 
corresponding event device seems to be closed but not released; when I 
plug the device back in, it gets a new input device handle. This means 
that after several suspend/resume cycles (in which it seems all usb 
devices are virtually unplugged and replugged) the kernel is out of 
event devices and complains likewise. My nice little program that 
catches specific keystrokes also stops to get any interesting events 
from that moment on. After reboot everything works again as expected.

I've seen a similar bug report on linux-kernel but it wasn't followed up 
on. Also this only mentioned problems through suspend cycles while I 
also have the problem simply plugging in and out.

Environment: linux kernel 2.6.24 vanilla on i386. The event files are 
held open by one or more processes when the devices are unplugged. 
Unfortunatly my program is not the only one that has them open, but hald 
and Xorg also have some of the devices open, so I cannot prevent this 
situation. Upon POLLERR | POLLHUP my app closes all event devices and 
rescans the /dev/input directory, this should be enough imho? I don't 
know how the other apps handle unplugging.

Please CC:

Thanks.

--------------ms060000000504040004070001
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
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDIxMTEyNDc0MVowIwYJKoZI
hvcNAQkEMRYEFDETIIIbEqV0CaipcXbosbO6FFUmMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZI
hvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3
DQMCAgEoMIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJl
ZW1haWwgSXNzdWluZyBDQQIQMYmwP1Q9qPAGX4Z7JoFYDTCBhwYLKoZIhvcNAQkQAgsxeKB2
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQMYmwP1Q9
qPAGX4Z7JoFYDTANBgkqhkiG9w0BAQEFAASCAQCA1MbbR9aHKmXqKLeQjAau705BAn2DLftt
uzxxcU3B/CFEWLiCVacYeQoOyyJ8XKInepr8CW8lvvESZHguxcB5xxX5EnmqhaRM7KA55Dyd
TZqGCKKWwzFD9rvNNWa2hU1KlvNlk/+CzHi57KSZ12AurJ8SqHVVy4CA9A194YkmI0o4poao
APsLm0B7uRXgnVzUJ2tLxFCjoYTw87lEKcpKVV0FrYYcwdv/f62iEMdDtqNzrZy4qTgHVUTY
RLPXdRy7jeGvtNH1rS2ZZgA2NVCSQMy9RMfYe8jvu3hgi71oXu/2fci/5U5Zg50iI9fhjjCW
ObqzU4ANAxjfOyaXDrS1AAAAAAAA
--------------ms060000000504040004070001--
