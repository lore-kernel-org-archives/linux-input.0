Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8393242D7B
	for <linux-input@vger.kernel.org>; Sat, 30 May 2026 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780120366; cv=none; b=fu3MOpuOhGdUCggix81RSAhJDbJf0iNMYnTPuyczB3yBxKY43GTLzqZahFXLCbym0oXVeY1HLWcMY8GSRvjhBfmLIOeBXkJjQgGvjXPivzVY+wU092ZaC7/jx+IHdfzCMLjdezQNmBst7zhSSIgJA2GWOZ8N6rNTT2oBpQQaxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780120366; c=relaxed/simple;
	bh=g7Y7oSEQhRGSn1nosiSXABfXAj+1YCyjB+H+/LK3n5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Frkm4uODiCVRsLLYIzJEUb0fYf3ULUf2Ktp2+Nf9Gqi9OqdlMMrzJL3P6EMWv5wbuXDHdxrMTQm3NvPeSNlj8+wun4bGEXv57RpHh8F/yPMC18B8U75Zzo4GrXzrkx7+nB2d1I4WrEzWiVk7xhYLOfhiZo3WmD3+A6oGfttW7jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlecdiVh; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlecdiVh"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304c520fe9aso6708842eec.0
        for <linux-input@vger.kernel.org>; Fri, 29 May 2026 22:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780120363; x=1780725163; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdQNgeZti+jbt/sPucXP21rO5FPFecMWYZ4eJpj7Cb8=;
        b=QlecdiVhJNHncNOAfi0sUPK3kzzJcwNpHlIOpddU+jDEWaTtlrdGZ1GxLPVkHISvFc
         zbU25DnFnduEliJ7OhcMeJkTGdFMfWJvr+o+DnRSlIL7tL7Tq6dG7PAKZRvTPjkvTEtt
         zEcTIrvG1u+uxLPs4pSLFUfCwWaij++Rw+sAD9oqXAhlUgjs8nY3GrOhh6BF+Bk/IZue
         hGTMaBRXTDaQTrgOST52UNKMHKSFppt/CvROs9MqploKi0dZILhM4p6gQGXFIvPJOPWT
         EfeKaFmUOJwbwmKjuieeBEjoIj3ZfNtmE9PRhDfbDFIVtJi3yq06MP8bWXAZGEmJvIUl
         /rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780120363; x=1780725163;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdQNgeZti+jbt/sPucXP21rO5FPFecMWYZ4eJpj7Cb8=;
        b=o/hDBH7u2lHsXR9dVLG0AfAZTJ8OCRRJhbIqVpJjg93yCmM3G47cjzBA+qaKVcOXI3
         f4IY3r1ZfLM1eehW6GJeBv4PCDrLxaA6ZzTQ3dmrRRLTjlpgDVlpW7ua/Zr54cyeMEMC
         9409ETbi9EgLGnnjvh+b6lWyV/Irded3otluM18yQiuBMEfNCa1aCGZZGLus3KK1C3Cf
         uPfy4LgydJx7fuRCyHLA7M2kbmy4GQ3jJFmZmQAYThbx63GE+D7cWvfFN+3eOvk2idGX
         9QHLjx/ROdGO7mE2IkLZ6ceCO3ImLHYGzyjBBrJvQdcCCdrrmBSUJLHYqpk6z9QEQcE+
         tTKw==
X-Gm-Message-State: AOJu0YxLqC/aCVSflXRk6QVHuEW/Y8k1GEQpCMJQ5+YgJvvDhB3BTNbn
	cujFXzvDcE0BdV2oG5Yig+5aJYsJ5YtkEXmwZSNLI6I8NhZ8qyByy5gIdk08Dw==
X-Gm-Gg: Acq92OHqRE0R3VS6a0n+S2mLpFHy983XJYHdJCK0PoubYVrjBfjUYJnFpstY/16omH3
	V2s/K1mx47lIswOaCWGatmiC0Lz5K8cyeDqxEUlHPBlBq3CLcgV+ke6SqDllOvZqq0TeDmCIU+a
	QDD7UZcG6GDC3aMdJKQDUxqBvqriC5HYdUED570iVx8DZcSPrL99AgVQW1x4uRpijMeXbYx/XFb
	buiGqVrMtcrHGhDt69mh8H3YQzje/VEnfiUsKfRugBH/53QB6kF+OMB5qm+eX5QFqt6nr1TnXbb
	BCqNY03UGwzh0nbioACOknatGdBdT9QYkWMcrSO/ejIGDzkJT3Le9fVlIsg7GjSYhC2dH0hkKeu
	RlIoO8HuomDbiYTwOFqOykjUx12q+Y/pK0A66WQ6Spap6FK1qjg3w9adtX9oqUmynbfOGnOnxGC
	DhnrZPM5HH/37tA2ITN9x3LwzmRKtM6YUunuOMkk0pu2QBm5bAAw+4Z2lAmvsw0n6XsoVlgLkgU
	HI=
X-Received: by 2002:a05:7300:a191:b0:2f1:6252:f8fe with SMTP id 5a478bee46e88-304fa49edfcmr1238962eec.3.1780120362745;
        Fri, 29 May 2026 22:52:42 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:307d:2a52:8823:4a01])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d26d1sm3293012eec.30.2026.05.29.22.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 22:52:42 -0700 (PDT)
Date: Fri, 29 May 2026 22:52:39 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: atlas_btns - modernize the driver
Message-ID: <ahp6qt_viW3l-NlX@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Rework the driver to use modern style:

- Remove global state by introducing a per-device structure
- Use devm for resource management (input device allocation)
- Use dev_err_probe() for error reporting in the probe path
- Clean up unused definitions and headers.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/atlas_btns.c | 109 ++++++++++++++++----------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index 835ad45a9d65..5805a1a3bb05 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -15,17 +15,18 @@
 #include <linux/types.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
-#include <linux/uaccess.h>
 
 #define ACPI_ATLAS_NAME		"Atlas ACPI"
-#define ACPI_ATLAS_CLASS	"Atlas"
 
-static unsigned short atlas_keymap[16];
-static struct input_dev *input_dev;
+struct atlas_btns {
+	struct input_dev *input_dev;
+	unsigned short keymap[16];
+};
 
 /* button handling code */
 static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
-		    u32 function, void *handler_context, void **return_context)
+					   u32 function, void *handler_context,
+					   void **return_context)
 {
 	*return_context =
 		(function != ACPI_REGION_DEACTIVATE) ? handler_context : NULL;
@@ -34,33 +35,37 @@ static acpi_status acpi_atlas_button_setup(acpi_handle region_handle,
 }
 
 static acpi_status acpi_atlas_button_handler(u32 function,
-		      acpi_physical_address address,
-		      u32 bit_width, u64 *value,
-		      void *handler_context, void *region_context)
+					     acpi_physical_address address,
+					     u32 bit_width, u64 *value,
+					     void *handler_context,
+					     void *region_context)
 {
-	acpi_status status;
+	struct atlas_btns *atlas = region_context;
 
 	if (function == ACPI_WRITE) {
 		int code = address & 0x0f;
 		int key_down = !(address & 0x10);
 
-		input_event(input_dev, EV_MSC, MSC_SCAN, code);
-		input_report_key(input_dev, atlas_keymap[code], key_down);
-		input_sync(input_dev);
+		input_event(atlas->input_dev, EV_MSC, MSC_SCAN, code);
+		input_report_key(atlas->input_dev, atlas->keymap[code],
+				 key_down);
+		input_sync(atlas->input_dev);
 
-		status = AE_OK;
-	} else {
-		pr_warn("shrugged on unexpected function: function=%x,address=%lx,value=%x\n",
-			function, (unsigned long)address, (u32)*value);
-		status = AE_BAD_PARAMETER;
+		return AE_OK;
 	}
 
-	return status;
+	dev_warn(atlas->input_dev->dev.parent,
+		 "unexpected function: function=%x,address=%lx,value=%x\n",
+		 function, (unsigned long)address, (u32)*value);
+
+	return AE_BAD_PARAMETER;
 }
 
 static int atlas_acpi_button_probe(struct platform_device *pdev)
 {
 	struct acpi_device *device;
+	struct atlas_btns *atlas;
+	struct input_dev *input_dev;
 	acpi_status status;
 	int i;
 	int err;
@@ -69,65 +74,62 @@ static int atlas_acpi_button_probe(struct platform_device *pdev)
 	if (!device)
 		return -ENODEV;
 
-	input_dev = input_allocate_device();
-	if (!input_dev) {
-		pr_err("unable to allocate input device\n");
+	atlas = devm_kzalloc(&pdev->dev, sizeof(*atlas), GFP_KERNEL);
+	if (!atlas)
 		return -ENOMEM;
-	}
+
+	input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!input_dev)
+		return -ENOMEM;
+
+	atlas->input_dev = input_dev;
 
 	input_dev->name = "Atlas ACPI button driver";
 	input_dev->phys = "ASIM0000/atlas/input0";
 	input_dev->id.bustype = BUS_HOST;
-	input_dev->keycode = atlas_keymap;
-	input_dev->keycodesize = sizeof(unsigned short);
-	input_dev->keycodemax = ARRAY_SIZE(atlas_keymap);
+	input_dev->keycode = atlas->keymap;
+	input_dev->keycodesize = sizeof(atlas->keymap[0]);
+	input_dev->keycodemax = ARRAY_SIZE(atlas->keymap);
 
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
-	__set_bit(EV_KEY, input_dev->evbit);
-	for (i = 0; i < ARRAY_SIZE(atlas_keymap); i++) {
+	for (i = 0; i < ARRAY_SIZE(atlas->keymap); i++) {
 		if (i < 9) {
-			atlas_keymap[i] = KEY_F1 + i;
-			__set_bit(KEY_F1 + i, input_dev->keybit);
-		} else
-			atlas_keymap[i] = KEY_RESERVED;
+			atlas->keymap[i] = KEY_F1 + i;
+			input_set_capability(input_dev, EV_KEY, KEY_F1 + i);
+		} else {
+			atlas->keymap[i] = KEY_RESERVED;
+		}
 	}
 
 	err = input_register_device(input_dev);
-	if (err) {
-		pr_err("couldn't register input device\n");
-		input_free_device(input_dev);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(&pdev->dev, err,
+				     "couldn't register input device\n");
 
 	/* hookup button handler */
 	status = acpi_install_address_space_handler(device->handle,
-				0x81, &acpi_atlas_button_handler,
-				&acpi_atlas_button_setup, device);
-	if (ACPI_FAILURE(status)) {
-		pr_err("error installing addr spc handler\n");
-		input_unregister_device(input_dev);
-		err = -EINVAL;
-	}
+						    0x81,
+						    &acpi_atlas_button_handler,
+						    &acpi_atlas_button_setup,
+						    atlas);
+	if (ACPI_FAILURE(status))
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "error installing addr spc handler\n");
 
-	return err;
+	return 0;
 }
 
 static void atlas_acpi_button_remove(struct platform_device *pdev)
 {
 	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
-	acpi_status status;
 
-	status = acpi_remove_address_space_handler(device->handle,
-				0x81, &acpi_atlas_button_handler);
-	if (ACPI_FAILURE(status))
-		pr_err("error removing addr spc handler\n");
-
-	input_unregister_device(input_dev);
+	acpi_remove_address_space_handler(device->handle, 0x81,
+					  &acpi_atlas_button_handler);
 }
 
 static const struct acpi_device_id atlas_device_ids[] = {
-	{"ASIM0000", 0},
-	{"", 0},
+	{ "ASIM0000" },
+	{ "" }
 };
 MODULE_DEVICE_TABLE(acpi, atlas_device_ids);
 
@@ -144,4 +146,3 @@ module_platform_driver(atlas_acpi_driver);
 MODULE_AUTHOR("Jaya Kumar");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Atlas button driver");
-
-- 
2.54.0.823.g6e5bcc1fc9-goog


-- 
Dmitry
