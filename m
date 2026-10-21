Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547413;
	b=1IrQRQ295P4lsHFdWyhKd6f22Tn9o7jKpPokpRkeYfFo/DSilUTidZvZpNMUgrCDhjcJ
	 IrVhyIudefQ5PdJmZF6+dNyQV2pHYbiXLidqlDH4AGGIYJrS6x6I2J2AV6AFL8qICH2vy
	 jPKGQvJnAbxfrR7JYwztfust7iHWIDUcjrTOVA6ho1ZVCjo/PzVe9S6YzWP8t3VoyIy8t
	 qnIvGNMROvDrZrgq7IG3WeWWoBKri7uSN/QM4GNaJzztT9zPdWzsk/3YfUhrp6KQvX2n+
	 6moLEWymddS0LnqNmISARK3zoQUKlf+5v/k4aN29f0Up0zVwFTxE1SSc7gMPLdVkmpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SbBvyVbLG0tQQ8Qqhoffo4kWq5gHdbGII/4Aa/1W3Dc=;
	b=4YLwz7yOpCyKqblsOghozaCgV8SQtTba2mlrzw++phqwZ7iBWqR0g5+xRBdRPK4OVwee
	 OAlMP3eIjjSi5gjHHMDAZbQPRmID+onR9OACWwq0IvDt6MDApBr3Gzrb4/XAntzVDQD+b
	 n9U2kGLPfrjf4xUhxoMRpbF4O23bbooFPv2c14tJe1MjskQ6dqDadtFeUMl1tkt58i0uf
	 NVsYYxoI7MYghIv4179zDhRQuBpP11uoU1qpNavwIoO2UmWtWvb4bnNJqi4pKONOlD5Ox
	 TgOd7ihgoHQ1ylG0/U2IEikxo6ojP6eUlMWwHKBYXUrKI7QVO+E5H9X2p8dT9Ww+/bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XYPIfMer;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C7606A32D
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 01:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 998C7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XYPIfMer
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15ea896ddc8so299946c88.0
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 18:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792547412; x=1793152212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SbBvyVbLG0tQQ8Qqhoffo4kWq5gHdbGII/4Aa/1W3Dc=;
        b=XYPIfMerTCp0Xuqp2TRlvKjebAiNU/J6S1+1msPp4lyf22Roc3ic90OjfP4ul7P5GX
         XMvxugPW68FF/sZwFcA83hfZ42JUUrTewsgbE11+zdl8kGKI/3mFpPfMPaEE0+PvTKNp
         hsbY6hDNACScwc8kIRviZY8/90fNoD8STug69seyXYWXi9RvzsqT+Y8fhdOhoo48R5uQ
         f8VM3xTWmGuUbQ81JtQdtwbDzvx9KdAGBjzyT/086ak3gRBVsxL+Ec5YGk+g8Yzb7O7I
         RKTQxVRW6VN7ro+LB3U7Dw3/RdiYk6Uzfmt/4LmzWTkvcGrwT/uqioFdkk02nLeaqdv+
         T2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792547412; x=1793152212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SbBvyVbLG0tQQ8Qqhoffo4kWq5gHdbGII/4Aa/1W3Dc=;
        b=jfT+FA9Dx1wfzFvG8BXHtyL/JWYhNbF4RNNMSbXywE13djOco1tbCSOIol+08CR9hP
         EljBBmGFYoQqf6rJXsfvHLgZGRGamKjEkK6nB0LekFM4pw3teJ1VR2wdBRb7qg26e3Mh
         /TvFvDHWkbzw05qo5o7x6aIw3l93qL3sjiADDA0VpFs38OE9HM2w18XLlxwfKbmVZaBC
         2p612d6lKHUpI5gmg/dM8S8zgMKSWRRjsIi1hYYz8YiB63RoyiHN2AAmUrgy+ZPfTy3l
         E7/iQQEIm+9d+bUv0UO43lFTGLihyNvNe/yuK+zM70ORDPTQ8TRpEvls3xjFaWl9COQH
         X2nw==
X-Forwarded-Encrypted: i=1; AKwUvByY0fqBq0hw32zxyjHn0ipc/MC8le3tnFpgpcWJ0zrwyMF7s1g0pv5qC0P8t6RmVI9YZ3GcWnJvRozdjA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKKEm+nCoFKyn02u2EMHMtpl/AYblMig4kjoORrd3LJv2/yZLRU
	15/JgZlNgVbIbWdk5M6EEy6r02dyT4s5Kpq5rrSBweKXg0RFDHfMunB7
X-Gm-Gg: AYBFou3cN0M7zxzmwUqEGPUEvKb0H0cD5Ec9VCct2taIjXd0PNvdBwT7RVwP2uLwcxn
	ZyFl80uvdim+Lolcvi6HRPBY7FceYWMHyBrCmB4DWWsFQRfwQrkNYZ4V/SrhVSKrNmfBF131Na4
	mDelYth22Dj418D/JETg0QSjVHuLEREQ4iLFZUKsTuKMnXJVsks7XM8IRwljGHUF4/2wzkcmdZq
	EpBeru8FvTndKWJRVVRxnxjxvBSdUW5QmawGUQwrlnJCezB1RjzGIhwmVYG2SBSWtx6UQQ+iaNb
	ckPgkOqzLsHj0lTIpTvwT4QGEgliEm56/I2y+V3EOhEhLXOIcTtyNJztVPj4WLG27X66/xtgM/9
	tFv+d/e1Es5291Sker1EPBtuX+Z+ISI7UL4ATDs8APj6F5bwN15/qx5uSEP0YEGyx0Ev9AUqULR
	j9MwVbU3o7kYlGENa7DH49o6ye/dGnkP5t05od1mTrm6AG930xD41Ungp9wKWwhHnwZABgo4ik6
	pBZdAr6v9tBA3GwZPD23ksxGlEeG/WmZ3UQSJWqhVJSXbpVhSZwjmPGUZTF5anvw52J5uctHlUS
	AYk2dYHFSP9hJC8epF/2fsWWhEmc6IG5gnTS7iF7DW3kvi7WR9wsjGPBCphLzz0XHQ==
X-Received: by 2002:a05:7022:4589:b0:14f:8e70:fad0 with SMTP id a92af1059eb24-190a738157amr1043137c88.33.1792547411541;
        Tue, 20 Oct 2026 18:50:11 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bd6b7ccsm2106839c88.13.2026.10.20.18.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:50:10 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Input: soc_button_array - convert to software nodes
Date: Tue, 20 Oct 2026 18:50:01 -0700
Message-ID: <20261021015004.1537738-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the driver from using legacy platform data to using software
nodes for registering 'gpio-keys' devices. This allows us to
transition away from platform data and use generic device properties.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/Kconfig            |   1 -
 drivers/input/misc/soc_button_array.c | 134 ++++++++++++++++++--------
 2 files changed, 92 insertions(+), 43 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 169768e3d5bb..a2984c1048f3 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -906,7 +906,6 @@ config INPUT_SOC_BUTTON_ARRAY
 	depends on KEYBOARD_GPIO && ACPI
 	depends on X86
 	depends on GPIOLIB
-	select GPIOLIB_LEGACY
 	help
 	  Say Y here if you have a SoC-based tablet that originally runs
 	  Windows 8 or a Microsoft Surface Book 2, Pro 5, Laptop 1 or later.
diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 8d782ef4f78b..aa7838b864c2 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -14,9 +14,11 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/gpio/consumer.h>
-#include <linux/gpio_keys.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
 #include <linux/platform_data/x86/soc.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 static bool use_low_level_irq;
@@ -59,10 +61,10 @@ struct soc_button_data {
  * gets called with the lid open (e.g. on boot and on resume), it sets the
  * irq-type to IRQ_TYPE_LEVEL_LOW. Where as the gpio-keys driver programs the
  * type to, and expects it to be, IRQ_TYPE_EDGE_BOTH.
- * To work around this we don't set gpio_keys_button.gpio on these 2-in-1s,
+ * To work around this we don't set "gpios" property on these 2-in-1s,
  * instead we get the irq for the GPIO ourselves, configure it as
  * IRQ_TYPE_LEVEL_LOW (to match how the _LID AML code configures it) and pass
- * the irq in gpio_keys_button.irq. Below is a list of affected devices.
+ * the irq as a device resource. Below is a list of affected devices.
  */
 static const struct dmi_system_id dmi_use_low_level_irq[] = {
 	{
@@ -131,18 +133,31 @@ static const struct dmi_system_id dmi_invalid_acpi_index[] = {
 };
 
 /*
- * Get the Nth GPIO number from the ACPI object.
+ * Get the Nth GPIO information from the ACPI object.
  */
 static int soc_button_lookup_gpio(struct device *dev, int acpi_index,
-				  int *gpio_ret, int *irq_ret)
+				  bool active_low,
+				  struct software_node_ref_args *gpio_ref,
+				  int *irq_ret)
 {
+	struct gpio_device *gdev;
+	struct fwnode_handle *fwnode;
 	struct gpio_desc *desc;
 
 	desc = gpiod_get_index(dev, NULL, acpi_index, GPIOD_ASIS);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-	*gpio_ret = desc_to_gpio(desc);
+	gdev = gpiod_to_gpio_device(desc);
+	fwnode = dev_fwnode(gpio_device_to_device(gdev));
+	if (!fwnode) {
+		gpiod_put(desc);
+		return -ENODEV;
+	}
+
+	*gpio_ref = SOFTWARE_NODE_REFERENCE(fwnode, gpiod_hwgpio(desc),
+					    active_low ? GPIO_ACTIVE_LOW :
+							 GPIO_ACTIVE_HIGH);
 	*irq_ret = gpiod_to_irq(desc);
 
 	gpiod_put(desc);
@@ -150,11 +165,28 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index,
 	return 0;
 }
 
+static void soc_button_remove_swnodes(struct fwnode_handle *parent)
+{
+	struct fwnode_handle *child;
+
+	if (IS_ERR_OR_NULL(parent))
+		return;
+
+	fwnode_for_each_child_node(parent, child)
+		fwnode_remove_software_node(child);
+
+	fwnode_remove_software_node(parent);
+}
+
 static struct platform_device *
 soc_button_device_create(struct platform_device *pdev,
 			 const struct soc_button_info *button_info,
 			 bool autorepeat)
 {
+	const struct property_entry parent_props[] = {
+		PROPERTY_ENTRY_BOOL("autorepeat"),
+		{ }
+	};
 	struct platform_device_info pdevinfo = {
 		.parent = &pdev->dev,
 		.name = "gpio-keys",
@@ -162,17 +194,19 @@ soc_button_device_create(struct platform_device *pdev,
 	};
 	const struct soc_button_info *info;
 	struct platform_device *pd;
-	struct gpio_keys_button *gpio_keys;
-	struct gpio_keys_platform_data *gpio_keys_pdata;
+	struct fwnode_handle *parent_node;
 	const struct dmi_system_id *dmi_id;
 	int invalid_acpi_index = -1;
-	int error, gpio, irq = 0;
+	int error, irq = 0;
 	int n_buttons = 0;
 
 	for (info = button_info; info->name; info++)
 		if (info->autorepeat == autorepeat)
 			n_buttons++;
 
+	if (n_buttons == 0)
+		return ERR_PTR(-ENODEV);
+
 	struct resource *irq_resources __free(kfree) = NULL;
 	/* See dmi_use_low_level_irq[] comment */
 	if (!autorepeat && (use_low_level_irq ||
@@ -182,17 +216,10 @@ soc_button_device_create(struct platform_device *pdev,
 			return ERR_PTR(-ENOMEM);
 	}
 
-	gpio_keys_pdata = devm_kzalloc(&pdev->dev,
-				       sizeof(*gpio_keys_pdata) +
-					sizeof(*gpio_keys) * n_buttons,
-				       GFP_KERNEL);
-	if (!gpio_keys_pdata)
-		return ERR_PTR(-ENOMEM);
-
-	pdevinfo.data = gpio_keys_pdata;
-	pdevinfo.size_data = sizeof(*gpio_keys_pdata);
+	parent_node = fwnode_create_software_node(autorepeat ? parent_props : NULL, NULL);
+	if (IS_ERR(parent_node))
+		return ERR_CAST(parent_node);
 
-	gpio_keys = (void *)(gpio_keys_pdata + 1);
 	n_buttons = 0;
 
 	dmi_id = dmi_first_match(dmi_invalid_acpi_index);
@@ -200,13 +227,19 @@ soc_button_device_create(struct platform_device *pdev,
 		invalid_acpi_index = (long)dmi_id->driver_data;
 
 	for (info = button_info; info->name; info++) {
+		struct software_node_ref_args gpio_ref;
+		struct property_entry child_props[7] = { };
+		struct fwnode_handle *child_node;
+		int prop_idx = 0;
+
 		if (info->autorepeat != autorepeat)
 			continue;
 
 		if (info->acpi_index == invalid_acpi_index)
 			continue;
 
-		error = soc_button_lookup_gpio(&pdev->dev, info->acpi_index, &gpio, &irq);
+		error = soc_button_lookup_gpio(&pdev->dev, info->acpi_index,
+					       info->active_low, &gpio_ref, &irq);
 		if (error || irq < 0) {
 			/*
 			 * Propagate -EPROBE_DEFER, skip button on other errors.
@@ -223,57 +256,68 @@ soc_button_device_create(struct platform_device *pdev,
 			if ((error == -EPROBE_DEFER || irq == -EPROBE_DEFER) &&
 			    !(soc_intel_is_byt() || soc_intel_is_cht())) {
 				error = -EPROBE_DEFER;
-				goto err_free_mem;
+				goto err_remove_swnodes;
 			}
 
 			continue;
 		}
 
+		child_props[prop_idx++] = PROPERTY_ENTRY_U32("linux,code", info->event_code);
+		child_props[prop_idx++] = PROPERTY_ENTRY_STRING("label", info->name);
+
+		if (info->event_type != EV_KEY)
+			child_props[prop_idx++] =
+				PROPERTY_ENTRY_U32("linux,input-type",
+						   info->event_type);
+
+		if (info->wakeup)
+			child_props[prop_idx++] = PROPERTY_ENTRY_BOOL("wakeup-source");
+
+		/* These devices often use cheap buttons, use 50 ms debounce */
+		child_props[prop_idx++] = PROPERTY_ENTRY_U32("debounce-interval", 50);
+
 		/* See dmi_use_low_level_irq[] comment */
 		if (irq_resources) {
 			irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);
 			irq_resources[n_buttons] = DEFINE_RES_IRQ(irq);
-			gpio_keys[n_buttons].gpio = -ENOENT;
 		} else {
-			gpio_keys[n_buttons].gpio = gpio;
+			child_props[prop_idx++] =
+				PROPERTY_ENTRY_REF("gpios", &gpio_ref);
+		}
+
+		child_node = fwnode_create_software_node(child_props, parent_node);
+		if (IS_ERR(child_node)) {
+			error = PTR_ERR(child_node);
+			goto err_remove_swnodes;
 		}
 
-		gpio_keys[n_buttons].type = info->event_type;
-		gpio_keys[n_buttons].code = info->event_code;
-		gpio_keys[n_buttons].active_low = info->active_low;
-		gpio_keys[n_buttons].desc = info->name;
-		gpio_keys[n_buttons].wakeup = info->wakeup;
-		/* These devices often use cheap buttons, use 50 ms debounce */
-		gpio_keys[n_buttons].debounce_interval = 50;
 		n_buttons++;
 	}
 
 	if (n_buttons == 0) {
 		error = -ENODEV;
-		goto err_free_mem;
+		goto err_remove_swnodes;
 	}
 
-	gpio_keys_pdata->buttons = gpio_keys;
-	gpio_keys_pdata->nbuttons = n_buttons;
-	gpio_keys_pdata->rep = autorepeat;
-
 	if (irq_resources) {
 		pdevinfo.res = irq_resources;
 		pdevinfo.num_res = n_buttons;
 	}
 
+	pdevinfo.fwnode = parent_node;
+
 	pd = platform_device_register_full(&pdevinfo);
 	error = PTR_ERR_OR_ZERO(pd);
 	if (error) {
 		dev_err(&pdev->dev,
 			"failed registering gpio-keys: %d\n", error);
-		goto err_free_mem;
+		goto err_remove_swnodes;
 	}
 
 	return pd;
 
-err_free_mem:
-	devm_kfree(&pdev->dev, gpio_keys_pdata);
+err_remove_swnodes:
+	soc_button_remove_swnodes(parent_node);
 	return ERR_PTR(error);
 }
 
@@ -439,12 +483,18 @@ static struct soc_button_info *soc_button_get_button_info(struct device *dev)
 static void soc_button_remove(struct platform_device *pdev)
 {
 	struct soc_button_data *priv = platform_get_drvdata(pdev);
-
+	struct platform_device *pd;
+	struct fwnode_handle *fwnode;
 	int i;
 
-	for (i = 0; i < BUTTON_TYPES; i++)
-		if (priv->children[i])
-			platform_device_unregister(priv->children[i]);
+	for (i = 0; i < BUTTON_TYPES; i++) {
+		pd = priv->children[i];
+		if (pd) {
+			fwnode = dev_fwnode(&pd->dev);
+			platform_device_unregister(pd);
+			soc_button_remove_swnodes(fwnode);
+		}
+	}
 }
 
 static int soc_button_probe(struct platform_device *pdev)
-- 
2.56.0.212.g129ede20d9-goog

