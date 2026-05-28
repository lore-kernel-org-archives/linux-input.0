Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9AA3246EB
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 05:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946361; cv=none; b=ZFn8deo9KEKjbNKpjnknFoDCUjMsTo5bHQumJnDwu4v7MxX5s1tLxB7zmjsGQa7Uk8OKJPnTFnbVTqNMsdufz5D4YEf56v7qQ/DafrKxqsXoa7QANL6Sr5Ze8ENvIoFZgOlAdXaLCw8zLv3PY/jWX6VMBpzvqBei/bvdHWySeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946361; c=relaxed/simple;
	bh=N5Bs7jrwAWana/GHhO8hVdgu7yjQxJ+wg3hxQlL/s2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ct0diJ0BEbWJdKDff5Rqz1saD/9Mw+UZ6jW+iZVvuRn4hcbDqpNG+syWTFStNCGVHZ4oZvjeH1tx1BLN5esW4DDR/EYotGJB2R6XqCzKyKT32hLBb+i/QkISsS1fM7GnNQw4hWDT/54PHA4SCS5qXnj8hhDJPIA/sVLkVojUcrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/XYnQ30; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/XYnQ30"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd11a3729e8so1925770466b.0
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 22:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779946357; x=1780551157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMAGW8nfdxjsjGAkIOyueBisELm9uNOe9lSbirQK6Uo=;
        b=p/XYnQ30t8cvETQscMSjPNzWUPNxTBZEfFsXm+pU9eomeQFolL+dmcGB2v7RFcrKvw
         DOqPKyzC0CBZt9iuNnGQsqg0CA5JnrcM/pDYplOdxzCEK0nsaCiBy2/x9p/fLH/MS7kV
         naltG+62DSf4JCNILrprTQpPT9wGmCXvpJAAdkcSA3Af17XF0NWkA2XBamgKpMP9Ybe1
         c/IcajJ9TbbCA4jcsJ9qE2TO2cV4nqdN230RXBtBnwVrr3OTpB4LtHFpzmIg2o9u0RY3
         AE9hl0B7x46PCJOCp9yjmdl5PEN2yhiSYwLxgFQ2FjqNyzbMspc2MYtrXnnvu0Afo+Gh
         Y9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946357; x=1780551157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EMAGW8nfdxjsjGAkIOyueBisELm9uNOe9lSbirQK6Uo=;
        b=H7JJnJ3ARQgxtoCYQNmM94RbPZ5cvOVDi5acbB9DYtbIA54zNNs44BrHrbWr+mF/vH
         ijjMbMVN7sI6UB/mBSdh4iJdR3pNl7sD1fvqtzZo9YF2LEzvmFdbwdAGyS1xYtLNatHe
         yU2nbxDb/nFU1stfrFpsmAgOWePQTSqgfxXqmTj81Frl+qZRGcJ18cRpp8qO84MnCrjO
         l//cOf0d9ceItacMk9+yx1VRhhr95PzBGr9yfRgHd+NVI4NxSkK+5UJkb5nezm9clanl
         fxFkYVFUtiFxuKOWvIWj4KfHhqQ4KdcYfmrscRace+DuY99A9a6C8DqdStPjPv5EC05d
         LrUg==
X-Forwarded-Encrypted: i=1; AFNElJ8QqUCTLZ72gHC5BVoKMdSClzH4TgU0y3vH1s29ALusJ/8levnDtijU/6LeY4GvGVBkDoxLub5RfF90KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc7KuSNs1yS5rCZep6UNHE+mYI5tcZ7o4eHXHh6CG9x+RRrSWF
	JcTCQtRxSg5mdKBU/zJc3dNV0eNc5ETTpHgR031n73AG0FyRqrmL/YeM
X-Gm-Gg: Acq92OHqu9WuvKS9OGLz62i1hKDiSetZPvExcbiFY2Mw0zWghh3pg5a6wer4Xgi/Nnh
	IjKVBtjbifl0GL+4DgZ3Ih+SHl3OOeCIDe23TT+P02n7OLIAT3JafCeGLoSIFstGgSFKWsBrjg5
	7jIsCnjaF+srcuccP1thw+65BDPNGCEuZmtpuVKN8HyMtV8wlBkxwxXsdDfP/5XbNXY6mVQ2cpo
	M+sr+Wt8lGG94vnDrHOsTt493KbkD6wnmDqoANW2/XN7k0xhTykmqyhUablIhbSqd98v7/bd8o5
	KaFWs1H4Pl7nKIPFQrS/xMspec414ejmFGNFMrwcISIb0nxK2N3CgbtHLTnsv7kKPy25G3AyQMy
	AMBRY21NmtMb+lh7XjHE3rucXi6vREpN699w4vfgg7Ctye+S45yYxFGIHBcTkL8IvTVYily/Vuv
	WLs1CPM3Qyf+4u5A6Io5sVkN/PCwjrX7UzQQ==
X-Received: by 2002:a17:907:60cb:b0:bda:e47:70c6 with SMTP id a640c23a62f3a-bdd22944feamr1637047666b.1.1779946357072;
        Wed, 27 May 2026 22:32:37 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5eca616sm693427966b.30.2026.05.27.22.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:32:36 -0700 (PDT)
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
Subject: [PATCH v8 5/7] leds: Add driver for ASUS Transformer LEDs
Date: Thu, 28 May 2026 08:32:01 +0300
Message-ID: <20260528053203.9339-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528053203.9339-1-clamor95@gmail.com>
References: <20260528053203.9339-1-clamor95@gmail.com>
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
index 000000000000..09503e76331c
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
+		led->cdev.brightness_get = asus_ec_led_get_brightness;
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
+MODULE_ALIAS("platform:asus-transformer-ec-led");
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("ASUS Transformer's charging LED driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0

