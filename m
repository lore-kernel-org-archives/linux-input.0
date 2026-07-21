Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74AD44E025
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627601; cv=none; b=HU4Q2tPm4HV1i8lsMqa4+UjTCpbugQ0BRgOVA4+C4PFOxCnkMWmVl7NaGO/2tJMIc1WBPb9KqqeqVLJhVQ5oUK8JmltQJRljsU1+NlTWOPj5AZeheAzF0ykGFj73g2/XiE0N3j+oPFXlv9zjdIjpUseM3KLZKPYFwCK6j33AqTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627601; c=relaxed/simple;
	bh=m4QdZ7W4WUy39laVncWPNH4CPixifxecxugKJLMj/XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJF0cHRuBWkXQOA57AuuKh2KSQXY7iJVumtcTjnjvAAdneRkSP6VDEjqk6CYe74zb2v1pLUvfNf53hDq7uqQlE7WMnTlyLD9aIkxcymkI2hoc/5LTKL/L2xd+m1MTgBsbs8yEF34Fr+YNXxVqA2BJmxWMz7JkPDtw2sk1i2lmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmLaKaNP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmLaKaNP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso24262375e9.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627596; x=1785232396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gz4Bferib7A51Cp2ESgO9ZvVsMRzMPGju7EyGtmofdI=;
        b=OmLaKaNPcGJIv66owusrPQcP4GGxuj1J83Kf9kWElOHZvlRz465xcehacE5InkpKQN
         EKwhmyWsQ3RjbydvXfqJ/5lhKUEWA7d7lciFvQeyjLKAEJiWPAkuveW2u0P5mhDMeAkT
         G38UtQ18n5Px2yF4kwx36ttmw2qgYw/a/WVH8Wn7ilp2XxCUPexD11zgy32qRTGwmmTy
         h6X0MM3W8kuUIdHJYF/TDa2U6CiDuwAD70xey49NK4t10HJeIPxJZGQmEb2a3uf7AYC0
         m8EOkw2IyvETiS5Uu2wAHL+CgxXQZ5m7L16iQxmb+xme8C22GQcF76ak8tH6bubhNcoI
         lqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627596; x=1785232396;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gz4Bferib7A51Cp2ESgO9ZvVsMRzMPGju7EyGtmofdI=;
        b=siWxjG/Rl4dDB0iX3DJQxScmSEIbDt/Lr8xFVC82pUa+i8AMyVqk6+567Gxa3TdJd3
         KPNzuEPWOxRRSyo41tdrhzEyapTgedIuAMogbtOlwl9InMi2wSTzOaQYQIxKFKpQheUf
         OtG0RrzrgcwDu7/d/xx0rR3+R6t8vIT4SObPXTZO8FvQ/EI+NTWgB97ul2s+xWaaDnC0
         HGRb0/GKTXBQdmOqKQiwEQO6JX5S/HQpg+jDMdjkHSBvegvsCgda0m2BjbUvn8iziSa8
         ijGkf4pkQUbtl5IDtKGBzkljVCQuJV+Za/k4jaV4JLbtuw80CckRVv0cIjdAi6akcrdy
         TXNg==
X-Forwarded-Encrypted: i=1; AHgh+RoDl7+Qt6gdjOrSbVeZNcwWZkqWJhGEc7tQ5TJrgPh6ZpRVg3Vf+IdHQViVDzGI6TF1EWiqA3NoGaGRtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfhCBroR2uT5JScDaYpquAiRRyfF5Pbn19I3gqp6Qah0ecAx4
	Yl07V5hPKs5yrSLgQr5WisKS2Ns4Gdf5xkABWSVwZdeyAN7FI0Hp9SR/
X-Gm-Gg: AfdE7ckrUneGXghkK6qUt5QNR/ejcqMIt4Kduz2ogn6wLVj2p9b3etb6vUbT3rD3h5g
	0yYOq29F1SOygu7iOZ2qhPTIlrQWhNfj5CkSRKXTS3PoXynW9DbYPQdOTB+Odz8pir8E0y+NCg1
	JLLzf7CLSOgm4SF5R0oNULEYJCbgrv0V7A6PWgN1OzT0tUO3XzpHTfwI3CGDJv1n/yd4r0z254D
	D48Ha1rOZExQdP6HYDnJ3c5dUSBagyxKE8TwLHlb3VvyQt5poZs0juCzg98E5mfS2HJj13S7zo2
	hTNuxIx5U/49PYv1agehKM4dnCVeoaivF1aoSw7tff8a2DlciWmhfsZKIiXNcBK7cXvH+7+CQRw
	CNw3/u09Ctbdr0xcDGWrsnRdCepmwgyr74vE/QHAVXrmyhcIeRYaJXd0BNvqsXfejE7rE1Tkdpq
	03u2A1PYUD3pGpKOc8NievfL65ALuDppTTTg==
X-Received: by 2002:a7b:c344:0:b0:494:282:106c with SMTP id 5b1f17b1804b1-4954a3f5295mr148889305e9.16.1784627595967;
        Tue, 21 Jul 2026 02:53:15 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49565482c5asm82834285e9.10.2026.07.21.02.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:53:15 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v10 5/7] leds: Add driver for ASUS Transformer LEDs
Date: Tue, 21 Jul 2026 12:52:31 +0300
Message-ID: <20260721095233.420823-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721095233.420823-1-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

ASUS Transformer tablets have a green and an amber LED on both the Pad
and the Dock. If both LEDs are enabled simultaneously, the emitted light
will be yellow.

Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/leds/Kconfig                    |  11 +++
 drivers/leds/Makefile                   |   1 +
 drivers/leds/leds-asus-transformer-ec.c | 125 ++++++++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 drivers/leds/leds-asus-transformer-ec.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index f4a0a3c8c8705..f637d23400a89 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -120,6 +120,17 @@ config LEDS_OSRAM_AMS_AS3668
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-as3668.
 
+config LEDS_ASUS_TRANSFORMER_EC
+	tristate "LED Support for Asus Transformer charging LED"
+	depends on LEDS_CLASS
+	depends on MFD_ASUS_TRANSFORMER_EC
+	help
+	  This option enables support for charging indicator on
+	  Asus Transformer's Pad and it's Dock.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-asus-transformer-ec.
+
 config LEDS_AW200XX
 	tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 7db3768912ca5..56304ab90eb31 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
 obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
+obj-$(CONFIG_LEDS_ASUS_TRANSFORMER_EC)	+= leds-asus-transformer-ec.o
 obj-$(CONFIG_LEDS_OSRAM_AMS_AS3668)	+= leds-as3668.o
 obj-$(CONFIG_LEDS_AW200XX)		+= leds-aw200xx.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/leds-asus-transformer-ec.c
new file mode 100644
index 0000000000000..4421d629911ed
--- /dev/null
+++ b/drivers/leds/leds-asus-transformer-ec.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+enum {
+	ASUSEC_LED_AMBER,
+	ASUSEC_LED_GREEN,
+	ASUSEC_LED_MAX
+};
+
+struct asus_ec_led_config {
+	const char *name;
+	unsigned int color;
+	u64 ctrl_bit;
+};
+
+struct asus_ec_led {
+	struct asus_ec_leds_data *ddata;
+	struct led_classdev cdev;
+	u64 ctrl_bit;
+};
+
+struct asus_ec_leds_data {
+	const struct asusec_core *ec;
+	struct asus_ec_led leds[ASUSEC_LED_MAX];
+};
+
+static const struct asus_ec_led_config asus_ec_leds[] = {
+	[ASUSEC_LED_AMBER] = {
+		.name = "amber",
+		.color = LED_COLOR_ID_AMBER,
+		.ctrl_bit = ASUSEC_CTL_LED_AMBER,
+	},
+	[ASUSEC_LED_GREEN] = {
+		.name = "green",
+		.color = LED_COLOR_ID_GREEN,
+		.ctrl_bit = ASUSEC_CTL_LED_GREEN,
+	},
+};
+
+static enum led_brightness asus_ec_led_get_brightness(struct led_classdev *cdev)
+{
+	struct asus_ec_led *led = container_of(cdev, struct asus_ec_led, cdev);
+	const struct asusec_core *ec = led->ddata->ec;
+	u64 ctl;
+	int ret;
+
+	ret = asus_dockram_access_ctl(ec->dockram, &ctl, 0, 0);
+	if (ret)
+		return LED_OFF;
+
+	return ctl & led->ctrl_bit ? LED_ON : LED_OFF;
+}
+
+static int asus_ec_led_set_brightness(struct led_classdev *cdev,
+				      enum led_brightness brightness)
+{
+	struct asus_ec_led *led = container_of(cdev, struct asus_ec_led, cdev);
+	const struct asusec_core *ec = led->ddata->ec;
+
+	if (brightness)
+		return asus_dockram_access_ctl(ec->dockram, NULL,
+					       led->ctrl_bit, led->ctrl_bit);
+
+	return asus_dockram_access_ctl(ec->dockram, NULL, led->ctrl_bit, 0);
+}
+
+static int asus_ec_led_probe(struct platform_device *pdev)
+{
+	const struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
+	struct asus_ec_leds_data *ddata;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ddata);
+	ddata->ec = ec;
+
+	for (int i = 0; i < ASUSEC_LED_MAX; i++) {
+		const struct asus_ec_led_config *cfg = &asus_ec_leds[i];
+		struct asus_ec_led *led = &ddata->leds[i];
+
+		led->cdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s::%s",
+						ddata->ec->name, cfg->name);
+		if (!led->cdev.name)
+			return -ENOMEM;
+
+		led->cdev.max_brightness = 1;
+		led->cdev.color = cfg->color;
+		led->cdev.flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
+		led->cdev.brightness_get = asus_ec_led_get_brightness;
+		led->cdev.brightness_set_blocking = asus_ec_led_set_brightness;
+
+		led->ddata = ddata;
+		led->ctrl_bit = cfg->ctrl_bit;
+
+		ret = devm_led_classdev_register(dev, &led->cdev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to register %s LED\n",
+					     cfg->name);
+	}
+
+	return 0;
+}
+
+static struct platform_driver asus_ec_led_driver = {
+	.driver.name = "asus-transformer-ec-led",
+	.probe = asus_ec_led_probe,
+};
+module_platform_driver(asus_ec_led_driver);
+
+MODULE_ALIAS("platform:asus-transformer-ec-led");
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("ASUS Transformer's charging LED driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

