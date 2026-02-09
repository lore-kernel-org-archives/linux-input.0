Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EEB369216
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770633880; cv=none; b=Swc6LqNMTh9x1cXMKkLSlfKdd/D0govRK4zb+jwy4Cgbp8hEZ4vauKbHZX7J7vfjm0fVLS5SxSxcsDcoeijjVh6MPgrIB/ZgWe90w4VF0kwq1eCQF/Y9jSfnfidsoXfCHfHqzlLat59qyrtytb3Etco8P8TExII+6MwbvTTK29A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770633880; c=relaxed/simple;
	bh=ngKFCu3cqOl5gPWRaEKogf59QUayqMRH5eB6YPE7vFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBJ0Q9aYKt6n7JuAxXkhUJyGGwSxftopP98GdzKMOv6LY07UJjv7aznWXUGUZI6zHYr4Snv8YMvgvZ+pYUZ0fo78uSbeE39bBSTpKsXoCDwY88rPimNWdefTj7ExCqVbMTgs1jqL3OujZmh8WgquwvLSl3twkuLN3CU6pQgBAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEVQmzJP; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEVQmzJP"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59dd9aef51eso5701690e87.2
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 02:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770633875; x=1771238675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIqndriki6fg3AQEF8QYByWC9DeqMY7pkJM5t0jf4fU=;
        b=QEVQmzJPK1YE+CYWirktDsG0llMNQTi6y40dxxhCGeDZMx4znmtkyBnpCTZVzZ3Gcx
         uYU/MQwMjXphMBX+zwYHCd2Bbtr/BO1xSRP0kVwFp3sZYZ3nvzTutihzLjcwxG8hBlGz
         KQ1I5p/nqSz9nobl24l1NUwUDsT6diiCq3vZ1gT+eN71m66/IN6dFLdKyHPVcapHCa1y
         7TaM4VDK2PogWE+CfBPPgwE3cN+bLF5neM9PPFsoLSoVcqfOuCYRONmXJmRkCI1ktvE0
         d8okLgDBmD5sUO9D2t/As48/BzkxiK3W/BTMqPbzEZwt6lcRKPBLyW7AyI1+fkVVGT0M
         X+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770633875; x=1771238675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIqndriki6fg3AQEF8QYByWC9DeqMY7pkJM5t0jf4fU=;
        b=OWWOMmwz1nuBAqlJXUVfcGYst0jSqYszwt6euJR7YimDjvJHW8rWfdeaKg+0pNNvls
         2eOXYx7hlB9mjkvE4cpBBE1gpept/FyhjaI+Q1ujTtAXz3r3nCwE9vR1lufXTEDfk48M
         i5NWJ2oG9hVrs1ADTIcbPNqcqqYWBeYloyuHiHctYP6VD8WluQIoFUADYHKX/8acmaGU
         BQ8OZT2wATJkc3kjx0vJ7V4jqVjOu+4gwMi1YjoR363GHUETvE5F58UEy0iREBJVdBRU
         ttcAJApbt2m03IgGhXCWGHx2EgL3psHmb+7xJxyK8bk7M7bNLok0PNunTIN8dv/CEe6n
         ivpg==
X-Forwarded-Encrypted: i=1; AJvYcCUmI01GYcaSxJ3+zD72qhOh5deCnCMVW8MqgVZv8pW4vmKO4E/IEOyfKvu36MyL6Fh2/8Yb3dVtj+jYCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXn92wclv5N8BaCh7qZu6yjIgesgH0a6OurdExEqv8vHcqx9+j
	zO3NiC7ZJfh78MdlQyNZwCGhw036PVJ0LmaXB3uC6AgT6JracIxXdzp2
X-Gm-Gg: AZuq6aKZiB1QHegUPzSqMh7tZkj70sUy8fKnrDNJ+SFzx4lHvUwnPkRVGY/h5OZTLSU
	3Z177gZJO5dlLYaKNPlK+ZxJ9ZBH6GM79+E3YQIgc91vgONXCYkV70svmYiNR85Qs9KiBVHyXeg
	FA+sEW933qNq0AWVE4DItUK5pK9Och1Or0TxvgdjAfyBvnNwecbJJwlUx9TqkQ89c3BDZ7aP92Z
	h3IRAcz5LJSDcISyTZmyMVnzEd7iWQ3IBQcnDTU1RtFxndvugph7lVTE1AM9RqZ4UGGlRQ5psC2
	9woc66FAVUDMDy9uXkeZ/kK0EXxVYIAJp5M402n5sxmQBonlRSAIEo8MRtJRBXXpqxPmfOIev5F
	M3BubjeTwD3MkobTGN9C/zglJcQs+2JpE4mpwwkjNH5sNWHF9O5xuA84s3UYKrDGo29Y1j3W6Gw
	l+
X-Received: by 2002:a05:6512:250c:b0:59e:5243:6c95 with SMTP id 2adb3069b0e04-59e52436ed4mr233533e87.24.1770633875248;
        Mon, 09 Feb 2026 02:44:35 -0800 (PST)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6f88sm2501469e87.21.2026.02.09.02.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:44:34 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 7/9] leds: Add driver for Asus Transformer LEDs
Date: Mon,  9 Feb 2026 12:44:05 +0200
Message-ID: <20260209104407.116426-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209104407.116426-1-clamor95@gmail.com>
References: <20260209104407.116426-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Asus Transformer tablets have a green and an amber LED on both the Pad
and the Dock. If both LEDs are enabled simultaneously, the emitted light
will be yellow.

Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/leds/Kconfig        |  11 ++++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-asus-ec.c | 104 ++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 drivers/leds/leds-asus-ec.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 597d7a79c988..96dab210f6ca 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -120,6 +120,17 @@ config LEDS_OSRAM_AMS_AS3668
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-as3668.
 
+config LEDS_ASUSEC
+	tristate "LED Support for Asus Transformer charging LED"
+	depends on LEDS_CLASS
+	depends on MFD_ASUSEC
+	help
+	  This option enables support for charging indicator on
+	  Asus Transformer's Pad and it's Dock.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-asus-ec.
+
 config LEDS_AW200XX
 	tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 8fdb45d5b439..1117304dfdf4 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
 obj-$(CONFIG_LEDS_AS3668)		+= leds-as3668.o
+obj-$(CONFIG_LEDS_ASUSEC)		+= leds-asus-ec.o
 obj-$(CONFIG_LEDS_AW200XX)		+= leds-aw200xx.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
diff --git a/drivers/leds/leds-asus-ec.c b/drivers/leds/leds-asus-ec.c
new file mode 100644
index 000000000000..5dd76c9247ee
--- /dev/null
+++ b/drivers/leds/leds-asus-ec.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ASUS EC driver - battery LED
+ */
+
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/mfd/asus-ec.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/*
+ * F[5] & 0x07
+ *  auto: brightness == 0
+ *  bit 0: blink / charger on
+ *  bit 1: amber on
+ *  bit 2: green on
+ */
+
+#define ASUSEC_CTL_LED_BLINK		BIT_ULL(40)
+#define ASUSEC_CTL_LED_AMBER		BIT_ULL(41)
+#define ASUSEC_CTL_LED_GREEN		BIT_ULL(42)
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
+static const struct of_device_id asus_ec_led_match[] = {
+	{ .compatible = "asus,ec-led" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, asus_ec_led_match);
+
+static struct platform_driver asus_ec_led_driver = {
+	.driver = {
+		.name = "asus-ec-led",
+		.of_match_table = asus_ec_led_match,
+	},
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

