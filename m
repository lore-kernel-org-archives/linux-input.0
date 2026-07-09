Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5A3A8FE6
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 04:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783572797; cv=none; b=DCP/yB0CvktGlApnRXwkQ21p8duOUI5CtHNHGU18P3wGLhxnM7i1ouZ3y8muP1NtSJfamXh3cPawccJvsvOz53goB53p+BOD8ProjAm1hgdhEk+DsO6IfubBlIg2y9TKm+5ZX4UDo1BXo3vd8pkaCZbJxRIFZML1keuLMXXDuik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783572797; c=relaxed/simple;
	bh=+cx4J0lL2WP6F2bcjEbrDLi3zNUFXejjGcAoikGrCWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irdRP6v7B7VWLlySd7J+EX+4cv4gRwz4ax6gzJDq/KcLlGbleKTEc4fNoe3u7ns3ohbX2tpVqzt//CoSvxj0kXuGJlb4t10oPVfY5Zu616Ms3HEd9UpLKOq6+xqjYwn15oOVDD4L8sjCtwoaKZaGQpTBAD5ymQTpS3eyPX03wrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij9J/wJh; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij9J/wJh"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca7c1176317so775007a12.1
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 21:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783572795; x=1784177595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+M3rTQ3CjpVF9vvR8XU5vj2lKkvONQlP0xZS2BToiE=;
        b=Ij9J/wJhD0pdrFBJkt8Tx+TFteBSLpWoXZLLQ7XZ+LtsT5Grl3LDu9RXy38xCiwOro
         6qpY/1xOFN62CxAjkPP1X+yKjR0pXTovX2QiM7eRCo95UmlLQwMWcgTxPiP/PBPvY9kH
         H17laDCVpxhuwlg9jMLmhn27LUCbNGAf+IrSYlgkKwxJGhu2Kx9GLW8X/0nIWBpetLbQ
         gnqqW8cz94Wxt+5q+lOfcS/fTcUL62mEmy6KY/ETIhfq0Hb1SlNZXhq39BrOUrH8e5em
         RvB0plQ/ExerPWPopXr21vHP5jpIK48E0L2pS99UJQRIlB0ItEI2+AcGwmTTbQJKPV3H
         yHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783572795; x=1784177595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+M3rTQ3CjpVF9vvR8XU5vj2lKkvONQlP0xZS2BToiE=;
        b=DsbA+w+iWiG3LIdDH703u5gzFXmybXhPW4kGiFdEWTHZm3hFepIxn5WrbKiVn52V0m
         7PYAP6uApneBcvtetDilJxrNKlRpCbu6lfbsYRkinZr86H/ZWJsfX6n1sbp3y5rAtWaf
         H8qjsPdmVXEbwYtoTqlZKqXQcVypSPZVk3w5i36MFq5OuzFw3N8lqstP7ogYpVvL1SQO
         IFhk647mTIaRDXA7YTmNQxTw+j8/RJP/r8yKpoZbsZosfeXuhLbNucVox1UzZPTXBWu3
         DsFAA9qXmCa05ZwZfUBYdi1QgfYcRMTvvn/rGa+NJH3TTwmMDCruA8Bzg4R72G+3bBcA
         YpHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpx84rAGqrtF7/ET6Gmji2PNOwkq22IWcrPe34MYcR4fdOpz0ef9vDXOeR6jphiG0fG9kHSLapY0VYNzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLas/90zUI3NR/ahTAWAEii5whr3XDIUtd9VZHN8xcaq5XeQrz
	HmnNl5oyI4VXoycM8AdAeGKIoxeUDp3z+RQW45wOQFHyi6qcDIdNxXOy
X-Gm-Gg: AfdE7cnpyrcmSdvMS6NQeJxRbyOHEFXLLYBezx1IRAq7/9vIF58JEowuhjSaFw70UNq
	ti+Wa2+wGO2wX1uHy1oPExqcVvtaj5E4neykrwhNvIGhKJP2rAZVIoiMKzcDxJjwjkL4dDUCzXs
	SIQd1LNOimmrIyL/ygP+kKi11XJrzC3vrr9A5yps09qPGJTFpjS2Q2IAzbgiW8nNH7KuGawYHkx
	IZKotTnkmmhg41bmE1BRT362g6Q+KUpyrMOYKLRsiSJWeLvgpOp3tn4byDU6FkD1dDowmS9NCr1
	Wmp3yrPue5sNC4udgdkzn/C+/eUfvMcCvxQxX6TYxwMNUOKivd22PFyS3a//O0Nqwhdq5jQb0K8
	lXolJRobWrLOa5043Zqz2CEznW+0GWiQAJpEF/LgCfXe6c8qyAnpgIcYGQfuWVMsqLW4748WYZ1
	LLkNMMJY/9dzx1I10pmoV0JwAE/llhar9pukh3nGO4bNmjJjTlJXj8LJhZ0j/snjTs4NO+PKxV+
	Zo3
X-Received: by 2002:a05:6a21:1bc3:b0:3bf:5ff5:2b15 with SMTP id adf61e73a8af0-3c0bc96019dmr6232053637.16.1783572794887;
        Wed, 08 Jul 2026 21:53:14 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e229:88c8:fd09:9a39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b658a99afsm26559252c88.0.2026.07.08.21.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:53:13 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 08 Jul 2026 21:53:03 -0700
Subject: [PATCH v2 05/11] Input: samsung-keypad - remove support for
 platform data
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-samsung-kp-v2-5-3c6ed4c9b3b6@gmail.com>
References: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
In-Reply-To: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 patches@opensource.cirrus.com
X-Mailer: b4 0.16-dev-b242f

Because there are no more users of samsung_keypad_platdata left in
the kernel remove support for it from the driver.

The driver supports generic device properties so all configuration
should be done using them instead of a custom platform data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/samsung-keypad.c | 184 ++++++++++++--------------------
 include/linux/input/samsung-keypad.h    |  39 -------
 2 files changed, 68 insertions(+), 155 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index b9d4ea5f202a..6f1d766a4134 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -21,7 +22,9 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/sched.h>
-#include <linux/input/samsung-keypad.h>
+
+#define SAMSUNG_MAX_ROWS			8
+#define SAMSUNG_MAX_COLS			8
 
 #define SAMSUNG_KEYIFCON			0x00
 #define SAMSUNG_KEYIFSTSCLR			0x04
@@ -231,144 +234,77 @@ static void samsung_keypad_close(struct input_dev *input_dev)
 	samsung_keypad_stop(keypad);
 }
 
-static const struct matrix_keymap_data *
-samsung_parse_verbose_keymap(struct device *dev)
+static int samsung_keypad_parse_keymap(struct samsung_keypad *keypad)
 {
-	struct matrix_keymap_data *keymap_data;
+	struct matrix_keymap_data keymap_data = { 0 };
+	struct device *dev = &keypad->pdev->dev;
 	struct fwnode_handle *child;
 	u32 *keymap;
 	unsigned int key_count;
-
-	keymap_data = devm_kzalloc(dev, sizeof(*keymap_data), GFP_KERNEL);
-	if (!keymap_data)
-		return ERR_PTR(-ENOMEM);
+	int retval;
 
 	key_count = device_get_child_node_count(dev);
-	keymap = devm_kcalloc(dev, key_count, sizeof(*keymap), GFP_KERNEL);
-	if (!keymap)
-		return ERR_PTR(-ENOMEM);
+	if (key_count) {
+		keymap = kcalloc(key_count, sizeof(*keymap), GFP_KERNEL);
+		if (!keymap)
+			return -ENOMEM;
 
-	keymap_data->keymap_size = key_count;
-	keymap_data->keymap = keymap;
+		keymap_data.keymap = keymap;
+		keymap_data.keymap_size = key_count;
 
-	device_for_each_child_node(dev, child) {
-		u32 row, col, key_code;
+		device_for_each_child_node(dev, child) {
+			u32 row, col, key_code;
 
-		fwnode_property_read_u32(child, "keypad,row", &row);
-		fwnode_property_read_u32(child, "keypad,column", &col);
-		fwnode_property_read_u32(child, "linux,code", &key_code);
+			fwnode_property_read_u32(child, "keypad,row", &row);
+			fwnode_property_read_u32(child, "keypad,column", &col);
+			fwnode_property_read_u32(child, "linux,code", &key_code);
 
-		*keymap++ = KEY(row, col, key_code);
+			*keymap++ = KEY(row, col, key_code);
+		}
 	}
 
-	return keymap_data;
-}
-
-static const struct samsung_keypad_platdata *
-samsung_keypad_parse_properties(struct device *dev)
-{
-	const struct matrix_keymap_data *keymap_data;
-	struct samsung_keypad_platdata *pdata;
-	u32 num_rows = 0, num_cols = 0;
-	int error;
-
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
-	device_property_read_u32(dev, "samsung,keypad-num-rows", &num_rows);
-	device_property_read_u32(dev, "samsung,keypad-num-columns", &num_cols);
-
-	error = matrix_keypad_parse_properties(dev, &num_rows, &num_cols);
-	if (error)
-		return ERR_PTR(error);
-
-	pdata->rows = num_rows;
-	pdata->cols = num_cols;
-
-	if (!device_property_present(dev, "linux,keymap")) {
-		keymap_data = samsung_parse_verbose_keymap(dev);
-		if (IS_ERR(keymap_data))
-			return ERR_CAST(keymap_data);
-
-		pdata->keymap_data = keymap_data;
-	}
-
-
-	pdata->no_autorepeat =
-		device_property_read_bool(dev, "linux,input-no-autorepeat");
-
-	pdata->wakeup = device_property_read_bool(dev, "wakeup-source") ||
-			/* legacy name */
-			device_property_read_bool(dev, "linux,input-wakeup");
-
-	return pdata;
+	retval = matrix_keypad_build_keymap(key_count ? &keymap_data : NULL,
+					    NULL, keypad->rows, keypad->cols,
+					    keypad->keycodes,
+					    keypad->input_dev);
+	kfree(keymap_data.keymap);
+	return retval;
 }
 
 static int samsung_keypad_probe(struct platform_device *pdev)
 {
-	const struct samsung_keypad_platdata *pdata;
 	const struct platform_device_id *id;
+	struct device *dev = &pdev->dev;
 	struct samsung_keypad *keypad;
 	struct resource *res;
 	struct input_dev *input_dev;
 	unsigned int row_shift;
+	u32 num_rows = 0, num_cols = 0;
+	bool wakeup;
 	int error;
+	device_property_read_u32(dev, "samsung,keypad-num-rows", &num_rows);
+	device_property_read_u32(dev, "samsung,keypad-num-columns", &num_cols);
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (pdata) {
-		if (!pdata->keymap_data) {
-			dev_err(&pdev->dev, "no keymap data defined\n");
-			return -EINVAL;
-		}
-	} else {
-		pdata = samsung_keypad_parse_properties(&pdev->dev);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-	}
-
-	if (!pdata->rows || pdata->rows > SAMSUNG_MAX_ROWS)
-		return -EINVAL;
+	error = matrix_keypad_parse_properties(dev, &num_rows, &num_cols);
+	if (error)
+		return error;
 
-	if (!pdata->cols || pdata->cols > SAMSUNG_MAX_COLS)
+	if (num_rows > SAMSUNG_MAX_ROWS || num_cols > SAMSUNG_MAX_COLS)
 		return -EINVAL;
 
-	/* initialize the gpio */
-	if (pdata->cfg_gpio)
-		pdata->cfg_gpio(pdata->rows, pdata->cols);
-
-	row_shift = get_count_order(pdata->cols);
+	row_shift = get_count_order(num_cols);
 
 	keypad = devm_kzalloc(&pdev->dev,
 			      struct_size(keypad, keycodes,
-					  pdata->rows << row_shift),
+					  num_rows << row_shift),
 			      GFP_KERNEL);
 	if (!keypad)
 		return -ENOMEM;
 
-	input_dev = devm_input_allocate_device(&pdev->dev);
-	if (!input_dev)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	keypad->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!keypad->base)
-		return -EBUSY;
-
-	keypad->clk = devm_clk_get_prepared(&pdev->dev, "keypad");
-	if (IS_ERR(keypad->clk)) {
-		dev_err(&pdev->dev, "failed to get keypad clk\n");
-		return PTR_ERR(keypad->clk);
-	}
-
-	keypad->input_dev = input_dev;
 	keypad->pdev = pdev;
 	keypad->row_shift = row_shift;
-	keypad->rows = pdata->rows;
-	keypad->cols = pdata->cols;
+	keypad->rows = num_rows;
+	keypad->cols = num_cols;
 	keypad->stopped = true;
 	init_waitqueue_head(&keypad->wait);
 
@@ -384,26 +320,45 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!input_dev)
+		return -ENOMEM;
+
+	keypad->input_dev = input_dev;
+
 	input_dev->name = pdev->name;
 	input_dev->id.bustype = BUS_HOST;
 
 	input_dev->open = samsung_keypad_open;
 	input_dev->close = samsung_keypad_close;
 
-	error = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
-					   pdata->rows, pdata->cols,
-					   keypad->keycodes, input_dev);
+	error = samsung_keypad_parse_keymap(keypad);
 	if (error) {
 		dev_err(&pdev->dev, "failed to build keymap\n");
 		return error;
 	}
 
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
-	if (!pdata->no_autorepeat)
+
+	if (!device_property_read_bool(&pdev->dev, "linux,input-no-autorepeat"))
 		__set_bit(EV_REP, input_dev->evbit);
 
 	input_set_drvdata(input_dev, keypad);
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	keypad->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!keypad->base)
+		return -EBUSY;
+
+	keypad->clk = devm_clk_get_prepared(&pdev->dev, "keypad");
+	if (IS_ERR(keypad->clk)) {
+		dev_err(&pdev->dev, "failed to get keypad clk\n");
+		return PTR_ERR(keypad->clk);
+	}
+
 	keypad->irq = platform_get_irq(pdev, 0);
 	if (keypad->irq < 0) {
 		error = keypad->irq;
@@ -418,7 +373,11 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	device_init_wakeup(&pdev->dev, pdata->wakeup);
+	wakeup = device_property_read_bool(dev, "wakeup-source") ||
+		 /* legacy name */
+		 device_property_read_bool(dev, "linux,input-wakeup");
+	device_init_wakeup(&pdev->dev, wakeup);
+
 	platform_set_drvdata(pdev, keypad);
 
 	error = devm_pm_runtime_enable(&pdev->dev);
@@ -429,13 +388,6 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	if (!dev_get_platdata(&pdev->dev)) {
-		if (pdata->keymap_data) {
-			devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
-			devm_kfree(&pdev->dev, (void *)pdata->keymap_data);
-		}
-		devm_kfree(&pdev->dev, (void *)pdata);
-	}
 
 	return 0;
 }
diff --git a/include/linux/input/samsung-keypad.h b/include/linux/input/samsung-keypad.h
deleted file mode 100644
index ab6b97114c08..000000000000
--- a/include/linux/input/samsung-keypad.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Samsung Keypad platform data definitions
- *
- * Copyright (C) 2010 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- */
-
-#ifndef __SAMSUNG_KEYPAD_H
-#define __SAMSUNG_KEYPAD_H
-
-#include <linux/input/matrix_keypad.h>
-
-#define SAMSUNG_MAX_ROWS	8
-#define SAMSUNG_MAX_COLS	8
-
-/**
- * struct samsung_keypad_platdata - Platform device data for Samsung Keypad.
- * @keymap_data: pointer to &matrix_keymap_data.
- * @rows: number of keypad row supported.
- * @cols: number of keypad col supported.
- * @no_autorepeat: disable key autorepeat.
- * @wakeup: controls whether the device should be set up as wakeup source.
- * @cfg_gpio: configure the GPIO.
- *
- * Initialisation data specific to either the machine or the platform
- * for the device driver to use or call-back when configuring gpio.
- */
-struct samsung_keypad_platdata {
-	const struct matrix_keymap_data	*keymap_data;
-	unsigned int rows;
-	unsigned int cols;
-	bool no_autorepeat;
-	bool wakeup;
-
-	void (*cfg_gpio)(unsigned int rows, unsigned int cols);
-};
-
-#endif /* __SAMSUNG_KEYPAD_H */

-- 
2.55.0.795.g602f6c329a-goog

