Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E404C9569
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689974; cv=none; b=BxkOT5X/fQWlnNhKXrKNNvAQMqTjMocjuTL8n4JMKQRrUNE5zpzWFY58nOOdaO/rCo+emM6+zs+sHzldIeUO8V+3t/s85ucQ/iW6c1D06UZ3b0YzrjogLVBVtRRrvGZzJa3d6G7qPrUaLXUhtvBXi2rXUFGxC/mZZ0JC5mBGyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689974; c=relaxed/simple;
	bh=IPErsPidHOtsOHADJ4lGj5buMrPBghJqoqr41Q/V/eM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfzRL0SzhTFMxUGh/ZHo4RD7zU9rmblIY2wjLMpYJyDzklcF775Qkd77beSgmu/URlqfJEZI9LpUD8WM43bfuAG2uhOMylA4CUcLH+rbyO6Ecrvaz1cg7U0pkb8SJNdelwk4v94CBZWGpY5QFjs82dXfhabUf/bq/GVul4WrBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFM3Pduh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFM3Pduh"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso48110775e9.0
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 09:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689972; x=1779294772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTvP0mekYCTZkqE7Gqekk6c3AzomGlmddXPgIcbpL44=;
        b=gFM3PduhnrP+udhiI4uCf9lix42UacjQYpLGPWSHdICS4tBpcS7BHE+kwRLT52EvG0
         MuBzfmQTSDXN9FzfY69agisduszPVt2vd0++6FU4XeIHocMwlw7C03gAnkbUYxyqmWv8
         fzmNZFJPE51A09l2GdDreUT5WMcfjlLsLOg/6muWfPjlvLDu4+5mTMtayzZSf78kgw6A
         +WhgkxC/PrThmg6OgfWohHaAVRS/tWvNEN+XyIxXSbAYyCtwzs7MysTlfZWKEpo/iEdr
         HqMYnh//fmHgwxglOvyQQ6frd82JO9QdrxJKoWobC2xTlse6i1IcRA95iQORKJ1YYrHI
         LxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689972; x=1779294772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zTvP0mekYCTZkqE7Gqekk6c3AzomGlmddXPgIcbpL44=;
        b=SXCBqp1QAo9XQsUMUscY0UT0bQDB95FPSq5bQuQURJz0hnf4y8ccbXsZvBJh19SKcE
         Xr19SV0QhDxer3aZPuYxA9ekL0KXHJ4eurSXrbhvk9cCSB3j9eOn1bx7GNlSch5vrjuc
         PCLVSFSGOi4oK8CreX+JFPjKWMUxLrh8S3NpWmXKONGc+DrqLzWvTT1pkvh6nKhFHxIz
         o5Yy6mkzPvee+OOfoCKIi8lo5J7WdnGC4qVx0E9bAWIkjuhkklTdy8urqF2n7yIYBNNx
         YRnr6WkhV+v0e0owyVWMtcyZLcbJC0xb7sElN4rTM86DYloFQU62pqZV1EZQyd2Ato+f
         ABng==
X-Forwarded-Encrypted: i=1; AFNElJ96dMxVgjOV5zLz+AsVnVXZC/e7RuKc1OSCdW2WCTmZwVqsaKdheDEcMS4FnND83U4qkIgthpMASCUgiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymV3a7/bUKTvhal7UJdHByXfcq9NYX0ZCtHDzzAprXX/HHUqRa
	ydY3GleW3UsB3Y0HmKmekj4owWFqO7pU7uhS814bCebBWN/ih3Z9rwt7
X-Gm-Gg: Acq92OF2gnTCzPdb7QIsAtIjWARSBdZQ8zqsWWSlq5yzoFg1d6LNVjsmMZ9ygVemfcR
	4+J112w5r/gRVbh5585R7dvX4jZSIlgvfVVHFuHoHMQ8kv1kjn+a8f2aBSBh2y+MqteY+SY2Zxw
	qBuvKHbrmXhmd4GjqavHnBmH7fdSN0Z2MQcQmOKtW3n3bkkvs7ytjbtOaolX/Acyx+f0MYSTia4
	6K4i03L7hV6mpx1ViBUeg9PwLCDjk9NvpyW39pBt4vo8UCokP3USj/AO+v4s4OnFiTlFy+cy5iL
	fqDNpZfHZB+Y0UJ3F39t3uzdcgotUrZKEhskKR5NO/9HER+J3tpcbdJUCw9kwzK6sDq9igwkA1v
	hTsE93YXL83qXQBcJAXLQo175Ht4L/KHsmO32vzXGv97MVh+mBFW5z5vNR/8ohNrvf5LlZezQS6
	PIrtWl8o8UZc/8gsaBCM0+4i55LFZDGRR0xWCexGwT26SsyNqWZQShibplnbl4V0djD5voE5vdX
	ICa/e8=
X-Received: by 2002:a05:600c:5397:b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-48fc9a0775amr54581795e9.4.1778689971379;
        Wed, 13 May 2026 09:32:51 -0700 (PDT)
Received: from gmail.com ([91.126.139.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f447166sm44820915e9.30.2026.05.13.09.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:32:50 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 1/7] hid-asus: Fix up Zenbook Duo report descriptors
Date: Wed, 13 May 2026 18:32:42 +0200
Message-ID: <20260513163248.16483-2-p.pisati@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513163248.16483-1-p.pisati@gmail.com>
References: <20260513163248.16483-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Leivenzon <hacker1024@users.sourceforge.net>

This is similar to the T100CHI/T90CHI keyboard dock fix.
Without it, all reports log:

Unmapped Asus vendor usagepage code 0x76

Signed-off-by: Joshua Leivenzon <hacker1024@users.sourceforge.net>
---
 drivers/hid/hid-asus.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67a..ce246efba74d3 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -99,6 +99,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_ROG_CLAYMORE_II_KEYBOARD	BIT(12)
 #define QUIRK_ROG_ALLY_XPAD		BIT(13)
 #define QUIRK_HID_FN_LOCK		BIT(14)
+#define QUIRK_ZENBOOK_DUO_KEYBOARD	BIT(15)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
@@ -1384,17 +1385,20 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Asus T100 keyb report descriptor\n");
 		rdesc[74] &= ~HID_MAIN_ITEM_CONSTANT;
 	}
-	/* For the T100CHI/T90CHI keyboard dock */
-	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
+	/* For the T100CHI/T90CHI keyboard dock and Zenbook Duo 2024+ keyboards */
+	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI | QUIRK_ZENBOOK_DUO_KEYBOARD)) {
 		int rsize_orig;
 		int offs;
 
 		if (drvdata->quirks & QUIRK_T100CHI) {
 			rsize_orig = 403;
 			offs = 388;
-		} else {
+		} else if (drvdata->quirks & QUIRK_T90CHI) {
 			rsize_orig = 306;
 			offs = 291;
+		} else if (drvdata->quirks & QUIRK_ZENBOOK_DUO_KEYBOARD) {
+			rsize_orig = 257;
+			offs = 176;
 		}
 
 		/*
@@ -1414,7 +1418,8 @@ static const __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 			hid_info(hdev, "Fixing up %s keyb report descriptor\n",
 				drvdata->quirks & QUIRK_T100CHI ?
-				"T100CHI" : "T90CHI");
+				"T100CHI" : drvdata->quirks & QUIRK_T90CHI ?
+				"T90CHI" : "ZENBOOK DUO");
 
 			memcpy(new_rdesc, rdesc, rsize_orig);
 			*rsize = rsize_orig + 1;
-- 
2.53.0

