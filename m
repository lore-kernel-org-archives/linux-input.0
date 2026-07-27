Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12041D4F1
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164147; cv=none; b=M5TUYKT5Gwmn9/9+BGSyyT4uIbdQ0vtUPv6rnMjl7emfMu3gohv704kwmVUMUsVEa5u6Sxk8ZpBTD/P16GnNNbYW3BY96fMAAGTG4xTpJrBTBQdlqBmmpVQVl9CSOXbk46f81XjHrZsLGCXogHyz+6blyY2gIkNmKjwndhptMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164147; c=relaxed/simple;
	bh=bJrLzecpfTUo7kxNNFlhCL/BU9mzR61RxnMrVok7Nq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NskJttKT3CrLSHrAng9SiCsS2QCawb4QH8QyJmZ8woykMETbduD6iPyRHvLNKioZuS0SOmH4UpRMrYFmDwj2uf6rT4ib6YdFXdEYOj/+mas/a8VEe2yMO25bI5YJ/Vn/WkuS4tBs+WwUGlDORJSr7wDz8qCFlZFub62b0mylnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=TWADOGbK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="TWADOGbK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso14440875e9.3
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785164142; x=1785768942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GwT2mOWLYnjxLX3mlHCZ6xT3IxjQjU8Zp0KHC+ZYUjs=;
        b=TWADOGbKB04LV9+UoIgDxfGZCMTCP+zpNYVk10MfBOqtQvHJGTu5u4MrizxeQ6ef60
         ns0AcPF3dEuZsjb72d+Y1dzHirA/LZutX92uCmAcwMxbCuOQvJ+Vn+xlj90qXODC1KL1
         GgdYjvfqyaUGOGY5RDkYwqL7NK4X3nO4e56vH/2eOC1IEcQAdB0cKBrGB/XNDiT7DXus
         O6NBEwJfJhZeOQQ95eaObGRZDDSqSSz3GjMhS1+ZYAIIeQDXXcfsWH6sW4fUHXuIHJjW
         8/d3WLbCUWdNLibr5VtI2HW9MP1mpQ09nnaI4Io0xhj0mi1oXw51UP3/0RXlWfvb5Tgw
         ZKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164142; x=1785768942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GwT2mOWLYnjxLX3mlHCZ6xT3IxjQjU8Zp0KHC+ZYUjs=;
        b=APNjgB+XB2XCOP9UuAKoV9qp2o9KMbykq+QnzBqUV+UTLwXnWBBHsXoeMXpy6zWjJY
         aWYVhi5mRcoC5P6IAPwsjl8z3EKwhT87uA9p7UEjBaiP88bV2au+K8KHjKmgrCJ55RbH
         lul+XH+fn1blI2lySS1CacmwbwskMK1e0EQGMTR2gQu+X7HJrLUjI8Z5VmWdTmPOdEbZ
         EI5T6Qd9PHSRt1VgPZANI7zkg4575nBfQ0PqmJVxjMUXJOILgE5xNvzaO2Rk1fFMKcoL
         U1ft5r42lbzB4emG5U/IM53k9o0AsKobSAMMyLU9/C2O102sr4Sp+vROtvg+MPh4xS48
         hg/g==
X-Forwarded-Encrypted: i=1; AHgh+RrvcHRhMUmcnqh5SdnoRUeMWM6Kytgb4TP66oZI/ZDz10HIYpNjdqdS+P0HzLr+ueyKVKqVALRXOpeGyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/IczgPdfHUIzAvRF/Ethr8Tq1ITuoEGvqkVUKDIlTn2EEvL2Y
	6HUZClJzOiee8y0H6KuQc5M8c8wTMLC7cJCF2CF0NXhc19kIZRl3v+idC99pcLQpztWRoqXBlrc
	KanMo9RQ=
X-Gm-Gg: AR+sD13nm39/6Ndqo9pB4g+ey60ThrEEYZGARSTFsSA8F/xoSj2W9sq5UdVKxvv26Iy
	qOyrSjYGsgdiCDX5Z3b8f94XDCj49ftQGPWsEWDunns51kABnC0YWfHLRPQNrqVquKL5TxJwQ6J
	bjCQluVAkoNY3ATiE1y3/sT6JdsSmyzAC1WZ1R3ZYo6HP6jEsG2aXsJzKY6jw/VLU7AQyPQvHuh
	2hzEcxBSy816c3D9u18ZqPXUk1y2yvrq5YAGCSsIT7dMszN6PWTV75EUd2fxTVEqlEzDKOSs9PG
	ziNvA6Yj/DNrEe17fXu5lNil/0Xttg8oMbRQCghh0xijFadCcdLuYA8N1JpKfQff1Ts20cjHt9w
	3dPCLy5hQ6+u/Fz7wygeHja5w/L/EPFsy8ScPmGTp9JClMzRMI5qhg8iaXarYYav0ph9pReItHy
	ryzhqEu2TtQHUSl79tWk8=
X-Received: by 2002:a05:600c:630d:b0:495:4d35:5eab with SMTP id 5b1f17b1804b1-496b5747e37mr118462355e9.24.1785164142464;
        Mon, 27 Jul 2026 07:55:42 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm254241585e9.1.2026.07.27.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:55:42 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 15:55:33 +0100
Subject: [PATCH v3 8/8] HID: wacom: do not use 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mod-devicetable-hid_device_id-v3-8-980896ca283e@thegoodpenguin.co.uk>
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
In-Reply-To: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785164134; l=15808;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=bJrLzecpfTUo7kxNNFlhCL/BU9mzR61RxnMrVok7Nq8=;
 b=6XzXbhnW/fQdUkELC2rHRZGNdRtTk8YrPCUhVfWDc9zd2+D3HRjFy7GMr8EVnG3G1RHdQyIfJ
 CDy/QZ1L3ZQArHWUek35qBexyeo8G0+4Rg7AQXakR7NS7X2ZNH7ijKk
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

The driver data field is used to match the product with
a 'wacom_features' struct via a remapped enum - since
we already have to look it up at runtime and validate,
we can just remove the remapping and look up the
'wacom_features' directly by the product id.

This makes the code easier to edit and maintain. It also
reduces the complexity of macro magic and keeps macros
local to the module.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/wacom.h     | 178 +------------------------------------------
 drivers/hid/wacom_sys.c |   7 +-
 drivers/hid/wacom_wac.c | 197 +++++++++++++++++++++++++++++++++++++++++++-----
 drivers/hid/wacom_wac.h |   5 ++
 4 files changed, 186 insertions(+), 201 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 115d0eb23277..80a1a5d09e55 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -228,182 +228,6 @@ static inline u32 wacom_rescale(u32 value, u32 in_max, u32 out_max)
 
 extern const struct hid_device_id wacom_ids[];
 
-/* This table lists all unique product IDs that are matched with
- * a corresponging wacom_features_##prod struct. So any new product
- * should be added to this table.
- */
-#define HID_WACOM_PRODUCT_TABLE() \
-	table_entry(0x00) \
-	table_entry(0x03) \
-	table_entry(0x10) \
-	table_entry(0x11) \
-	table_entry(0x12) \
-	table_entry(0x13) \
-	table_entry(0x14) \
-	table_entry(0x15) \
-	table_entry(0x16) \
-	table_entry(0x17) \
-	table_entry(0x18) \
-	table_entry(0x19) \
-	table_entry(0x20) \
-	table_entry(0x21) \
-	table_entry(0x22) \
-	table_entry(0x23) \
-	table_entry(0x24) \
-	table_entry(0x26) \
-	table_entry(0x27) \
-	table_entry(0x28) \
-	table_entry(0x29) \
-	table_entry(0x2A) \
-	table_entry(0x30) \
-	table_entry(0x31) \
-	table_entry(0x32) \
-	table_entry(0x33) \
-	table_entry(0x34) \
-	table_entry(0x35) \
-	table_entry(0x37) \
-	table_entry(0x38) \
-	table_entry(0x39) \
-	table_entry(0x3F) \
-	table_entry(0x41) \
-	table_entry(0x42) \
-	table_entry(0x43) \
-	table_entry(0x44) \
-	table_entry(0x45) \
-	table_entry(0x47) \
-	table_entry(0x57) \
-	table_entry(0x59) \
-	table_entry(0x5B) \
-	table_entry(0x5D) \
-	table_entry(0x5E) \
-	table_entry(0x60) \
-	table_entry(0x61) \
-	table_entry(0x62) \
-	table_entry(0x63) \
-	table_entry(0x64) \
-	table_entry(0x65) \
-	table_entry(0x69) \
-	table_entry(0x6A) \
-	table_entry(0x6B) \
-	table_entry(0x81) \
-	table_entry(0x84) \
-	table_entry(0x90) \
-	table_entry(0x93) \
-	table_entry(0x94) \
-	table_entry(0x97) \
-	table_entry(0x9A) \
-	table_entry(0x9F) \
-	table_entry(0xB0) \
-	table_entry(0xB1) \
-	table_entry(0xB2) \
-	table_entry(0xB3) \
-	table_entry(0xB4) \
-	table_entry(0xB5) \
-	table_entry(0xB7) \
-	table_entry(0xB8) \
-	table_entry(0xB9) \
-	table_entry(0xBA) \
-	table_entry(0xBB) \
-	table_entry(0xBC) \
-	table_entry(0xBD) \
-	table_entry(0xC0) \
-	table_entry(0xC2) \
-	table_entry(0xC4) \
-	table_entry(0xC5) \
-	table_entry(0xC6) \
-	table_entry(0xC7) \
-	table_entry(0xCC) \
-	table_entry(0xCE) \
-	table_entry(0xD0) \
-	table_entry(0xD1) \
-	table_entry(0xD2) \
-	table_entry(0xD3) \
-	table_entry(0xD4) \
-	table_entry(0xD5) \
-	table_entry(0xD6) \
-	table_entry(0xD7) \
-	table_entry(0xD8) \
-	table_entry(0xDA) \
-	table_entry(0xDB) \
-	table_entry(0xDD) \
-	table_entry(0xDE) \
-	table_entry(0xDF) \
-	table_entry(0xE2) \
-	table_entry(0xE3) \
-	table_entry(0xE5) \
-	table_entry(0xE6) \
-	table_entry(0xEC) \
-	table_entry(0xED) \
-	table_entry(0xEF) \
-	table_entry(0xF0) \
-	table_entry(0xF4) \
-	table_entry(0xF6) \
-	table_entry(0xF8) \
-	table_entry(0xFA) \
-	table_entry(0xFB) \
-	table_entry(0x100) \
-	table_entry(0x101) \
-	table_entry(0x10D) \
-	table_entry(0x10E) \
-	table_entry(0x10F) \
-	table_entry(0x116) \
-	table_entry(0x12C) \
-	table_entry(0x300) \
-	table_entry(0x301) \
-	table_entry(0x302) \
-	table_entry(0x303) \
-	table_entry(0x304) \
-	table_entry(0x307) \
-	table_entry(0x309) \
-	table_entry(0x30A) \
-	table_entry(0x30C) \
-	table_entry(0x30E) \
-	table_entry(0x314) \
-	table_entry(0x315) \
-	table_entry(0x317) \
-	table_entry(0x318) \
-	table_entry(0x319) \
-	table_entry(0x323) \
-	table_entry(0x325) \
-	table_entry(0x326) \
-	table_entry(0x32A) \
-	table_entry(0x32B) \
-	table_entry(0x32C) \
-	table_entry(0x32F) \
-	table_entry(0x331) \
-	table_entry(0x333) \
-	table_entry(0x335) \
-	table_entry(0x336) \
-	table_entry(0x33B) \
-	table_entry(0x33C) \
-	table_entry(0x33D) \
-	table_entry(0x33E) \
-	table_entry(0x343) \
-	table_entry(0x360) \
-	table_entry(0x361) \
-	table_entry(0x377) \
-	table_entry(0x379) \
-	table_entry(0x37A) \
-	table_entry(0x37B) \
-	table_entry(0x393) \
-	table_entry(0x3c6) \
-	table_entry(0x3c8) \
-	table_entry(0x3dd) \
-	table_entry(0x4001) \
-	table_entry(0x4004) \
-	table_entry(0x5000) \
-	table_entry(0x5002) \
-	table_entry(0x6004) \
-	table_entry(HID_ANY_ID) \
-
-enum wacom_features_table_index {
-#define table_entry(product)	\
-	WACOM_FEATURE_TABLE_##product,
-	HID_WACOM_PRODUCT_TABLE()
-	NUM_OF_WACOM_FEATURES_IN_TABLE
-#undef table_entry
-};
-
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
 void wacom_setup_device_quirks(struct wacom *wacom);
 int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
@@ -425,5 +249,5 @@ struct wacom_led *wacom_led_next(struct wacom *wacom, struct wacom_led *cur);
 int wacom_equivalent_usage(int usage);
 int wacom_initialize_leds(struct wacom *wacom);
 void wacom_idleprox_timeout(struct timer_list *list);
-const struct wacom_features *get_wacom_features(enum wacom_features_table_index index);
+const struct wacom_features *get_wacom_features(u32 product);
 #endif
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 834519751a5c..4514b2762cc3 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2559,7 +2559,7 @@ static void wacom_wireless_work(struct work_struct *work)
 		}
 
 		/* Stylus interface */
-		const struct wacom_features *features = get_wacom_features(id->driver_data);
+		const struct wacom_features *features = get_wacom_features(id->product);
 
 		if (!features) {
 			hid_err(wacom->hdev, "could not get wacom features.\n");
@@ -2831,9 +2831,6 @@ static int wacom_probe(struct hid_device *hdev,
 	struct wacom_features *features;
 	int error;
 
-	if (!id->driver_data)
-		return -EINVAL;
-
 	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
 
 	/* hid-core sets this quirk for the boot interface */
@@ -2848,7 +2845,7 @@ static int wacom_probe(struct hid_device *hdev,
 
 	wacom_wac = &wacom->wacom_wac;
 
-	const struct wacom_features *id_features = get_wacom_features(id->driver_data);
+	const struct wacom_features *id_features = get_wacom_features(id->product);
 
 	if (!id_features) {
 		hid_err(wacom->hdev, "could not get wacom id_features.\n");
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index d0a864d52509..e066aa334837 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -4945,40 +4945,199 @@ static const struct wacom_features wacom_features_HID_ANY_ID =
 static const struct wacom_features wacom_features_0x94 =
 	{ "Wacom Bootloader", .type = BOOTLOADER };
 
-static const struct wacom_features *wacom_features_table[] = {
-#define table_entry(product)				\
-	[WACOM_FEATURE_TABLE_##product] = &wacom_features_##product,
-	HID_WACOM_PRODUCT_TABLE()
-#undef table_entry
+#define WACOM_FEATURE_TABLE_ENTRY(product_id)			\
+	{.product = product_id, .wacom_features_ptr = &wacom_features_##product_id}
+
+static const struct wacom_features_table_item wacom_features_table[] = {
+	WACOM_FEATURE_TABLE_ENTRY(0x00),
+	WACOM_FEATURE_TABLE_ENTRY(0x03),
+	WACOM_FEATURE_TABLE_ENTRY(0x10),
+	WACOM_FEATURE_TABLE_ENTRY(0x11),
+	WACOM_FEATURE_TABLE_ENTRY(0x12),
+	WACOM_FEATURE_TABLE_ENTRY(0x13),
+	WACOM_FEATURE_TABLE_ENTRY(0x14),
+	WACOM_FEATURE_TABLE_ENTRY(0x15),
+	WACOM_FEATURE_TABLE_ENTRY(0x16),
+	WACOM_FEATURE_TABLE_ENTRY(0x17),
+	WACOM_FEATURE_TABLE_ENTRY(0x18),
+	WACOM_FEATURE_TABLE_ENTRY(0x19),
+	WACOM_FEATURE_TABLE_ENTRY(0x20),
+	WACOM_FEATURE_TABLE_ENTRY(0x21),
+	WACOM_FEATURE_TABLE_ENTRY(0x22),
+	WACOM_FEATURE_TABLE_ENTRY(0x23),
+	WACOM_FEATURE_TABLE_ENTRY(0x24),
+	WACOM_FEATURE_TABLE_ENTRY(0x26),
+	WACOM_FEATURE_TABLE_ENTRY(0x27),
+	WACOM_FEATURE_TABLE_ENTRY(0x28),
+	WACOM_FEATURE_TABLE_ENTRY(0x29),
+	WACOM_FEATURE_TABLE_ENTRY(0x2A),
+	WACOM_FEATURE_TABLE_ENTRY(0x30),
+	WACOM_FEATURE_TABLE_ENTRY(0x31),
+	WACOM_FEATURE_TABLE_ENTRY(0x32),
+	WACOM_FEATURE_TABLE_ENTRY(0x33),
+	WACOM_FEATURE_TABLE_ENTRY(0x34),
+	WACOM_FEATURE_TABLE_ENTRY(0x35),
+	WACOM_FEATURE_TABLE_ENTRY(0x37),
+	WACOM_FEATURE_TABLE_ENTRY(0x38),
+	WACOM_FEATURE_TABLE_ENTRY(0x39),
+	WACOM_FEATURE_TABLE_ENTRY(0x3F),
+	WACOM_FEATURE_TABLE_ENTRY(0x41),
+	WACOM_FEATURE_TABLE_ENTRY(0x42),
+	WACOM_FEATURE_TABLE_ENTRY(0x43),
+	WACOM_FEATURE_TABLE_ENTRY(0x44),
+	WACOM_FEATURE_TABLE_ENTRY(0x45),
+	WACOM_FEATURE_TABLE_ENTRY(0x47),
+	WACOM_FEATURE_TABLE_ENTRY(0x57),
+	WACOM_FEATURE_TABLE_ENTRY(0x59),
+	WACOM_FEATURE_TABLE_ENTRY(0x5B),
+	WACOM_FEATURE_TABLE_ENTRY(0x5D),
+	WACOM_FEATURE_TABLE_ENTRY(0x5E),
+	WACOM_FEATURE_TABLE_ENTRY(0x60),
+	WACOM_FEATURE_TABLE_ENTRY(0x61),
+	WACOM_FEATURE_TABLE_ENTRY(0x62),
+	WACOM_FEATURE_TABLE_ENTRY(0x63),
+	WACOM_FEATURE_TABLE_ENTRY(0x64),
+	WACOM_FEATURE_TABLE_ENTRY(0x65),
+	WACOM_FEATURE_TABLE_ENTRY(0x69),
+	WACOM_FEATURE_TABLE_ENTRY(0x6A),
+	WACOM_FEATURE_TABLE_ENTRY(0x6B),
+	WACOM_FEATURE_TABLE_ENTRY(0x81),
+	WACOM_FEATURE_TABLE_ENTRY(0x84),
+	WACOM_FEATURE_TABLE_ENTRY(0x90),
+	WACOM_FEATURE_TABLE_ENTRY(0x93),
+	WACOM_FEATURE_TABLE_ENTRY(0x94),
+	WACOM_FEATURE_TABLE_ENTRY(0x97),
+	WACOM_FEATURE_TABLE_ENTRY(0x9A),
+	WACOM_FEATURE_TABLE_ENTRY(0x9F),
+	WACOM_FEATURE_TABLE_ENTRY(0xB0),
+	WACOM_FEATURE_TABLE_ENTRY(0xB1),
+	WACOM_FEATURE_TABLE_ENTRY(0xB2),
+	WACOM_FEATURE_TABLE_ENTRY(0xB3),
+	WACOM_FEATURE_TABLE_ENTRY(0xB4),
+	WACOM_FEATURE_TABLE_ENTRY(0xB5),
+	WACOM_FEATURE_TABLE_ENTRY(0xB7),
+	WACOM_FEATURE_TABLE_ENTRY(0xB8),
+	WACOM_FEATURE_TABLE_ENTRY(0xB9),
+	WACOM_FEATURE_TABLE_ENTRY(0xBA),
+	WACOM_FEATURE_TABLE_ENTRY(0xBB),
+	WACOM_FEATURE_TABLE_ENTRY(0xBC),
+	WACOM_FEATURE_TABLE_ENTRY(0xBD),
+	WACOM_FEATURE_TABLE_ENTRY(0xC0),
+	WACOM_FEATURE_TABLE_ENTRY(0xC2),
+	WACOM_FEATURE_TABLE_ENTRY(0xC4),
+	WACOM_FEATURE_TABLE_ENTRY(0xC5),
+	WACOM_FEATURE_TABLE_ENTRY(0xC6),
+	WACOM_FEATURE_TABLE_ENTRY(0xC7),
+	WACOM_FEATURE_TABLE_ENTRY(0xCC),
+	WACOM_FEATURE_TABLE_ENTRY(0xCE),
+	WACOM_FEATURE_TABLE_ENTRY(0xD0),
+	WACOM_FEATURE_TABLE_ENTRY(0xD1),
+	WACOM_FEATURE_TABLE_ENTRY(0xD2),
+	WACOM_FEATURE_TABLE_ENTRY(0xD3),
+	WACOM_FEATURE_TABLE_ENTRY(0xD4),
+	WACOM_FEATURE_TABLE_ENTRY(0xD5),
+	WACOM_FEATURE_TABLE_ENTRY(0xD6),
+	WACOM_FEATURE_TABLE_ENTRY(0xD7),
+	WACOM_FEATURE_TABLE_ENTRY(0xD8),
+	WACOM_FEATURE_TABLE_ENTRY(0xDA),
+	WACOM_FEATURE_TABLE_ENTRY(0xDB),
+	WACOM_FEATURE_TABLE_ENTRY(0xDD),
+	WACOM_FEATURE_TABLE_ENTRY(0xDE),
+	WACOM_FEATURE_TABLE_ENTRY(0xDF),
+	WACOM_FEATURE_TABLE_ENTRY(0xE2),
+	WACOM_FEATURE_TABLE_ENTRY(0xE3),
+	WACOM_FEATURE_TABLE_ENTRY(0xE5),
+	WACOM_FEATURE_TABLE_ENTRY(0xE6),
+	WACOM_FEATURE_TABLE_ENTRY(0xEC),
+	WACOM_FEATURE_TABLE_ENTRY(0xED),
+	WACOM_FEATURE_TABLE_ENTRY(0xEF),
+	WACOM_FEATURE_TABLE_ENTRY(0xF0),
+	WACOM_FEATURE_TABLE_ENTRY(0xF4),
+	WACOM_FEATURE_TABLE_ENTRY(0xF6),
+	WACOM_FEATURE_TABLE_ENTRY(0xF8),
+	WACOM_FEATURE_TABLE_ENTRY(0xFA),
+	WACOM_FEATURE_TABLE_ENTRY(0xFB),
+	WACOM_FEATURE_TABLE_ENTRY(0x100),
+	WACOM_FEATURE_TABLE_ENTRY(0x101),
+	WACOM_FEATURE_TABLE_ENTRY(0x10D),
+	WACOM_FEATURE_TABLE_ENTRY(0x10E),
+	WACOM_FEATURE_TABLE_ENTRY(0x10F),
+	WACOM_FEATURE_TABLE_ENTRY(0x116),
+	WACOM_FEATURE_TABLE_ENTRY(0x12C),
+	WACOM_FEATURE_TABLE_ENTRY(0x300),
+	WACOM_FEATURE_TABLE_ENTRY(0x301),
+	WACOM_FEATURE_TABLE_ENTRY(0x302),
+	WACOM_FEATURE_TABLE_ENTRY(0x303),
+	WACOM_FEATURE_TABLE_ENTRY(0x304),
+	WACOM_FEATURE_TABLE_ENTRY(0x307),
+	WACOM_FEATURE_TABLE_ENTRY(0x309),
+	WACOM_FEATURE_TABLE_ENTRY(0x30A),
+	WACOM_FEATURE_TABLE_ENTRY(0x30C),
+	WACOM_FEATURE_TABLE_ENTRY(0x30E),
+	WACOM_FEATURE_TABLE_ENTRY(0x314),
+	WACOM_FEATURE_TABLE_ENTRY(0x315),
+	WACOM_FEATURE_TABLE_ENTRY(0x317),
+	WACOM_FEATURE_TABLE_ENTRY(0x318),
+	WACOM_FEATURE_TABLE_ENTRY(0x319),
+	WACOM_FEATURE_TABLE_ENTRY(0x323),
+	WACOM_FEATURE_TABLE_ENTRY(0x325),
+	WACOM_FEATURE_TABLE_ENTRY(0x326),
+	WACOM_FEATURE_TABLE_ENTRY(0x32A),
+	WACOM_FEATURE_TABLE_ENTRY(0x32B),
+	WACOM_FEATURE_TABLE_ENTRY(0x32C),
+	WACOM_FEATURE_TABLE_ENTRY(0x32F),
+	WACOM_FEATURE_TABLE_ENTRY(0x331),
+	WACOM_FEATURE_TABLE_ENTRY(0x333),
+	WACOM_FEATURE_TABLE_ENTRY(0x335),
+	WACOM_FEATURE_TABLE_ENTRY(0x336),
+	WACOM_FEATURE_TABLE_ENTRY(0x33B),
+	WACOM_FEATURE_TABLE_ENTRY(0x33C),
+	WACOM_FEATURE_TABLE_ENTRY(0x33D),
+	WACOM_FEATURE_TABLE_ENTRY(0x33E),
+	WACOM_FEATURE_TABLE_ENTRY(0x343),
+	WACOM_FEATURE_TABLE_ENTRY(0x360),
+	WACOM_FEATURE_TABLE_ENTRY(0x361),
+	WACOM_FEATURE_TABLE_ENTRY(0x377),
+	WACOM_FEATURE_TABLE_ENTRY(0x379),
+	WACOM_FEATURE_TABLE_ENTRY(0x37A),
+	WACOM_FEATURE_TABLE_ENTRY(0x37B),
+	WACOM_FEATURE_TABLE_ENTRY(0x393),
+	WACOM_FEATURE_TABLE_ENTRY(0x3c6),
+	WACOM_FEATURE_TABLE_ENTRY(0x3c8),
+	WACOM_FEATURE_TABLE_ENTRY(0x3dd),
+	WACOM_FEATURE_TABLE_ENTRY(0x4001),
+	WACOM_FEATURE_TABLE_ENTRY(0x4004),
+	WACOM_FEATURE_TABLE_ENTRY(0x5000),
+	WACOM_FEATURE_TABLE_ENTRY(0x5002),
+	WACOM_FEATURE_TABLE_ENTRY(0x6004),
+	WACOM_FEATURE_TABLE_ENTRY(HID_ANY_ID),
 };
 
-const struct wacom_features *get_wacom_features(enum wacom_features_table_index index)
+const struct wacom_features *get_wacom_features(u32 product)
 {
-	if (index >= NUM_OF_WACOM_FEATURES_IN_TABLE)
-		return NULL;
+	int i;
 
-	return wacom_features_table[index];
+	for (i = 0; i < ARRAY_SIZE(wacom_features_table); i++)
+		if (wacom_features_table[i].product == product)
+			return wacom_features_table[i].wacom_features_ptr;
+
+	return NULL;
 }
 
 #define USB_DEVICE_WACOM(prod)						\
-	HID_DEVICE(BUS_USB, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = WACOM_FEATURE_TABLE_##prod
+	HID_DEVICE(BUS_USB, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod)
 
 #define BT_DEVICE_WACOM(prod)						\
-	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = WACOM_FEATURE_TABLE_##prod
+	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod)
 
 #define I2C_DEVICE_WACOM(prod)						\
-	HID_DEVICE(BUS_I2C, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = WACOM_FEATURE_TABLE_##prod
+	HID_DEVICE(BUS_I2C, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod)
 
 #define PCI_DEVICE_WACOM(prod)						\
-	HID_DEVICE(BUS_PCI, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = WACOM_FEATURE_TABLE_##prod
+	HID_DEVICE(BUS_PCI, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod)
 
 #define USB_DEVICE_LENOVO(prod)					\
-	HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, prod),			\
-	.driver_data = WACOM_FEATURE_TABLE_##prod
+	HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, prod)
 
 const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x00) },
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 126bec6e5c0c..ecb85c459d9a 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -279,6 +279,11 @@ struct wacom_features {
 	int hid_type;
 };
 
+struct wacom_features_table_item {
+	u32 product;
+	const struct wacom_features *wacom_features_ptr;
+};
+
 struct wacom_shared {
 	bool stylus_in_proximity;
 	bool touch_down;

-- 
2.43.0

