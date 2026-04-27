Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5622EFD9B;
	Mon, 27 Apr 2026 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300452; cv=none; b=c4JAYdF5SidyQj80ED0n9lQXcfGStJU4nx/sLm9etIycViD4Y8yxBXD0y70ckIl0/oKndbYbEsn7eaiDvrRwXeEGUd5BdHXO1t5H9T4ZN9TWBQW46PDGS586+vQyG0aVKbopL1gs30HKH1hs3eWPj75ylJj88fQGY308iktlsXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300452; c=relaxed/simple;
	bh=Uu70zpQsAsxpUVC8lO1BNp5pfR3GRNVLVZiVQ4UlGIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZXaldM9zyPBCMSMKbDX0RXSjef2OhKvmloCWCCvLISnrIoJ2sftPxxsPCl4iAEEtCtAvbZZ/VYy9nrnfYgFJjSGli9hfoB3yumUfgaaDDb2kdlTwlbd9j+AFth+1N3Nr1FhFO66kuLZx33Safej7IOEDLydgi4djEonbOn1fMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReMw50p2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReMw50p2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EF5C19425;
	Mon, 27 Apr 2026 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777300452;
	bh=Uu70zpQsAsxpUVC8lO1BNp5pfR3GRNVLVZiVQ4UlGIk=;
	h=From:To:Cc:Subject:Date:From;
	b=ReMw50p2CxZGIeRlhgnCabAdqL16XkFoH7Qn8uhf4S04SXvOvmLQEnY+0skBtRTBL
	 xA4Z50B8PkYr8jz2xK9uHClVAb2wVNglOjfzSF3ARjQa6OMi7FuIFbdKoNSfpGVvVL
	 ZduWSRDxMiVnAL6SAUqPOwr0YS4cfsgX3n8EmBZKhkudoHN44+uRgim3dqRnn0xeUK
	 ViT83pBHvDKpKH3mlM9tnNfOcOcdrU9hCdMiISOttZ1C5kRO+EYIyxw9HywCwi8O2F
	 NltInq9oGAzyf/WIOdiq56wVWyNdgWWTc0n8GXpSkOyLeHqWqm8XMXO5B5mOUnLYaI
	 k1hBNGDZXoxKA==
From: Arnd Bergmann <arnd@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lee Jones <lee@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] input: gpio-keys: make legacy gpiolib optional
Date: Mon, 27 Apr 2026 16:33:49 +0200
Message-Id: <20260427143406.3020992-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Most users of gpio-keys and gpio-keys-polled use modern gpiolib
interfaces, but there are still number of ancient sh, arm32 and x86
machines that have never been converted.

Add an #ifdef block for the parts of the driver that are only used on
those legacy machines.

The two Rohm PMIC drivers use a gpio-keys device without an actual GPIO,
passing an IRQ number instead. In order to keep this working both with
and with CONFIG_GPIOLIB_LEGACY, change the gpio-keys driver to ignore
the gpio number if an IRQ is passed.

Link: https://lore.kernel.org/all/b3c94552-c104-42e3-be15-7e8362e8039e@gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: skip the fake GPIO number passing from mfd
---
 drivers/input/keyboard/gpio_keys.c        | 7 ++++---
 drivers/input/keyboard/gpio_keys_polled.c | 2 ++
 drivers/mfd/rohm-bd71828.c                | 1 -
 drivers/mfd/rohm-bd718x7.c                | 1 -
 include/linux/gpio_keys.h                 | 2 ++
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index aed4c9be35d2..e988657f97cb 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -528,7 +528,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 			 */
 			bdata->gpiod = NULL;
 		}
-	} else if (gpio_is_valid(button->gpio)) {
+#ifdef CONFIG_GPIOLIB_LEGACY
+	} else if (!button->irq && gpio_is_valid(button->gpio)) {
 		/*
 		 * Legacy GPIO number, so request the GPIO here and
 		 * convert it to descriptor.
@@ -546,6 +547,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 		if (button->active_low ^ gpiod_is_active_low(bdata->gpiod))
 			gpiod_toggle_active_low(bdata->gpiod);
+#endif
 	}
 
 	if (bdata->gpiod) {
@@ -583,8 +585,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 			if (irq < 0) {
 				error = irq;
 				dev_err_probe(dev, error,
-					      "Unable to get irq number for GPIO %d\n",
-					      button->gpio);
+					      "Unable to get irq number for GPIO\n");
 				return error;
 			}
 			bdata->irq = irq;
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index c7aea2cdd712..4e7a366ff05b 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -301,6 +301,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 				return dev_err_probe(dev, PTR_ERR(bdata->gpiod),
 						     "failed to get gpio\n");
 			}
+#ifdef CONFIG_GPIOLIB_LEGACY
 		} else if (gpio_is_valid(button->gpio)) {
 			/*
 			 * Legacy GPIO number so request the GPIO here and
@@ -323,6 +324,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 
 			if (button->active_low ^ gpiod_is_active_low(bdata->gpiod))
 				gpiod_toggle_active_low(bdata->gpiod);
+#endif
 		}
 
 		bdata->last_state = -1;
diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index a79f354bf5cb..df6dad762ec9 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -39,7 +39,6 @@
 
 static struct gpio_keys_button button = {
 	.code = KEY_POWER,
-	.gpio = -1,
 	.type = EV_KEY,
 	.wakeup = 1,
 };
diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index ff714fd4f54d..dd774aa8828b 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -20,7 +20,6 @@
 
 static struct gpio_keys_button button = {
 	.code = KEY_POWER,
-	.gpio = -1,
 	.type = EV_KEY,
 };
 
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 80fa930b04c6..e8d6dc290efb 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -25,7 +25,9 @@ struct device;
  */
 struct gpio_keys_button {
 	unsigned int code;
+#ifdef CONFIG_GPIOLIB_LEGACY
 	int gpio;
+#endif
 	int active_low;
 	const char *desc;
 	unsigned int type;
-- 
2.39.5

