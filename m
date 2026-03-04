Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E973DBD74
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 18:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650693; cv=none; b=Y3vgFclvUYlExZNIs/hMChEhUk7TnD2Fz+ifgEsbSVV/NLEzHQr9GVPEBD5XlDcLR2mvcTiuF1N1yM01bNHLu/PvCqk6uv0KEtPePX8oI5vo02DzbZ0Grv4H/qf1r/GFtMmL2SR5JLHUfzozfYIl1GCCIwjTI0CXJBB6JLbgX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650693; c=relaxed/simple;
	bh=iAwN1L5RO+DcRjbiVg9nB/v71sR6G3TJGVFbQvAkWCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIw+AEkurcse0WmLBf2FKLqjPtp5DAfBOCciCQO2shrdoDlNXx/wdCEhZDht4Q3k+paZ8GW1sg5a2NHeKng+lXlbnjowTb/wgu6fZV0GaVbkV010t84JGSgddWd422XJzrNh6fhGgB+W2m9sL1Z0c9SiVm6x+pIPK1NbQ7AG40s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wo6JTunx; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo6JTunx"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a23cf08e0so33333291fa.3
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2026 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772650688; x=1773255488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KTN5RIw3jy7znvqFB96hO7oLoRvfbkutQBACbQ/WQc=;
        b=Wo6JTunxe4SklQRnE8CMfK4Txy8k7pXW7nr8TyTFoRB+VERRiwA9k2ts7l1C3GI1BF
         LKAhGQtzrrKfF86HyWFsVN0jKO+xEwrexA1J9oqOomUVpoTNl0Bu+5j1mt6SwdSXDLGN
         4EkO186J2TUcC8KgbZLkxjrSI6/l4KSrVSUl+f3Db45T4lIRCWrTojjmRBC6wkv0CI7q
         gdcrqtpKUbmEg2hiGz7bqboyiw+nVTu2PitlwHMhnSZaJxIzztnGr+UvNui4qVlyEOPc
         PnX9CKP8LrOSqCksrEGmqgpEz3yXydSHz8P8TBAuDnHbhw9wur8iwpyeGHOjTJfcnWkk
         uPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772650688; x=1773255488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KTN5RIw3jy7znvqFB96hO7oLoRvfbkutQBACbQ/WQc=;
        b=lXyYPqaphmIdS+rD4m+Tet196GYjC6v5ueWca1HWZxsLSTOZAlc3eCWZPfi8aM31zt
         /O/w09xAb2Jvi9TtRu2yw1ccEL0EGwjK0xA3wnRm0tGmvFyoNoGx7D+ecBf7D5833oHf
         fMksZG9Xdo09OdeHuzqGTiJRklJ+s196IhBVhSt480oBZ4DVQ+4W0oTl2l77/Vjoocoq
         MPXjtKPpk1RoZtAdM6OFmRgKDN1JV1Obkl74QxN+Aa0KqJPFFSxnTl/LC0ZQsUPRqDuI
         D/HOPA0MmEIzALSBs9MJALhtU7Il9tJd6zs97eEYFaOmM2Pyg1pNwPb73dT8c6UYmX1k
         WHJA==
X-Forwarded-Encrypted: i=1; AJvYcCXCbELT18fm36risv/dPPOzcAnv0zgHJD44ESIwI/OaI5kME3bsmC9KU+7tUXJoYovM3s7yl9a7UYAe8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YynrseO7lQrfGyQhBkAaaBh/zgWE+ge12PhEKtiU3Z3HQMNxa1S
	wUk8Hoqquy30XH3sOUzYbIsxDaNsqGAPM/lHaBudTdyIZ7K/vM1deVbR
X-Gm-Gg: ATEYQzy0UIkstTRyU9CSYCsSAw6VMk+FCn/yhwC1ATQAehFIpkTrbsZPl+i3tTpPM9f
	aXlzhjgg21yDN8vUP5K6H/+Ol55INdfXz9r1p7vnaNAH8QdO3y9V9ONsSA7xnLHhoC1mdcGKmuQ
	wfQ8IzzpWU/Le7oxXAJ7AnvSq3AaRTFxJ8znd8KvNbGZeGDeJKgAh8TyWdXr1CDLqpUHB0GibTO
	n4pQ6XkD0LpF91BPE6eCkw63H/fWq9SxfLszfESHWOctTht9eYTMumXRH8S6pwqUua4X8r7QYdA
	/oMlnk1/7qYp/I1cHgiUEip+fUgmlyiiPXNK27kUumpch3fpoxcdUsUJdIh3RSih7mNCwGd8k8R
	avDzYkyUtAUdeLHMBgwDycXPZIURdd3brWfuCUCBEm6kwMm5/jtXMletYGnlwS5rZ4ibV6D2OSp
	dRQXoBXpx8x3HS
X-Received: by 2002:a05:651c:987:b0:385:bab3:5ba7 with SMTP id 38308e7fff4ca-38a2c6af560mr21897461fa.19.1772650688249;
        Wed, 04 Mar 2026 10:58:08 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12a6ddd3bsm704985e87.0.2026.03.04.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:58:07 -0800 (PST)
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
Subject: [PATCH v5 5/7] leds: Add driver for ASUS Transformer LEDs
Date: Wed,  4 Mar 2026 20:57:49 +0200
Message-ID: <20260304185751.83494-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304185751.83494-1-clamor95@gmail.com>
References: <20260304185751.83494-1-clamor95@gmail.com>
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
index 597d7a79c988..bda06dc145d7 100644
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

