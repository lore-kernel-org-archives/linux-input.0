From: =?UTF-8?B?VG9iaWFzIE3DvGxsZXI=?= <Tobias_Mueller@twam.info>
Subject: [PATCH] appletouch driver and 4th generation macbooks
Date: Fri, 14 Mar 2008 18:22:45 +0100
Message-ID: <47DAB465.7090100@twam.info>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms020207080605060806010801"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ceres.twam.info ([84.16.224.131]:36373 "EHLO smtp.twam.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbYCNRW4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Mar 2008 13:22:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, johannes@sipsolutions.net

This is a cryptographically signed message in MIME format.

--------------ms020207080605060806010801
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello!

Adds product ids for 4th generation MacBooks in appletouch driver. 

Signed-off-by: Tobias Mueller <Tobias_Mueller@twam.info>

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index b4423a4..8dd3942 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -62,6 +62,10 @@
 #define GEYSER4_ISO_PRODUCT_ID 0x021B
 #define GEYSER4_JIS_PRODUCT_ID 0x021C

+#define GEYSER4_HF_ANSI_PRODUCT_ID     0x0229
+#define GEYSER4_HF_ISO_PRODUCT_ID      0x022A
+#define GEYSER4_HF_JIS_PRODUCT_ID      0x022B
+
 #define ATP_DEVICE(prod)                                       \
        .match_flags = USB_DEVICE_ID_MATCH_DEVICE |             \
                       USB_DEVICE_ID_MATCH_INT_CLASS |          \
@@ -93,6 +97,10 @@ static struct usb_device_id atp_table [] = {
        { ATP_DEVICE(GEYSER4_ISO_PRODUCT_ID) },
        { ATP_DEVICE(GEYSER4_JIS_PRODUCT_ID) },

+       { ATP_DEVICE(GEYSER4_HF_ANSI_PRODUCT_ID) },
+       { ATP_DEVICE(GEYSER4_HF_ISO_PRODUCT_ID) },
+       { ATP_DEVICE(GEYSER4_HF_JIS_PRODUCT_ID) },
+
        /* Terminating entry */
        { }
 };
@@ -217,7 +225,10 @@ static inline int atp_is_geyser_3(struct atp *dev)
                (productId == GEYSER3_JIS_PRODUCT_ID) ||
                (productId == GEYSER4_ANSI_PRODUCT_ID) ||
                (productId == GEYSER4_ISO_PRODUCT_ID) ||
-               (productId == GEYSER4_JIS_PRODUCT_ID);
+               (productId == GEYSER4_JIS_PRODUCT_ID) ||
+               (productId == GEYSER4_HF_ANSI_PRODUCT_ID) ||
+               (productId == GEYSER4_HF_ISO_PRODUCT_ID) ||
+               (productId == GEYSER4_HF_JIS_PRODUCT_ID);
 }

--------------ms020207080605060806010801
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJmzCC
AygwggKRoAMCAQICEDdfXmLiPCut3WRIWKcEfrgwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MTIxMTE0NDIyNVoX
DTA4MTIxMDE0NDIyNVowgYcxEDAOBgNVBAQTB011ZWxsZXIxIDAeBgNVBCoTF1RvYmlhcyBX
b2xmZ2FuZyBBbmRyZWFzMSgwJgYDVQQDEx9Ub2JpYXMgV29sZmdhbmcgQW5kcmVhcyBNdWVs
bGVyMScwJQYJKoZIhvcNAQkBFhhUb2JpYXNfTXVlbGxlckB0d2FtLmluZm8wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQC3vN/xQv+Nqk74OxgDpqJHwYGdwWOemIfl/W1sOlIE
FXzO9IDR57fa4FlqIUFrezqlolzipm1ZJAfxVhO4pdSjtwNj/4Z6ap5c3LbTjZYwL2abiFPi
qQPrwyIzYYKTyRpWetnTs0BVohEHMR38/sA3LMI4VQQEBYAd/XnPQPOLObLqbUggI1JZwmgO
zLEI1GSUEI2fUVyMeKIyXqX293cgw/5zQuoyZ87PQX80LsBkRx7JOnyUZ94+togZU/NtHso4
u+GcxVK8II/BN5wXYCoIQvNxsR0jc1AGJ7Y2xnjACjUVFeK/n1gZYTa4ZPPm3F/4XyGbd88U
3Qd2cBgP4cF5AgMBAAGjNTAzMCMGA1UdEQQcMBqBGFRvYmlhc19NdWVsbGVyQHR3YW0uaW5m
bzAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBACk9SGx4seRUhysubF04VghMmHFt
ap3+um/34i+t7rAFxAjA3Fj1NRxyTDuy3TT6M0yO4Toak4778ssDJP8fWIY71DvP5VYhHUJw
F+nCPacU2HRORLTXf61GhqzQzrvujj/yj3Z6z6c2OLc90CaDaoVjTb3nf9F6+1L7ID5ecozo
MIIDKDCCApGgAwIBAgIQN19eYuI8K63dZEhYpwR+uDANBgkqhkiG9w0BAQUFADBiMQswCQYD
VQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDcxMjExMTQ0MjI1
WhcNMDgxMjEwMTQ0MjI1WjCBhzEQMA4GA1UEBBMHTXVlbGxlcjEgMB4GA1UEKhMXVG9iaWFz
IFdvbGZnYW5nIEFuZHJlYXMxKDAmBgNVBAMTH1RvYmlhcyBXb2xmZ2FuZyBBbmRyZWFzIE11
ZWxsZXIxJzAlBgkqhkiG9w0BCQEWGFRvYmlhc19NdWVsbGVyQHR3YW0uaW5mbzCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBALe83/FC/42qTvg7GAOmokfBgZ3BY56Yh+X9bWw6
UgQVfM70gNHnt9rgWWohQWt7OqWiXOKmbVkkB/FWE7il1KO3A2P/hnpqnlzcttONljAvZpuI
U+KpA+vDIjNhgpPJGlZ62dOzQFWiEQcxHfz+wDcswjhVBAQFgB39ec9A84s5suptSCAjUlnC
aA7MsQjUZJQQjZ9RXIx4ojJepfb3dyDD/nNC6jJnzs9BfzQuwGRHHsk6fJRn3j62iBlT820e
yji74ZzFUrwgj8E3nBdgKghC83GxHSNzUAYntjbGeMAKNRUV4r+fWBlhNrhk8+bcX/hfIZt3
zxTdB3ZwGA/hwXkCAwEAAaM1MDMwIwYDVR0RBBwwGoEYVG9iaWFzX011ZWxsZXJAdHdhbS5p
bmZvMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAKT1IbHix5FSHKy5sXThWCEyY
cW1qnf66b/fiL63usAXECMDcWPU1HHJMO7LdNPozTI7hOhqTjvvyywMk/x9YhjvUO8/lViEd
QnAX6cI9pxTYdE5EtNd/rUaGrNDOu+6OP/KPdnrPpzY4tz3QJoNqhWNNved/0Xr7UvsgPl5y
jOgwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0
ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9u
MSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEW
HHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2
MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0
eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0Ew
gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9
zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPP
K9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGj
gZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
LnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYw
KQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9
reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo0
5RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDZDCCA2ACAQEwdjBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDdfXmLiPCut3WRIWKcEfrgwCQYF
Kw4DAhoFAKCCAcMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MDgwMzE0MTcyMjQ1WjAjBgkqhkiG9w0BCQQxFgQU5+RfFNMS7WxytK0qGsoZQ7f4nbcwUgYJ
KoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgYUGCSsGAQQBgjcQBDF4MHYwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA3X15i4jwrrd1kSFinBH64
MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAhA3X15i4jwrrd1kSFinBH64MA0GCSqGSIb3DQEBAQUABIIBAAOczsxg
ujcURrr/vORebxbICsASvqZP1YN08nW6zSkY+vxKuzMwAxypHoqqIXHON0dufN/kl9Yp4OrK
lbVSMfyTaNMdAxyTVU0BMKm46r7TKiVr1xzKzUOahBYcqB2oLxmC24k2lfgFnsJmueVawx5h
tFmh7LnzzDi+QuIWqOPOkr6LkpMrgoDzGpqwIBk8KjmJgP9z366Vn5moXIBQkEKSHHTLHy63
tZt+J3B2w2tmr9+0ooLvfieSa5Ag3jP9rv2VcPNTyc3CMNKw00rfnzlYu3fyHt3LLtluS4Cg
dDOrowNAQQwnfKqsfl6H+y9ST1u7jQeRTeCk0L00cQDIfVgAAAAAAAA=
--------------ms020207080605060806010801--
