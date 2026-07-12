Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D48367B84
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822393; cv=none; b=e9DchkfxvBKAWHMfcUHZ0rn/ePxWNuamkDQP9b+I17DiYjJJIbY3nnPmOODlg6br0/HeRWoecrHzU2Vi7xO0Wkvzpw0uydkWxOwY7pZLucDQ6nM3elT2hdyOZJTi8tfbGiTu1i0TRHwOs4ELQFr8HA/SpcdZsjxdHxWi2RlGIsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822393; c=relaxed/simple;
	bh=o14WWo5qJFt+cooxn41hVY96/Zqncd1xZ05HOGgFc/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fjO4mASOhaVyN9TMWzuLLmDXpEn6B7zg9gaczUAGpqK0TNqApxArMUZqlTTE0iz/0LoLhSdAs3vkRH1eV8X+z8KdxOVEcdRK90geRoeqyuvbh4hh+VYqtD42OUKNRd/6F/fslomoK5KnXI76IaRtLvVTGdyPB/eiNhQK+1XBvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOoMgTjw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOoMgTjw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cca24023edso25328185ad.1
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 19:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783822391; x=1784427191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5FHjUZQYADUT6bCIy3JjzfiUR27NaQqxGvamZew7Xmw=;
        b=dOoMgTjw10WINSyMQDQpScfZNUm791DTIb1xvcHd1+Rx0zvGrG70Y6Zknmbo5TTcTl
         APkHatjg8/aoOYScAueBIBLoW7h4EYz9C+drZnspf3D42G4suXqoWziOrO5iNYhs6GvG
         +qF8BTnlvt3Au+K4bCLhmF+2PFszbX2IQHs1m9X78FRudn5B91QhIacq5i+sMZktUcs8
         UpqxZeiXf3bd30rfR8iBXtBg+WVIYOkU2r/ZjTMDnOzfrnYo9lYVMsS3b9mu+nSDiAkt
         nhGUqWEEAghrhNnKCtAEarcOpf5jbYRymKYcBN/JYcNPnwdBwZJZ2mK/O1zNGQkcRot7
         vj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783822391; x=1784427191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5FHjUZQYADUT6bCIy3JjzfiUR27NaQqxGvamZew7Xmw=;
        b=i7WipXMUH+T5A+no0dyNWG1M/JTkCho3ORqIKKrj0jVn3/CNMiiwiCNSLqFspP+G85
         i7eiav2K8F5mp6EFCs7/FWo70VNkSgfJb1Lo+kLrpkZjhhaeIRjg2DA0G2yaN7NiRA1Z
         v4gqFuv96O7ZxvFWQxoqF1UkKCtxwNN//33lnCX6+xaGmtxf9DVPrMmcPuvgc1932LYz
         UdTo7VMuMIriFayUFl32SoMxxa5Q21hfNAU1GhEv0aWQtL7yolaa1EqhPaZDdP9eK+vH
         DSPNflq7w5QiCQSI9rLzXX7s1MCV1Us6NOJoDppv1uqy4Qmp0hYETN4gVYmHIaBTPqQv
         sobQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxPc6tjemz5y7kMLq98M1vnZ/uVQbSlQzIvbFDTG1AHg1YCZRjKoC5mPv9LINBm2eITvxlSalWMgS3TQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcdxC1cr7T8jdTDPVyJ3D16Ynydf+44gXdafPwVWz4N7JD5IKN
	lqPkBBzBDDJ4I3A3LjfMN+E6GUvr0zFS94//v+teP0RaxgtojS/3oCDX
X-Gm-Gg: AfdE7ckToog9RI9IGBPJqIJkF+TA2f9fbNKgafHDB5nrbHDQAIxMX/GO61ANl0/KnYx
	EdHW/zuOJRxfCLMKJHsjyAFykmXUzhhEygSU62cC4CpOnXz0PAz1ETzkS38FWyz6+PAU0dLOCla
	pywjGbANGa9YlZl++5r66c1mPqHRPgZ1hRc+Lf5pzOTWoU4diNE3YsDh42TLxrmkNv20VmX1NIN
	2LLQfrgJw9u7UasRz8Vktwe1r4KTy1ZOCKi9ro5wm9T+1WFdXz8YnqfoW2ZF6BNw2Ss7q/8TMIp
	ST3juRVQufxiUUiEC1iqES1WdMSJAku7vjwU+XGlJdbr9qJbGlVNCxIfv6jGL90ICnBjfkzToQo
	NRBTaqj/AZ/wR6BXihwNgklGFB1XI8BaAT7fu9PETeII6QWRlrzt8BE9Qd7Za5IFhNvn+jFpg/B
	Aj33kOPAmuFRVPvZb4kfoyy3bjJ9cJ1kJ7ZHTktry5CgYvDAn1QR13481YByn1GF4hCm1dPPpQZ
	u4=
X-Received: by 2002:a05:6300:2290:b0:3b5:4fff:fa0f with SMTP id adf61e73a8af0-3c1109ecda0mr4245973637.14.1783822391326;
        Sat, 11 Jul 2026 19:13:11 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm54796692eec.18.2026.07.11.19.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:13:10 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 11 Jul 2026 19:12:47 -0700
Subject: [PATCH v3 06/10] ARM: s3c: crag6410: use software nodes/properties
 to set up GPIO keys
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-samsung-kp-v3-6-b2fcaba77aff@gmail.com>
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

Switch the gpio-keys device to use software nodes/properties to
describe the buttons and switches. This will allow dropping support
for platform data from the gpio-keys driver in the future.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-s3c/mach-crag6410.c | 79 ++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
index c2df5dcb3368..757c0f383ff1 100644
--- a/arch/arm/mach-s3c/mach-crag6410.c
+++ b/arch/arm/mach-s3c/mach-crag6410.c
@@ -18,6 +18,7 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/leds.h>
 #include <linux/delay.h>
 #include <linux/mmc/host.h>
@@ -228,32 +229,68 @@ static void __init crag6410_setup_keypad(void)
 		pr_err("failed to instantiate keypad device\n");
 }
 
-static struct gpio_keys_button crag6410_gpio_keys[] = {
-	[0] = {
-		.code	= KEY_SUSPEND,
-		.gpio	= S3C64XX_GPL(10),	/* EINT 18 */
-		.type	= EV_KEY,
-		.wakeup	= 1,
-		.active_low = 1,
-	},
-	[1] = {
-		.code	= SW_FRONT_PROXIMITY,
-		.gpio	= S3C64XX_GPN(11),	/* EINT 11 */
-		.type	= EV_SW,
-	},
+static const struct software_node crag6410_gpio_keys_node = {
+	.name = "crag6410-gpio-keys",
 };
 
-static struct gpio_keys_platform_data crag6410_gpio_keydata = {
-	.buttons	= crag6410_gpio_keys,
-	.nbuttons	= ARRAY_SIZE(crag6410_gpio_keys),
+static const struct property_entry crag6410_suspend_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", KEY_SUSPEND),
+	PROPERTY_ENTRY_GPIO("gpios",
+			    SAMSUNG_GPIO_NODE('L'), 10,	/* EINT 18 */
+			    GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_BOOL("wakeup-source"),
+	{ }
 };
 
-static struct platform_device crag6410_gpio_keydev = {
-	.name		= "gpio-keys",
-	.id		= 0,
-	.dev.platform_data = &crag6410_gpio_keydata,
+static const struct software_node crag6410_suspend_key_node = {
+	.parent = &crag6410_gpio_keys_node,
+	.properties = crag6410_suspend_key_props,
+};
+
+static const struct property_entry crag6410_prox_sw_props[] = {
+	PROPERTY_ENTRY_U32("linux,input-type", EV_SW),
+	PROPERTY_ENTRY_U32("linux,code", SW_FRONT_PROXIMITY),
+	PROPERTY_ENTRY_GPIO("gpios",
+			    SAMSUNG_GPIO_NODE('N'), 11,	/* EINT 11 */
+			    GPIO_ACTIVE_HIGH),
+	{ }
+};
+
+static const struct software_node crag6410_prox_sw_node = {
+	.parent = &crag6410_gpio_keys_node,
+	.properties = crag6410_prox_sw_props,
 };
 
+static const struct software_node *crag6410_gpio_keys_swnodes[] = {
+	&crag6410_gpio_keys_node,
+	&crag6410_suspend_key_node,
+	&crag6410_prox_sw_node,
+	NULL
+};
+
+static void __init crag6410_setup_gpio_keys(void)
+{
+	struct platform_device_info keys_info = {
+		.name	= "gpio-keys",
+		.id	= 0,
+	};
+	struct platform_device *pd;
+	int err;
+
+	err = software_node_register_node_group(crag6410_gpio_keys_swnodes);
+	if (err) {
+		pr_err("failed to register gpio-keys software nodes: %d\n", err);
+		return;
+	}
+
+	keys_info.fwnode = software_node_fwnode(&crag6410_gpio_keys_node);
+
+	pd = platform_device_register_full(&keys_info);
+	err = PTR_ERR_OR_ZERO(pd);
+	if (err)
+		pr_err("failed to create gpio-keys device: %d\n", err);
+}
+
 static struct resource crag6410_dm9k_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C64XX_PA_XM0CSN5, 2),
 	[1] = DEFINE_RES_MEM(S3C64XX_PA_XM0CSN5 + (1 << 8), 2),
@@ -397,7 +434,6 @@ static struct platform_device *crag6410_devs0[] __initdata = {
 	&samsung_device_pwm,
 	&s3c64xx_device_iis0,
 	&s3c64xx_device_iis1,
-	&crag6410_gpio_keydev,
 };
 
 static struct platform_device *crag6410_devs1[] __initdata = {
@@ -909,6 +945,7 @@ static void __init crag6410_machine_init(void)
 
 	gpiod_add_lookup_table(&crag_leds_table);
 	crag6410_setup_keypad();
+	crag6410_setup_gpio_keys();
 
 	platform_add_devices(crag6410_devs1, ARRAY_SIZE(crag6410_devs1));
 	gpio_led_register_device(-1, &gpio_leds_pdata);

-- 
2.55.0.795.g602f6c329a-goog

