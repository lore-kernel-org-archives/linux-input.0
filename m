From: Dennis Chen <barracks510@gmail.com>
Subject: Re: [PATCH] HID: multitouch: add support for Type Cover Pro 3
Date: Sat, 23 Jul 2016 15:13:39 -0500
Message-ID: <1469304819.3131.4.camel@gmail.com>
References: <1466196443.21223.1.camel@gmail.com>
	 <alpine.LNX.2.00.1606172259110.6874@cbobk.fhfr.pm>
	 <20160617211142.GH24234@mail.corp.redhat.com>
	 <1466275994.2669.11.camel@gmail.com>
	 <20160618194534.GI24234@mail.corp.redhat.com>
	 <1466369282.15726.7.camel@gmail.com>
	 <20160620095934.GN24234@mail.corp.redhat.com>
	 <1466739490.3464.8.camel@gmail.com>
	 <20160624071419.GO24234@mail.corp.redhat.com>
	 <1466840940.28419.6.camel@gmail.com>
	 <20160701145212.GA24234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha-512";
	protocol="application/x-pkcs7-signature";
	boundary="=-hgSc0ognI9UeXZygI90P"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33343 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbcGWUNu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Jul 2016 16:13:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id l9so13344974oih.0
        for <linux-input@vger.kernel.org>; Sat, 23 Jul 2016 13:13:50 -0700 (PDT)
In-Reply-To: <20160701145212.GA24234@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--=-hgSc0ognI9UeXZygI90P
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Ag6MYY3ryS4gYzKTVaij"


--=-Ag6MYY3ryS4gYzKTVaij
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


On Fri, 2016-07-01 at 16:52 +0200, Benjamin Tissoires wrote:
>=C2=A0
> I spent a good amount of time trying to figure out where the bug was,
> and I couldn't reproduce it either with uhid or even with usb_gadget.
> Even KASan doesn't gives any wrong memory access, and I can't
> understand why you get this faulty behavior.
>=20
> So I must say, I am puzzled on why you end up calling
> usbhid_init_reports() while the quirk HID_QUIRK_NO_INIT_REPORTS
> should be in place.
> Would you mind adding some printk() in hid-multitouch to dump the
> value of hdev->quirks before and after calling hid_hw_start() in
> mt_probe()?
>=20
> Also, ideally, if you could add a dump_stack() in
> drivers/hid/usbhid/hid-core.c, right before leaving
> usbhid_init_reports(), that would be awesome.
>=20

Here's a dmesg dump. It seems the quirks aren't cleared.

[    3.787730] Pre-hid_hw_start hdev->quirks: -2147483328
[    3.787731] clocksource: Switched to clocksource tsc
[    4.217617] scsi 4:0:0:0: Direct-Access     Generic- USB3.0 CRW   -SD 1.=
00 PQ: 0 ANSI: 6
[    4.218413] sd 4:0:0:0: Attached scsi generic sg2 type 0
[    5.011924] Console: switching to colour frame buffer device 270x90
[    5.030415] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    5.471214] sd 4:0:0:0: [sdc] 31116288 512-byte logical blocks: (15.9 GB=
/14.8 GiB)
[    5.474542] sd 4:0:0:0: [sdc] Write Protect is off
[    5.474547] sd 4:0:0:0: [sdc] Mode Sense: 2f 00 00 00
[    5.477097] sd 4:0:0:0: [sdc] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[    5.492349]  sdc: sdc1
[    5.494359] sd 4:0:0:0: [sdc] Attached SCSI removable disk
[    7.817402] CPU: 3 PID: 338 Comm: systemd-udevd Not tainted 4.7.0-rc7+ #=
7
[    7.817409] Hardware name: Microsoft Corporation Surface Pro 3/Surface P=
ro 3, BIOS 3.11.0850 04/07/2015
[    7.817413]  0000000000000286 000000007db35b48 ffff880145c839f8 ffffffff=
813d618f
[    7.817420]  0000000000000000 ffff880149404000 ffff880145c83a28 ffffffff=
81688b7e
[    7.817425]  ffff880145c68350 0000000000000002 ffff880149404000 ffff8800=
3fb5ad08
[    7.817430] Call Trace:
[    7.817443]  [<ffffffff813d618f>] dump_stack+0x63/0x84
[    7.817453]  [<ffffffff81688b7e>] usbhid_init_reports+0xde/0x110
[    7.817459]  [<ffffffff816890da>] usbhid_start+0x52a/0x770
[    7.817465]  [<ffffffff81686fc0>] ? hid_retry_timeout+0x60/0x60
[    7.817471]  [<ffffffff81686710>] ? usbhid_restart_out_queue+0x110/0x110
[    7.817481]  [<ffffffffa00535f5>] mt_probe+0x1b5/0x263 [hid_multitouch]
[    7.817487]  [<ffffffff8167c707>] hid_device_probe+0xd7/0x150
[    7.817492]  [<ffffffff8151cbac>] driver_probe_device+0x22c/0x440
[    7.817496]  [<ffffffff8151ce91>] __driver_attach+0xd1/0xf0
[    7.817500]  [<ffffffff8151cdc0>] ? driver_probe_device+0x440/0x440
[    7.817508]  [<ffffffff8151a4dc>] bus_for_each_dev+0x6c/0xc0
[    7.817512]  [<ffffffff8151c29e>] driver_attach+0x1e/0x20
[    7.817517]  [<ffffffff8151bce3>] bus_add_driver+0x1c3/0x280
[    7.817522]  [<ffffffffa0011000>] ? 0xffffffffa0011000
[    7.817526]  [<ffffffff8151d7e0>] driver_register+0x60/0xe0
[    7.817529]  [<ffffffffa0011000>] ? 0xffffffffa0011000
[    7.817533]  [<ffffffff8167b543>] __hid_register_driver+0x53/0x90
[    7.817540]  [<ffffffffa001101e>] mt_driver_init+0x1e/0x1000 [hid_multit=
ouch]
[    7.817547]  [<ffffffff81002190>] do_one_initcall+0x50/0x180
[    7.817554]  [<ffffffff811d9cba>] ? kvfree+0x2a/0x40
[    7.817561]  [<ffffffff81221099>] ? kfree+0x159/0x170
[    7.817567]  [<ffffffff8121fb82>] ? kmem_cache_alloc_trace+0x182/0x1d0
[    7.817574]  [<ffffffff811b6116>] ? do_init_module+0x27/0x1d8
[    7.817580]  [<ffffffff811b614e>] do_init_module+0x5f/0x1d8
[    7.817589]  [<ffffffff8112ecdc>] load_module+0x1fdc/0x27d0
[    7.817595]  [<ffffffff8112bbb0>] ? __symbol_put+0x60/0x60
[    7.817605]  [<ffffffff8124555b>] ? vfs_read+0x11b/0x130
[    7.817612]  [<ffffffff8112f746>] SYSC_finit_module+0xe6/0x120
[    7.817619]  [<ffffffff8112f79e>] SyS_finit_module+0xe/0x10
[    7.817623]  [<ffffffff81003d52>] do_syscall_64+0x62/0x110
[    7.817631]  [<ffffffff817e0ca1>] entry_SYSCALL64_slow_path+0x25/0x25
[    7.818076] input: Microsoft Surface Type Cover Keyboard as /devices/pci=
0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0001/input/input2
[    7.869886] input: Microsoft Surface Type Cover Consumer Control as /dev=
ices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0001/input/inp=
ut4
[    7.870276] input: Microsoft Surface Type Cover Touchpad as /devices/pci=
0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:045E:07DC.0001/input/input6
[    7.870849] hid-multitouch 0003:045E:07DC.0001: input,hiddev0,hidraw0: U=
SB HID v1.11 Keyboard [Microsoft Surface Type Cover] on usb-0000:00:14.0-3/=
input0
[    7.870857] Post-hid_hw_start hdev->quirks: -2147483328

Sincerely,
Dennis Chen
--=-Ag6MYY3ryS4gYzKTVaij
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABEKAAYFAleTz/QACgkQpXlhF/qpw/lKEwCguXClvmFzAp2GcbDFL6jhQhjx
0QQAoLL2ZzTGXzZ/6jTm73yvGFRkCRwq
=qHIW
-----END PGP SIGNATURE-----

--=-Ag6MYY3ryS4gYzKTVaij--

--=-hgSc0ognI9UeXZygI90P
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
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNjA3MjMyMDEzNDRaME8GCSqGSIb3DQEJBDFCBEA2
xKcK4VaUe+Um9xE1F74bjuUivs/C6D6KGp04lCTVUi9aInO3wLv/SRDolNZyw8f+M9T0ubIcRRN+
0yn2zjbOMIGlBgkrBgEEAYI3EAQxgZcwgZQwgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFy
dENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgw
NgYDVQQDEy9TdGFydENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQID
EA1LMIGnBgsqhkiG9w0BCRACCzGBl6CBlDCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0
Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2
BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMQ
DUswDQYJKoZIhvcNAQEBBQAEggEAVv6PWbnhbQDK13y0tsRy9m5F4crQjMstpY07ImQR55+n4lNH
qyra5h+Z5rEyvMFo79WH90wwLiY12VncGyFuxtbEVC/EnxG9pRVyh6tRZjxULWc3An3r5OlAXjY2
DjMkFs2Sf4IiRYPgW05/36MTYUJcGHtiVKlbh7+LWuV15zyZyq6Q1G60nr3mJmrCLU83h7da81vu
nMRh1fQgqmRi6onFhkNFGlux+RJlIDIQJ9qeSOnoFXRF1dMNwc7YlN7G+6Pujj8lekj6tA4tjxLV
6wpzrVskAwyBCz5T0jydHXEmmAji+6Em9B93Izsv5VatGBvXpdAx5SfxXUX0CmrniAAAAAAAAA==


--=-hgSc0ognI9UeXZygI90P--

