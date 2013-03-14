From: David Woodhouse <dwmw2@infradead.org>
Subject: [RFC/RFT] Reset bcm5974 into wellspring mode when it forgets
Date: Thu, 14 Mar 2013 14:30:07 +0000
Message-ID: <1363271407.4853.52.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="sha1"; protocol="application/x-pkcs7-signature";
	boundary="=-eZ84RDj8vrIDq8khEVO1"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:59109 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755923Ab3CNOaR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Mar 2013 10:30:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org


--=-eZ84RDj8vrIDq8khEVO1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Occasionally the trackpad in my MacBookPro 8,3 stops working, spewing
 'bcm5974: bad trackpad package, length: 8'

I haven't been able to reproduce this on demand, but it's annoying when
it does happen. I'm *assuming* that it's somehow forgotten what mode
it's supposed to be in. The fix for this on suspend/resume was to switch
it back to Wellspring mode again, so let's try that...

Untested, because my trackpad seems to *know* when I'm actually running
a kernel with this patch, and doesn't ever misbehave. I've played with
removing the *normal* mode switch in bcm5974_start_traffic() but can't
get it to produce the 'bad trackpad package' message at all in that
case, so the rest function doesn't get invoked.

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 2baff1b..db0b3ab 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -244,6 +244,7 @@ struct bcm5974 {
 	struct bt_data *bt_data;	/* button transferred data */
 	struct urb *tp_urb;		/* trackpad usb request block */
 	u8 *tp_data;			/* trackpad transferred data */
+	struct work_struct reset_work;	/* reset to wellspring mode */
 	const struct tp_finger *index[MAX_FINGERS];	/* finger index data */
 	struct input_mt_pos pos[MAX_FINGERS];		/* position array */
 	int slots[MAX_FINGERS];				/* slot assignments */
@@ -676,9 +677,14 @@ static void bcm5974_irq_trackpad(struct urb *urb)
 	if (dev->tp_urb->actual_length =3D=3D 2)
 		goto exit;
=20
-	if (report_tp_state(dev, dev->tp_urb->actual_length))
+	if (report_tp_state(dev, dev->tp_urb->actual_length)) {
 		dprintk(1, "bcm5974: bad trackpad package, length: %d\n",
 			dev->tp_urb->actual_length);
+		if (dev->tp_urb->actual_length =3D=3D 8) {
+			/* Hm. Make sure it's in wellspring mode... */
+			schedule_work(&dev->reset_work);
+		}
+	}
=20
 exit:
 	error =3D usb_submit_urb(dev->tp_urb, GFP_ATOMIC);
@@ -815,6 +821,14 @@ static int bcm5974_resume(struct usb_interface *iface)
 	return error;
 }
=20
+static void bcm5974_mode_workfn(struct work_struct *work)
+{
+	struct bcm5974 *dev =3D container_of(work, struct bcm5974, reset_work);
+
+	dev_info(&dev->intf->dev, "Reset into wellspring mode...\n");
+	bcm5974_wellspring_mode(dev, true);
+}
+
 static int bcm5974_probe(struct usb_interface *iface,
 			 const struct usb_device_id *id)
 {
@@ -840,6 +854,7 @@ static int bcm5974_probe(struct usb_interface *iface,
 	dev->input =3D input_dev;
 	dev->cfg =3D *cfg;
 	mutex_init(&dev->pm_mutex);
+	INIT_WORK(&dev->reset_work, bcm5974_mode_workfn);
=20
 	/* setup urbs */
 	if (cfg->tp_type =3D=3D TYPE1) {
@@ -936,6 +951,7 @@ static void bcm5974_disconnect(struct usb_interface *if=
ace)
 				  dev->bt_data, dev->bt_urb->transfer_dma);
 	usb_free_urb(dev->tp_urb);
 	usb_free_urb(dev->bt_urb);
+	cancel_work_sync(&dev->reset_work);
 	kfree(dev);
 }
=20



--=20
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

--=-eZ84RDj8vrIDq8khEVO1
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIUbjCCBjQw
ggQcoAMCAQICAR4wDQYJKoZIhvcNAQEFBQAwfTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0
Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxKTAn
BgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4XDTA3MTAyNDIxMDE1NVoX
DTE3MTAyNDIxMDE1NVowgYwxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSsw
KQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFy
dENvbSBDbGFzcyAxIFByaW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMcJg8zOLdgasSmkLhOrlr6KMoOMpohBllVHrdRvEg/q6r8jR+EK
75xCGhR8ToREoqe7zM9/UnC6TS2y9UKTpT1v7RSMzR0t6ndl0TWBuUr/UXBhPk+Kmy7bI4yW4urC
+y7P3/1/X7U8ocb8VpH/Clt+4iq7nirMcNh6qJR+xjOhV+VHzQMALuGYn5KZmc1NbJQYclsGkDxD
z2UbFqE2+6vIZoL+jb9x4Pa5gNf1TwSDkOkikZB1xtB4ZqtXThaABSONdfmv/Z1pua3FYxnCFmdr
/+N2JLKutIxMYqQOJebr/f/h5t95m4JgrM3Y/w7YX9d7YAL9jvN4SydHsU6n65cCAwEAAaOCAa0w
ggGpMA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBRTcu2SnODaywFc
fH6WNU7y1LhRgjAfBgNVHSMEGDAWgBROC+8apEBbpRdphzDKNGhD0EGu8jBmBggrBgEFBQcBAQRa
MFgwJwYIKwYBBQUHMAGGG2h0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9jYTAtBggrBgEFBQcwAoYh
aHR0cDovL3d3dy5zdGFydHNzbC5jb20vc2ZzY2EuY3J0MFsGA1UdHwRUMFIwJ6AloCOGIWh0dHA6
Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNybDAnoCWgI4YhaHR0cDovL2NybC5zdGFydHNzbC5j
b20vc2ZzY2EuY3JsMIGABgNVHSAEeTB3MHUGCysGAQQBgbU3AQIBMGYwLgYIKwYBBQUHAgEWImh0
dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cu
c3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwDQYJKoZIhvcNAQEFBQADggIBAAqDCH14qywG
XLhjjF6uHLkjd02hcdh9hrw+VUsv+q1eeQWB21jWj3kJ96AUlPCoEGZ/ynJNScWy6QMVQjbbMXlt
UfO4n4bGGdKo3awPWp61tjAFgraLJgDk+DsSvUD6EowjMTNx25GQgyYJ5RPIzKKR9tQW8gGK+2+R
HxkUCTbYFnL6kl8Ch507rUdPPipJ9CgJFws3kDS3gOS5WFMxcjO5DwKfKSETEPrHh7p5shuuNktv
sv6hxHTLhiMKX893gxdT3XLS9OKmCv87vkINQcNEcIIoFWbP9HORz9v3vQwR4e3ksLc2JZOAFK+s
sS5XMEoznzpihEP0PLc4dCBYjbvSD7kxgDwZ+Aj8Q9PkbvE9sIPP7ON0fz095HdThKjiVJe6vofq
+n6b1NBc8XdrQvBmunwxD5nvtTW4vtN6VY7mUCmxsCieuoBJ9OlqmsVWQvifIYf40dJPZkk9YgGT
zWLpXDSfLSplbY2LL9C9U0ptvjcDjefLTvqSFc7tw1sEhF0n/qpA2r0GpvkLRDmcSwVyPvmjFBGq
Up/pNy8ZuPGQmHwFi2/14+xeSUDG2bwnsYJQG2EdJCB6luQ57GEnTA/yKZSTKI8dDQa8Sd3zfXb1
9mOgSF0bBdXbuKhEpuP9wirslFe6fQ1t5j5R0xi72MZ8ikMu1RQZKCyDbMwazlHiMIIHFzCCBf+g
AwIBAgIDBCZ6MA0GCSqGSIb3DQEBBQUAMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRD
b20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYG
A1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwHhcN
MTIwNTAxMTI1ODI3WhcNMTMwNTAzMTEzNzIwWjBdMRkwFwYDVQQNExA4Y1VOSzUzMTc0ODRYRjk3
MRwwGgYDVQQDDBNkd213MkBpbmZyYWRlYWQub3JnMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZy
YWRlYWQub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyYe7wo6MrtrB4uIGGbrY
4IifY/Xsq22pSv605yganL0+uyUdd8rCjrYlH6Q/ra5TVJCQFTgzaepkuqPQc79DC/Cxmzm6Qo+s
wLZy868oFsccsVokL2bPAWIPaRXfNPJKkYR1FTWQfZpWJVQmT+sPf1XFUullVBAK+d9RztopyacI
xWoZ/W/Cmv7mseQbttYTtGKJa0btX73nsQRWl6SgErWXo59zg9friCLTy1GXMXJYB8H+PtnuwX0w
MrAvWDdX1ABgIlA17W3FraCn0eW15ZM46eyu0/amGzJZNtemCWF73P7BAijzeV1jNmiJFXdZ0DT0
w+hmtMO9PxdDUyt78QIDAQABo4IDrjCCA6owCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBTkfe5UOr3PcirsjApibyyUEfsyRzAf
BgNVHSMEGDAWgBRTcu2SnODaywFcfH6WNU7y1LhRgjAeBgNVHREEFzAVgRNkd213MkBpbmZyYWRl
YWQub3JnMIICIQYDVR0gBIICGDCCAhQwggIQBgsrBgEEAYG1NwECAjCCAf8wLgYIKwYBBQUHAgEW
Imh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93
d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwgfcGCCsGAQUFBwICMIHqMCcWIFN0YXJ0
Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MAMCAQEagb5UaGlzIGNlcnRpZmljYXRlIHdhcyBp
c3N1ZWQgYWNjb3JkaW5nIHRvIHRoZSBDbGFzcyAxIFZhbGlkYXRpb24gcmVxdWlyZW1lbnRzIG9m
IHRoZSBTdGFydENvbSBDQSBwb2xpY3ksIHJlbGlhbmNlIG9ubHkgZm9yIHRoZSBpbnRlbmRlZCBw
dXJwb3NlIGluIGNvbXBsaWFuY2Ugb2YgdGhlIHJlbHlpbmcgcGFydHkgb2JsaWdhdGlvbnMuMIGc
BggrBgEFBQcCAjCBjzAnFiBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgECGmRM
aWFiaWxpdHkgYW5kIHdhcnJhbnRpZXMgYXJlIGxpbWl0ZWQhIFNlZSBzZWN0aW9uICJMZWdhbCBh
bmQgTGltaXRhdGlvbnMiIG9mIHRoZSBTdGFydENvbSBDQSBwb2xpY3kuMDYGA1UdHwQvMC0wK6Ap
oCeGJWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL2NydHUxLWNybC5jcmwwgY4GCCsGAQUFBwEBBIGB
MH8wOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLnN0YXJ0c3NsLmNvbS9zdWIvY2xhc3MxL2NsaWVu
dC9jYTBCBggrBgEFBQcwAoY2aHR0cDovL2FpYS5zdGFydHNzbC5jb20vY2VydHMvc3ViLmNsYXNz
MS5jbGllbnQuY2EuY3J0MCMGA1UdEgQcMBqGGGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tLzANBgkq
hkiG9w0BAQUFAAOCAQEAqDU1FKifNtCFJbLnvOi1BLRfk7mut55PMtPSZLJ4/AnG7AjmJnbBI4U5
DELwvVq3mIpwUpGqZUkqkZMEfBPIbfq517UZB3h4iANtqif+ULfTLhg5XgcK5eF8/T6EtX2c3epq
ylARdleCbj/0FwiUDvPlTsA6PIN4SCekjRLgjKERrL3heFz+Hteq1rtMAvMkNuyL0/0ijyyg2y45
NASAl2Afl9SLes/fnoh9nBwzfNQfb6qDYUFpnglfpGrq/0b1NtaOUb2z1SR+H1tKlb8bVJJIdvpu
mEi27kSRIhzk3h30uTfKkKetgy++ouyldxZ7KZ0PuoLQrBy465EoQLosETCCBxcwggX/oAMCAQIC
AwQmejANBgkqhkiG9w0BAQUFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0
ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMT
L1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBMB4XDTEyMDUw
MTEyNTgyN1oXDTEzMDUwMzExMzcyMFowXTEZMBcGA1UEDRMQOGNVTks1MzE3NDg0WEY5NzEcMBoG
A1UEAwwTZHdtdzJAaW5mcmFkZWFkLm9yZzEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFk
Lm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMmHu8KOjK7aweLiBhm62OCIn2P1
7KttqUr+tOcoGpy9PrslHXfKwo62JR+kP62uU1SQkBU4M2nqZLqj0HO/QwvwsZs5ukKPrMC2cvOv
KBbHHLFaJC9mzwFiD2kV3zTySpGEdRU1kH2aViVUJk/rD39VxVLpZVQQCvnfUc7aKcmnCMVqGf1v
wpr+5rHkG7bWE7RiiWtG7V+957EEVpekoBK1l6Ofc4PX64gi08tRlzFyWAfB/j7Z7sF9MDKwL1g3
V9QAYCJQNe1txa2gp9HlteWTOOnsrtP2phsyWTbXpglhe9z+wQIo83ldYzZoiRV3WdA09MPoZrTD
vT8XQ1Mre/ECAwEAAaOCA64wggOqMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgSwMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDAdBgNVHQ4EFgQU5H3uVDq9z3Iq7IwKYm8slBH7MkcwHwYDVR0j
BBgwFoAUU3Ltkpzg2ssBXHx+ljVO8tS4UYIwHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiEGA1UdIASCAhgwggIUMIICEAYLKwYBBAGBtTcBAgIwggH/MC4GCCsGAQUFBwIBFiJodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRwOi8vd3d3LnN0
YXJ0c3NsLmNvbS9pbnRlcm1lZGlhdGUucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFydENvbSBD
ZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3YXMgaXNzdWVk
IGFjY29yZGluZyB0byB0aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVtZW50cyBvZiB0aGUg
U3RhcnRDb20gQ0EgcG9saWN5LCByZWxpYW5jZSBvbmx5IGZvciB0aGUgaW50ZW5kZWQgcHVycG9z
ZSBpbiBjb21wbGlhbmNlIG9mIHRoZSByZWx5aW5nIHBhcnR5IG9ibGlnYXRpb25zLjCBnAYIKwYB
BQUHAgIwgY8wJxYgU3RhcnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwAwIBAhpkTGlhYmls
aXR5IGFuZCB3YXJyYW50aWVzIGFyZSBsaW1pdGVkISBTZWUgc2VjdGlvbiAiTGVnYWwgYW5kIExp
bWl0YXRpb25zIiBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5LjA2BgNVHR8ELzAtMCugKaAnhiVo
dHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9jcnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkG
CCsGAQUFBzABhi1odHRwOi8vb2NzcC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2Ew
QgYIKwYBBQUHMAKGNmh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xp
ZW50LmNhLmNydDAjBgNVHRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcN
AQEFBQADggEBAKg1NRSonzbQhSWy57zotQS0X5O5rreeTzLT0mSyePwJxuwI5iZ2wSOFOQxC8L1a
t5iKcFKRqmVJKpGTBHwTyG36ude1GQd4eIgDbaon/lC30y4YOV4HCuXhfP0+hLV9nN3qaspQEXZX
gm4/9BcIlA7z5U7AOjyDeEgnpI0S4IyhEay94Xhc/h7Xqta7TALzJDbsi9P9Io8soNsuOTQEgJdg
H5fUi3rP356IfZwcM3zUH2+qg2FBaZ4JX6Rq6v9G9TbWjlG9s9Ukfh9bSpW/G1SSSHb6bphItu5E
kSIc5N4d9Lk3ypCnrYMvvqLspXcWeymdD7qC0KwcuOuRKEC6LBExggNvMIIDawIBATCBlDCBjDEL
MAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdp
dGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFy
eSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMEJnowCQYFKw4DAhoFAKCCAa8wGAYJKoZIhvcNAQkD
MQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTMwMzE0MTQzMDA4WjAjBgkqhkiG9w0BCQQx
FgQU9ZK6viPiuEwOkLADNsyYy0pjwMcwgaUGCSsGAQQBgjcQBDGBlzCBlDCBjDELMAkGA1UEBhMC
SUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRp
ZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1l
ZGlhdGUgQ2xpZW50IENBAgMEJnowgacGCyqGSIb3DQEJEAILMYGXoIGUMIGMMQswCQYDVQQGEwJJ
TDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlm
aWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVk
aWF0ZSBDbGllbnQgQ0ECAwQmejANBgkqhkiG9w0BAQEFAASCAQADSyrDy1Ypzc49MzjHA2yxDXKH
uLCsLFbZ9fNcpw87rrQpRBhmJK74gIkl9omd2n+dqAxGGvj9x53X4y92qZ1sC2kqgkch3BNroi2+
M6CrgSz/EqGNm++dNY1+zXl6nFxxCK9NygSs/99pRMHLnBNaoWD/AoYGbG603YqgFGqondsll8L1
Z+XhHv0EhDJORxefkTXhIcWHVdr6c4nrLasx4O6KqAcXyKATXAGWn8GA2pZmprow8yK72jISiSDA
Q6qbaF2GbUVZJ1lYV3wJLpL2hKBQQ4mOskqDAvUqLN3ObchVDf9VD8x0Kik3SIAziZLvghBlbqm5
/pScL+MxE8w5AAAAAAAA


--=-eZ84RDj8vrIDq8khEVO1--

