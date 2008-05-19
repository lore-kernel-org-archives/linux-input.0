From: =?UTF-8?B?VG9iaWFzIE3DvGxsZXI=?= <Tobias_Mueller@twam.info>
Subject: Re: uinput problem
Date: Mon, 19 May 2008 18:38:55 +0200
Message-ID: <4831AD1F.2000606@twam.info>
References: <482DB441.7020205@twam.info> <20080519115457.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms090607080108050805090002"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ceres.twam.info ([84.16.224.131]:51308 "EHLO smtp.twam.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759322AbYESQjE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 May 2008 12:39:04 -0400
In-Reply-To: <20080519115457.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090607080108050805090002
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry!

Dmitry Torokhov wrote:
> Are you working in the console or in X?
In X. I tried it in the console and it seems to work. Problem occurs only within X.

> What keyboard driver are you using?
In xorg.conf is 
         Driver         "keyboard"
set.

> You may want to send EV_SYN/SYN_REPORT calls in between
> keypress events since consumers might rely on them.

I added a function

void SysSync(int fd) {
	struct input_event ev;
	memset (&ev, 0, sizeof(ev));
	ev.type=EV_SYN; ev.code=SYN_REPORT; ev.value=0;
	write (fd, &ev, sizeof(ev));
}
and then tried

	SysKeypress (uinput_fd, KEY_LEFTSHIFT, 1);
	SysSync(uinput_fd);
	SysKeypress (uinput_fd, KEY_1, 1);
	SysSync(uinput_fd);
	SysKeypress (uinput_fd, KEY_1, 0);
	SysSync(uinput_fd);
	SysKeypress (uinput_fd, KEY_LEFTSHIFT, 0);
	SysSync(uinput_fd);

	SysKeypress (uinput_fd, KEY_1, 1);
	SysSync(uinput_fd);
	SysKeypress (uinput_fd, KEY_1, 0);
	SysSync(uinput_fd);

but same behaviour within X.

Regards
  Tobias





--------------ms090607080108050805090002
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
MDgwNTE5MTYzODU1WjAjBgkqhkiG9w0BCQQxFgQUN7luf+bwji3XartsvPGcXHLt5UQwUgYJ
KoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgYUGCSsGAQQBgjcQBDF4MHYwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA3X15i4jwrrd1kSFinBH64
MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAhA3X15i4jwrrd1kSFinBH64MA0GCSqGSIb3DQEBAQUABIIBAIfFbNRl
/IdRDRP5rXWDbS+btSa979TGnDXVrJHFCqvNl8rB7wYBuEVPwPxMw3ILzf34KF8IIR+ckqjB
meU8NNYF8Vg1i0Sb5+XEJS9GEINEdf0NYm1p+6P44hEkQqYsidMTL7XEPWYJKu7+Xe944SbH
Yf1OKgSoESuD9h+crfk69E5ig5y811R0SqU7+9++zHfFgEdYj6Yws8tcg1CN6rXi2t0q+/w5
lQ/2e1tH8PzSbCkQpyr+0N75PQm0zNm7/m48Ka/lJGvIhHVu0Jisp8VH+NL4Kiy/FjZQYwed
l/utDZ9MZra20kXNHJRcfVIx4MGPMZsqDDgkSyYyl2lrvGkAAAAAAAA=
--------------ms090607080108050805090002--
