Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4C366074
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822385; cv=none; b=IdHym7tyrmRDD50fREiIPk+cNfmIhpi5nFHLsKknurmQPVBQjB1OeatpoeqXaIOAW+8UOysDpm4TVQcJ9riYDmwR2hvI/iI8m1pLqUxw5nuCqW7t2F4zIvmoutG17M1k4pWVB2HZNkZpR00LHhl+EwygRbC8/NYGjNncW4jCtrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822385; c=relaxed/simple;
	bh=Fg2KtAXDCXXyltSoF8WHknhmYOpPlfFwduvTzcAsQoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUljSR+OjhZ4KtLahvr8muE/pdowOx2iy1MWXVSkZ337cEweRGLFsNVUk2YgRs+wWojTXIxD7RIMsqhKf9nQXZ2Zxjx+Wns51ThHlZphZZ4PGYDt298vinOzl7EIU2hjsTuj/OGlowYGjXWPEL01l5yFVLwJU+APYdLpQs+vrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAF/kEkJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAF/kEkJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37df72c9984so3671355a91.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 19:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783822383; x=1784427183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JKukckWpY+orPNsziCIsLI7E7zxitxT1NiWuLx/R2I4=;
        b=PAF/kEkJnwurFstloIClJLTZVjQ02VAMtSU8vtyjucVKlgAaYTNVPhwVI5udfBUah3
         l8GrzBMpKWeTpjn+9GJYhwLy+pJus1kTX3H+p4L6pEv54klxINi9M3i2mpaN3VyWY2np
         FtTg/A8gRte6hUPXemZ9m8Vs7fwoYW0iUEFddU3b8c+JXmi/MehDeagi+yqXptUiX23M
         G6gHJnwVyqUZwi5uHAK5AThXpm+O7e5AuxuqgPAlcKq6U9YEvZ/WP6SOzv+iDMQ3Oxxw
         dxd2rF4cVF7qcxU8GBrLZduu8QRdSHOv4IWaMiQxIM1fugKmaolXDi64gnEmpg9r8k+C
         e9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783822383; x=1784427183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKukckWpY+orPNsziCIsLI7E7zxitxT1NiWuLx/R2I4=;
        b=KCVez2AKDn1oFXb1iWs1IixcQxIWPrbkIFXPxKnfF9uh6ckgle2CWpds7RoP9n1S9E
         VYMBV4cLjQuGWirsolg8TuK1e874n4k81QEqtGM9gmXTaH8jSjg21huoXSJ5ss+1P/Lr
         e1zkI0ASMBfIWygJFtDabn2HjTPiV4MFQQHLACg3oxKfV3P9BF7ppuD5tmEXZyDsUHzc
         VxUa4XGM3NefIHgdtztK7x4LVERLXXATRqEI+ri2+KPQrkph1V38P0xY+rBbW3qfsqTn
         Dwib1PHyJqm1UKH9GTMWmTLdhLJlmDLS/X0mzsn9LWsQylLZGKTZ9szWlTsLx05cAryh
         RkKw==
X-Forwarded-Encrypted: i=1; AHgh+RpvmOpv19gpVpUU+DKOdtl8nSKPraFcaTU1UPLXhtCKkBN1FIksrLNNeb8wNarpqerWLMwJV1wMTZDxIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybgQqhhtbTkSibJAQtq2e2uXflafctEMtx29z9rZ93BLZ9uGzv
	Mi9J0mNHehay4OizL657sTbGZJIWRjNr6xOGh8stGAB38ap6EUAieM1J
X-Gm-Gg: AfdE7ck/rWIQ0sJl/dn/5QieTfRvQgwqYpLP9P8kPcMOZtyjg8MRf3eXpef4DvwEbcM
	INELdW+YrUjjnjSiiYdARf6JV+zd2Qk6tWVErGuI/qZ5pwmllnvCr+TSPWJPGzsybj5h0M0JsJO
	CKmodBU6LHyCGPWEPNKPEJ9KS2UTm6VZJbEYuUhdufInjWGuTiF8TK/hHMUYzpgu3q01Z0uZS3i
	Q6SjYfUqa6aLiMV2Ss3RSGMbyQe1gAugRvY2p7z+kcPn44xL1MZQV1ibLBrqv8MgORJSZKMnfVV
	h8IHmajfX+2JZ82B0o+/WPRw3a6CxvRvJK1WXBe55CY1JK0VKUr++e0RKydZD8Lj9B1/5UGJIgk
	6drQr3tZ6wPNO1N4WevNfnTvPS9dgMs/HkEjXtnU48Yz1ujbbH2FCz70CXUiT8q3/+KUMZ3adC6
	Ku0HEq8LgpsoKIEQIBSnRtY7H43Iqtka8IALEwx3JxyPA313j40ggyV6ZJLt7eAZjh+mv85qDsh
	5k=
X-Received: by 2002:a17:90a:e7c9:b0:387:e0cb:7f7 with SMTP id 98e67ed59e1d1-38dc784ae88mr4308970a91.43.1783822382978;
        Sat, 11 Jul 2026 19:13:02 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm54796692eec.18.2026.07.11.19.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:13:01 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 11 Jul 2026 19:12:43 -0700
Subject: [PATCH v3 02/10] Input: samsung-keypad - handle compact binding
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-samsung-kp-v3-2-b2fcaba77aff@gmail.com>
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

Add support for standard matrix keymap binding (in addition to the
existing verbose binding with a sub-node for each key). This will
allow easier conversions from platform data to device properties when
using static device properties.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/samsung-keypad.c | 134 +++++++++++++++++---------------
 1 file changed, 71 insertions(+), 63 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 17127269e3f0..cc34f0146161 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -231,83 +231,89 @@ static void samsung_keypad_close(struct input_dev *input_dev)
 	samsung_keypad_stop(keypad);
 }
 
-#ifdef CONFIG_OF
-static struct samsung_keypad_platdata *
-samsung_keypad_parse_dt(struct device *dev)
+static const struct matrix_keymap_data *
+samsung_parse_verbose_keymap(struct device *dev)
 {
-	struct samsung_keypad_platdata *pdata;
 	struct matrix_keymap_data *keymap_data;
-	uint32_t *keymap, num_rows = 0, num_cols = 0;
-	struct device_node *np = dev->of_node, *key_np;
+	struct fwnode_handle *child;
+	u32 *keymap;
 	unsigned int key_count;
 
-	if (!np) {
-		dev_err(dev, "missing device tree data\n");
-		return ERR_PTR(-EINVAL);
+	keymap_data = devm_kzalloc(dev, sizeof(*keymap_data), GFP_KERNEL);
+	if (!keymap_data)
+		return ERR_PTR(-ENOMEM);
+
+	key_count = device_get_child_node_count(dev);
+	keymap = devm_kcalloc(dev, key_count, sizeof(*keymap), GFP_KERNEL);
+	if (!keymap)
+		return ERR_PTR(-ENOMEM);
+
+	keymap_data->keymap_size = key_count;
+	keymap_data->keymap = keymap;
+
+	device_for_each_child_node(dev, child) {
+		u32 row, col, key_code;
+
+		fwnode_property_read_u32(child, "keypad,row", &row);
+		fwnode_property_read_u32(child, "keypad,column", &col);
+		fwnode_property_read_u32(child, "linux,code", &key_code);
+
+		*keymap++ = KEY(row, col, key_code);
 	}
 
+	return keymap_data;
+}
+
+static const struct samsung_keypad_platdata *
+samsung_keypad_parse_properties(struct device *dev)
+{
+	const struct matrix_keymap_data *keymap_data;
+	struct samsung_keypad_platdata *pdata;
+	u32 num_rows = 0, num_cols = 0;
+	int error;
+
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(dev, "could not allocate memory for platform data\n");
+	if (!pdata)
 		return ERR_PTR(-ENOMEM);
-	}
 
-	of_property_read_u32(np, "samsung,keypad-num-rows", &num_rows);
-	of_property_read_u32(np, "samsung,keypad-num-columns", &num_cols);
-	if (!num_rows || !num_cols) {
-		dev_err(dev, "number of keypad rows/columns not specified\n");
-		return ERR_PTR(-EINVAL);
+	if (device_property_present(dev, "linux,keymap")) {
+		error = matrix_keypad_parse_properties(dev, &num_rows, &num_cols);
+		if (error)
+			return ERR_PTR(error);
+	} else {
+		device_property_read_u32(dev, "samsung,keypad-num-rows", &num_rows);
+		device_property_read_u32(dev, "samsung,keypad-num-columns", &num_cols);
+		if (!num_rows || !num_cols) {
+			dev_err(dev, "number of keypad rows/columns not specified\n");
+			return ERR_PTR(-EINVAL);
+		}
 	}
+
 	pdata->rows = num_rows;
 	pdata->cols = num_cols;
 
-	keymap_data = devm_kzalloc(dev, sizeof(*keymap_data), GFP_KERNEL);
-	if (!keymap_data) {
-		dev_err(dev, "could not allocate memory for keymap data\n");
-		return ERR_PTR(-ENOMEM);
-	}
-	pdata->keymap_data = keymap_data;
+	if (!device_property_present(dev, "linux,keymap")) {
+		keymap_data = samsung_parse_verbose_keymap(dev);
+		if (IS_ERR(keymap_data))
+			return ERR_CAST(keymap_data);
 
-	key_count = of_get_child_count(np);
-	keymap_data->keymap_size = key_count;
-	keymap = devm_kcalloc(dev, key_count, sizeof(uint32_t), GFP_KERNEL);
-	if (!keymap) {
-		dev_err(dev, "could not allocate memory for keymap\n");
-		return ERR_PTR(-ENOMEM);
+		pdata->keymap_data = keymap_data;
 	}
-	keymap_data->keymap = keymap;
 
-	for_each_child_of_node(np, key_np) {
-		u32 row, col, key_code;
-		of_property_read_u32(key_np, "keypad,row", &row);
-		of_property_read_u32(key_np, "keypad,column", &col);
-		of_property_read_u32(key_np, "linux,code", &key_code);
-		*keymap++ = KEY(row, col, key_code);
-	}
 
-	pdata->no_autorepeat = of_property_read_bool(np, "linux,input-no-autorepeat");
+	pdata->no_autorepeat =
+		device_property_read_bool(dev, "linux,input-no-autorepeat");
 
-	pdata->wakeup = of_property_read_bool(np, "wakeup-source") ||
+	pdata->wakeup = device_property_read_bool(dev, "wakeup-source") ||
 			/* legacy name */
-			of_property_read_bool(np, "linux,input-wakeup");
-
+			device_property_read_bool(dev, "linux,input-wakeup");
 
 	return pdata;
 }
-#else
-static struct samsung_keypad_platdata *
-samsung_keypad_parse_dt(struct device *dev)
-{
-	dev_err(dev, "no platform data defined\n");
-
-	return ERR_PTR(-EINVAL);
-}
-#endif
 
 static int samsung_keypad_probe(struct platform_device *pdev)
 {
 	const struct samsung_keypad_platdata *pdata;
-	const struct matrix_keymap_data *keymap_data;
 	const struct platform_device_id *id;
 	struct samsung_keypad *keypad;
 	struct resource *res;
@@ -316,18 +322,17 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	int error;
 
 	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		pdata = samsung_keypad_parse_dt(&pdev->dev);
+	if (pdata) {
+		if (!pdata->keymap_data) {
+			dev_err(&pdev->dev, "no keymap data defined\n");
+			return -EINVAL;
+		}
+	} else {
+		pdata = samsung_keypad_parse_properties(&pdev->dev);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
 	}
 
-	keymap_data = pdata->keymap_data;
-	if (!keymap_data) {
-		dev_err(&pdev->dev, "no keymap data defined\n");
-		return -EINVAL;
-	}
-
 	if (!pdata->rows || pdata->rows > SAMSUNG_MAX_ROWS)
 		return -EINVAL;
 
@@ -391,7 +396,7 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	input_dev->open = samsung_keypad_open;
 	input_dev->close = samsung_keypad_close;
 
-	error = matrix_keypad_build_keymap(keymap_data, NULL,
+	error = matrix_keypad_build_keymap(pdata->keymap_data, NULL,
 					   pdata->rows, pdata->cols,
 					   keypad->keycodes, input_dev);
 	if (error) {
@@ -430,11 +435,14 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
-	if (pdev->dev.of_node) {
-		devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
-		devm_kfree(&pdev->dev, (void *)pdata->keymap_data);
+	if (!dev_get_platdata(&pdev->dev)) {
+		if (pdata->keymap_data) {
+			devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
+			devm_kfree(&pdev->dev, (void *)pdata->keymap_data);
+		}
 		devm_kfree(&pdev->dev, (void *)pdata);
 	}
+
 	return 0;
 }
 

-- 
2.55.0.795.g602f6c329a-goog

