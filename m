Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479536729D
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 02:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822391; cv=none; b=CUgN4RSPCODyBG/iq9D70MkC3Gpkm4T+JZk7eIk3JlPBOX4peVE8L16g+Cx6KthEPZ1mUwBpzP7MZwzEXXLpLATsa6fosqPbxA6y9ZV2eBbt2Oni0kufc0Oyx9roImDWE+7T6fTZt8eRuGHgs1iAWJc36nE/c4GdL71K8jpkSzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822391; c=relaxed/simple;
	bh=MbHlbYKPDPXngEv5b2cf7bYHnBjY1dG/nTATjVUAvcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNiVNP5cV9izsfZXCqZMlKfc5KMSMixEmvIOeAdBRpYr3SQvQm/MqzE3N6rsPkKUB7fvN5TkyfUhy90e/cQbjeRvQGbWN9JXgpZAruK6vnzNIX3AYkq9ghUhCWJCj5M+xAOEY3RtcD4lVeF1gv64yV7pHJ7DvjlDXp99PzUU57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IckXT8aQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IckXT8aQ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-382a3fe0d28so2093232a91.0
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 19:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783822387; x=1784427187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQ4PU66CTnBXQAzr6PHBDQyKEYKs9ioZmr93h8ngf+E=;
        b=IckXT8aQImmqrso9oMx61C2RjvuLXJwQ7XqMOcAakT97vVobu5muRvNsYjAq1LiLOT
         MM2jQpk/8Y2gGt1MjD3VjbwDADaJFBNmBxiDObBwyGyNR/01RbDKxOPexSAJVrmjuLWJ
         JCbkSlIYNJW7McIxypquyS2NmAQVBEyX5zJgcwqx4q7w3zHsbGz/jK7ha22mXXuEdwE2
         agHx3bQt9+W4XQsBxm9LIn37LfnZBbwl3IDa6mIh/hcNgnHQyjxp2J36I94QaZAxJna0
         tIBMDUkHlp22U88fCKtkKjQDqbSoLHyVBQO7gV21hldHN/U9ocGp+mLTBgD/9wc7JoOk
         rf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783822387; x=1784427187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQ4PU66CTnBXQAzr6PHBDQyKEYKs9ioZmr93h8ngf+E=;
        b=Tq5+eLACp9KBcAcYcp/QbP37FjRvFpfwUm6t/wB+LXN0SG0vSy/q8R4CA6qOmoYQcF
         U1vQaIJcicXK5fTMBiQJ3ExPYAR8ieU33cyup+DWUHBIQEjrbUo19+D/vN0He81IuKFQ
         c2lEDbpCoOq4BLuXg0QNilnqCtV1OuI1QfUj/eZfhG3YKRU/mF9i3QiPGl2M+BEBd28C
         o75FL+LVfjpoXAKzPWcDRZihmugPh3bPYzbSKZB5fwslEPirumGiN9sL5FGtoZTMJoB8
         AeJd8aJPaFEBmtbLNeNgE2Q1pupLKqDWN2qLFGLxChMzOrAd0VDOCdhpCNc2Wtxuxi2a
         Zjbw==
X-Forwarded-Encrypted: i=1; AHgh+RrbqbsTOAFqZl3Cpb4Tv78Mtd1XRJcKJL79o3R14zlhYLozqtqKuzEMsfsrzjWXgtinW977Tgs3AQoFQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/UBzu8AsM8L9+TejnY3w3m1T3N0gJ4Rl+KeLDyI+CdmrZnZCU
	S0Ni4qioFGmVijmxDjkrAhSJPK6LdW1gY6Tzl6Hu4z3PBbBWPmlbhOXj
X-Gm-Gg: AfdE7ckYzy1OGH7wBRoc0ggzmKCZ3Ok5PtzzSr/9eR3b5RWh6wgOiY1Eom4+TLcQGnl
	V/jJ0dWC+ZkHB8pPfDXiX1KUpmEg/EuCEVSLUIZ29GEHJ8bl/WA/EJylHIVcQQsp2ySPLAZuYSO
	+iDi3MTIiIXzjkS+pWsMP+RuW3Bc6meqaJFuHaPB3hT79eEc/OaYojKXW0/97Hhl45NrM0A90ca
	NA67qMv73rFNxswzE7Ga0XLhPhukWleNaacL90VZqUkKPeEV58OpoP52Tcw6LMqx5d52GBJFLRL
	gatguneoVV+g/nkvh17Q5Z/5Ydq3VP+MRW/uOOcpot28rXALh5dMJ6WV3/XQT0jdZ0zy7FTIPXd
	cKPjmoBD+BcmPpgqb43nY2umA4cte0tcZJxnLNFmKIeUKJEpCQeHhBmXNUiwPpRSfB0dNyPaByc
	w8QV6uf2v1u+t1cfqwwPhuh3h0eeeMJsgmXLUU+TbUa025iMHGMwzRdfHEvT/1koMFTUDn01qVV
	dQ=
X-Received: by 2002:a17:90b:5343:b0:37f:9ce1:7369 with SMTP id 98e67ed59e1d1-38dc777486cmr4384818a91.31.1783822387067;
        Sat, 11 Jul 2026 19:13:07 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm54796692eec.18.2026.07.11.19.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:13:06 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 11 Jul 2026 19:12:45 -0700
Subject: [PATCH v3 04/10] ARM: s3c: crag6410: switch keypad device to
 software properties
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-samsung-kp-v3-4-b2fcaba77aff@gmail.com>
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
 patches@opensource.cirrus.com, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.16-dev-b242f

Switch the keypad device to use software properties to describe the
keypad. This will allow dropping support for platform data from the
samsung-keypad driver.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-s3c/Kconfig                |  5 ---
 arch/arm/mach-s3c/Kconfig.s3c64xx        |  7 ----
 arch/arm/mach-s3c/Makefile.s3c64xx       |  1 -
 arch/arm/mach-s3c/devs.c                 | 27 ---------------
 arch/arm/mach-s3c/devs.h                 |  1 -
 arch/arm/mach-s3c/keypad.h               | 27 ---------------
 arch/arm/mach-s3c/mach-crag6410.c        | 56 ++++++++++++++++++++++++--------
 arch/arm/mach-s3c/setup-keypad-s3c64xx.c | 20 ------------
 8 files changed, 42 insertions(+), 102 deletions(-)

diff --git a/arch/arm/mach-s3c/Kconfig b/arch/arm/mach-s3c/Kconfig
index b3656109f1f7..2e77bb4f3a8c 100644
--- a/arch/arm/mach-s3c/Kconfig
+++ b/arch/arm/mach-s3c/Kconfig
@@ -111,11 +111,6 @@ config S3C64XX_DEV_SPI0
 	  Compile in platform device definitions for S3C64XX's type
 	  SPI controller 0
 
-config SAMSUNG_DEV_KEYPAD
-	bool
-	help
-	  Compile in platform device definitions for keypad
-
 config SAMSUNG_DEV_PWM
 	bool
 	help
diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
index 3f97fba8e4f5..aef97cc5d195 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c64xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
@@ -74,11 +74,6 @@ config S3C64XX_SETUP_FB_24BPP
 	help
 	  Common setup code for S3C64XX with an 24bpp RGB display helper.
 
-config S3C64XX_SETUP_KEYPAD
-	bool
-	help
-	  Common setup code for S3C64XX KEYPAD GPIO configurations
-
 config S3C64XX_SETUP_SDHCI_GPIO
 	bool
 	help
@@ -106,7 +101,6 @@ config MACH_WLF_CRAGG_6410
 	select S3C64XX_DEV_SPI0
 	select S3C64XX_SETUP_FB_24BPP
 	select S3C64XX_SETUP_I2C1
-	select S3C64XX_SETUP_KEYPAD
 	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_SPI
 	select S3C64XX_SETUP_USB_PHY
@@ -117,7 +111,6 @@ config MACH_WLF_CRAGG_6410
 	select S3C_DEV_I2C1
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
-	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
 	help
 	  Machine support for the Wolfson Cragganmore S3C6410 variant.
diff --git a/arch/arm/mach-s3c/Makefile.s3c64xx b/arch/arm/mach-s3c/Makefile.s3c64xx
index 61287ad2ea42..1686b1f344f8 100644
--- a/arch/arm/mach-s3c/Makefile.s3c64xx
+++ b/arch/arm/mach-s3c/Makefile.s3c64xx
@@ -32,7 +32,6 @@ obj-y				+= dev-audio-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP)	+= setup-fb-24bpp-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_I2C0)	+= setup-i2c0-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_I2C1)	+= setup-i2c1-s3c64xx.o
-obj-$(CONFIG_S3C64XX_SETUP_KEYPAD)	+= setup-keypad-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_SPI)		+= setup-spi-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_USB_PHY) += setup-usb-phy-s3c64xx.o
diff --git a/arch/arm/mach-s3c/devs.c b/arch/arm/mach-s3c/devs.c
index bab2abd8a34a..0237307b9238 100644
--- a/arch/arm/mach-s3c/devs.c
+++ b/arch/arm/mach-s3c/devs.c
@@ -39,7 +39,6 @@
 #include "devs.h"
 #include "fb.h"
 #include <linux/platform_data/i2c-s3c2410.h>
-#include "keypad.h"
 #include "pwm-core.h"
 #include "sdhci.h"
 #include "usb-phy.h"
@@ -265,32 +264,6 @@ void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
 }
 #endif /* CONFIG_S3C_DEV_I2C1 */
 
-/* KEYPAD */
-
-#ifdef CONFIG_SAMSUNG_DEV_KEYPAD
-static struct resource samsung_keypad_resources[] = {
-	[0] = DEFINE_RES_MEM(SAMSUNG_PA_KEYPAD, SZ_32),
-	[1] = DEFINE_RES_IRQ(IRQ_KEYPAD),
-};
-
-struct platform_device samsung_device_keypad = {
-	.name		= "samsung-keypad",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(samsung_keypad_resources),
-	.resource	= samsung_keypad_resources,
-};
-
-void __init samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd)
-{
-	struct samsung_keypad_platdata *npd;
-
-	npd = s3c_set_platdata(pd, sizeof(*npd), &samsung_device_keypad);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = samsung_keypad_cfg_gpio;
-}
-#endif /* CONFIG_SAMSUNG_DEV_KEYPAD */
-
 /* PWM Timer */
 
 #ifdef CONFIG_SAMSUNG_DEV_PWM
diff --git a/arch/arm/mach-s3c/devs.h b/arch/arm/mach-s3c/devs.h
index 21c00786c264..2737990063b1 100644
--- a/arch/arm/mach-s3c/devs.h
+++ b/arch/arm/mach-s3c/devs.h
@@ -39,7 +39,6 @@ extern struct platform_device s3c_device_i2c1;
 extern struct platform_device s3c_device_ohci;
 extern struct platform_device s3c_device_usb_hsotg;
 
-extern struct platform_device samsung_device_keypad;
 extern struct platform_device samsung_device_pwm;
 
 /**
diff --git a/arch/arm/mach-s3c/keypad.h b/arch/arm/mach-s3c/keypad.h
deleted file mode 100644
index 9754b9a29945..000000000000
--- a/arch/arm/mach-s3c/keypad.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Samsung Platform - Keypad platform data definitions
- *
- * Copyright (C) 2010 Samsung Electronics Co.Ltd
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- */
-
-#ifndef __PLAT_SAMSUNG_KEYPAD_H
-#define __PLAT_SAMSUNG_KEYPAD_H
-
-#include <linux/input/samsung-keypad.h>
-
-/**
- * samsung_keypad_set_platdata - Set platform data for Samsung Keypad device.
- * @pd: Platform data to register to device.
- *
- * Register the given platform data for use with Samsung Keypad device.
- * The call will copy the platform data, so the board definitions can
- * make the structure itself __initdata.
- */
-extern void samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd);
-
-/* defined by architecture to configure gpio. */
-extern void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols);
-
-#endif /* __PLAT_SAMSUNG_KEYPAD_H */
diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
index c4040aad1ed3..c2df5dcb3368 100644
--- a/arch/arm/mach-s3c/mach-crag6410.c
+++ b/arch/arm/mach-s3c/mach-crag6410.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/input-event-codes.h>
+#include <linux/input/matrix_keypad.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/leds.h>
@@ -22,6 +23,7 @@
 #include <linux/mmc/host.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/pwm_backlight.h>
 #include <linux/dm9000.h>
@@ -53,7 +55,6 @@
 #include "gpio-cfg.h"
 #include <linux/platform_data/spi-s3c64xx.h>
 
-#include "keypad.h"
 #include "devs.h"
 #include "cpu.h"
 #include <linux/platform_data/i2c-s3c2410.h>
@@ -176,7 +177,7 @@ static struct s3c_fb_platdata crag6410_lcd_pdata = {
 
 /* 2x6 keypad */
 
-static uint32_t crag6410_keymap[] = {
+static const u32 crag6410_keymap[] __initconst = {
 	/* KEY(row, col, keycode) */
 	KEY(0, 0, KEY_VOLUMEUP),
 	KEY(0, 1, KEY_HOME),
@@ -192,17 +193,41 @@ static uint32_t crag6410_keymap[] = {
 	KEY(1, 5, KEY_CAMERA),
 };
 
-static struct matrix_keymap_data crag6410_keymap_data = {
-	.keymap		= crag6410_keymap,
-	.keymap_size	= ARRAY_SIZE(crag6410_keymap),
+static const struct property_entry crag6410_keypad_props[] __initconst = {
+	PROPERTY_ENTRY_U32("keypad,num-columns", 6),
+	PROPERTY_ENTRY_U32("keypad,num-rows", 2),
+	PROPERTY_ENTRY_U32_ARRAY("linux,keymap", crag6410_keymap),
+	{ }
+};
+
+static const struct resource crag6410_keypad_resources[] __initconst = {
+	[0] = DEFINE_RES_MEM(SAMSUNG_PA_KEYPAD, SZ_32),
+	[1] = DEFINE_RES_IRQ(IRQ_KEYPAD),
 };
 
-static struct samsung_keypad_platdata crag6410_keypad_data = {
-	.keymap_data	= &crag6410_keymap_data,
-	.rows		= 2,
-	.cols		= 6,
+static const struct platform_device_info crag6410_keypad_info __initconst = {
+	.name		= "samsung-keypad",
+	.id		= PLATFORM_DEVID_NONE,
+	.res		= crag6410_keypad_resources,
+	.num_res	= ARRAY_SIZE(crag6410_keypad_resources),
+	.properties	= crag6410_keypad_props,
 };
 
+static void __init crag6410_setup_keypad(void)
+{
+	struct platform_device *pd;
+
+	/* Set all the necessary GPK pins to special-function 3: KP_ROW[x] */
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPK(8), 2, S3C_GPIO_SFN(3));
+
+	/* Set all the necessary GPL pins to special-function 3: KP_COL[x] */
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPL(0), 6, S3C_GPIO_SFN(3));
+
+	pd = platform_device_register_full(&crag6410_keypad_info);
+	if (IS_ERR(pd))
+		pr_err("failed to instantiate keypad device\n");
+}
+
 static struct gpio_keys_button crag6410_gpio_keys[] = {
 	[0] = {
 		.code	= KEY_SUSPEND,
@@ -361,7 +386,7 @@ static struct platform_device wallvdd_device = {
 	},
 };
 
-static struct platform_device *crag6410_devices[] __initdata = {
+static struct platform_device *crag6410_devs0[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc2,
 	&s3c_device_i2c0,
@@ -372,8 +397,10 @@ static struct platform_device *crag6410_devices[] __initdata = {
 	&samsung_device_pwm,
 	&s3c64xx_device_iis0,
 	&s3c64xx_device_iis1,
-	&samsung_device_keypad,
 	&crag6410_gpio_keydev,
+};
+
+static struct platform_device *crag6410_devs1[] __initdata = {
 	&crag6410_dm9k_device,
 	&s3c64xx_device_spi0,
 	&crag6410_lcd_powerdev,
@@ -873,16 +900,17 @@ static void __init crag6410_machine_init(void)
 	gpiod_add_lookup_table(&crag_wm1250_ev1_gpiod_table);
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
-	samsung_keypad_set_platdata(&crag6410_keypad_data);
-
 	gpiod_add_lookup_table(&crag_spi0_gpiod_table);
 	s3c64xx_spi0_set_platdata(0, 2);
 
 	pwm_add_table(crag6410_pwm_lookup, ARRAY_SIZE(crag6410_pwm_lookup));
-	platform_add_devices(crag6410_devices, ARRAY_SIZE(crag6410_devices));
+	platform_add_devices(crag6410_devs0, ARRAY_SIZE(crag6410_devs0));
 	platform_device_register_full(&crag6410_mmgpio_devinfo);
 
 	gpiod_add_lookup_table(&crag_leds_table);
+	crag6410_setup_keypad();
+
+	platform_add_devices(crag6410_devs1, ARRAY_SIZE(crag6410_devs1));
 	gpio_led_register_device(-1, &gpio_leds_pdata);
 
 	regulator_has_full_constraints();
diff --git a/arch/arm/mach-s3c/setup-keypad-s3c64xx.c b/arch/arm/mach-s3c/setup-keypad-s3c64xx.c
deleted file mode 100644
index 8463ad37c6ab..000000000000
--- a/arch/arm/mach-s3c/setup-keypad-s3c64xx.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// Copyright (c) 2010 Samsung Electronics Co., Ltd.
-//		http://www.samsung.com/
-//
-// GPIO configuration for S3C64XX KeyPad device
-
-#include <linux/gpio.h>
-#include "gpio-cfg.h"
-#include "keypad.h"
-#include "gpio-samsung.h"
-
-void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
-{
-	/* Set all the necessary GPK pins to special-function 3: KP_ROW[x] */
-	s3c_gpio_cfgrange_nopull(S3C64XX_GPK(8), rows, S3C_GPIO_SFN(3));
-
-	/* Set all the necessary GPL pins to special-function 3: KP_COL[x] */
-	s3c_gpio_cfgrange_nopull(S3C64XX_GPL(0), cols, S3C_GPIO_SFN(3));
-}

-- 
2.55.0.795.g602f6c329a-goog

