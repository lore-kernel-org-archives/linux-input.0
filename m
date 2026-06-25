Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F644332EBD
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375371; cv=none; b=mKly15PTOHw1Ux3r204U8nCXMugY7TbQ+v+o7Z9UnIYojS5k5nF1FEVdgwgKlhOJtyXTXbvMfu+oV0rdvFZsUbwvlGWmOijAKYInX0XBj6RdThaVMNaBd2HodmTKy5hnSHk8WJcy/gr6yCSyoqEvQyXl2oKPylUIFIJIcx3bxRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375371; c=relaxed/simple;
	bh=9oDA10mVcGDGv+sL10nK0ogYvKF0k4VHZamZ70v0O3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueYY6hfPjJ89+pPRYhtWZqD+wZpNluMIy9XU/Nhuv7GRhhJSfysGgqdOpZyBvx6fXUAubKTEtsNJtYcUY/chtsGwl6/5B0q2X8Wr6wU7pSpcKS+fNIhmBpW3eYpVyaDpitH36jcRjXgq0mIvgZttfjOxy0OdmrywERd5yKIpizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bu0QUJlF; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bu0QUJlF"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39ad400e72dso414101fa.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375368; x=1782980168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqCosCRy6LaIx8tyejecFxD0SP4hYQhYZ46XfJ3cNnA=;
        b=bu0QUJlFFE453FbrEBEdk8yFbgSihe5hRyAVayBXdKBddSPFd9b2iZiPjJZWvuke6g
         b5J820eaBRw/Me8TaVWkA+qDKP3gg2iy2aJDqLnAOQ9swxFxesL/MUi8ZX+CAfA3BU42
         XbyYzuwQhYUj4rsOClU/JG+yhmuIq5MdljxNA1VdNPy0/ZSDEhsgBg2vKzidSgCZ20R9
         44BAE42Vvf4SuTUPsZgpOGn+FLITLEXWK7ukA9LabuXIqKBG0g7hzTA1eXJ9rhmPcB7A
         sM7NYZI8gue7Qt5z499I5JyKoNjuDHcGhlUvQPvJbFq43gVwHwnermJYLVLLjFPweg2Z
         ngiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375368; x=1782980168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bqCosCRy6LaIx8tyejecFxD0SP4hYQhYZ46XfJ3cNnA=;
        b=BiDuvlh/W2cX1gvXOVIOpZy5Toeju+BdXeMkZQcqoETVr12RMDG+iyiW6jiIpxWN3S
         83Wo0YcaJ+F9K+k+AcqkI+l0K5s+saZELFBlxZfySwa/1JosL78qX4OGmEwy+yjBfOrw
         7Ab6bGpEDQqzEAPlF01i3oYs3UOxuB48b6Zl8ltyiRbWbRdGYZcZ1LTCgXRUD9W6QI8u
         wqY3gDQ8AH99iupPOA4DC9d5aPmXxOMTOJOeGXizpmSYnRi0IhXiNUOZXVbzNEH0IJyt
         pFqdSgDGBPVufXB/H1O+IkyeJUfUpiGtSFGEGz+DyE5tUmZNMJ3aZZYM9hzzNPRN4qQL
         ZWwA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6PZD6VTsO6CwfyKbYHHUfSRawzKtAaY/ZKmlmT/M4MfK1bOOAW5nKZo87GGhSVq7YTAGPZ67FVbqrbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztIoTj+sk9QTD7uaowmBiHfXkEerzDzfyb0zp5sT/CKB7Ck6Zy
	i5JQYnx+QdogzKoNJIOhRYBEWxupIQ0t1iS6kF5w/6eNJbLS+YV6zhZR
X-Gm-Gg: AfdE7clAPWiaGmuhmEqyUkV4t2z+H3YJEKCfGNwkSIDUHOQwCEXuxZKh9L3CtTqjA5+
	l+O3X33/7D4tIJ4f6jRwELFRzjeviz9mNJqL2g3kvheFIKd46TPqWEeL96/srn73BC8FQ4+j5bI
	rrtuzoFs7XehlwMmAresPnuompKGnujo/VI9sq1Gfpz7KGs1F4UONwRvqJwmH49RujWUjp77tMN
	8TYAjjN07ao+xaF0Se+QuRN5po8YyQkFZ0FlUxnQAOTEJscvxDMHbmkDx7XpU2Z6k4izBfH/P4a
	CRticCeqt24ftSJqZituJi7d4gYz2htHOZ7mB8furyO6FujatRWzO1CbpZ0pkbdUWI31OL0yWfu
	r6Q0fXx3LQOhQdZzG2sN1b9aCnCOCpJ1efjBvE68PChRAMRTr7Gw/3n3L9U4dawOugi+6Aeg8jz
	VbT+VXnN1Vm8ZCsSftCjQPRWEgXX02ZxtRaw==
X-Received: by 2002:a2e:b8d3:0:b0:396:8ac1:53a7 with SMTP id 38308e7fff4ca-39acb57d49emr3541901fa.8.1782375367208;
        Thu, 25 Jun 2026 01:16:07 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999afce64dsm39162221fa.14.2026.06.25.01.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:16:06 -0700 (PDT)
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
Subject: [PATCH v9 5/7] leds: Add driver for ASUS Transformer LEDs
Date: Thu, 25 Jun 2026 11:15:27 +0300
Message-ID: <20260625081529.22447-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625081529.22447-1-clamor95@gmail.com>
References: <20260625081529.22447-1-clamor95@gmail.com>
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
index f4a0a3c8c870..f637d23400a8 100644
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
index 8fdb45d5b439..d5395c3f1124 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
 obj-$(CONFIG_LEDS_AS3668)		+= leds-as3668.o
+obj-$(CONFIG_LEDS_ASUS_TRANSFORMER_EC)	+= leds-asus-transformer-ec.o
 obj-$(CONFIG_LEDS_AW200XX)		+= leds-aw200xx.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/leds-asus-transformer-ec.c
new file mode 100644
index 000000000000..4421d629911e
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

