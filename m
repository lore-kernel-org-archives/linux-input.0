From: simon@mungewell.org
Subject: [RESEND] - HID: add support for force feedback in  'Thrustmaster
 F430 Force Feedback' steering wheel
Date: Tue, 23 Nov 2010 15:21:05 -0500
Message-ID: <ece69dfce015de7cc10b9c0257af3627.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20101123152105_45988"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:43478 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab0KWUVH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Nov 2010 15:21:07 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Orefice <aorefice77@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>

------=_20101123152105_45988
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Doesn't look like this was picked up by anybody... at least there was no
'ack'.

On behalf of Antonio, please find attached a git-ized version of the patch.

This just add the USB ID's. Builds OK against Linus' git tree, but I don't
have the wheel to test.

Cheers,
Simon Wood.
http://www.speed-dreams.org

------=_20101123152105_45988
Content-Type: application/octet-stream;
  name="0001-This-patch-add-supports-for-force-feedback-Thrustmas.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
  filename=
 "0001-This-patch-add-supports-for-force-feedback-Thrustmas.patch"

RnJvbSA3NDkyYjZiOTNjY2I5OTA0NDhiOWVkYTNhMWQ4Mjc3ODE5YzgxYWJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaW1vbiBXb29kIDxzaW1vbkBtdW5nZXdlbGwub3JnPgpEYXRl
OiBXZWQsIDE3IE5vdiAyMDEwIDE4OjM3OjA1IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gVGhpcyBw
YXRjaCBhZGQgc3VwcG9ydHMgZm9yIGZvcmNlIGZlZWRiYWNrIFRocnVzdG1hc3RlciAiRjQzMCBG
b3JjZQogRmVlZGJhY2siIHN0ZWVyaW5nIHdoZWVsLgoKUmVwb3J0ZWQgYnk6ICJBbnRvbmlvIE9y
ZWZpY2UiIDxhb3JlZmljZTc3QGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2hpZC9oaWQtY29yZS5j
IHwgICAgMSArCiBkcml2ZXJzL2hpZC9oaWQtdG1mZi5jIHwgICAgMiArKwogMiBmaWxlcyBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9oaWQvaGlkLWNvcmUuYyBiL2RyaXZlcnMvaGlkL2hpZC1jb3JlLmMKaW5kZXggNTE1MzQ1Yi4u
ODhjYjA0ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9oaWQvaGlkLWNvcmUuYworKysgYi9kcml2ZXJz
L2hpZC9oaWQtY29yZS5jCkBAIC0xMzg2LDYgKzEzODYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IGhpZF9kZXZpY2VfaWQgaGlkX2JsYWNrbGlzdFtdID0gewogCXsgSElEX1VTQl9ERVZJQ0UoVVNC
X1ZFTkRPUl9JRF9USFJVU1RNQVNURVIsIDB4YjY1MSkgfSwKIAl7IEhJRF9VU0JfREVWSUNFKFVT
Ql9WRU5ET1JfSURfVEhSVVNUTUFTVEVSLCAweGI2NTMpIH0sCiAJeyBISURfVVNCX0RFVklDRShV
U0JfVkVORE9SX0lEX1RIUlVTVE1BU1RFUiwgMHhiNjU0KSB9LAorCXsgSElEX1VTQl9ERVZJQ0Uo
VVNCX1ZFTkRPUl9JRF9USFJVU1RNQVNURVIsIDB4YjY1YSkgfSwKIAl7IEhJRF9VU0JfREVWSUNF
KFVTQl9WRU5ET1JfSURfVE9QU0VFRCwgVVNCX0RFVklDRV9JRF9UT1BTRUVEX0NZQkVSTElOSykg
fSwKIAl7IEhJRF9VU0JfREVWSUNFKFVTQl9WRU5ET1JfSURfVE9QU0VFRDIsIFVTQl9ERVZJQ0Vf
SURfVE9QU0VFRDJfUkZfQ09NQk8pIH0sCiAJeyBISURfVVNCX0RFVklDRShVU0JfVkVORE9SX0lE
X1RXSU5IQU4sIFVTQl9ERVZJQ0VfSURfVFdJTkhBTl9JUl9SRU1PVEUpIH0sCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2hpZC9oaWQtdG1mZi5jIGIvZHJpdmVycy9oaWQvaGlkLXRtZmYuYwppbmRleCAx
NTQzNGM4Li4yNWJlNGUxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2hpZC9oaWQtdG1mZi5jCisrKyBi
L2RyaXZlcnMvaGlkL2hpZC10bWZmLmMKQEAgLTI1Niw2ICsyNTYsOCBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGhpZF9kZXZpY2VfaWQgdG1fZGV2aWNlc1tdID0gewogCQkuZHJpdmVyX2RhdGEgPSAo
dW5zaWduZWQgbG9uZylmZl9qb3lzdGljayB9LAogCXsgSElEX1VTQl9ERVZJQ0UoVVNCX1ZFTkRP
Ul9JRF9USFJVU1RNQVNURVIsIDB4YjY1NCksCS8qIEZHVCBGb3JjZSBGZWVkYmFjayBXaGVlbCAq
LwogCQkuZHJpdmVyX2RhdGEgPSAodW5zaWduZWQgbG9uZylmZl9qb3lzdGljayB9LAorCXsgSElE
X1VTQl9ERVZJQ0UoVVNCX1ZFTkRPUl9JRF9USFJVU1RNQVNURVIsIDB4YjY1YSksCS8qIEY0MzAg
Rm9yY2UgRmVlZGJhY2sgV2hlZWwgKi8KKwkJLmRyaXZlcl9kYXRhID0gKHVuc2lnbmVkIGxvbmcp
ZmZfam95c3RpY2sgfSwKIAl7IH0KIH07CiBNT0RVTEVfREVWSUNFX1RBQkxFKGhpZCwgdG1fZGV2
aWNlcyk7Ci0tIAoxLjcuMC40Cg==
------=_20101123152105_45988--


