Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD736F420
	for <linux-input@vger.kernel.org>; Sat,  2 May 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725686; cv=none; b=sX30tPL9D9wlV9I5CkxhYd60x0AXSeTqV7bV788TJh2BujOVCOwvmUE2RfE98mXS4hTA0NJkra9DH+uzYvUXqak0DJ+/lIrd0wLMZjKVMCD1FBlIfu4L5eEGlLz0M09lnNrPO5jf8oZ8wwVxpkbO3hAbAuAl6ClguJkjIRdb/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725686; c=relaxed/simple;
	bh=ee4Z8BXlgFycQt2dRA5KJB/GvQDzeoiKpo9CXTIodS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnXzmgjKIMMPvN7//g9tvoRp8mfuBRYB+O868minsn4srGctRUNUF9nmGH3rEu4Dz+KcBXvBo1B+8PN2oEGTmTwT6MgGL8Y/Lwney3DSNLflDCGpLM8s4Aw5cBTeiZ0t6xNxESiFc8zLeZa0N6LJk+h/WawRmx53RzZh5Vu+VEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltpIHXlt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltpIHXlt"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67c3cb1433cso183389a12.0
        for <linux-input@vger.kernel.org>; Sat, 02 May 2026 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777725682; x=1778330482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQpI9S4zHlj4VcZDUQwUF17T7cur1QEg2Dks5jP/SGE=;
        b=ltpIHXltkaSi3mYkeGidvCtxhXXjuehCfbVIdTGivPV4m2wEk2y7wY1IUh+m/BA356
         cdwdR7Ny3CtasQtOLckm14RyzJ7v8UYsjz2pngVnXFc/kIwLNBe8k2PcEoBqfBozrzRB
         lqBZVYLPS8RyzGmEQnKFt2EKtFQ4685FRZ0k9VWG81y5X0BA9sIE1+fxoGSAgKTU5tqa
         rVToxKc7K/Kcn4JSSm8zncXWpnhkjCL5AiJ3G7htyWwebbYSH2t/Pw2NF0doSddDSGVO
         ISQOb+NgoMPL36MtdRKhke5zPVfxoaRzLlT9aPFp/Ug6vxCPqRKWh4uVFISsYYl1rXl7
         /Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777725682; x=1778330482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iQpI9S4zHlj4VcZDUQwUF17T7cur1QEg2Dks5jP/SGE=;
        b=Kf1hts1DZkv771eOHsoAvwSYiWQQBVNxFaSizPNdZfp5dBJbkrL7ZNpZ8Y4TjncGWK
         DYAWy6eJZLnNHuvcqW78T9KxWLo+tb/GCa0wQPIhY6uxhxbLbvXONgo6HYnqgQltv6vA
         R/xv7xDA7Vu3Z9l6F20UYInWqolo3/duFSSqglHGEz51sRZdgxZEL6jDwIjbR9yIZyxy
         l1QCz4dr7TVXFPuxI1MiAH7zNzma+fTOzKSiuS8750GHaq5nJzt0cQzNELyJp106b3fK
         CZXxbeT3NzsFmAgGqBmXuAEF7hKwA22PCIfrEnHolYKUHdf6JSx/0kojFP8Ekbx6BQYP
         e+4g==
X-Forwarded-Encrypted: i=1; AFNElJ8LdobUE5ckWbm2ffAR9DLuF+ddVQPmALlZVjqD9dqgrPvtnQ+9k627dKQZg61dwVhY2uhOXNZw6DVecA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+2zNMcIG6oCXStMlhBbfqRwTJcCwfP4sX8lupppEPRIJBQaY
	5pv65JebFRa97NbZod9sqtTiLW2MSVVxWurwDs54K0abdGLbOIUf7Jtu
X-Gm-Gg: AeBDietoPQvn98CsKjymSCtVYCzyDc4i/nebmUMInbyCXfQRlEQXdKX/KUxhpVQHyBi
	KLews6u3nio1/j4SCxgFE02C460zZ/ZHiLEGYUQrQ+q8UA5jdByvE/4K9vtD4cIiPwb0E+f4Yth
	tOuKOJOE3jHvKE7ugNIQZF7C/RV2DfkWx6PSpiSr94/pA5lvG7CSkSreO7a3Mg9BJ10HS+M1CVO
	wdXZhhFM8LHQrBzS1OWq0YbgiHm3iQx40HaOdtYB4uLOLZaJ2fSRRafKH2nNCw591pBpqehOAfr
	/08kez0ezQE7UhQli4Ywp0RHnAIz4LmeKm2VdrgXh18EweXjD/44E06UqwUOuFLL2qOJicMIm29
	o6I6I5KZc2Z9pvMO6PDCB8vgh9RE8zyjacJ+NS0s4BAMJeE4Tgkj9RkJPST4JRCFsoMtyLAf7cK
	zFGXit/hhe26iJXRtv7HxGBtY=
X-Received: by 2002:a17:906:7956:b0:ba9:d5c9:fdfd with SMTP id a640c23a62f3a-bbffcd82dacmr145705566b.31.1777725682097;
        Sat, 02 May 2026 05:41:22 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e281cdsm1649649a12.3.2026.05.02.05.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 05:41:21 -0700 (PDT)
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
Subject: [PATCH v6 5/7] leds: Add driver for ASUS Transformer LEDs
Date: Sat,  2 May 2026 15:40:53 +0300
Message-ID: <20260502124055.22475-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260502124055.22475-1-clamor95@gmail.com>
References: <20260502124055.22475-1-clamor95@gmail.com>
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
 drivers/leds/Kconfig                    | 11 ++++
 drivers/leds/Makefile                   |  1 +
 drivers/leds/leds-asus-transformer-ec.c | 79 +++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
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
index 000000000000..3186038e3be7
--- /dev/null
+++ b/drivers/leds/leds-asus-transformer-ec.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+static void asus_ec_led_set_brightness_amber(struct led_classdev *led,
+					     enum led_brightness brightness)
+{
+	const struct asusec_info *ec = dev_get_drvdata(led->dev->parent);
+
+	if (brightness)
+		asus_ec_set_ctl_bits(ec, ASUSEC_CTL_LED_AMBER);
+	else
+		asus_ec_clear_ctl_bits(ec, ASUSEC_CTL_LED_AMBER);
+}
+
+static void asus_ec_led_set_brightness_green(struct led_classdev *led,
+					     enum led_brightness brightness)
+{
+	const struct asusec_info *ec = dev_get_drvdata(led->dev->parent);
+
+	if (brightness)
+		asus_ec_set_ctl_bits(ec, ASUSEC_CTL_LED_GREEN);
+	else
+		asus_ec_clear_ctl_bits(ec, ASUSEC_CTL_LED_GREEN);
+}
+
+static int asus_ec_led_probe(struct platform_device *pdev)
+{
+	struct asusec_info *ec = cell_to_ec(pdev);
+	struct device *dev = &pdev->dev;
+	struct led_classdev *amber_led, *green_led;
+	int ret;
+
+	platform_set_drvdata(pdev, ec);
+
+	amber_led = devm_kzalloc(dev, sizeof(*amber_led), GFP_KERNEL);
+	if (!amber_led)
+		return -ENOMEM;
+
+	amber_led->name = devm_kasprintf(dev, GFP_KERNEL, "%s::amber", ec->name);
+	amber_led->max_brightness = 1;
+	amber_led->flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
+	amber_led->brightness_set = asus_ec_led_set_brightness_amber;
+
+	ret = devm_led_classdev_register(dev, amber_led);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register amber LED\n");
+
+	green_led = devm_kzalloc(dev, sizeof(*green_led), GFP_KERNEL);
+	if (!green_led)
+		return -ENOMEM;
+
+	green_led->name = devm_kasprintf(dev, GFP_KERNEL, "%s::green", ec->name);
+	green_led->max_brightness = 1;
+	green_led->flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
+	green_led->brightness_set = asus_ec_led_set_brightness_green;
+
+	ret = devm_led_classdev_register(dev, green_led);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register green LED\n");
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

