From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH] input: correct the MODULE_LICENSE of corgikbd.c and spitzkbd.c
Date: Wed, 21 May 2008 18:20:45 +0800
Message-ID: <f17812d70805210320i6dc27b3fjff09ae08bef8f12f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5228_17266869.1211365245717"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:62127 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925AbYEUKVE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2008 06:21:04 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1608501ywe.1
        for <linux-input@vger.kernel.org>; Wed, 21 May 2008 03:20:45 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-arm <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>

------=_Part_5228_17266869.1211365245717
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>From 4a99f96d2a27e668f9e78e75fcee24d8f5bca261 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Wed, 21 May 2008 18:18:32 +0800
Subject: [PATCH] input: correct the MODULE_LICENSE of corgikbd.c and spitzkbd.c

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/corgikbd.c |    2 +-
 drivers/input/keyboard/spitzkbd.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/corgikbd.c
b/drivers/input/keyboard/corgikbd.c
index 29fbec6..1aa46ae 100644
--- a/drivers/input/keyboard/corgikbd.c
+++ b/drivers/input/keyboard/corgikbd.c
@@ -412,5 +412,5 @@ module_exit(corgikbd_exit);

 MODULE_AUTHOR("Richard Purdie <rpurdie@rpsys.net>");
 MODULE_DESCRIPTION("Corgi Keyboard Driver");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:corgi-keyboard");
diff --git a/drivers/input/keyboard/spitzkbd.c
b/drivers/input/keyboard/spitzkbd.c
index 61e401b..1aa3718 100644
--- a/drivers/input/keyboard/spitzkbd.c
+++ b/drivers/input/keyboard/spitzkbd.c
@@ -494,5 +494,5 @@ module_exit(spitzkbd_exit);

 MODULE_AUTHOR("Richard Purdie <rpurdie@rpsys.net>");
 MODULE_DESCRIPTION("Spitz Keyboard Driver");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:spitz-keyboard");
-- 
1.5.4.3



-- 
Cheers
- eric

------=_Part_5228_17266869.1211365245717
Content-Type: text/x-diff;
 name=0001-input-correct-the-MODULE_LICENSE-of-corgikbd.c-and.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fghrkflr0
Content-Disposition: attachment;
 filename=0001-input-correct-the-MODULE_LICENSE-of-corgikbd.c-and.patch

RnJvbSA0YTk5Zjk2ZDJhMjdlNjY4ZjllNzhlNzVmY2VlMjRkOGY1YmNhMjYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmljIE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KRGF0
ZTogV2VkLCAyMSBNYXkgMjAwOCAxODoxODozMiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGlucHV0
OiBjb3JyZWN0IHRoZSBNT0RVTEVfTElDRU5TRSBvZiBjb3JnaWtiZC5jIGFuZCBzcGl0emtiZC5j
CgpTaWduZWQtb2ZmLWJ5OiBFcmljIE1pYW8gPGVyaWMubWlhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBk
cml2ZXJzL2lucHV0L2tleWJvYXJkL2Nvcmdpa2JkLmMgfCAgICAyICstCiBkcml2ZXJzL2lucHV0
L2tleWJvYXJkL3NwaXR6a2JkLmMgfCAgICAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tleWJv
YXJkL2Nvcmdpa2JkLmMgYi9kcml2ZXJzL2lucHV0L2tleWJvYXJkL2Nvcmdpa2JkLmMKaW5kZXgg
MjlmYmVjNi4uMWFhNDZhZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9jb3Jn
aWtiZC5jCisrKyBiL2RyaXZlcnMvaW5wdXQva2V5Ym9hcmQvY29yZ2lrYmQuYwpAQCAtNDEyLDUg
KzQxMiw1IEBAIG1vZHVsZV9leGl0KGNvcmdpa2JkX2V4aXQpOwogCiBNT0RVTEVfQVVUSE9SKCJS
aWNoYXJkIFB1cmRpZSA8cnB1cmRpZUBycHN5cy5uZXQ+Iik7CiBNT0RVTEVfREVTQ1JJUFRJT04o
IkNvcmdpIEtleWJvYXJkIERyaXZlciIpOwotTU9EVUxFX0xJQ0VOU0UoIkdQTHYyIik7CitNT0RV
TEVfTElDRU5TRSgiR1BMIHYyIik7CiBNT0RVTEVfQUxJQVMoInBsYXRmb3JtOmNvcmdpLWtleWJv
YXJkIik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2lucHV0L2tleWJvYXJkL3NwaXR6a2JkLmMgYi9k
cml2ZXJzL2lucHV0L2tleWJvYXJkL3NwaXR6a2JkLmMKaW5kZXggNjFlNDAxYi4uMWFhMzcxOCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC9rZXlib2FyZC9zcGl0emtiZC5jCisrKyBiL2RyaXZl
cnMvaW5wdXQva2V5Ym9hcmQvc3BpdHprYmQuYwpAQCAtNDk0LDUgKzQ5NCw1IEBAIG1vZHVsZV9l
eGl0KHNwaXR6a2JkX2V4aXQpOwogCiBNT0RVTEVfQVVUSE9SKCJSaWNoYXJkIFB1cmRpZSA8cnB1
cmRpZUBycHN5cy5uZXQ+Iik7CiBNT0RVTEVfREVTQ1JJUFRJT04oIlNwaXR6IEtleWJvYXJkIERy
aXZlciIpOwotTU9EVUxFX0xJQ0VOU0UoIkdQTHYyIik7CitNT0RVTEVfTElDRU5TRSgiR1BMIHYy
Iik7CiBNT0RVTEVfQUxJQVMoInBsYXRmb3JtOnNwaXR6LWtleWJvYXJkIik7Ci0tIAoxLjUuNC4z
Cgo=
------=_Part_5228_17266869.1211365245717--
