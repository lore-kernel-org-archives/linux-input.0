Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4373F39FB
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120428; cv=none; b=m0Jx8TX7xna8fRLqE0ZGPZ9Uhl/wlKA8regufPAtqmT2kbHx17ml2nhP9wafzSLFqdQkpuz/vNYP704qIQkIM4Dk9rQpyiPfW+XzcA/luaCG3YJJ1Oqtfpix4ivhIqeJHpYZ+Hc4vt9DSvmlUvo40UY+MpOW5EPPXqmyejBaZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120428; c=relaxed/simple;
	bh=lVYU22Y5Ir69wDkvv7hToHs50FivmWy0WICMwJWBdsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSLEeBp/fHlVYW+riLWd7HDSwoBXnBMpztt2z7hCkSmM7pPUmAFg5MQ6uIzQR5SyNtr7ZJNbCRS+NAMr9AZqfRIhtkrf5sXoWM1aQrfQhw6hobjOvdSmh/ggencmsqNiI7KYv/0DlMRS9HrMnsTjAN9+TH6pcd8M5a+1oruKGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=wX7o3avh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="wX7o3avh"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48896199cbaso19399005e9.1
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1779120411; x=1779725211; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1Zaaqmqxh7fW6GrkDq6rtfonmed+F1FtkVFlaeX614=;
        b=wX7o3avhlctBtTqQxFR64drGrnjz79f4CkJnw6vZJ2xi7xqnpE/C98ZeEDubjgQpDA
         FprbBoK786KjDzzWzI/MtEudPlM3+VIGOd4SorucMn7JjTElgTFgiLFIA7EZEJY0BaqB
         TdVC2/TpGKqEtmG1kv7y7crvcx55jBWgrGnkxraW7Nh2j9bZrFKdNVz3uDZwq0tSJSny
         kjWx2MSkwWkRYG/VLvG6i2P4b7cYf56FJ4DeWDCJQR6yZzYSNrfAU0NZrh90YFMnpXVK
         +IsdZp1S8rbJPxSnzDAYkHNHEYUltsKhLR6hoO0B9BZFIOn+S9JpMZ0n3UfOPd3TtkGG
         CqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779120411; x=1779725211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U1Zaaqmqxh7fW6GrkDq6rtfonmed+F1FtkVFlaeX614=;
        b=Lqw8mqd7wNELZgIXKufTXrLvdLsp6vi9JlkDeV6LupZi3VcXeEinq6IHMCB7O+6JRF
         Mw5Vnrr0IPSlzWE0N9cL1sQ+lozn62/WJn4YRJHB8izBo4otuRnBrybvItVGoax+zX+u
         MhcGylLr+pd6twBuFvVJ+ueAfS7AlBneDhdzOFeiYkTpdN7upQW2r393nl1J5ZQnuwrT
         7SLMQtU1e1m8Qn90rQ3fsDNOEls5xjAkWqhSZr4optS3QqqLDvCmml9veB/rUwuKnSZu
         ommvahuw7zcF7oRMkvXpTRvM58E2B/m8z9EBW/Zwva4uaLfTafWhO6A/twEXQ47A48Bb
         e4vA==
X-Forwarded-Encrypted: i=1; AFNElJ+wq+Vp5piBUiroFwu2LanMObaAHEggclZIjNuMKWbqB099RqZWw0HsTbiYJ+B0s1PnkdUz3kp2Q7FQ3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+NTtr3P0tetQ0PKWIOlRtSZVJzCFsKkyK96ct3u7CEU6NB55
	QYIYGK1uffNlacNv/1N7Eox4man+ldQKHMhsCdXrzXlgi2g3oybj0+uRm3VRiaViedg=
X-Gm-Gg: Acq92OERMXPbnIxu3jDuSDEEHe+5aEfOJMIASHqWZIGBhrHnLHabnlx7QQmgAsF7PaT
	4s2rFCdB7HnM37IWZnxcpZ38a8vybM3tRT9DlTO1AOSxjahKRv+EFdZ5VOqHL1shZtsuDoee9HE
	BBTTdZsEMRAkNqW5BDpjG3P0+lv9lpzCKRUFOx8b2JI+bl80bq5dbAqoj9xtpyHu4kuboexfsM5
	iAoSYHkE4GCnu/nUogZG8PcthVesOvUrXF25ZqXmGF8JmLWdRZtase3on6yC+FEfC4KrFWGjhGJ
	SN+rJQ1HALa6vVbS58+pTPDe2zy8QiKHvpoDVCFwpdfyNW8UklIQOyy53gh5uaN6xxel/NgJlOu
	vEqQrfNzeWRr116eCpnW3GtBqg8CBXpgf8Jfz1+IG+MZCxBN6rW+/u11rgLe690NaKHZQs9b8J6
	NcCYuqZvh6mwUIoR2W4bgQq+WTyM+/838IPiG/OgFj
X-Received: by 2002:a05:600c:491e:b0:48e:978f:c45a with SMTP id 5b1f17b1804b1-48fed455991mr141851495e9.19.1779120411008;
        Mon, 18 May 2026 09:06:51 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:de11:5404:1c7b:7b76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13b4sm38867318f8f.28.2026.05.18.09.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:06:50 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 18 May 2026 17:06:29 +0100
Subject: [PATCH 10/11] HID: hid-tmff: use 'hid_device_id::driver_data_ptr'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mod-devicetable-hid_device_id-v1-10-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, 
 "Christian A. Ehrhardt" <lk@c--e.de>, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779120401; l=2886;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=lVYU22Y5Ir69wDkvv7hToHs50FivmWy0WICMwJWBdsE=;
 b=axjHXWupj/sZvWPxQunoWU9ThNPQmQ0wuXyYuOba1+c5zKv+Mgw+jKBb55iNiBi6eqrD3Cedg
 MCa8mObBEbvDzozSrkBl9InK+UKJM48XwDwvc1m9RHXTpsWFQYilU+j
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Remove the casts to (unsigned long) and instead assign the
'ff_rumble' and 'ff_joystick' variables as they should, as pointers.
Remove the cast to (void *) during probe - tmff_init() second parameter
already accepts a const pointer, so no further action was needed here.
These changes improve readability of the code.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/hid-tmff.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
index 423f395d01ac..0d7e73fba0fa 100644
--- a/drivers/hid/hid-tmff.c
+++ b/drivers/hid/hid-tmff.c
@@ -226,7 +226,7 @@ static int tm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err;
 	}
 
-	tmff_init(hdev, (void *)id->driver_data);
+	tmff_init(hdev, id->driver_data_ptr);
 
 	return 0;
 err:
@@ -235,25 +235,25 @@ static int tm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 static const struct hid_device_id tm_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300),
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304),   /* FireStorm Dual Power 2 (and 3) */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, THRUSTMASTER_DEVICE_ID_2_IN_1_DT),   /* Dual Trigger 2-in-1 */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb323),   /* Dual Trigger 3-in-1 (PC Mode) */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb324),   /* Dual Trigger 3-in-1 (PS3 Mode) */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb605),   /* NASCAR PRO FF2 Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data_ptr = ff_joystick },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651),	/* FGT Rumble Force Wheel */
-		.driver_data = (unsigned long)ff_rumble },
+		.driver_data_ptr = ff_rumble },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb653),	/* RGT Force Feedback CLUTCH Raging Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data_ptr = ff_joystick },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654),	/* FGT Force Feedback Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data_ptr = ff_joystick },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb65a),	/* F430 Force Feedback Wheel */
-		.driver_data = (unsigned long)ff_joystick },
+		.driver_data_ptr = ff_joystick },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, tm_devices);

-- 
2.43.0

