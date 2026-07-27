Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502D941C2FB
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164146; cv=none; b=RtkCeyUx4oqLZFk1VFgCLvOl89UV2fssZBC+ufipu7ANvRMrNlkTHZb1QuulZFSpuROd79U/6BZCuo7seVRfR88jvT3OsLxKKI/aajQc4r8DCYmrn17pXo9L7h2lzzkbbVnIxs39brlHyyn+RYgMBvfb0ovp+R748txSBnlEm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164146; c=relaxed/simple;
	bh=eupl724npbu/tVWbFUtDgkqYoJkNnxWhKkwdUvnYUz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Np2eeWARmL8nmyb/vE6SD6aLJ2P+qycP6JWfYu14kSas0Ber1Pd2xiCpwJcQYnRQqs2Pvf93MyaXLNqB34w9rWP+pVT3lWGD3oq173BXO4MhR+1iBNeYy6BiQNDvjZ6JfDz2FAYyMBAioJ2Z/WSnfW1WBFKy15+Td1bKEiwqJ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=JjHemDE2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="JjHemDE2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so19357165e9.1
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785164140; x=1785768940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KYDFpA7Huw9LUy+VPqRQWbQAVzVmWp3v3ZuAVf0uLfE=;
        b=JjHemDE2l2G8nIdzds0zMKEG7Cx4SAk+pwOs9s/przSx65HGFVvB6uwO1ZfMTP/lN6
         neho+gh7dDQYEXvbImCWaB8OqTvOhfZt+V/MX6UFddC8kVqBokcuIWhjc1awzTpRzZ7q
         sUzfS6Hm3cH3XT2NSe3e8+Qr2nUrxQDJ6HWRzsl10ROLknJXWH8n6chtviD/8CZu1Sh0
         pWbRoOKvrmRBXjZv6wvb6XOeAM5b++coOap1BXJm/m0QgZ3FeQ//4ryEDzCEMTPH6Klo
         oEvISSQXaYrVG70Z/CJZlKQm3XAEkXyFDuHS6D8IEPoUtdeN6dFqtsnD2Zowvl+6Ng2y
         N+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164140; x=1785768940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYDFpA7Huw9LUy+VPqRQWbQAVzVmWp3v3ZuAVf0uLfE=;
        b=eAldQV7RP1Ecg/ofx89UNiD6hh4vx3GMETPaix+7paMaEaJZ6nD+dKAvdEQUukcDys
         bbeeBUONHglcY/qcEcUhgqOrhAPY2ZcZSw6iqnVneX3d6VqVCHadLw0bkg5KS0qjvw05
         N3lywbGJPseyk4eZKmUQloMICnQBAkMWWjv5Xh21sCoMRlidOlrVaFFDHTYijkYdVG+D
         q5DYAl5LmqzDC2BQ09YPD81SJ+iUHPwztkhsneHFb4+Nsiw53kwt5ucdh++RNbAyR31j
         h1tg8jXzQcoqHeBJFmMB/jwWOW72zS2Zd9ySafnWVMzBrpjB+Di/KM/l0ym20xNKQ33z
         hlsg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6FovepLo41cXaFSi/KeVbXEK0ZcVzbbaqUc31eL/o1KA3sgPZgm6kYyt93RWyZYl2IDHEdX79FF1pxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt53xyZyljrlGqD3m0an5e4K7Utis2BfhA419aoKknQpUyQEbS
	Lku5S4OKCoKP4HvH48WKsIjZEBvtETClQNkt9Fj/m4Bp0opGbINkCGNhILh3kBIhhks6XLDnYIk
	usVH+9JM=
X-Gm-Gg: AR+sD13wgCCxSZN37RqIRpgCntCJnljV2ofWVtNXM8Zzw1T/eVC0eAh+qj7C0NNW1R/
	2pz+luIq5QXZHzjcdVWYujJmqYUryiee0jQdF/cvzSTgm7EETLZ+oAGNOTeG9VTxLrrQrAd7Sfb
	0TRXJBrMjK9PXdub+R6X4oy9ho+02PlqjSbzqcNlEMzsyc5oySPfCHSsbjP3yRs/4PP8LZENG27
	u62eojJUwNbVpZHInE2Ou+IOLpVcaoew405ertP0Lrbdmm8xScxXuI1Bjb66biBCpnmCrtTqN9l
	iKPs0lRTzBmeD1XGqVutMSQFI4WLOukMcXPpEx0hhMSiGwTHIn8AW54sTMpuku3R6hInQRFRAnM
	b4RaU/e9p8uSXeOOWt7zL2XYTcC+Ks5ejHMJI0cjmPKXtGZnzRaRpE9Z6Z8uqtsoB5B0v8YsdAs
	ZUhOkIiXGQ62EA0+VqXDQ=
X-Received: by 2002:a05:600c:6986:b0:495:8a1:7670 with SMTP id 5b1f17b1804b1-496b575d19amr124940925e9.35.1785164140573;
        Mon, 27 Jul 2026 07:55:40 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm254241585e9.1.2026.07.27.07.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:55:40 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 15:55:31 +0100
Subject: [PATCH v3 6/8] HID: wacom: cleanup usage of 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mod-devicetable-hid_device_id-v3-6-980896ca283e@thegoodpenguin.co.uk>
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
In-Reply-To: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785164134; l=9702;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=eupl724npbu/tVWbFUtDgkqYoJkNnxWhKkwdUvnYUz0=;
 b=+/tTwUh+ZO/2z2VYQ+2BJ5ZpZowPMsLByLcxwFvw/Gi3OU+b/mywX0TnGETYemMiItNIcOHjc
 xdlVVuYyEZwBzALSk32WhTdnBpI05j0DLMEPw6XuS1aAMd9tdksU2Le
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

This module is using the 'hid_device_id::driver_data' field
as a valid pointer to dereference. The hid subsystem allows
for injecting 'new_id' device via the command line. It follows
that it is more convenient to have 'driver_data' to be an integer
to allow the userspace to select a valid pointer via an index.

Lets enable this and store an index to the table of pointers
'wacom_features_table' instead, the access to this table is
bounded and checked at runtime via the 'wacom_features_table_index'
enum to avoid OOB dereferencing of objects.

The implementation relies heavily on the preprocessor - but
given the large amount of required entries (162) this is justified,
more robust and more resilient to user error than manual input.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/wacom.h     | 177 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/wacom_sys.c |  22 ++++--
 drivers/hid/wacom_wac.c |  25 +++++--
 3 files changed, 214 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 1deacb4568cb..115d0eb23277 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -228,6 +228,182 @@ static inline u32 wacom_rescale(u32 value, u32 in_max, u32 out_max)
 
 extern const struct hid_device_id wacom_ids[];
 
+/* This table lists all unique product IDs that are matched with
+ * a corresponging wacom_features_##prod struct. So any new product
+ * should be added to this table.
+ */
+#define HID_WACOM_PRODUCT_TABLE() \
+	table_entry(0x00) \
+	table_entry(0x03) \
+	table_entry(0x10) \
+	table_entry(0x11) \
+	table_entry(0x12) \
+	table_entry(0x13) \
+	table_entry(0x14) \
+	table_entry(0x15) \
+	table_entry(0x16) \
+	table_entry(0x17) \
+	table_entry(0x18) \
+	table_entry(0x19) \
+	table_entry(0x20) \
+	table_entry(0x21) \
+	table_entry(0x22) \
+	table_entry(0x23) \
+	table_entry(0x24) \
+	table_entry(0x26) \
+	table_entry(0x27) \
+	table_entry(0x28) \
+	table_entry(0x29) \
+	table_entry(0x2A) \
+	table_entry(0x30) \
+	table_entry(0x31) \
+	table_entry(0x32) \
+	table_entry(0x33) \
+	table_entry(0x34) \
+	table_entry(0x35) \
+	table_entry(0x37) \
+	table_entry(0x38) \
+	table_entry(0x39) \
+	table_entry(0x3F) \
+	table_entry(0x41) \
+	table_entry(0x42) \
+	table_entry(0x43) \
+	table_entry(0x44) \
+	table_entry(0x45) \
+	table_entry(0x47) \
+	table_entry(0x57) \
+	table_entry(0x59) \
+	table_entry(0x5B) \
+	table_entry(0x5D) \
+	table_entry(0x5E) \
+	table_entry(0x60) \
+	table_entry(0x61) \
+	table_entry(0x62) \
+	table_entry(0x63) \
+	table_entry(0x64) \
+	table_entry(0x65) \
+	table_entry(0x69) \
+	table_entry(0x6A) \
+	table_entry(0x6B) \
+	table_entry(0x81) \
+	table_entry(0x84) \
+	table_entry(0x90) \
+	table_entry(0x93) \
+	table_entry(0x94) \
+	table_entry(0x97) \
+	table_entry(0x9A) \
+	table_entry(0x9F) \
+	table_entry(0xB0) \
+	table_entry(0xB1) \
+	table_entry(0xB2) \
+	table_entry(0xB3) \
+	table_entry(0xB4) \
+	table_entry(0xB5) \
+	table_entry(0xB7) \
+	table_entry(0xB8) \
+	table_entry(0xB9) \
+	table_entry(0xBA) \
+	table_entry(0xBB) \
+	table_entry(0xBC) \
+	table_entry(0xBD) \
+	table_entry(0xC0) \
+	table_entry(0xC2) \
+	table_entry(0xC4) \
+	table_entry(0xC5) \
+	table_entry(0xC6) \
+	table_entry(0xC7) \
+	table_entry(0xCC) \
+	table_entry(0xCE) \
+	table_entry(0xD0) \
+	table_entry(0xD1) \
+	table_entry(0xD2) \
+	table_entry(0xD3) \
+	table_entry(0xD4) \
+	table_entry(0xD5) \
+	table_entry(0xD6) \
+	table_entry(0xD7) \
+	table_entry(0xD8) \
+	table_entry(0xDA) \
+	table_entry(0xDB) \
+	table_entry(0xDD) \
+	table_entry(0xDE) \
+	table_entry(0xDF) \
+	table_entry(0xE2) \
+	table_entry(0xE3) \
+	table_entry(0xE5) \
+	table_entry(0xE6) \
+	table_entry(0xEC) \
+	table_entry(0xED) \
+	table_entry(0xEF) \
+	table_entry(0xF0) \
+	table_entry(0xF4) \
+	table_entry(0xF6) \
+	table_entry(0xF8) \
+	table_entry(0xFA) \
+	table_entry(0xFB) \
+	table_entry(0x100) \
+	table_entry(0x101) \
+	table_entry(0x10D) \
+	table_entry(0x10E) \
+	table_entry(0x10F) \
+	table_entry(0x116) \
+	table_entry(0x12C) \
+	table_entry(0x300) \
+	table_entry(0x301) \
+	table_entry(0x302) \
+	table_entry(0x303) \
+	table_entry(0x304) \
+	table_entry(0x307) \
+	table_entry(0x309) \
+	table_entry(0x30A) \
+	table_entry(0x30C) \
+	table_entry(0x30E) \
+	table_entry(0x314) \
+	table_entry(0x315) \
+	table_entry(0x317) \
+	table_entry(0x318) \
+	table_entry(0x319) \
+	table_entry(0x323) \
+	table_entry(0x325) \
+	table_entry(0x326) \
+	table_entry(0x32A) \
+	table_entry(0x32B) \
+	table_entry(0x32C) \
+	table_entry(0x32F) \
+	table_entry(0x331) \
+	table_entry(0x333) \
+	table_entry(0x335) \
+	table_entry(0x336) \
+	table_entry(0x33B) \
+	table_entry(0x33C) \
+	table_entry(0x33D) \
+	table_entry(0x33E) \
+	table_entry(0x343) \
+	table_entry(0x360) \
+	table_entry(0x361) \
+	table_entry(0x377) \
+	table_entry(0x379) \
+	table_entry(0x37A) \
+	table_entry(0x37B) \
+	table_entry(0x393) \
+	table_entry(0x3c6) \
+	table_entry(0x3c8) \
+	table_entry(0x3dd) \
+	table_entry(0x4001) \
+	table_entry(0x4004) \
+	table_entry(0x5000) \
+	table_entry(0x5002) \
+	table_entry(0x6004) \
+	table_entry(HID_ANY_ID) \
+
+enum wacom_features_table_index {
+#define table_entry(product)	\
+	WACOM_FEATURE_TABLE_##product,
+	HID_WACOM_PRODUCT_TABLE()
+	NUM_OF_WACOM_FEATURES_IN_TABLE
+#undef table_entry
+};
+
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
 void wacom_setup_device_quirks(struct wacom *wacom);
 int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
@@ -249,4 +425,5 @@ struct wacom_led *wacom_led_next(struct wacom *wacom, struct wacom_led *cur);
 int wacom_equivalent_usage(int usage);
 int wacom_initialize_leds(struct wacom *wacom);
 void wacom_idleprox_timeout(struct timer_list *list);
+const struct wacom_features *get_wacom_features(enum wacom_features_table_index index);
 #endif
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f7..834519751a5c 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2559,8 +2559,13 @@ static void wacom_wireless_work(struct work_struct *work)
 		}
 
 		/* Stylus interface */
-		wacom_wac1->features =
-			*((struct wacom_features *)id->driver_data);
+		const struct wacom_features *features = get_wacom_features(id->driver_data);
+
+		if (!features) {
+			hid_err(wacom->hdev, "could not get wacom features.\n");
+			return;
+		}
+		wacom_wac1->features = *features;
 
 		wacom_wac1->pid = wacom_wac->pid;
 		hid_hw_stop(hdev1);
@@ -2572,8 +2577,7 @@ static void wacom_wireless_work(struct work_struct *work)
 		if (wacom_wac1->features.touch_max ||
 		    (wacom_wac1->features.type >= INTUOSHT &&
 		    wacom_wac1->features.type <= BAMBOO_PT)) {
-			wacom_wac2->features =
-				*((struct wacom_features *)id->driver_data);
+			wacom_wac2->features = *features;
 			wacom_wac2->pid = wacom_wac->pid;
 			hid_hw_stop(hdev2);
 			error = wacom_parse_and_register(wacom2, true);
@@ -2843,7 +2847,15 @@ static int wacom_probe(struct hid_device *hdev,
 	wacom->hdev = hdev;
 
 	wacom_wac = &wacom->wacom_wac;
-	wacom_wac->features = *((struct wacom_features *)id->driver_data);
+
+	const struct wacom_features *id_features = get_wacom_features(id->driver_data);
+
+	if (!id_features) {
+		hid_err(wacom->hdev, "could not get wacom id_features.\n");
+		return -EINVAL;
+	}
+	wacom_wac->features = *id_features;
+
 	features = &wacom_wac->features;
 
 	if (features->check_for_hid_type && features->hid_type != hdev->type)
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85625..d0a864d52509 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -4945,25 +4945,40 @@ static const struct wacom_features wacom_features_HID_ANY_ID =
 static const struct wacom_features wacom_features_0x94 =
 	{ "Wacom Bootloader", .type = BOOTLOADER };
 
+static const struct wacom_features *wacom_features_table[] = {
+#define table_entry(product)				\
+	[WACOM_FEATURE_TABLE_##product] = &wacom_features_##product,
+	HID_WACOM_PRODUCT_TABLE()
+#undef table_entry
+};
+
+const struct wacom_features *get_wacom_features(enum wacom_features_table_index index)
+{
+	if (index >= NUM_OF_WACOM_FEATURES_IN_TABLE)
+		return NULL;
+
+	return wacom_features_table[index];
+}
+
 #define USB_DEVICE_WACOM(prod)						\
 	HID_DEVICE(BUS_USB, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+	.driver_data = WACOM_FEATURE_TABLE_##prod
 
 #define BT_DEVICE_WACOM(prod)						\
 	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+	.driver_data = WACOM_FEATURE_TABLE_##prod
 
 #define I2C_DEVICE_WACOM(prod)						\
 	HID_DEVICE(BUS_I2C, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+	.driver_data = WACOM_FEATURE_TABLE_##prod
 
 #define PCI_DEVICE_WACOM(prod)						\
 	HID_DEVICE(BUS_PCI, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
-	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+	.driver_data = WACOM_FEATURE_TABLE_##prod
 
 #define USB_DEVICE_LENOVO(prod)					\
 	HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, prod),			\
-	.driver_data = (kernel_ulong_t)&wacom_features_##prod
+	.driver_data = WACOM_FEATURE_TABLE_##prod
 
 const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x00) },

-- 
2.43.0

