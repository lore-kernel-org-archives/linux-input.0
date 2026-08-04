Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D03CC324
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 20:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874843; cv=none; b=myfoXiEhqOCMU2+nCHaWHtdm9eY4weiw0CIPZDpXlXB/j+J7k9Wqbmi2LdBju+vNvlijqjj5HhTmGISO1gyjPsCxd2/6EmAmn8koZCyqhUw2gLZZhfcP7YD7ZSQKfKfS6ft5MG0VSHdo15bCHkbyQ80Qtz/dvvsCIuRZ+FslRGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874843; c=relaxed/simple;
	bh=kkf8TW5MJxNTJ7+CR2sDFidCT2RHsRoOHSnmf6X5CZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+K2kDqKLrUP+dwRhnXvJqa1dkl9IajP0MpzxwwP8td+O7Ezbln/53j7LXbzgr4b+dftIuq9kT3ZZrBj+jaHiQLUDogjUkEJsnfepqnE9wRS6CITw58mpZbfTY1bhvymJUqBSCQSFrhcQZNZUWgBpRuxaEjbeA8zFCyen8XB9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWO3l01D; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWO3l01D"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso108270a12.1
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785874841; x=1786479641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r6d+vbD9wuzkkuB/nbI31f2jI9KftyE/vm8BKPz6LeI=;
        b=VWO3l01DnS2Z94Nt55fZw8HMns19yjMgdUVOln/rdsS59XLgwu0BnSZB6CtehF5KeH
         +FhCfZCDu4osEkxulq5ZPIArCYp+77BwT2Av6Auu0O95mJ1EV8WU9fHXQYF9/qQQkBZF
         TTUZQTP1WTKthwLQ3P0hP/d4nFD0xM5Mn167rD+YTxTPxQeejBmQchjlaluBDMU0cojS
         nbTUJWisIhlTlhrYr/K56vHMgBkYKLH9AbOcKukja7Sjkr+BUI68dsPJKBDjDwXGqYsu
         J28/augTJFAgBepEhBDAsbnqbvmUAGHnhC3KvkgHI34PP4M+1yMtl2ywnWBw35DhQ2bu
         im4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785874841; x=1786479641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6d+vbD9wuzkkuB/nbI31f2jI9KftyE/vm8BKPz6LeI=;
        b=s0BU6UMWtmUVspS/MCyk80Xm6kYc1Pm6qnaxvgYeNYAsa3dbphXMV/WuhP2GBOhKzH
         B72J/f4Ft2/IDBE8XCgWw7sunhvcAwjL7thEfnLYG36fWJC7idm38/ynC/HyrkwuTB2j
         3qH/aTy+bANN8tiYlflZ8DXEJJHL80+VpaP9iairXgyv/v1tcInLrIsrBgWDOV6HM1el
         RH2/Nu+9UPf7DiCmJsBHEC+ZOb7S04MqEE1mMNgpmbFoYjzPfMHaHyQO377goa1C70Vh
         7KZxDiy0iUgfeJR8eBBOVO1aiww2OV4uF6Kiotf0JqTHDLy7+JGef16YS1iOsHGxiGTE
         vZgw==
X-Gm-Message-State: AOJu0YwoV/30MEdaMdlXOWKAtvDmXrOFE0oKb7gaq8yjXPxD7wghBVjE
	nItiRFYhu8/zGfie1iN8cY1kiT//9LpX1sudWYn4VZ9EZGViTzK95MYM
X-Gm-Gg: AR+sD13Ey843FbaIHZEOqPZRwFdqHcctBnfy24OpD6UlnjJlrZVaWAa88j1oJQWQ80Q
	pxo4R1YLINxc0R+7a2dcIkzKTnhKUnn5C4v6EoSyYtW4ME6rO39rKkMFJr1Izyt8dj/zEzri159
	rHNuRgcYDrYKsn7oajN+Cr0gepZGMukPz1WLnsqdkApZPz2JxNztnybsmi71z2IpBfbAfou/7oy
	Kv0JGfKWSARe3lgWC1nYUMm/glBp5iM3zB6cDuaCWJ11TGY99jtPXvQGZzRnnaZt0dDJ1fmopIr
	wb8FuCWlZRvLNVnt76OmvrvKku8DPawGTNucwhFP7lSRiNh8n7u9/Kpw/XOSE5Td/0xp+9OsHM5
	wfBjA/juA9N7T5M1MohbsH8FTFi8NBfHfPGfyGL6oapMAoYVbDNMm6e4bXVr1E/C34F87IZlm1F
	8gFX1UojSijVEhj/OCwCDIfLax2namubv5DhsMSDuGuvGj4M4qzu1D8Ynj1lRFFUmCI36pyA4c5
	O4jf4QBKB/ZseVx6L4FppuWRU7yRxc=
X-Received: by 2002:a05:6a20:cfa2:b0:3c4:397a:69b8 with SMTP id adf61e73a8af0-3cb85e6c93amr1631362637.21.1785874841253;
        Tue, 04 Aug 2026 13:20:41 -0700 (PDT)
Received: from localhost ([2409:40c4:2007:21a9:9627:a686:aad0:561f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673a9e4sm9012952eec.18.2026.08.04.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:20:40 -0700 (PDT)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	rydberg@bitmath.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
	mayhemandcoffee <mayhemandcoffee@gmail.com>
Subject: [PATCH] HID: multitouch: Add report ID mismatch quirk for ASUS ROG Z13 Folio
Date: Wed,  5 Aug 2026 01:50:31 +0530
Message-ID: <20260804202031.75738-1-lovekeshsolanki00@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e716edafedad ("HID: multitouch: Check to ensure report
responses match the request") introduced validating GET_FEATURE
responses return the requested report ID.

ASUS ROG Z13 Flow (2025) GZ302EA touchpad (USB 0b05:1a30) returns
a different report ID for Win8 feature request. Before this check,
the response was still processed and allowed device to switch into
its full Touchpad Precision mode.

After the validation, the response is discarded before
hid_report_raw_event() processes it and device remains in fallback
mode and no longer exposes ABS_MT_SLOT, ABS_MT_TOOL_TYPE or the
multi-finger BTN_TOOL_* capabilities for palm rejection.

Add a device quirk to allow the known firmware behavior for
this device while preserving report ID validation for all other
devices.

The device previously matched the generic MT_CLS_WIN_8 entry, so
base the new class on MT_CLS_WIN_8 to keep it on the same quirk set
as before the regression.  MT_QUIRK_CONFIDENCE must be set
explicitly: it is normally enabled by the class name check in
mt_touch_input_mapping(), which only matches the MT_CLS_WIN_8*
names, and it is what makes ABS_MT_TOOL_TYPE available for
touchpads.

Fixes: e716edafedad ("HID: multitouch: Check to ensure report responses match the request")

Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Reported-by: mayhemandcoffee <mayhemandcoffee@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221774
Tested-by: mayhemandcoffee <mayhemandcoffee@gmail.com>
---
 drivers/hid/hid-multitouch.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index edb37b4c867e..de421ae47848 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -79,6 +79,7 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_APPLE_TOUCHBAR		BIT(23)
 #define MT_QUIRK_YOGABOOK9I		BIT(24)
 #define MT_QUIRK_KEEP_LATENCY_ON_CLOSE	BIT(25)
+#define MT_QUIRK_IGNORE_FEATURE_ID_MISMATCH	BIT(26)
 
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
@@ -235,6 +236,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
 #define MT_CLS_APPLE_TOUCHBAR			0x0114
 #define MT_CLS_YOGABOOK9I			0x0115
 #define MT_CLS_EGALAX_P80H84			0x0116
+#define MT_CLS_ASUS_ROG_Z13_FOLIO		0x0117
 #define MT_CLS_SIS				0x0457
 
 #define MT_DEFAULT_MAXCONTACT	10
@@ -405,6 +407,16 @@ static const struct mt_class mt_classes[] = {
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
 			MT_QUIRK_ASUS_CUSTOM_UP },
+	{ .name = MT_CLS_ASUS_ROG_Z13_FOLIO,
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_IGNORE_DUPLICATES |
+			MT_QUIRK_HOVERING |
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_STICKY_FINGERS |
+			MT_QUIRK_WIN8_PTP_BUTTONS |
+			MT_QUIRK_CONFIDENCE |
+			MT_QUIRK_IGNORE_FEATURE_ID_MISMATCH,
+		.export_all_inputs = true },
 	{ .name = MT_CLS_VTL,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
@@ -507,6 +519,7 @@ static const struct attribute_group mt_attribute_group = {
 
 static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 {
+	struct mt_device *td = hid_get_drvdata(hdev);
 	int ret;
 	u32 size = hid_report_len(report);
 	u8 *buf;
@@ -528,8 +541,14 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 		dev_warn(&hdev->dev, "failed to fetch feature %d\n",
 			 report->id);
 	} else {
-		/* The report ID in the request and the response should match */
-		if (report->id != buf[0]) {
+		/*
+		 * The report ID in the request and the response should match.
+		 * Some firmware (e.g. the ASUS ROG Z13 Folio
+		 * touchpad) returns a mismatched ID on this specific fetch;
+		 * tolerate it only for devices explicitly flagged as such.
+		 */
+		if (report->id != buf[0] &&
+		    !(td->mtclass.quirks & MT_QUIRK_IGNORE_FEATURE_ID_MISMATCH)) {
 			hid_err(hdev, "Returned feature report did not match the request\n");
 			goto free;
 		}
@@ -2726,6 +2745,12 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			   I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288) },
 
+	/* Asus ROG Flow Z13 (2025) GZ302EA keyboard-cover touchpad */
+	{ .driver_data = MT_CLS_ASUS_ROG_Z13_FOLIO,
+		HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_ASUSTEK,
+			USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO) },
+
 	/* Generic MT device */
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_MULTITOUCH, HID_ANY_ID, HID_ANY_ID) },
 
-- 
2.55.0

