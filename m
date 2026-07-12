Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EE0367B84
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 02:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822402; cv=none; b=jincevSsxT95pXqTSTYU7oNaaOmyOG7RgN0AP2p9me/WBHEnCmJFKr/y3/wMgd5q4nIuBcdhw2ELQ9POqV2EYOsqPtxNpGMJ8demG+KnKhIWTsZfOVXcjDWhPocYK5hHxoBcEI6Dzxp4mWvbgfHMA06HklIRVaaeVhH1lVsbQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822402; c=relaxed/simple;
	bh=EYs1cAQYrxKtJFmAc2+/heSToHPC1pab4g1v6irxLGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7p4YClE3kcWED9oduQNzDw8difFE2031/rQXXtk554rsjU0Povbbe6+VXQFZUZN4IUvKm6NSPqSeRud00JUY6aUhpj9HQoJrvKySuTxPEatV8NpCeNvULGK1QWcTaiE7rlyoN2Yf73NrpCsiUhmQOvPYRFVI9NL4TBHcaEQmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKX1gEis; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKX1gEis"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37df72c9984so3671592a91.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 19:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783822399; x=1784427199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5AFVwN6iVzF4B4uVu1QcDeH3p0cXhfS2t6vqHL4txKQ=;
        b=JKX1gEisD6+DPf0N22IU55YgCHw26SBj8lUF+6kIuj8/2cwKiC4YqBoMmt/jl5PDJn
         ieShNco9qSSNODx4iWxzRC3Lksl3rdRNPlgUCjUSgWNvJmavEYGkE63qND1Seb0dWIGu
         Fjk2JTfbsXgrYSHBYQ5uGc6kw7/ai3v2BQGnHyNJIBCGfAn1kHx8j21c79NA1F4IfsRU
         ffw6Fu81WH26VX/cBl4JB0YDzukLT3OgnzAZnwCg2NYBweqw1RaSFuMw3IH+yQGa1PkZ
         jB3WnD/ah89HHyhkQB11uM+odLkhhKoKdsWJHsfrw3j8Bp8ujRleB959KNsrodtw0/zO
         amyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783822399; x=1784427199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5AFVwN6iVzF4B4uVu1QcDeH3p0cXhfS2t6vqHL4txKQ=;
        b=myZ8SxKOljSH2UepZu9N+nbXWW26Ns40fM0gjJFUDOtVVJ6BQ89X65ZSqmRoYmctwR
         r7kzBMTO6ozYKIgNZFcEttoUzNUkwmkmOJwblFRyr2rXwxHXR+OCpSomDwsuhSgfy7io
         Mdx3svUh478TMKZj79V9gSprZQUG5VHVEwdvQ8QcohMwMGGl8ibQAzrG4ge0fAwdHSKB
         2IZMWfhoEQZkas2Vnbf19VB9o3T9zd9HiSSiJ+2e4ejFgWQq1AdrXXA9V3eOuOhcwpVL
         Hntngk0l+8BDI013Rrb8TCItuqFgebJHjqc4vYcU3Jnpk/VTesp0EbZbldwG9waeOUwx
         OXrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYi69Nc5l452OvTQ7DdjIkxm2JFgPk+dmbxzR5FpeCMuPNAIQO6QMW4aDpdqm/Et/GGZ0Fv66l89vPCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRviREJxcsPNdCgOLNYfpJXMsgz1hUO/CdBbjEWoe2oyF88R2
	LLj3rAui1jPTz8/Yy3K2NOS/Btk0SDU1SAVBAqlOqpkJ0CVCOSPQPwKTWgESCA==
X-Gm-Gg: AfdE7ckURkX2cPDFOwAftrX1Cqn3h5gtp9tg4krwLG5wTa8wLHgX0p1TMhsEkj0/hen
	CswoDUOsc3vyIoU3nOH4GmsjZD1dKqKDL6NIgrIwyNThR7ft7AMuktUrmVAA7YNQ5kGn0pU0wQy
	j1984UTU9+CeKcIZ/7MgJI/NDxGaj1rIhMlv/pn9TlAhnrdLtz5NTDPY7hL2tDJ4rz9mxEeth/R
	gODXmsZhy3qvdQGkHtS7prynYTkbIYlsl1LDKtQ9Z71ryP/PWQ3OHPIl5HrGjvOGHh+MKWzFToz
	zQDR02dLafCYL5kYe9PwrFNyIp1inUjiWnm3tvdMGpuN5XZ4fY+0VU/ir7mSctvFwyrfAb/RPXB
	1dzrN+scPjAkEqH4KAXiVbNcZM2LxQIGj67JKDld9vyqAKBhBvA4WoyZq6WJ7j2yI4nc7EK25xI
	Bo6cx0Bi3IGJkgD3uPM2RADDlz/CeR5hjrJFQNCSKTgKty9j8JKBqDv2/CoiV1733iDnAxTwoTl
	bCsodLR043New==
X-Received: by 2002:a17:90b:2641:b0:387:e0cb:7f4 with SMTP id 98e67ed59e1d1-38dc783efacmr4605750a91.40.1783822399368;
        Sat, 11 Jul 2026 19:13:19 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm54796692eec.18.2026.07.11.19.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:13:18 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 11 Jul 2026 19:12:51 -0700
Subject: [PATCH v3 10/10] ARM: s3c: crag6410: convert remaining GPIO lookup
 tables to property entries
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-samsung-kp-v3-10-b2fcaba77aff@gmail.com>
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

Static property entries support defining GPIOs and are more similar to
device tree properties and are not prone to losing link between device
and a lookup table because of changes in device name. Convert the board
to use them for WM1250 and SPI0 devices.

This also fixes issue with recent conversion to GPIO descriptors
where GPIO lookup tables were specifying incorrect GPIO chip name
("GPIO<N>" vs "GP<N>").

Fixes: 10a366f36e2a ("ASoC: wm1250-ev1: Convert to GPIO descriptors")
Fixes: a45cf3cc72dd ("spi: s3c64xx: Convert to use GPIO descriptors")
Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-s3c/devs.c          | 35 -----------------
 arch/arm/mach-s3c/devs.h          |  1 -
 arch/arm/mach-s3c/mach-crag6410.c | 83 ++++++++++++++++++++++++++++-----------
 3 files changed, 59 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-s3c/devs.c b/arch/arm/mach-s3c/devs.c
index 0237307b9238..d1125316043b 100644
--- a/arch/arm/mach-s3c/devs.c
+++ b/arch/arm/mach-s3c/devs.c
@@ -335,38 +335,3 @@ void __init dwc2_hsotg_set_platdata(struct dwc2_hsotg_plat *pd)
 		npd->phy_exit = s3c_usb_phy_exit;
 }
 #endif /* CONFIG_S3C_DEV_USB_HSOTG */
-
-#ifdef CONFIG_S3C64XX_DEV_SPI0
-static struct resource s3c64xx_spi0_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_SPI0, SZ_256),
-	[1] = DEFINE_RES_IRQ(IRQ_SPI0),
-};
-
-struct platform_device s3c64xx_device_spi0 = {
-	.name		= "s3c6410-spi",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s3c64xx_spi0_resource),
-	.resource	= s3c64xx_spi0_resource,
-	.dev = {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-void __init s3c64xx_spi0_set_platdata(int src_clk_nr, int num_cs)
-{
-	struct s3c64xx_spi_info pd;
-
-	/* Reject invalid configuration */
-	if (!num_cs || src_clk_nr < 0) {
-		pr_err("%s: Invalid SPI configuration\n", __func__);
-		return;
-	}
-
-	pd.num_cs = num_cs;
-	pd.src_clk_nr = src_clk_nr;
-	pd.cfg_gpio = s3c64xx_spi0_cfg_gpio;
-
-	s3c_set_platdata(&pd, sizeof(pd), &s3c64xx_device_spi0);
-}
-#endif /* CONFIG_S3C64XX_DEV_SPI0 */
diff --git a/arch/arm/mach-s3c/devs.h b/arch/arm/mach-s3c/devs.h
index 2737990063b1..90a86ade3570 100644
--- a/arch/arm/mach-s3c/devs.h
+++ b/arch/arm/mach-s3c/devs.h
@@ -27,7 +27,6 @@ extern struct platform_device *s3c24xx_uart_src[];
 
 extern struct platform_device s3c64xx_device_iis0;
 extern struct platform_device s3c64xx_device_iis1;
-extern struct platform_device s3c64xx_device_spi0;
 
 extern struct platform_device s3c_device_fb;
 extern struct platform_device s3c_device_hsmmc0;
diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
index 1ba3d47d85b7..9f4756898a78 100644
--- a/arch/arm/mach-s3c/mach-crag6410.c
+++ b/arch/arm/mach-s3c/mach-crag6410.c
@@ -443,7 +443,6 @@ static struct platform_device *crag6410_devs0[] __initdata = {
 
 static struct platform_device *crag6410_devs1[] __initdata = {
 	&crag6410_dm9k_device,
-	&s3c64xx_device_spi0,
 	&crag6410_lcd_powerdev,
 	&crag6410_backlight_device,
 	&speyside_device,
@@ -777,17 +776,22 @@ static struct wm831x_pdata glenfarclas_pmic_pdata = {
 	.disable_touch = true,
 };
 
-static struct gpiod_lookup_table crag_wm1250_ev1_gpiod_table = {
-	/* The WM1250-EV1 is device 0027 on I2C bus 1 */
-	.dev_id = "1-0027",
-	.table = {
-		GPIO_LOOKUP("GPION", 12, "clk-ena", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("GPIOL", 12, "clk-sel0", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("GPIOL", 13, "clk-sel1", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("GPIOL", 14, "osr", GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP("GPIOL", 8, "master", GPIO_ACTIVE_HIGH),
-		{ },
-	},
+static const struct property_entry crag_wm1250_ev1_properties[] = {
+	PROPERTY_ENTRY_GPIO("clk-ena-gpios",
+			    SAMSUNG_GPIO_NODE('N'), 12, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("clk-sel0-gpios",
+			    SAMSUNG_GPIO_NODE('L'), 12, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("clk-sel1-gpios",
+			    SAMSUNG_GPIO_NODE('L'), 13, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("osr-gpios",
+			    SAMSUNG_GPIO_NODE('L'), 14, GPIO_ACTIVE_HIGH),
+	PROPERTY_ENTRY_GPIO("master-gpios",
+			    SAMSUNG_GPIO_NODE('L'), 8, GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node crag_wm1250_ev1_swnode = {
+	.properties = crag_wm1250_ev1_properties,
 };
 
 static struct i2c_board_info i2c_devs1[] = {
@@ -800,7 +804,8 @@ static struct i2c_board_info i2c_devs1[] = {
 	{ I2C_BOARD_INFO("wlf-gf-module", 0x24) },
 	{ I2C_BOARD_INFO("wlf-gf-module", 0x25) },
 	{ I2C_BOARD_INFO("wlf-gf-module", 0x26) },
-	{ I2C_BOARD_INFO("wm1250-ev1", 0x27), },
+	{ I2C_BOARD_INFO("wm1250-ev1", 0x27),
+	  .swnode = &crag_wm1250_ev1_swnode, },
 };
 
 static struct s3c2410_platform_i2c i2c1_pdata = {
@@ -904,15 +909,48 @@ static void __init crag6410_setup_leds(void)
 
 static struct dwc2_hsotg_plat crag6410_hsotg_pdata;
 
-static struct gpiod_lookup_table crag_spi0_gpiod_table = {
-	.dev_id = "s3c6410-spi.0",
-	.table = {
-		GPIO_LOOKUP_IDX("GPIOC", 3, "cs", 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("GPION", 5, "cs", 1, GPIO_ACTIVE_LOW),
-		{ },
-	},
+static const struct software_node_ref_args crag6410_spi0_gpio_refs[] = {
+	SOFTWARE_NODE_REFERENCE(SAMSUNG_GPIO_NODE('C'), 3, GPIO_ACTIVE_LOW),
+	SOFTWARE_NODE_REFERENCE(SAMSUNG_GPIO_NODE('N'), 5, GPIO_ACTIVE_LOW),
+};
+
+static const struct property_entry crag6410_spi0_properties[] __initconst = {
+	PROPERTY_ENTRY_REF_ARRAY("cs-gpios", crag6410_spi0_gpio_refs),
+	{ }
+};
+
+static const struct resource crag6410_spi0_resource[] __initconst = {
+	[0] = DEFINE_RES_MEM(S3C_PA_SPI0, SZ_256),
+	[1] = DEFINE_RES_IRQ(IRQ_SPI0),
+};
+
+static const struct s3c64xx_spi_info crag6410_spi0_platform_data __initconst = {
+	.num_cs = 2,
+	.cfg_gpio = s3c64xx_spi0_cfg_gpio,
 };
 
+static const struct platform_device_info crag6410_spi0_info __initconst = {
+	.name		= "s3c6410-spi",
+	.id		= 0,
+	.res		= crag6410_spi0_resource,
+	.num_res	= ARRAY_SIZE(crag6410_spi0_resource),
+	.data		= &crag6410_spi0_platform_data,
+	.size_data	= sizeof(crag6410_spi0_platform_data),
+	.dma_mask	= DMA_BIT_MASK(32),
+	.properties	= crag6410_spi0_properties,
+};
+
+static void __init crag6410_setup_spi0(void)
+{
+	struct platform_device *pd;
+	int err;
+
+	pd = platform_device_register_full(&crag6410_spi0_info);
+	err = PTR_ERR_OR_ZERO(pd);
+	if (err)
+		pr_err("failed to create spi0 device: %d\n", err);
+}
+
 static void __init crag6410_machine_init(void)
 {
 	/* Open drain IRQs need pullups */
@@ -941,18 +979,15 @@ static void __init crag6410_machine_init(void)
 
 	software_node_register(&crag_dcdc1_swnode);
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
-	gpiod_add_lookup_table(&crag_wm1250_ev1_gpiod_table);
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
-	gpiod_add_lookup_table(&crag_spi0_gpiod_table);
-	s3c64xx_spi0_set_platdata(0, 2);
-
 	pwm_add_table(crag6410_pwm_lookup, ARRAY_SIZE(crag6410_pwm_lookup));
 	platform_add_devices(crag6410_devs0, ARRAY_SIZE(crag6410_devs0));
 	platform_device_register_full(&crag6410_mmgpio_devinfo);
 
 	crag6410_setup_keypad();
 	crag6410_setup_gpio_keys();
+	crag6410_setup_spi0();
 
 	platform_add_devices(crag6410_devs1, ARRAY_SIZE(crag6410_devs1));
 	crag6410_setup_leds();

-- 
2.55.0.795.g602f6c329a-goog

