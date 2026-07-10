Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DC3B4EAA;
	Fri, 10 Jul 2026 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718357; cv=none; b=kSp/yGVph+8QoxNQxh5L2xSdhk1Ev7FvNYDo/a8jkxLl5UrNrHu1lgt1hrYdKqu7kMhXzcvH/2necVrtCVbLVOvGTBIVV1bmUizv0zRKSUJdU977MfYalikKT8qFlCO8xrevwszFVYwxRGwhRBnwvSZ9MRtHmic+drHGYdQmGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718357; c=relaxed/simple;
	bh=ZxnRrZtRPuAIq8NlMUIxxH+gHJOLJ3rFA3IW5TGDwuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jqBuhtn65CM2shI0YuHV0DFnx6rPKuoeyZX4BirMQAaXyBBR1RkodVJlwor7NtraRqOEA2QveY7WpJy1NbbZB50xHQf9VF8aXSTqLqzmFKOp5K83bqN2xP+19CqUkTtJcU/7lkrJafwhXbutAMnuqzpC/aznqMRvWFX9tAoT7vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYfBr9rY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYfBr9rY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05711F00A3A;
	Fri, 10 Jul 2026 21:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718355;
	bh=UX90iQ3LkDmO8fRydgIUY2muq8ufm1s4/Q3CAMMdDfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UYfBr9rYqJ3+zhU7JqhDQxcZAlQI/LzCnnEyzpRqtui+m4dKf9bJUQDvuL/gyoXQw
	 J/DeSKg0VPHHYLle3QzaAeH7FABooKcd/PjkMVuQ40A3KS/al5Cf/K9zgNGUTX4e0n
	 I3um47bsI5gzjY1Iy7Pzv4gqp1yweyHAqhZvAfqfROVeC0U9YACY48B3vvy7Q6Nv7M
	 WS6/p7e7rrRYDu8Q+l4EWBgPPl8o3sagLPzzsGqlikNMF/o2dqIcnRQ4APs3BvLO53
	 mSpNZQHP0ZH2G9UXQFVhWx2uLCORI4q0VYbbv4N1CwM5hh3xLTmbrz0srEMkdGmpNo
	 ojfp5Ln736G4w==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-gpio@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/6] [v6] leds: gpio: make legacy gpiolib interface optional
Date: Fri, 10 Jul 2026 23:18:51 +0200
Message-Id: <20260710211854.1371746-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260710211854.1371746-1-arnd@kernel.org>
References: <20260710211854.1371746-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There are still a handful of ancient mips/armv5/sh boards that use the
gpio_led:gpio member to pass an old-style gpio number, but all modern
users have been converted to gpio descriptors.

While the CONFIG_GPIOLIB_LEGACY option that guards devm_gpio_request_one()
and related helpers is currently turned on in all kernel builds,
the plan is to only enable it on the few platforms that actually
pass gpio numbers in any platform_data.

Split out the legacy portion of the platform_data handling into a custom
helper function that is guarded with in #ifdef block, to allow the
the leds-gpio driver to compile cleanly when CONFIG_GPIOLIB_LEGACY
gets turned off. Once the last user is converted, this function can
be removed.

Link: https://lore.kernel.org/all/e9252384-a55c-4a91-9c61-06e05a0b2ce4@app.fastmail.com/
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v5: no changes
v4: whitespace changes only
v3: simplify gpio_led_get_gpiod
v2: rework a little bit to keep the legacy code path more separate,
    extend changelog description
---
 drivers/leds/leds-gpio.c | 52 +++++++++++++++++++++++++++-------------
 include/linux/leds.h     |  2 ++
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index a3428b22de3a..9cbcf7e40a15 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -9,8 +9,8 @@
 #include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/legacy.h>
 #include <linux/leds.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -212,7 +212,6 @@ static struct gpio_desc *gpio_led_get_gpiod(struct device *dev, int idx,
 					    const struct gpio_led *template)
 {
 	struct gpio_desc *gpiod;
-	int ret;
 
 	/*
 	 * This means the LED does not come from the device tree
@@ -223,16 +222,29 @@ static struct gpio_desc *gpio_led_get_gpiod(struct device *dev, int idx,
 	gpiod = devm_gpiod_get_index_optional(dev, NULL, idx, GPIOD_OUT_LOW);
 	if (IS_ERR(gpiod))
 		return gpiod;
-	if (gpiod) {
-		gpiod_set_consumer_name(gpiod, template->name);
-		return gpiod;
-	}
 
-	/*
-	 * This is the legacy code path for platform code that
-	 * still uses GPIO numbers. Ultimately we would like to get
-	 * rid of this block completely.
-	 */
+	gpiod_set_consumer_name(gpiod, template->name);
+	return gpiod;
+}
+
+#ifdef CONFIG_GPIOLIB_LEGACY
+/*
+ * This is the legacy code path for platform code that still uses
+ * GPIO numbers, mainly MIPS and SuperH board files.
+ * Ultimately we would like to get rid of this block completely.
+ *
+ * ppc44x-warp sets the template->gpiod directly instead of
+ * adding a lookup table or device properties. This is not
+ * much better.
+ */
+static struct gpio_desc *gpio_led_get_legacy_gpiod(struct device *dev, int idx,
+						   const struct gpio_led *template)
+{
+	struct gpio_desc *gpiod;
+	int ret;
+
+	if (template->gpiod)
+		return template->gpiod;
 
 	/* skip leds that aren't available */
 	if (!gpio_is_valid(template->gpio))
@@ -252,6 +264,13 @@ static struct gpio_desc *gpio_led_get_gpiod(struct device *dev, int idx,
 
 	return gpiod;
 }
+#else
+static struct gpio_desc *gpio_led_get_legacy_gpiod(struct device *dev, int idx,
+						   const struct gpio_led *template)
+{
+	return template->gpiod ?: ERR_PTR(-ENOENT);
+}
+#endif
 
 static int gpio_led_probe(struct platform_device *pdev)
 {
@@ -270,14 +289,13 @@ static int gpio_led_probe(struct platform_device *pdev)
 			const struct gpio_led *template = &pdata->leds[i];
 			struct gpio_led_data *led_dat = &priv->leds[i];
 
-			if (template->gpiod)
-				led_dat->gpiod = template->gpiod;
-			else
+			led_dat->gpiod = gpio_led_get_gpiod(dev, i, template);
+			if (!led_dat->gpiod)
 				led_dat->gpiod =
-					gpio_led_get_gpiod(dev, i, template);
+					 gpio_led_get_legacy_gpiod(dev, i, template);
 			if (IS_ERR(led_dat->gpiod)) {
-				dev_info(dev, "Skipping unavailable LED gpio %d (%s)\n",
-					 template->gpio, template->name);
+				dev_info(dev, "Skipping unavailable LED gpio %s\n",
+					 template->name);
 				continue;
 			}
 
diff --git a/include/linux/leds.h b/include/linux/leds.h
index b16b803cc1ac..e646bffcd8e7 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -676,8 +676,10 @@ typedef int (*gpio_blink_set_t)(struct gpio_desc *desc, int state,
 struct gpio_led {
 	const char *name;
 	const char *default_trigger;
+#ifdef CONFIG_GPIOLIB_LEGACY
 	unsigned 	gpio;
 	unsigned	active_low : 1;
+#endif
 	unsigned	retain_state_suspended : 1;
 	unsigned	panic_indicator : 1;
 	unsigned	default_state : 2;
-- 
2.39.5

