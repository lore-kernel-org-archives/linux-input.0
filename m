From: Andrew Rodland <andrew@cleverdomain.org>
Subject: Re: Mayflash / Dragonrise GameCube controller adapter recognized as
 tablet, not joystick
Date: Thu, 5 Feb 2015 00:02:21 -0500
Message-ID: <CABFQKmMMJBj==983B-hgxT5MqpYV7uesSLvQqKgsTMXHgL+rMg@mail.gmail.com>
References: <CABFQKmN7Lzr2GzZ4d+HgbzMRDe_NBxJDL81qMpaOGOV07LYwag@mail.gmail.com>
	<CAKdAkRTU5a8MTstcJXgqAcfAKgjKUz=64aKP11TPaJKcCytK3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a1133d030864d24050e503596
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750706AbbBEFCX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 00:02:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 986E336F47
	for <linux-input@vger.kernel.org>; Thu,  5 Feb 2015 00:02:22 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DF4136F46
	for <linux-input@vger.kernel.org>; Thu,  5 Feb 2015 00:02:22 -0500 (EST)
Received: from mail-ie0-f176.google.com (unknown [209.85.223.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3404636F44
	for <linux-input@vger.kernel.org>; Thu,  5 Feb 2015 00:02:22 -0500 (EST)
Received: by mail-ie0-f176.google.com with SMTP id at20so7614391iec.7
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2015 21:02:21 -0800 (PST)
In-Reply-To: <CAKdAkRTU5a8MTstcJXgqAcfAKgjKUz=64aKP11TPaJKcCytK3w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--001a1133d030864d24050e503596
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Feb 4, 2015 at 7:48 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Andrew,
>
>
> From the list of events you posted below it seems the device needs
> HID_QUIRK_MULTI_INPUT to split it into 4 individual input devices.
>
That did the trick neatly. Everything works, although no force
feedback (and sadly hacking it into hid-dr isn't as trivial as I
hoped).

Patch in case it's useful (attached because of gmail, sorry).

(which also doesn't reply to list by default, so here's a dupe. Some
day I'll switch back to a real mail client.)

--001a1133d030864d24050e503596
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-Add-HID_QUIRK_MULTI_INPUT-for-Dragonrise-GameCube-ad.patch"
Content-Disposition: attachment;
	filename="0001-Add-HID_QUIRK_MULTI_INPUT-for-Dragonrise-GameCube-ad.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i5rogj200

RnJvbSA2MWNhMzIwYTQzZjY1MmVkZWIwMGQzN2ZlY2ZlZjFmMjIyNmFmYmFiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZXcgUm9kbGFuZCA8YW5kcmV3QGNsZXZlcmRvbWFpbi5v
cmc+CkRhdGU6IFdlZCwgNCBGZWIgMjAxNSAyMzowOTozNiAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IEFkZCBISURfUVVJUktfTVVMVElfSU5QVVQgZm9yIERyYWdvbnJpc2UgR2FtZUN1YmUgYWRhcHRl
cgoKLS0tCiBkcml2ZXJzL2hpZC9oaWQtaWRzLmggICAgICAgICAgIHwgMyArKy0KIGRyaXZlcnMv
aGlkL3VzYmhpZC9oaWQtcXVpcmtzLmMgfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9oaWQvaGlkLWlkcy5o
IGIvZHJpdmVycy9oaWQvaGlkLWlkcy5oCmluZGV4IDkyNDMzNTkuLjA0MTc1M2UgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvaGlkL2hpZC1pZHMuaAorKysgYi9kcml2ZXJzL2hpZC9oaWQtaWRzLmgKQEAg
LTI3Miw3ICsyNzIsOCBAQAogI2RlZmluZSBVU0JfVkVORE9SX0lEX0RNSQkJMHgwYzBiCiAjZGVm
aW5lIFVTQl9ERVZJQ0VfSURfRE1JX0VOQwkJMHg1ZmFiCiAKLSNkZWZpbmUgVVNCX1ZFTkRPUl9J
RF9EUkFHT05SSVNFCTB4MDA3OQorI2RlZmluZSBVU0JfVkVORE9SX0lEX0RSQUdPTlJJU0UgICAg
ICAgICAgICAgICAgMHgwMDc5CisjZGVmaW5lIFVTQl9ERVZJQ0VfSURfRFJBR09OUklTRV9HQU1F
Q1VCRSAgICAgICAweDE4NDMKIAogI2RlZmluZSBVU0JfVkVORE9SX0lEX0RXQVYJCTB4MGVlZgog
I2RlZmluZSBVU0JfREVWSUNFX0lEX0VHQUxBWF9UT1VDSENPTlRST0xMRVIJMHgwMDAxCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2hpZC91c2JoaWQvaGlkLXF1aXJrcy5jIGIvZHJpdmVycy9oaWQvdXNi
aGlkL2hpZC1xdWlya3MuYwppbmRleCBiMjdiM2QzLi5lNDdhNDQ1IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2hpZC91c2JoaWQvaGlkLXF1aXJrcy5jCisrKyBiL2RyaXZlcnMvaGlkL3VzYmhpZC9oaWQt
cXVpcmtzLmMKQEAgLTcwLDYgKzcwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBoaWRfYmxhY2ts
aXN0IHsKIAl7IFVTQl9WRU5ET1JfSURfQ0gsIFVTQl9ERVZJQ0VfSURfQ0hfM0FYSVNfNUJVVFRP
Tl9TVElDSywgSElEX1FVSVJLX05PR0VUIH0sCiAJeyBVU0JfVkVORE9SX0lEX0NILCBVU0JfREVW
SUNFX0lEX0NIX0FYSVNfMjk1LCBISURfUVVJUktfTk9HRVQgfSwKIAl7IFVTQl9WRU5ET1JfSURf
RE1JLCBVU0JfREVWSUNFX0lEX0RNSV9FTkMsIEhJRF9RVUlSS19OT0dFVCB9LAorCXsgVVNCX1ZF
TkRPUl9JRF9EUkFHT05SSVNFLCBVU0JfREVWSUNFX0lEX0RSQUdPTlJJU0VfR0FNRUNVQkUsIEhJ
RF9RVUlSS19NVUxUSV9JTlBVVCB9LAogCXsgVVNCX1ZFTkRPUl9JRF9FTEFOLCBVU0JfREVWSUNF
X0lEX0VMQU5fVE9VQ0hTQ1JFRU4sIEhJRF9RVUlSS19BTFdBWVNfUE9MTCB9LAogCXsgVVNCX1ZF
TkRPUl9JRF9FTEFOLCBVU0JfREVWSUNFX0lEX0VMQU5fVE9VQ0hTQ1JFRU5fMDA5QiwgSElEX1FV
SVJLX0FMV0FZU19QT0xMIH0sCiAJeyBVU0JfVkVORE9SX0lEX0VMQU4sIFVTQl9ERVZJQ0VfSURf
RUxBTl9UT1VDSFNDUkVFTl8wMTAzLCBISURfUVVJUktfQUxXQVlTX1BPTEwgfSwKLS0gCjEuOS4x
Cgo=
--001a1133d030864d24050e503596--
