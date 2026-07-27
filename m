Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431641B8F7
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164144; cv=none; b=ts4G7PThvSDI+6FXNXQ2CTppEeyJUv0wG1Ys4vq1hh/Pjp6Vdgg5KyDlbC8pf3e8RSjq2LEBzKa20P43FIFiAiB+1FUhhxxOFrr/TYCqDQcQeIKVgCueOdXR+If2Bwtp0Le8FMUOjstITFuiUKSX83VTGbNHq7EFv+Dp2Xpkrzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164144; c=relaxed/simple;
	bh=pZko7Hj5g1cGs7saio5oOi15yOySsgTVL2JUbRACbIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MILFFZDo7vDgrc0Jdu2IlhA/7wodCY1m9rvKE2TxX38r2rsZucw3IHvxzI8KTTbTKRhiPVhyPHTnlf1b0ojywF2HWi7WtpxbcSQSvzZdwHelDaIjYGm1iJ0bbcxB+d79yOZiPNg/xvYZlLpvbNxu2ymYe29JiMSfnM2ipis6AN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=ZzL7b6Aa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="ZzL7b6Aa"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4957eefd361so21257695e9.1
        for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785164140; x=1785768940; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XU6/JWL8/kZd73XjFeVckB8CfI88LKwyFFmN33r1Spg=;
        b=ZzL7b6AaHpME879752pYgvEZ1wbPNBMoe8VW2Yn5J/ihZAXVLz6jBwSuD9MjROmZ7a
         B1R5x3ns2fd37uveu5SDbdd+kzsDN/fye2q06gpXJXNFCUgmgA5khy1ozenxpgGr1Ys1
         wS5pBQOahe/dBRAapFQOf503hBCt7nzeywlk7DJf3eUNgP3ywtAE7tZnzKBxRKi8GfRK
         QWZUceAWfCFIECLYxPaWcd3m5AnQxktXlKyr2xOXGduB3bCEZc2rgBzA9PO7/wOzJEjP
         W82qPcsZo5Pp9GALBLNWkSmokIFhy6mgsNZ8qlNmzLw2oiAzI+b+IxYij+Ad/d2EqER+
         aYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164140; x=1785768940;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XU6/JWL8/kZd73XjFeVckB8CfI88LKwyFFmN33r1Spg=;
        b=r2nWvIuI/lkSi37ZE4hrO1Ip4ZA+hL3MjxO6JpZGib5BS3qV7Kt7xc8i79Thw9ISP0
         /yXxjYpxdnrz4uHNG2yP1J8qArfkCrw6B7PCihhL1t13afTbKMvhgrdvI0LyiVTkQHG5
         5clbrxEjPIApG5Kub/TcqLFBQJoq5bGK58+FCDw18kzOMrf8mFB4JMEFrI7o3N7Ava3K
         j5sEzkct7KvV+sIngEzrwRaVQGz/uY5PhGWtAD8dNRnzbOlh+UapBs2as52fuBdsO9sT
         zSthFL9bBR+l5Q/0RAaDemzwRGr1yABX0X/Ki5cMq6MO0QXN6BX2XK6EuVBWOxcnJIuo
         km/w==
X-Forwarded-Encrypted: i=1; AHgh+RqaUceSifLjxpRVUhYcWfn2ps7JhkScLovXMRRAt71q5r3Tm2vYxE8vqIVkiwZpQxG9paURpuVgQSMwfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRxfcqJ4peK4AtWTGJja9xOMSzGB0xN8exYdLLhZXD9S4xfz06
	iPrVw45uIptOpg6HuX7ZdK6RxI0PRMeL98ObivYFs3ML3mcW2qXOWcz0aQcgRE1UarbMdgrwgD6
	5fzuF0Ts=
X-Gm-Gg: AR+sD13Llei9uHRn1TD18pIRKLocA1g/IlA+yvRLgPZHi9oxnACV7MaV5z6h9rsGaG7
	MwdpWrR7A2VIC3z649WOcWr56AZkw0GZVebpPERgvWL6y6EFWQuPXZnFqTS/6rPgl2bc8u1GA0u
	FgGekboJOWWorDpu64NS83vKP3G9nbp0v3RTeyQzsONRktVPiEkeDwNvAJoF2nYnWHcmpV2cIOZ
	Qk6iiqlLDxd5PVqnvHPFfDLXgol7d2CRMh002Qg9YKLl/AEzmXmabcgaQv5Z1TAMDC6JVkHWFs7
	75SlYvKzKchHwk7nAzO7OSPDcSCA13fPxbkz4DRJKcoxL5pT2mNOy+dhDvBWoTQHjmsQxxAOGF5
	RZfYSUtJXRFIllThHhafTWKNqHwhS+6OkZ7eo+4fIAAW88r8Mxlly9sLE+ewq7GQaSyxMk0cW55
	cNW7IIm/Glrq/i2+/ByxyuSDHPxp2Qvw==
X-Received: by 2002:a05:600c:253:b0:493:df5d:6ca6 with SMTP id 5b1f17b1804b1-496b571c5fdmr90525715e9.25.1785164139683;
        Mon, 27 Jul 2026 07:55:39 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9928fdsm254241585e9.1.2026.07.27.07.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:55:39 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 15:55:30 +0100
Subject: [PATCH v3 5/8] HID: hid-tmff: clean up usage of 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mod-devicetable-hid_device_id-v3-5-980896ca283e@thegoodpenguin.co.uk>
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
In-Reply-To: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785164134; l=4240;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=pZko7Hj5g1cGs7saio5oOi15yOySsgTVL2JUbRACbIw=;
 b=UYtOxUXcDOXtkikhXsacU4tcrMh86Ltef+Y0f0RtIZnmuUmzfFZCB2v6wnL7Zhh/lo9MMsSgj
 xF4Lcgo8EAgChL+7FsV8eGyaf72SLD5V2KyQD3vVcs3fg+g3Va6npLC
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

This module is using the 'hid_device_id::driver_data' field
as a valid pointer to dereference. The hid subsystem supports
injecting a 'new_id' device from the command line and so it is
more convenient to have this value to be an integer - that way
userspace can select a valid pointer within the driver via an
index.

Lets make this possible by storing an index to the table of
pointers 'ff_bits_table' there as opposed to the pointer address
directly.

The retrieval is bounded at runtime by the 'ff_bits_table_index'
enum to avoid dereferencing OOB objects.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/hid-tmff.c | 48 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
index 423f395d01ac..93de756dd30e 100644
--- a/drivers/hid/hid-tmff.c
+++ b/drivers/hid/hid-tmff.c
@@ -34,6 +34,17 @@ static const signed short ff_joystick[] = {
 	-1
 };
 
+enum ff_bits_table_index {
+	FF_BITS_TABLE_RUMBLE,
+	FF_BITS_TABLE_JOYSTICK,
+	NUM_OF_FF_BITS_IN_TABLE
+};
+
+static const signed short *ff_bits_table[] = {
+	[FF_BITS_TABLE_RUMBLE]		= ff_rumble,
+	[FF_BITS_TABLE_JOYSTICK]	= ff_joystick
+};
+
 #ifdef CONFIG_THRUSTMASTER_FF
 
 /* Usages for thrustmaster devices I know about */
@@ -210,9 +221,18 @@ static inline int tmff_init(struct hid_device *hid, const signed short *ff_bits)
 }
 #endif
 
+static const signed short *get_ff_bits(enum ff_bits_table_index index)
+{
+	if (index >= NUM_OF_FF_BITS_IN_TABLE)
+		return NULL;
+
+	return ff_bits_table[index];
+}
+
 static int tm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
+	const signed short *ff_bits = get_ff_bits(id->driver_data);
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -226,7 +246,13 @@ static int tm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err;
 	}
 
-	tmff_init(hdev, (void *)id->driver_data);
+	if (!ff_bits) {
+		hid_err(hdev, "no ff_bits found\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	tmff_init(hdev, ff_bits);
 
 	return 0;
 err:
@@ -235,25 +261,25 @@ static int tm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 static const struct hid_device_id tm_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300),
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data = FF_BITS_TABLE_RUMBLE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304),   /* FireStorm Dual Power 2 (and 3) */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data = FF_BITS_TABLE_RUMBLE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, THRUSTMASTER_DEVICE_ID_2_IN_1_DT),   /* Dual Trigger 2-in-1 */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data = FF_BITS_TABLE_RUMBLE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb323),   /* Dual Trigger 3-in-1 (PC Mode) */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data = FF_BITS_TABLE_RUMBLE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb324),   /* Dual Trigger 3-in-1 (PS3 Mode) */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data = FF_BITS_TABLE_RUMBLE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb605),   /* NASCAR PRO FF2 Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data = FF_BITS_TABLE_JOYSTICK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651),	/* FGT Rumble Force Wheel */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data = FF_BITS_TABLE_RUMBLE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb653),	/* RGT Force Feedback CLUTCH Raging Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data = FF_BITS_TABLE_JOYSTICK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654),	/* FGT Force Feedback Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data = FF_BITS_TABLE_JOYSTICK },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb65a),	/* F430 Force Feedback Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data = FF_BITS_TABLE_JOYSTICK },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, tm_devices);

-- 
2.43.0

