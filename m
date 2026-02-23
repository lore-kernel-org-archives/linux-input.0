Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6B034A3A2
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828297; cv=none; b=UJ/oZV7OWSZQO/zKrTtKIm6PrPkKaFnKnbT8ThLTOzIRxzC7RB/NdS6NdMoZ3+XwUR78PembQ8iJRtfksrGSxnoduDmlc7IOkbKtCSerPYhUVgWuSu3xPx+BS0+5Z+5/cG9dy92ZPodGtKLF5nYPEbDQI44X2NedCkXhR3KI1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828297; c=relaxed/simple;
	bh=iAwN1L5RO+DcRjbiVg9nB/v71sR6G3TJGVFbQvAkWCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXdnvQ/yWGXWj/knu6KvhxmUTaTqfZ5mBYi3J+3lmJOqSbzwlTwxuA5cC4xSCmlDMJFua+J+18EmkKPdSx5hhl88VqJDFR7CXlggFiRW0GjEWyL8eUhmXgGJSXH0DXTSNF/K3/qEAdNnQDWHza5AfoxYFrZuQs8nvrr0GT9Ceeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHLdB5iO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHLdB5iO"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-386714da2a2so31652591fa.1
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 22:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828294; x=1772433094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KTN5RIw3jy7znvqFB96hO7oLoRvfbkutQBACbQ/WQc=;
        b=dHLdB5iOYn+tAOTMbzwAvnbcf4NjQJClGPtt3yXGfcGYV47wZu0Sf7ItGBmuqpoAru
         ujdjsBDHRzSVEwFpW7XSjp2PobIc03ZRHkTOGkdzZBY4pGxFMZVlQBIRJnVOfqya7akB
         hhX2CuSr/223ofS8fgMqi8rDAEPgNFMs+KKcIZU/jEChYDsDfEG3KMSFmoaF8vkIeYZG
         U5j+T1gsC+dSPzScqU/vwgjoDMgvl/InHFZOkD4JEjDnK1oxNrWuj8c1oGfIzDs4vZ7E
         kYjdqedu+bxRejC2MObDsLUDS1WHpMbkbz0FDkLAw5h3R74OVHGxb7p1GJjfAYET4hol
         EDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828294; x=1772433094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KTN5RIw3jy7znvqFB96hO7oLoRvfbkutQBACbQ/WQc=;
        b=lvMON+6kvAS5xhpB4l2rwN4EJLDMT/3H/+SmtM/Wc7xVgSaCqx26xL8yakHuhoka48
         xGB6TU7tUhuSyYjnAtfXJfIzrcIq/+n7pAFILV/RAPnR0Slh3g3vGtrstSyxFosJiA1B
         AkXAUBTq+9wOph1LpqoHvC3u9l7qVg+DtWcm0OGTeaKoWBOC03IowqFEsFT12PBuPTon
         YRkNYOYTupZ/zHrK0HftNMMMSaUb0LA1Y+zEyDpqTM8hdnVO/2rtF25rDVkuimNRbQZp
         4zaefAeodUkDDjQhIcaGeSGwrPCEOAiBWsAuMQvzBO8dWZYYTtahNVquHLTDGEMgQDuJ
         PKVA==
X-Forwarded-Encrypted: i=1; AJvYcCVDWmnKogKfJmJ8/RIBoXHb0F8wC1pj/bC+HHZihtd2e/SnUpnwoSxSSx6cosTUpmrKFtxSoNka1Ib/qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWX8baLCimTLKq1vbgqh/UH4uJAXqCwberQaXyFwmo8W69C1M8
	rNIuCTL+/i92MC2WNLRNoExPGQMtw0W98wvQsBIKiswiMAwIndTd4jtN
X-Gm-Gg: AZuq6aIXoKVjSnhe/VPqgpZt7MRqT5+5AQa1di8onAdXSCUnMv4avtd107Na6KtuhzM
	pxoJpfe3U6xfveufUtiAwwWPG+4KSOYEmO8IyQ9bCTS/2EYvFLp6tFYL/ioBqmp2JMxzMnLQ1E7
	snMNJYD1zL6d1h8k+JppB6o38xzDwtJXAFCFS9TDx/sLaHrn3IO171ph1WfmQx6WhrN1NezJ2VO
	UKVSvLvp0+uqvh1V9r1Y/bCfYnlQ8xrayLe1zigxe7zpRQgDt+vFnRyB8rmdgOMiQduf9fWU0IA
	K0OXcnskG38ujqPREaIc7bxucRpX73oDzbp6tWCqe8qL9jqnt8IdudNZ9ekYMO2swddXCnYIywC
	t0IOdAVNd9AnY9LFwwI9OJzIme9Q3eUEC+vpnWHD+raJcq4LntxpPn+t64LQz9ALMfO6hax1Scd
	MTsdL57V3aHkRZ
X-Received: by 2002:a05:6512:39c5:b0:59e:462a:f892 with SMTP id 2adb3069b0e04-5a0ed87a0a4mr1997446e87.2.1771828293539;
        Sun, 22 Feb 2026 22:31:33 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb14596sm1361320e87.26.2026.02.22.22.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:31:32 -0800 (PST)
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
Subject: [PATCH v4 5/7] leds: Add driver for ASUS Transformer LEDs
Date: Mon, 23 Feb 2026 08:30:57 +0200
Message-ID: <20260223063059.11322-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223063059.11322-1-clamor95@gmail.com>
References: <20260223063059.11322-1-clamor95@gmail.com>
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

