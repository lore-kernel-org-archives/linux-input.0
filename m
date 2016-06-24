From: Dennis Chen <barracks510@gmail.com>
Subject: Re: [PATCH] HID: multitouch: add support for Type Cover Pro 3
Date: Thu, 23 Jun 2016 20:38:10 -0700
Message-ID: <1466739490.3464.8.camel@gmail.com>
References: <1466196443.21223.1.camel@gmail.com>
	 <alpine.LNX.2.00.1606172259110.6874@cbobk.fhfr.pm>
	 <20160617211142.GH24234@mail.corp.redhat.com>
	 <1466275994.2669.11.camel@gmail.com>
	 <20160618194534.GI24234@mail.corp.redhat.com>
	 <1466369282.15726.7.camel@gmail.com>
	 <20160620095934.GN24234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha-512";
	protocol="application/x-pkcs7-signature";
	boundary="=-ZszYGVyEexvvvy7MMmAL"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:34181 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbcFXDiY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 23:38:24 -0400
Received: by mail-oi0-f43.google.com with SMTP id s66so99171239oif.1
        for <linux-input@vger.kernel.org>; Thu, 23 Jun 2016 20:38:23 -0700 (PDT)
In-Reply-To: <20160620095934.GN24234@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org


--=-ZszYGVyEexvvvy7MMmAL
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0P+NOkDBn3YxCx7QECTa"


--=-0P+NOkDBn3YxCx7QECTa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-06-20 at 11:59 +0200, Benjamin Tissoires wrote:
> Could you send the dmesg after disconnet/reconnect
> and some hid-recorder[1] trace after re-attaching the device when
> the keyboard is not working?
>=20

I've noticed that the problem resolves itself after a while. Here are
the relevant dmseg lines.

---SNIP--
[ 2409.650260] usb 1-3: new full-speed USB device number 16 using xhci_hcd
[ 2409.815845] usb 1-3: New USB device found, idVendor=3D045e, idProduct=3D=
07dc
[ 2409.815853] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[ 2409.815858] usb 1-3: Product: Surface Type Cover
[ 2409.815861] usb 1-3: Manufacturer: Microsoft
[ 2409.815864] usb 1-3: SerialNumber: 041396550454
[ 2419.823679] hid-multitouch 0003:045E:07DC.0012: usb_submit_urb(ctrl) fai=
led: -1
[ 2419.823710] hid-multitouch 0003:045E:07DC.0012: timeout initializing rep=
orts
[ 2419.824295] input: Microsoft Surface Type Cover Keyboard as /devices/pci=
0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0012/input/input179
[ 2419.875399] input: Microsoft Surface Type Cover Consumer Control as /dev=
ices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0012/input/inp=
ut181
[ 2419.875837] input: Microsoft Surface Type Cover Touchpad as /devices/pci=
0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0012/input/input183
[ 2419.876411] hid-multitouch 0003:045E:07DC.0012: input,hiddev0,hidraw4: U=
SB HID v1.11 Keyboard [Microsoft Surface Type Cover] on usb-0000:00:14.0-3/=
input0
[ 2419.876641] usb 1-3: USB disconnect, device number 16
[ 2419.934821] hid-multitouch 0003:045E:07DC.0012: usb_submit_urb(ctrl) fai=
led: -19
[ 2420.191569] usb 1-3: new full-speed USB device number 17 using xhci_hcd
[ 2420.356899] usb 1-3: New USB device found, idVendor=3D045e, idProduct=3D=
07dc
[ 2420.356902] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[ 2420.356903] usb 1-3: Product: Surface Type Cover
[ 2420.356904] usb 1-3: Manufacturer: Microsoft
[ 2420.356905] usb 1-3: SerialNumber: 041396550454
[ 2430.361044] hid-multitouch 0003:045E:07DC.0013: usb_submit_urb(ctrl) fai=
led: -1
[ 2430.361072] hid-multitouch 0003:045E:07DC.0013: timeout initializing rep=
orts
[ 2430.361967] input: Microsoft Surface Type Cover Keyboard as /devices/pci=
0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0013/input/input195
[ 2430.414002] input: Microsoft Surface Type Cover Consumer Control as /dev=
ices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0013/input/inp=
ut197
[ 2430.414356] input: Microsoft Surface Type Cover Touchpad as /devices/pci=
0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0013/input/input199
[ 2430.415114] hid-multitouch 0003:045E:07DC.0013: input,hiddev0,hidraw4: U=
SB HID v1.11 Keyboard [Microsoft Surface Type Cover] on usb-0000:00:14.0-3/=
input0
[ 2430.415365] usb 1-3: USB disconnect, device number 17
[ 2430.457425] hid-multitouch 0003:045E:07DC.0013:=C2=A0usb_submit_urb(ctrl=
)
failed: -19
[ 2430.714979] usb 1-3: new full-speed USB device number 18 using xhci_hcd
[ 2430.880521] usb 1-3: New USB device found, idVendor=3D045e, idProduct=3D=
07dc
[ 2430.880528] usb 1-3: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[ 2430.880532] usb 1-3: Product: Surface Type Cover
[ 2430.880534] usb 1-3: Manufacturer: Microsoft
[ 2430.880537] usb 1-3: SerialNumber: 041396550454
[ 2434.993319] input: Microsoft Surface Type Cover Keyboard as /devices/pci=
0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0014/input/input211
[ 2435.045167] input: Microsoft Surface Type Cover Consumer Control as /dev=
ices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0014/input/inp=
ut213
[ 2435.045506] input: Microsoft Surface Type Cover Touchpad as /devices/pci=
0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0014/input/input215
[ 2435.046174] hid-multitouch 0003:045E:07DC.0014: input,hiddev0,hidraw4: U=
SB HID v1.11 Keyboard [Microsoft Surface Type Cover] on usb-0000:00:14.0-3/=
input0
---END---

Hopefully this is helpful. I've looked at the your patch, and - as
you've mentioned - have no idea why this only occurs with your patch.=C2=A0

Sincerely,
Dennis Chen
--=-0P+NOkDBn3YxCx7QECTa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABEKAAYFAldsqyMACgkQpXlhF/qpw/lL/gCZASgJUWtfnxDwCDZFR4RJOUv9
N90AoLlv6Rx2dyXdsQessg7KxvXhQRU6
=66d+
-----END PGP SIGNATURE-----

--=-0P+NOkDBn3YxCx7QECTa--

--=-ZszYGVyEexvvvy7MMmAL
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCCEpow
ggYtMIIFFaADAgECAgMQDUswDQYJKoZIhvcNAQELBQAwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQK
Ew1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWdu
aW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVu
dCBDQTAeFw0xNTExMTEyMTQzMDFaFw0xNjExMTEwNjMxNDZaMEYxHjAcBgNVBAMMFWJhcnJhY2tz
NTEwQGdtYWlsLmNvbTEkMCIGCSqGSIb3DQEJARYVYmFycmFja3M1MTBAZ21haWwuY29tMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtUHVaynx14U0iy8HenmG993oaTFzZ/OfQ0zoqsQl
MUt3XYwz9OdMG+UJq7+ilA2NSPzYnOBqJr0nYVlkX+cQpVlP2+/AtJ5bB/ScugNTOYn4cLqdc8ki
sAy+zNAPCwaF3Jrn16KxU7ufLut6kD56Nr8lX3/vD3XkPBbP3sn5wBEOV2u5NruJ/iS3/augzcww
vm5HSnH/JJ3rZNQ83lxyE5Nu0N7BW0FJ4CioavdhzN8bjvAfV7JM6CjcsTlujlrZYGKI/ByJuaUG
MduXhb/3H9UPtsvpQ/PLdlzpj9z4DVnJMtWQPJ3JM26d4ObmuYq8tk3nxnDwDG7HooF/k2VHYwID
AQABo4IC2zCCAtcwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIG
CCsGAQUFBwMEMB0GA1UdDgQWBBSph2B2A/xOxyzrDpSUkPUU8CqJpjAfBgNVHSMEGDAWgBRTcu2S
nODaywFcfH6WNU7y1LhRgjAgBgNVHREEGTAXgRViYXJyYWNrczUxMEBnbWFpbC5jb20wggFMBgNV
HSAEggFDMIIBPzCCATsGCysGAQQBgbU3AQIDMIIBKjAuBggrBgEFBQcCARYiaHR0cDovL3d3dy5z
dGFydHNzbC5jb20vcG9saWN5LnBkZjCB9wYIKwYBBQUHAgIwgeowJxYgU3RhcnRDb20gQ2VydGlm
aWNhdGlvbiBBdXRob3JpdHkwAwIBARqBvlRoaXMgY2VydGlmaWNhdGUgd2FzIGlzc3VlZCBhY2Nv
cmRpbmcgdG8gdGhlIENsYXNzIDEgVmFsaWRhdGlvbiByZXF1aXJlbWVudHMgb2YgdGhlIFN0YXJ0
Q29tIENBIHBvbGljeSwgcmVsaWFuY2Ugb25seSBmb3IgdGhlIGludGVuZGVkIHB1cnBvc2UgaW4g
Y29tcGxpYW5jZSBvZiB0aGUgcmVseWluZyBwYXJ0eSBvYmxpZ2F0aW9ucy4wNgYDVR0fBC8wLTAr
oCmgJ4YlaHR0cDovL2NybC5zdGFydHNzbC5jb20vY3J0dTEtY3JsLmNybDCBjgYIKwYBBQUHAQEE
gYEwfzA5BggrBgEFBQcwAYYtaHR0cDovL29jc3Auc3RhcnRzc2wuY29tL3N1Yi9jbGFzczEvY2xp
ZW50L2NhMEIGCCsGAQUFBzAChjZodHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zdWIuY2xh
c3MxLmNsaWVudC5jYS5jcnQwIwYDVR0SBBwwGoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMA0G
CSqGSIb3DQEBCwUAA4IBAQCIDk1zzs0LWnAI1exQQZWoJosQPN99h91Es4Bs5jx2d2OhY34EEI9b
B5qz7n7yI/7nWIkBOmmsAOtj4FVJFHk1SL9yJ1HuuhWMbaAjwjPlm0M8AHq1n1qBHozus0EMPFrv
DK6Hf5uZGqsPfEZ2DUCXxXUXxjWzbzL5LLIMdn6O2cz0X4FrFJAnDgxvGw2m819YBFp9FPn4hIWV
Cj3fwQxu1RntQa4nIbofKq4WPJk8jK77S3daV4vc1BtKNOlX9uxegdc8xPAhVpFYeKgzejMR3ho+
BgNyPffd/l02O/RYxx3RMP4OmADnZPUN5Xg/he7AIweCv47JAkqgNSMwIz9cMIIGLTCCBRWgAwIB
AgIDEA1LMA0GCSqGSIb3DQEBCwUAMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20g
THRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UE
AxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwHhcNMTUx
MTExMjE0MzAxWhcNMTYxMTExMDYzMTQ2WjBGMR4wHAYDVQQDDBViYXJyYWNrczUxMEBnbWFpbC5j
b20xJDAiBgkqhkiG9w0BCQEWFWJhcnJhY2tzNTEwQGdtYWlsLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBALVB1Wsp8deFNIsvB3p5hvfd6Gkxc2fzn0NM6KrEJTFLd12MM/TnTBvl
Cau/opQNjUj82Jzgaia9J2FZZF/nEKVZT9vvwLSeWwf0nLoDUzmJ+HC6nXPJIrAMvszQDwsGhdya
59eisVO7ny7repA+eja/JV9/7w915DwWz97J+cARDldruTa7if4kt/2roM3MML5uR0px/ySd62TU
PN5cchOTbtDewVtBSeAoqGr3YczfG47wH1eyTOgo3LE5bo5a2WBiiPwcibmlBjHbl4W/9x/VD7bL
6UPzy3Zc6Y/c+A1ZyTLVkDydyTNuneDm5rmKvLZN58Zw8Axux6KBf5NlR2MCAwEAAaOCAtswggLX
MAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAd
BgNVHQ4EFgQUqYdgdgP8Tscs6w6UlJD1FPAqiaYwHwYDVR0jBBgwFoAUU3Ltkpzg2ssBXHx+ljVO
8tS4UYIwIAYDVR0RBBkwF4EVYmFycmFja3M1MTBAZ21haWwuY29tMIIBTAYDVR0gBIIBQzCCAT8w
ggE7BgsrBgEEAYG1NwECAzCCASowLgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wuY29t
L3BvbGljeS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBpc3N1ZWQgYWNjb3JkaW5nIHRvIHRo
ZSBDbGFzcyAxIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9mIHRoZSBTdGFydENvbSBDQSBwb2xp
Y3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBwdXJwb3NlIGluIGNvbXBsaWFuY2Ug
b2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6
Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUxLWNybC5jcmwwgY4GCCsGAQUFBwEBBIGBMH8wOQYIKwYB
BQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIvY2xhc3MxL2NsaWVudC9jYTBCBggr
BgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvc3ViLmNsYXNzMS5jbGllbnQu
Y2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tLzANBgkqhkiG9w0BAQsF
AAOCAQEAiA5Nc87NC1pwCNXsUEGVqCaLEDzffYfdRLOAbOY8dndjoWN+BBCPWweas+5+8iP+51iJ
ATpprADrY+BVSRR5NUi/cidR7roVjG2gI8Iz5ZtDPAB6tZ9agR6M7rNBDDxa7wyuh3+bmRqrD3xG
dg1Al8V1F8Y1s28y+SyyDHZ+jtnM9F+BaxSQJw4MbxsNpvNfWARafRT5+ISFlQo938EMbtUZ7UGu
JyG6HyquFjyZPIyu+0t3WleL3NQbSjTpV/bsXoHXPMTwIVaRWHioM3ozEd4aPgYDcj333f5dNjv0
WMcd0TD+DpgA52T1DeV4P4XuwCMHgr+OyQJKoDUjMCM/XDCCBjQwggQcoAMCAQICAR4wDQYJKoZI
hvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsT
IlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENl
cnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3MTAyNDIxMDE1NVoXDTE3MTAyNDIxMDE1NVowgYwx
CzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1h
cnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AMcJg8zOLdgasSmkLhOrlr6KMoOMpohBllVHrdRvEg/q6r8jR+EK75xCGhR8ToREoqe7zM9/UnC6
TS2y9UKTpT1v7RSMzR0t6ndl0TWBuUr/UXBhPk+Kmy7bI4yW4urC+y7P3/1/X7U8ocb8VpH/Clt+
4iq7nirMcNh6qJR+xjOhV+VHzQMALuGYn5KZmc1NbJQYclsGkDxDz2UbFqE2+6vIZoL+jb9x4Pa5
gNf1TwSDkOkikZB1xtB4ZqtXThaABSONdfmv/Z1pua3FYxnCFmdr/+N2JLKutIxMYqQOJebr/f/h
5t95m4JgrM3Y/w7YX9d7YAL9jvN4SydHsU6n65cCAwEAAaOCAa0wggGpMA8GA1UdEwEB/wQFMAMB
Af8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRTcu2SnODaywFcfH6WNU7y1LhRgjAfBgNVHSME
GDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRaMFgwJwYIKwYBBQUHMAGGG2h0
dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYhaHR0cDovL3d3dy5zdGFydHNz
bC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6Ly93d3cuc3RhcnRzc2wuY29t
L3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2ZzY2EuY3JsMIGABgNV
HSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wu
Y29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2ludGVy
bWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBAAqDCH14qywGXLhjjF6uHLkjd02hcdh9hrw+
VUsv+q1eeQWB21jWj3kJ96AUlPCoEGZ/ynJNScWy6QMVQjbbMXltUfO4n4bGGdKo3awPWp61tjAF
graLJgDk+DsSvUD6EowjMTNx25GQgyYJ5RPIzKKR9tQW8gGK+2+RHxkUCTbYFnL6kl8Ch507rUdP
PipJ9CgJFws3kDS3gOS5WFMxcjO5DwKfKSETEPrHh7p5shuuNktvsv6hxHTLhiMKX893gxdT3XLS
9OKmCv87vkINQcNEcIIoFWbP9HORz9v3vQwR4e3ksLc2JZOAFK+ssS5XMEoznzpihEP0PLc4dCBY
jbvSD7kxgDwZ+Aj8Q9PkbvE9sIPP7ON0fz095HdThKjiVJe6vofq+n6b1NBc8XdrQvBmunwxD5nv
tTW4vtN6VY7mUCmxsCieuoBJ9OlqmsVWQvifIYf40dJPZkk9YgGTzWLpXDSfLSplbY2LL9C9U0pt
vjcDjefLTvqSFc7tw1sEhF0n/qpA2r0GpvkLRDmcSwVyPvmjFBGqUp/pNy8ZuPGQmHwFi2/14+xe
SUDG2bwnsYJQG2EdJCB6luQ57GEnTA/yKZSTKI8dDQa8Sd3zfXb19mOgSF0bBdXbuKhEpuP9wirs
lFe6fQ1t5j5R0xi72MZ8ikMu1RQZKCyDbMwazlHiMYIDnzCCA5sCAQEwgZQwgYwxCzAJBgNVBAYT
AklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0
aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJt
ZWRpYXRlIENsaWVudCBDQQIDEA1LMA0GCWCGSAFlAwQCAwUAoIIB2zAYBgkqhkiG9w0BCQMxCwYJ
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNjA2MjQwMzM4MTdaME8GCSqGSIb3DQEJBDFCBECE
5k7/yR/WqWcasCNrtz8T6qmx6VATxHqIIHkq1X98CJRnyzjdMH3GMAs2/dsnIFTCjwxuYOpy0czJ
fxutGjnPMIGlBgkrBgEEAYI3EAQxgZcwgZQwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFy
dENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgw
NgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQID
EA1LMIGnBgsqhkiG9w0BCRACCzGBl6CBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0
Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2
BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMQ
DUswDQYJKoZIhvcNAQEBBQAEggEABA5tD7QHoe4jqh6fGrBeNUDGxt1+gTWO+heA58JQW0WUlaLs
fqRC3Ozs/fcsWxCKcZtAayTOoZnLWP8OH7zvZE70C+D4R2YndDycdPRBs0Fpr8MpStR+aSdLhUh4
5s5DwNV/H/4hLO3zVq+wNrzys1Ps/LWNzZljWOy5iD55Md44OqkwUMvbkiOvZ2Mpotn0MT+EOmOH
iStxKET+XwlQM5zq3yH0JWDKWT1gpUiVLhO0+s3arILs1T4EJaYhN0SbQ/bk4LeCFzeZj4WmCRL9
2EGZXcKO16p77dCkFWhqPiJKES29KBBZmXsCFrpkQ+9MNQkwQaHF876N/zAavcxNzgAAAAAAAA==


--=-ZszYGVyEexvvvy7MMmAL--

