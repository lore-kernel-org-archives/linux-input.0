From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: [PATCH/HP7XX] - Fix touchscreen build error ( LONG() usage )
Date: Tue, 16 Sep 2008 20:08:57 -0700
Message-ID: <20080916200857.028a5bb0.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__16_Sep_2008_20_08_57_-0700_3kG5TunZJp/1I/e7"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:47995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbYIPSEP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Sep 2008 14:04:15 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1541650nfc.21
        for <linux-input@vger.kernel.org>; Tue, 16 Sep 2008 11:04:14 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

This is a multi-part message in MIME format.

--Multipart=_Tue__16_Sep_2008_20_08_57_-0700_3kG5TunZJp/1I/e7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This patch removes the usage of LONG() which is deprecated inside
the jornada720_ts.c file.
We also replace BIT() with BIT_MASK().

signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

diff --git a/drivers/input/touchscreen/jornada720_ts.c b/drivers/input/touchscreen/jornada720_ts.c
index bf44f9d..c8b7e8a 100644
--- a/drivers/input/touchscreen/jornada720_ts.c
+++ b/drivers/input/touchscreen/jornada720_ts.c
@@ -119,8 +119,8 @@ static int __devinit jornada720_ts_probe(struct platform_device *pdev)
 	input_dev->id.bustype = BUS_HOST;
 	input_dev->dev.parent = &pdev->dev;
 
-	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 	input_set_abs_params(input_dev, ABS_X, 270, 3900, 0, 0);
 	input_set_abs_params(input_dev, ABS_Y, 180, 3700, 0, 0);
 


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Multipart=_Tue__16_Sep_2008_20_08_57_-0700_3kG5TunZJp/1I/e7
Content-Type: application/octet-stream;
 name="jornada720_ts-LONG.patch"
Content-Disposition: attachment;
 filename="jornada720_ts-LONG.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vam9ybmFkYTcyMF90cy5jIGIv
ZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIwX3RzLmMKaW5kZXggYmY0NGY5ZC4u
YzhiN2U4YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIw
X3RzLmMKKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9qb3JuYWRhNzIwX3RzLmMKQEAg
LTExOSw4ICsxMTksOCBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBqb3JuYWRhNzIwX3RzX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJaW5wdXRfZGV2LT5pZC5idXN0eXBlID0g
QlVTX0hPU1Q7CiAJaW5wdXRfZGV2LT5kZXYucGFyZW50ID0gJnBkZXYtPmRldjsKIAotCWlucHV0
X2Rldi0+ZXZiaXRbMF0gPSBCSVQoRVZfS0VZKSB8IEJJVChFVl9BQlMpOwotCWlucHV0X2Rldi0+
a2V5Yml0W0xPTkcoQlROX1RPVUNIKV0gPSBCSVQoQlROX1RPVUNIKTsKKwlpbnB1dF9kZXYtPmV2
Yml0WzBdID0gQklUX01BU0soRVZfS0VZKSB8IEJJVF9NQVNLKEVWX0FCUyk7CisJaW5wdXRfZGV2
LT5rZXliaXRbQklUX1dPUkQoQlROX1RPVUNIKV0gPSBCSVRfTUFTSyhCVE5fVE9VQ0gpOwogCWlu
cHV0X3NldF9hYnNfcGFyYW1zKGlucHV0X2RldiwgQUJTX1gsIDI3MCwgMzkwMCwgMCwgMCk7CiAJ
aW5wdXRfc2V0X2Fic19wYXJhbXMoaW5wdXRfZGV2LCBBQlNfWSwgMTgwLCAzNzAwLCAwLCAwKTsK
IAo=

--Multipart=_Tue__16_Sep_2008_20_08_57_-0700_3kG5TunZJp/1I/e7--
