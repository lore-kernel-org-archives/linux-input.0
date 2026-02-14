Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE905310636
	for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092626; cv=none; b=hj6Ycgfh8ZAwYzKkWgut1YA4s8nUmQQ/Ij7wph95mrehv/WDlOyTERnnQ9SUl+awnrXp8ts50ob+74LtGKP4TTnly5RLXN7/4e7/EhSVJEhImyMJ9B/X4whimh4qp7+Y1511rar9kKuZbU1F3hR+jZXohWyHyjHXWr0tDyOsxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092626; c=relaxed/simple;
	bh=iAwN1L5RO+DcRjbiVg9nB/v71sR6G3TJGVFbQvAkWCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cONR911tBiDSfYIbNODB/8DTptHUHzNkcl+Mqwr1iN6RrZV+ik01nCN/KSfbx6D09YzQcIHMOAx+2Br7NovIoR5xJasmJuWgM3KMG4xcZoz1KE3P/bzrw4+Ceb6lav+r/bhBAGCl2Llx0m7w8NJDzERn9GoXZ4t61gCb/D+h4E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRJXHqlf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRJXHqlf"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b883787268fso232317766b.3
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771092622; x=1771697422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KTN5RIw3jy7znvqFB96hO7oLoRvfbkutQBACbQ/WQc=;
        b=TRJXHqlfplbhZjnC3vDDmGIeF6yQmIOqfgvg+PdyEY61U6p1rB9Pi1K3EjzLOk4r+x
         +pPdolxt514Mp0aBh9qEIM7mVWE6sgha534hnSNB5otJ+pMnrrmxdzv7p+1kFS4SfvGx
         RvkPgy6bgc2XSpq0mfjxf2PZJSlvN9UgMddBv5Te8c11oZ4SWwkDjoHE4I4pdUpoXkLW
         R182Gw+1O1sEVtejM//D1yqv/VOYlmSnu5VTWv8Sx9UtekJTXcXctHpOFAFyBpPI2kHb
         c3ka9AFnyjXdcDWyAE78oQELpcjO6aQHMB89BbY7bh3pZKtr5pX4DSvvue6pjKhJbVkm
         0PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771092622; x=1771697422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KTN5RIw3jy7znvqFB96hO7oLoRvfbkutQBACbQ/WQc=;
        b=cTrSZOd2l9xftGH8uqo7ZcFTC3l+mhEcLD0M/JAOz3nLv1Zz/9qQrOipXm2iQjaWpT
         4RQitrRtV2G+WRUhparkWsLu4nm01AGV4/51gRs8we/xvn7a1XQtfuUC4vOeVCIyeejq
         ELfqDKNXJX87a1wkKduQTeSJDkKYpuZT+CNOoPyyf/IvpHxOpYytZJqWEy6Mz1MdbO0v
         XwyNINcwLFbnIgbz3B3ELVa3bG0UJLQ9Eb/q7gwSbPawrEy0vhXo1hI9dbjAFxLMZVT5
         ad2gNnm3w9DwPL1yG2IpeTIArOTuIDhElhO4am6RsK95FUbFYu2wGKgLcCNaJdyRfslz
         LF8w==
X-Forwarded-Encrypted: i=1; AJvYcCU3LS/Y+Xql9Ug8PNBfNFuZO/vrU9CJth0VorZGzsK+dKSRaz/zCqL3iJ4EUJFe6QofGhfbSHRlFMyHFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzul7VCvgSI88PnaAfUXL6BDUXThKZPQ918rStsH7Ebap53JZO
	/sYHGkNvhb+I3RjwxcbS4rfYD5iiuQAJBW3Wm5hUScvBPOS09huJTEYe
X-Gm-Gg: AZuq6aIq3qAEf0c3OUebDeKMVNnHyzKEx8O+fT89EEO3zM/cpvuAtuvdrFwgSHM+pmG
	nKHaEJZFSIDXCuFbrJ+jHl63aYqheXIBkiAOdFL73bBRTpb1RDZgu8uTqOS6s85pKPLraW3Ob22
	7Z0SXGcXTc8pz5mBjVLfkWyxnxCdlApz4JafiVHKsyuLjIRxoqWnXxgkpmn+XmwGGi1k74xbdkj
	1s7hM3WIROaNACoA5FK7GHR6Psos/BZ37ef8PbclcZDxmOidvJK8SJOvpkEd416D2hZPSIKALhj
	Eo+X6BqGUQazi+4OSZx7fNhI/iEaNeM88iBCnSVMkBIxZnDjqkz+zfG2Qu52RX1xExIjlpv0Jti
	0QheLNrIqvZe3xvygNtgiD6wXsD9WaA6n+P04yHNO+6jwftqVgRSZ5KMOaASnnFvGfylEzl0Ut/
	5AhKJk87sLI4o4
X-Received: by 2002:a17:907:268b:b0:b88:775c:bd68 with SMTP id a640c23a62f3a-b8fc3b6e571mr169330166b.28.1771092622173;
        Sat, 14 Feb 2026 10:10:22 -0800 (PST)
Received: from xeon ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc735e506sm88122066b.11.2026.02.14.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:10:21 -0800 (PST)
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
Subject: [PATCH v3 5/7] leds: Add driver for ASUS Transformer LEDs
Date: Sat, 14 Feb 2026 20:09:57 +0200
Message-ID: <20260214180959.30714-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214180959.30714-1-clamor95@gmail.com>
References: <20260214180959.30714-1-clamor95@gmail.com>
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

