Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF048367296
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822394; cv=none; b=OtutCWhFPH05hn+8/fa4LUVk5wuHw6Yfc6ka8F1xivr6SZE6qzlnc8aF3aN1kcjDtTXXnkliDHnS8SiljzZNjI325UHu3OvH+9D7P/+eC5uX8XhfMphnNJ6QCAe40iFr5FmjkLVseSWNW8fdeVYEWY8KP52O5fVy9EWQm348qyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822394; c=relaxed/simple;
	bh=Ho25qvyScNsB+serwTNt0Bp3ZOd7cm6luU6beUPMWGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ULRmZWmoHF4kpfc8/WwihTBx0cQ4gTKHEYItkYB3/D8qzlL0OyQz6LzBrr6/c+nHIAFdfnN3nBQyijWsvv89gGrAmSBlKIkUq14f5A9vBPKCgSD7JVxftDqtc7K3wJGeHjydjBBUuh8f+sXL8/9tSZ4P6QXgz25hdnRciPVqXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJUAr1rU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJUAr1rU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc73e322dbso21847045ad.1
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 19:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783822389; x=1784427189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RtYcoZBXkE+h9uNyvUP8OwkMXsP5YIQmdPT0+QpRd2Q=;
        b=VJUAr1rUfzwEu1qVdBZ1wH7Wy4+lQ5AOW8fDr9+VMWr3d/Qwnh20uTCsS0dWNTNxVa
         7zagcdE1ZfLLs6ArpRu8qdTtn7oy34ChjDA5ht6CoEL8INyQI1jf/VUtCRrYsy1WxyVh
         3I3gvUftBr3Mc7Znd/4e3/42C/sb627ch8RPNNfu/ifwtoLgbsgm+NpCEabFyEj8Jt4d
         6Hggi1UwAEuV6Amcnft4ugxVB+TMg0IlIfi7+OUJye79f3e0sfnpuG8lIWIfNLL/p8ej
         D4rYjNjSzFWIFPwKr78iwcHQ9r/scwgiAx78PCyzrEXP72Vq0M56LrRXIhxSBtm9JSPU
         PBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783822389; x=1784427189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RtYcoZBXkE+h9uNyvUP8OwkMXsP5YIQmdPT0+QpRd2Q=;
        b=XHwC2Tk3sSK49g4wO/dRlZdfAASe0ckEbZz2mISRAJQg2TnvAbEw7IP7nDaLTxDEet
         szSODjIQ7s1+604+MbiML4W896eO0KGYtobs/kBYEi+blJ3aKcA/sA3YyTKSI2sX9378
         Ub1YEqStTk7uxAnL9pL8HNYMOf8xjYeYXiTog8dVWnIegv4SEltZmHCKIuW4SJc2229l
         v0ZSK/+ZvsImz4SnNQVBw0Twi/EKytmtgkAGdthkm6dFK+phh3IUSyoY9GBYMOOxnNdZ
         c9BMa+3QhDqL7qis3/m//DVak11i4HSJVQq1Ve6OfQo0UZ9pj79eiF2cAJOHL3Y1QWpP
         V/qg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8b4rfEbUz+OD8fXwuuHLqH+JaEEHlqSadwKE29mE4M9zbd7msTgVSsUoqVfxXyas/tIEHsDwZBkYIiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJcUoPvqXQwIx36LwK3AtlHpXO+pwXD6hIFQ/he5iyAFFrYx+
	/VKM+9XeB48YMuBQedfUK/V9tguReInaD97mZdwq8vss0nL3JOOWRfky
X-Gm-Gg: AfdE7cnv25J7sIYJcZKTl3pSpdHaiUs2sUAP2jUWo8xPbAB8XUSYEimDkJ4/A+xw3Gr
	RS0BwObpxealIPe7wEzdkH1ZtUBNWMJbLYOfMUFWFCIWOlqYn5ArrdHRdU55H/6qBPWu6vUOaAF
	G7hM1QIVYfYHMilPaXACraLq+d1JwXSZNa7ZN01VZV+7AuVaPoLrClSOhL20KjZVZl3uIU87DvI
	AN8vkYFPcnpdN5wqCsDTZNeIDDb1gxHHEkSOjgvviKgg7nl4iXWCttTvpFhReboO66ijYfvh0qo
	RIiXlpW7ImydfyPXlJsnjpBH9EpwKjglTkGiJw3MO/DpnkhxC67FQls/eCIVmIAnb5lLNt+NFPO
	vNEO0p/TJ7k1d/UKB9viLRrb9VmLIr+JyQgkXgU0nyesf2AjJ0nZnYysK7Xgl9yA/WkbN6JJQLT
	lJMiDU2REDm3lOVswYgaluqeJX0AHn7wZnsct2WM8oie9BdhaHzBime7DYvbUjTjh68LEtYs06b
	pA=
X-Received: by 2002:a05:6a21:9d48:b0:3bf:5ff5:2b0f with SMTP id adf61e73a8af0-3c11062f658mr4861795637.12.1783822389307;
        Sat, 11 Jul 2026 19:13:09 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm54796692eec.18.2026.07.11.19.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:13:08 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 11 Jul 2026 19:12:46 -0700
Subject: [PATCH v3 05/10] Input: samsung-keypad - remove support for
 platform data
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-samsung-kp-v3-5-b2fcaba77aff@gmail.com>
References: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
In-Reply-To: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
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
 patches@opensource.cirrus.com, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-b242f

Because there are no more users of samsung_keypad_platdata left in
the kernel remove support for it from the driver.

The driver supports generic device properties so all configuration
should be done using them instead of a custom platform data.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/samsung-keypad.c | 184 +++++++++++++-------------------
 include/linux/input/samsung-keypad.h    |  39 -------
 2 files changed, 72 insertions(+), 151 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index cc34f0146161..e54b3b9f2cf2 100644
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
@@ -231,26 +234,22 @@ static void samsung_keypad_close(struct input_dev *input_dev)
 	samsung_keypad_stop(keypad);
 }
 
-static const struct matrix_keymap_data *
-samsung_parse_verbose_keymap(struct device *dev)
+static int samsung_parse_verbose_keymap(struct samsung_keypad *keypad)
 {
-	struct matrix_keymap_data *keymap_data;
+	struct matrix_keymap_data keymap_data = { 0 };
+	struct device *dev = &keypad->pdev->dev;
 	struct fwnode_handle *child;
-	u32 *keymap;
-	unsigned int key_count;
-
-	keymap_data = devm_kzalloc(dev, sizeof(*keymap_data), GFP_KERNEL);
-	if (!keymap_data)
-		return ERR_PTR(-ENOMEM);
+	unsigned int key_count = device_get_child_node_count(dev);
+	unsigned int i;
 
-	key_count = device_get_child_node_count(dev);
-	keymap = devm_kcalloc(dev, key_count, sizeof(*keymap), GFP_KERNEL);
+	u32 *keymap __free(kfree) = kcalloc(key_count, sizeof(*keymap), GFP_KERNEL);
 	if (!keymap)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
-	keymap_data->keymap_size = key_count;
-	keymap_data->keymap = keymap;
+	keymap_data.keymap_size = key_count;
+	keymap_data.keymap = keymap;
 
+	i = 0;
 	device_for_each_child_node(dev, child) {
 		u32 row, col, key_code;
 
@@ -258,123 +257,69 @@ samsung_parse_verbose_keymap(struct device *dev)
 		fwnode_property_read_u32(child, "keypad,column", &col);
 		fwnode_property_read_u32(child, "linux,code", &key_code);
 
-		*keymap++ = KEY(row, col, key_code);
+		keymap[i++] = KEY(row, col, key_code);
 	}
 
-	return keymap_data;
+	return matrix_keypad_build_keymap(&keymap_data, NULL,
+					  keypad->rows, keypad->cols,
+					  keypad->keycodes,
+					  keypad->input_dev);
 }
 
-static const struct samsung_keypad_platdata *
-samsung_keypad_parse_properties(struct device *dev)
+static int samsung_keypad_parse_keymap(struct samsung_keypad *keypad)
 {
-	const struct matrix_keymap_data *keymap_data;
-	struct samsung_keypad_platdata *pdata;
-	u32 num_rows = 0, num_cols = 0;
-	int error;
-
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
-	if (device_property_present(dev, "linux,keymap")) {
-		error = matrix_keypad_parse_properties(dev, &num_rows, &num_cols);
-		if (error)
-			return ERR_PTR(error);
-	} else {
-		device_property_read_u32(dev, "samsung,keypad-num-rows", &num_rows);
-		device_property_read_u32(dev, "samsung,keypad-num-columns", &num_cols);
-		if (!num_rows || !num_cols) {
-			dev_err(dev, "number of keypad rows/columns not specified\n");
-			return ERR_PTR(-EINVAL);
-		}
-	}
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
+	struct device *dev = &keypad->pdev->dev;
 
-	pdata->wakeup = device_property_read_bool(dev, "wakeup-source") ||
-			/* legacy name */
-			device_property_read_bool(dev, "linux,input-wakeup");
+	if (device_property_present(dev, "linux,keymap"))
+		return matrix_keypad_build_keymap(NULL, NULL,
+						  keypad->rows, keypad->cols,
+						  keypad->keycodes,
+						  keypad->input_dev);
 
-	return pdata;
+	return samsung_parse_verbose_keymap(keypad);
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
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (pdata) {
-		if (!pdata->keymap_data) {
-			dev_err(&pdev->dev, "no keymap data defined\n");
+	if (device_property_present(dev, "linux,keymap")) {
+		error = matrix_keypad_parse_properties(dev, &num_rows, &num_cols);
+		if (error)
+			return error;
+	} else {
+		device_property_read_u32(dev, "samsung,keypad-num-rows", &num_rows);
+		device_property_read_u32(dev, "samsung,keypad-num-columns", &num_cols);
+		if (!num_rows || !num_cols) {
+			dev_err(dev, "number of keypad rows/columns not specified\n");
 			return -EINVAL;
 		}
-	} else {
-		pdata = samsung_keypad_parse_properties(&pdev->dev);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
 	}
 
-	if (!pdata->rows || pdata->rows > SAMSUNG_MAX_ROWS)
-		return -EINVAL;
-
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
 
@@ -390,26 +335,45 @@ static int samsung_keypad_probe(struct platform_device *pdev)
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
@@ -424,7 +388,11 @@ static int samsung_keypad_probe(struct platform_device *pdev)
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
@@ -435,14 +403,6 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	if (!dev_get_platdata(&pdev->dev)) {
-		if (pdata->keymap_data) {
-			devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
-			devm_kfree(&pdev->dev, (void *)pdata->keymap_data);
-		}
-		devm_kfree(&pdev->dev, (void *)pdata);
-	}
-
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

