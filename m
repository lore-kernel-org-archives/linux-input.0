Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5A3E6390
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098387; cv=none; b=bIedrDWtzd8qfCldkOvBO5ZyGkfHSc3L+RIplHnS1HdFwy/7gbHgnvpOYvIhzNukThA0J9/3y/s5pIJlTDMpwJ2GBafGvmTb7lMwDB3+CqczzxHH351UIPal06v43d6PiUmxRCeZmTsHOU1t4TfvhhsSenMA/D2wX/K84KJUeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098387; c=relaxed/simple;
	bh=zvx+CuDoLeWpL0b5P4WwzKHtlNaXBwisPyjicIkXSEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9Jo8U29YWuuHn8Qe2JNEe33mWsw2gREs4IIn5ag7S0DLsXFgbNm3+TdqPRFB+yrFjR5SEebmG4f1wfBI5eZeNa1RJDBjnjvI8LGrStqY+WQ7pobIvVs1rzKaghWGvlYjIhMaeYvjFGS/+HfFRiTgewo/1xPsqVQ+HK9ZbegqSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHnxFFry; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHnxFFry"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7645adbdso1287177f8f.1
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779098382; x=1779703182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkCBzfrCaF4CFrjZbQExKxSzPK+kr7Eu/t0azEdrSmI=;
        b=VHnxFFry1VpPACek6OjTru43UqgfioVeC34vP2xgWLSYRIfndKc0+Urb4Ul08uFpYz
         8YCIzWGW8yJ3GO677v86OiM93fJeT9XFh9nG5Ssi2wNZDi4JUQzaJcRQ7H9EYTY7vICD
         1KGAo5+nvDWdmhn/+9WpdPwiUP8ACbZvPz3kwfctULFSyXVwbqkunwEUrHJJDe78odpt
         VFpqAqSjGg2uam4KcoxBknwKBZ7nMolNG+T9ox3nS20Qv8lESZ8ewYeQwlXM0aJ4ljYr
         /m7k168b2vocH7TU26EoOg7rtOAwZd9GnLRTHS2KdCUUZwucjdCFfm5JYqEd8knIVLKI
         C+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098382; x=1779703182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YkCBzfrCaF4CFrjZbQExKxSzPK+kr7Eu/t0azEdrSmI=;
        b=iNF0HOZw+POp96UAVbkXe52szlHlu3uSVJ7GV/6kH/sb13mf0ZNAmAGqT1ldQffmUW
         BAMSSVXlUQKRFpJEku1T8aLeQeNRzzWpMW9WBr1eF+p6l0FanZ6u5hLibnA8/8IQcq94
         hw3qL3cJsIqN7p1VC6HPTUYcAVYCz6Iic/pZrCtiLZbk4ZgOvhDGOsB+xoIFpJfXSmiO
         8I1cIYQrZ+j911Ex/yrj01vtVpLhYTm4H5dIDk09Hz5mZzlxA1M7r0xWa9CwleXMrVIf
         4YMJ4Zh3hzSCMttqS2PcA2C79OyEABK0Q/mi1uDa2oklgA2+Kbc+VjJCOabGB4WYmZWn
         CO7g==
X-Forwarded-Encrypted: i=1; AFNElJ9KM6MH8LtF5cGWhtZCFyRHkUaKlrpegK9x/I0Ad1wnV7+sHejOiwiCIITKvCLm+9agCvtCrTf4Df3RBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDjSR8f5M8gbYYAdrao1guM71LCFOjE1FHosYWYyd7XoNs7mA7
	2nlEdPgLfZABYgIq28DeORSWFDTmLhinqC02wXSA1NO+FF36RQK7lLz7r1mHLA==
X-Gm-Gg: Acq92OH3STQvaD+/K6hN6QCuajiCgSYemxt457204QbwHQy8MXhQexhmSzAIcTI6jjh
	ZmeATQR9rAc2ioHY7jqJ10raVMMSEn6tfA1vMRifid+0J4g0bW//+PKFoIWrlvaGvDSw/yAuQSR
	uDYQVDIR7LggDhejOyFmEBJ3v01wPu4W04wRjiISiWUNMQfhd8yjvfZfx6n9ArTP1Gw0JCP1zKk
	rzH1Qw/lXawYW4gckFm7rQYYtVmcFm9x9qaiFEYoA2TTvl17WJfLzuvZcvvpoMtIHHG/3aGwjs3
	SWwG/y/5GQhvtzbHjLcB9S4BmZemOkiV8720voEQTbT+q6L0DCgnhubYPBlr0gkOqymFgJ7wINp
	ac6D0SGcqa3Csp73kB9e3cfCFHUR6q+45FjZs0OKSAnmW/6TX1h1pXE6W6RPbOpqGkxkBz6Awey
	vlRtRNnoFypFsTfoDhNp/3t+g=
X-Received: by 2002:a05:600c:35c6:b0:48f:dfe3:dae4 with SMTP id 5b1f17b1804b1-48fe60e9f8cmr245155755e9.13.1779098381640;
        Mon, 18 May 2026 02:59:41 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm102995005e9.7.2026.05.18.02.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:59:41 -0700 (PDT)
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
Subject: [PATCH v7 5/7] leds: Add driver for ASUS Transformer LEDs
Date: Mon, 18 May 2026 12:59:05 +0300
Message-ID: <20260518095907.36158-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260518095907.36158-1-clamor95@gmail.com>
References: <20260518095907.36158-1-clamor95@gmail.com>
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
 drivers/leds/leds-asus-transformer-ec.c | 109 ++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
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
index 000000000000..c9bdc46c02e1
--- /dev/null
+++ b/drivers/leds/leds-asus-transformer-ec.c
@@ -0,0 +1,109 @@
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
+	unsigned long long ctrl_bit;
+};
+
+struct asus_ec_led {
+	struct asus_ec_leds_data *ddata;
+	struct led_classdev cdev;
+	unsigned long long ctrl_bit;
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
+	int i, ret;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ddata);
+	ddata->ec = ec;
+
+	for (i = 0; i < ASUSEC_LED_MAX; i++) {
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
+		led->cdev.brightness_set_blocking = asus_ec_led_set_brightness;
+
+		led->ddata = ddata;
+		led->ctrl_bit = cfg->ctrl_bit;
+
+		ret = devm_led_classdev_register(dev, &led->cdev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to register %s LED\n",
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
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("ASUS Transformer's charging LED driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0

