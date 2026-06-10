Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81662428822
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104307; cv=none; b=CIIMJmhtzC2DaqNZ1EcpIHZbFIBb30EMhOr6D2HPyNoX7OxHHtK5u1qHfxS16dN1fnWOOFO/iGysHjcSnwobf+kTGLpGZxJ8nj39NgoFbZzBxFsWdRWlvfKQfuxB1avCf6H/vmM2TXyQl5PgNF4FN+dVyJHVvNRG5esv6fN1tjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104307; c=relaxed/simple;
	bh=pZko7Hj5g1cGs7saio5oOi15yOySsgTVL2JUbRACbIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYnNJKNnsiV08+B/GsydZSWeVqdnYNZazevZDLMDlJQI3RQXriLDKibEhIfPzyixHNJkN0SShPHG8kJ5ZOnQY2Tdu05E9T9mVodX2DyxmN3hHac7WPbfaV+zSpwc/xMTMrvyj1SdVJZFDkghOPx6KhOubU109rPHJdy2etAsqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=vbJKDbYm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="vbJKDbYm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490afc47455so36898245e9.2
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781104304; x=1781709104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XU6/JWL8/kZd73XjFeVckB8CfI88LKwyFFmN33r1Spg=;
        b=vbJKDbYmOYzE2sm79t4JhAKb4T6y9opWDLjZeMKRRO0ZwYdBTjzsaLNu9n+yID5HZA
         w65guqAXnTEpHT/lf8PE3kt3ku9Pfv3XLKJTqziiYkauSY8eR5pWuAPslfDmFKck6n0K
         vlkBerlrRz06dcU3DC3fUl3FqQfjMoevGgH3PZQ7PYR0hSTGvweRMNU5vOzUVUDHX3qa
         CiMdmQC9Emv8a6CdN0nV8ISMF/fyJeIuYY3NSfS7LlwZ3ISFdPJbDBgGx8Ra3/+mWfpD
         ri6jy4HwWiwFeoiNDNmA7REf6jutLKWh4aU6W9WmptV7fGrzdRla8H5jy1aaQKdyxjgK
         4c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104304; x=1781709104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XU6/JWL8/kZd73XjFeVckB8CfI88LKwyFFmN33r1Spg=;
        b=CoeiofJ2ODsHtLxJIQCHcyRXn/Qeb0tPrxVljsbXK9sqpU/Sju/QHm0DkWU9Gh+0+T
         Be4mpHEnlthrarfCdNAu60SB/3k22ZUfLbU/e6vdvy2yYnkXM2SVgfdFBn+1BRUdRwxm
         qH6StUfQi8rCYz1W6xakP45uCkBTlx8C/H7afoLD65E4tKQy81MTcSv2UfV1MM+EraQs
         O/lZnNYaMisXdMwq7CFUQSPYWX5R8PTCzPgxkoI8aQTgwWvEIRZTmk1lNW80Wc12suvO
         rk5oYPpl+T0IiEvC/D6jqzw0dhkMjmbaHJ+qdB8z/V3Ro+uhTVgERttQ87Sv2w4kblEF
         beiA==
X-Forwarded-Encrypted: i=1; AFNElJ9zfFnt8NYd3EaPpzv47tMkbm/QYhPU95J/3tt0GRJ5jdfy5tt9lPp9o/jNBpajLk7G/89RKA6I2Ho3Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJlYPbyK3FDaeC4UvRG68LlKxIlG/tS4P4hsiMuYZSJ1DLSFK1
	+VVf0XGvY7qJqb2mpmzsk1pZaCnYDRCvk00uomufjHYWfY3y5+D5FWWql+wDm/6DqHO/0mYOWP0
	hbWaa
X-Gm-Gg: Acq92OHCeOXIjNgDzcFYeF2OzsykGPiT7/cx+iO0dqRgHjPPT2xD9iYlIu5BHJsQOVN
	ntnq+pdEu/mXSBPk4T0aBXQZ4ECf8CzqcAqVMVWsVfrV2zEPPDcMwI+wHLAp6n5rem4FA13mrIU
	nPKlT/RXbs6/Y9UUudzIn8Wx26Tiro0y+fRZmUcBnhgw+maFhgRdNGPmJLpSc0IgElV5ZBnBQQS
	g+9FX+PK6ThTARiAhDP4dMADfH8ZbXdqlZXlmLzZ/hhUsTeQTAcL64NGO4GwkjcwEF51FOiVCND
	CqzIegzzZP1DEQWBb1WSrnm8PRrNNfXBakmxX05uUarE5GPMJcHUgyZmf4U2m2qwMq5GI9+gtdg
	i9voZJXtA2cLy1+JQDk2Fo52ywQdGzsJafb0hRJ4HGdB0NsZ/ThJ4DzxEYeInxXq/tAviFzCwlE
	CZBMziY9107DuvTMHXpVI9n4dCAF+uj6+XMXy6+ezKqY7goVfShPI=
X-Received: by 2002:a05:600c:5250:b0:490:b642:ce2c with SMTP id 5b1f17b1804b1-490d720455bmr93082735e9.14.1781104303650;
        Wed, 10 Jun 2026 08:11:43 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:1a6e:6004:a565:d3cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm585537575e9.7.2026.06.10.08.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:11:43 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 10 Jun 2026 16:11:32 +0100
Subject: [PATCH v2 09/12] HID: hid-tmff: clean up usage of 'driver_data'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mod-devicetable-hid_device_id-v2-9-a1d7473ccd9c@thegoodpenguin.co.uk>
References: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
In-Reply-To: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781104294; l=4240;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=pZko7Hj5g1cGs7saio5oOi15yOySsgTVL2JUbRACbIw=;
 b=1NtRBnT0KwhNLLKY5KcY2dLNLo5TXg2wHJ0heVydR41HUNbIEl0qFWSr8j3/tIWxJMAkg0HOR
 GMTEbqJx9/oDcqVl9UpXtErCrxK2PU4yKaRZohcZfllNjHcCL0G1n06
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

