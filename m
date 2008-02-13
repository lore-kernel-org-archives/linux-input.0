From: =?UTF-8?B?VG9iaWFzIE3DvGxsZXI=?= <Tobias_Mueller@twam.info>
Subject: Re: [PATCH] hid, 2.6.23 - add support for new macbook and apple aluminum
 keyboard "fn" key
Date: Wed, 13 Feb 2008 13:44:04 +0100
Message-ID: <47B2E614.5090001@twam.info>
References: <fosskb$klp$1@ger.gmane.org> <Pine.LNX.4.64.0802122143280.7699@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms010004030105060201010800"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ceres.twam.info ([84.16.224.131]:37175 "EHLO smtp.twam.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbYBMMpA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Feb 2008 07:45:00 -0500
In-Reply-To: <Pine.LNX.4.64.0802122143280.7699@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms010004030105060201010800
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jiri Kosina schrieb:
> Some part of the patch is already in 2.6.25-rc1 -- please see commit 
> a45d82d19a6c2a717bcc33cff243199b77fa0082, which adds support for Apple 
> Aluminium keyboards. So the patch would need some changes that it would 
> apply on top of current tree.
It seems there is almost everything implemented except for some product ids.

> Also, Tobias (added to CC) seems to be currently working on adding support 
> for a subset of keyboards that this patch adds. Tobias -- it seems like 
> this patch is handling a superset of what your patch does, right?
Yes

> It would be great if you could put this all together into one condensated 
> patch which I could merge into my tree.
I'm working on that, but I found a problem in the new 2.6.25-rc1 code.

Until 2.6.24 hidinput_apple_event which handles the apple specials was called by
hidinput_hid_event and if hidinput_apple_event changed some code, hidinput_hid_event
returned and didn't send any events.

In 2.6.25 hidinput_apple_event is called in hidinput_event_quirks which is called by 
hidinput_hid_event. But if hidinput_event_quirks sent events, hidinput_hid_event doesn't
know of this and send the events too! So if I press some keys on my keyboard, there are
2 keycodes sent.

This seems to be a greater change in 2.6.25 and I don't want to change this, because I think
someone made this change for some good reason.

Regards
  Tobias

--------------ms010004030105060201010800
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
MDgwMjEzMTI0NDA0WjAjBgkqhkiG9w0BCQQxFgQUNPDQCaW4fyB+L8rjn+cOXnAnXowwUgYJ
KoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgYUGCSsGAQQBgjcQBDF4MHYwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA3X15i4jwrrd1kSFinBH64
MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAhA3X15i4jwrrd1kSFinBH64MA0GCSqGSIb3DQEBAQUABIIBAG/kSnzo
tFeO6CAaMyz2RWjE4dCx09U0NTSJSY77Gsar7LBOC0lZik4x59abHDDyn7fgklsMCUEZPKSV
LbIA/gl8tAhUntH1Q/2T9pTWw4HdbDlAb0/H0iA0JEttQjntrrNQU0rdAG2rN58iwLseMXHj
6oaCRUvbT5MU2AxUmsQTKUWmzZ/UDbiPQCl23JHKthdlYzGDwd1e00uiITz0sME3GPEH2Nll
1P9bIWQDy015ogoPwUmxBx+40BwBWt6x2AABUqCzUQ4BSoJPB00QQNsiWwwhTCnUtDWhS+/2
KIzleYrh0+pixe9ZKyqpOSt/RtD9bV41tQtxsL+UlfC1fjYAAAAAAAA=
--------------ms010004030105060201010800--
