Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECD36606F;
	Fri, 13 Feb 2026 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771002881; cv=none; b=I6XaZSU9FYbdvt/RQKXWPddjae/ZvmkvaXQQ3tBf4HTuFPvfHM80jAVjilP3etGvMpk9e2b77KDg2s/rKsgObsAn6Qvpo7zFp3+xMK7zJLzfr6gfbZ1kVQOX2FMKPrRbeUY7amGa0lh3xCAuoySFC1LKmd02dYGzZB7N/BV6gLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771002881; c=relaxed/simple;
	bh=PGAH9rCxX7q2eQB3IVbofw/qNUc6fHrr2ONLETY6iEU=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=k81F0X7rferqhoWSkFPDnuBdDGpDhHLPup0jh+0QcMUitKSlW6mJx6a48vgY/6ZSeh7+Vil46EPeLFyr0HmHfOy4tXcoMFn5InLrKxz6mKKG8psgcNjAyn5TAVlShT4iDQ7DDKrydtRXiaRz7jFiBFs+o/MUkJ81sz3Taah7U9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=kov4yeMd; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="kov4yeMd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=2weegKCMFOEi+LSDYi9P5QCz9jexBGAsJwZMFbqjKas=; b=kov4yeMd1RkKNsThT02tvgp43k
	mFZpYkGK2QerI90/M+OniDAgPlk7VtusFQYSLRt2k3Bp6DQlqPl1YMZENDWBLx3f7Nx2al5ZWlP4p
	0ZEXwku+htAFJ0TDpOaPNNfWTk1+69KDKaHaSFh0UEOa6X/e4F5BizN6wwwDtnQA8uZE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49782 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vqwkX-0007VX-Ae; Fri, 13 Feb 2026 12:14:38 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: hvilleneuve@dimonoff.com,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hugo@hugovil.com
Date: Fri, 13 Feb 2026 12:14:26 -0500
Message-ID: <20260213171431.2228814-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213171431.2228814-1-hugo@hugovil.com>
References: <20260213171431.2228814-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v2 2/2] Input: charlieplex_keypad: add GPIO charlieplex keypad
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add support for GPIO-based charlieplex keypad, allowing to control
N^2-N keys using N GPIO lines.

Reuse matrix keypad keymap to simplify, even if there is no concept
of rows and columns in this type of keyboard.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 MAINTAINERS                                 |   7 +
 drivers/input/keyboard/Kconfig              |  14 ++
 drivers/input/keyboard/Makefile             |   1 +
 drivers/input/keyboard/charlieplex_keypad.c | 213 ++++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 drivers/input/keyboard/charlieplex_keypad.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed6d11a77466..0b2d71f32b400 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5765,6 +5765,13 @@ S:	Maintained
 F:	Documentation/hwmon/powerz.rst
 F:	drivers/hwmon/powerz.c
 
+CHARLIEPLEX KEYPAD DRIVER
+M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
+S:	Supported
+W:	http://www.mosaic-industries.com/embedded-systems/microcontroller-projects/electronic-circuits/matrix-keypad-scan-decode
+F:	Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
+F:	drivers/input/keyboard/charlieplex_keypad.c
+
 CHECKPATCH
 M:	Andy Whitcroft <apw@canonical.com>
 M:	Joe Perches <joe@perches.com>
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 2ff4fef322c24..ae54b4b7e2d8a 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -289,6 +289,20 @@ config KEYBOARD_MATRIX
 	  To compile this driver as a module, choose M here: the
 	  module will be called matrix_keypad.
 
+config KEYBOARD_CHARLIEPLEX
+	tristate "GPIO driven chearlieplex keypad support"
+	depends on GPIOLIB || COMPILE_TEST
+	select INPUT_MATRIXKMAP
+	help
+	  Enable support for GPIO driven charlieplex keypad. A charlieplex
+	  keypad allows to use fewer GPIO lines to interface to key switches.
+	  For example, an N lines charlieplex keypad can be used to interface
+	  to N^2-N different key switches. However, this type of keypad
+	  cannot detect more than one key press at a time.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called charlieplex_keypad.
+
 config KEYBOARD_HIL_OLD
 	tristate "HP HIL keyboard support (simple driver)"
 	depends on GSC || HP300
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 2d906e14f3e27..40b5cf5d374d2 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_LPC32XX)		+= lpc32xx-keys.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
+obj-$(CONFIG_KEYBOARD_CHARLIEPLEX)	+= charlieplex_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7360)		+= max7360-keypad.o
 obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121_touchkey.o
diff --git a/drivers/input/keyboard/charlieplex_keypad.c b/drivers/input/keyboard/charlieplex_keypad.c
new file mode 100644
index 0000000000000..81e8b6b96dab1
--- /dev/null
+++ b/drivers/input/keyboard/charlieplex_keypad.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  GPIO driven charlieplex keypad driver
+ *
+ *  Copyright (c) 2025 Hugo Villeneuve <hvilleneuve@dimonoff.com>
+ *
+ *  Based on matrix_keyboard.c
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/types.h>
+
+struct charlieplex_keypad {
+	struct input_dev *input_dev;
+	struct gpio_descs *line_gpios;
+	unsigned int nlines;
+	unsigned int line_scan_delay_us;
+	unsigned int debounce_threshold;
+	unsigned int debounce_count;
+	int debounce_code;
+	int current_code;
+};
+
+static void charlieplex_keypad_report_key(struct input_dev *input)
+{
+	struct charlieplex_keypad *keypad = input_get_drvdata(input);
+	const unsigned short *keycodes = input->keycode;
+
+	if (keypad->current_code > 0) {
+		input_event(input, EV_MSC, MSC_SCAN, keypad->current_code);
+		input_report_key(input, keycodes[keypad->current_code], 0);
+	}
+
+	if (keypad->debounce_code) {
+		input_event(input, EV_MSC, MSC_SCAN, keypad->debounce_code);
+		input_report_key(input, keycodes[keypad->debounce_code], 1);
+	}
+
+	input_sync(input);
+	keypad->current_code = keypad->debounce_code;
+}
+
+static void charlieplex_keypad_check_switch_change(struct input_dev *input,
+						   int code)
+{
+	struct charlieplex_keypad *keypad = input_get_drvdata(input);
+
+	if (code != keypad->debounce_code) {
+		keypad->debounce_count = 0;
+		keypad->debounce_code = code;
+	} else if (keypad->debounce_count < keypad->debounce_threshold) {
+		keypad->debounce_count++;
+
+		if (keypad->debounce_count >= keypad->debounce_threshold &&
+		    keypad->debounce_code != keypad->current_code)
+			charlieplex_keypad_report_key(input);
+	}
+}
+
+static void charlieplex_keypad_poll(struct input_dev *input)
+{
+	struct charlieplex_keypad *keypad = input_get_drvdata(input);
+	int oline;
+	int code;
+
+	for (code = 0, oline = 0; oline < keypad->nlines; oline++) {
+		DECLARE_BITMAP(values, MATRIX_MAX_ROWS);
+		int iline;
+		int rc;
+
+		/* Activate only one line as output at a time. */
+		gpiod_direction_output(keypad->line_gpios->desc[oline], 1);
+
+		if (keypad->line_scan_delay_us)
+			fsleep(keypad->line_scan_delay_us);
+
+		/* Read input on all other lines. */
+		rc = gpiod_get_array_value_cansleep(keypad->line_gpios->ndescs,
+						    keypad->line_gpios->desc,
+						    keypad->line_gpios->info, values);
+		if (rc)
+			return;
+
+		for (iline = 0; iline < keypad->nlines; iline++) {
+			if (iline == oline)
+				continue; /* Do not read active output line. */
+
+			/* Check if GPIO is asserted. */
+			if (test_bit(iline, values)) {
+				code = MATRIX_SCAN_CODE(oline, iline,
+							get_count_order(keypad->nlines));
+				/*
+				 * Exit loop immediately since we cannot detect
+				 * more than one key press at a time.
+				 */
+				break;
+			}
+		}
+
+		gpiod_direction_input(keypad->line_gpios->desc[oline]);
+
+		if (code)
+			break;
+	}
+
+	charlieplex_keypad_check_switch_change(input, code);
+}
+
+static int charlieplex_keypad_init_gpio(struct platform_device *pdev,
+					struct charlieplex_keypad *keypad)
+{
+	int i;
+
+	keypad->line_gpios = devm_gpiod_get_array(&pdev->dev, "line", GPIOD_IN);
+	if (IS_ERR(keypad->line_gpios))
+		return PTR_ERR(keypad->line_gpios);
+
+	keypad->nlines = keypad->line_gpios->ndescs;
+
+	if (keypad->nlines > MATRIX_MAX_ROWS)
+		return -EINVAL;
+
+	for (i = 0; i < keypad->nlines; i++)
+		gpiod_set_consumer_name(keypad->line_gpios->desc[i], "charlieplex_kbd_line");
+
+	return 0;
+}
+
+static int charlieplex_keypad_probe(struct platform_device *pdev)
+{
+	struct charlieplex_keypad *keypad;
+	unsigned int debounce_interval_ms;
+	unsigned int poll_interval_ms;
+	struct input_dev *input_dev;
+	int err;
+
+	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
+	if (!keypad)
+		return -ENOMEM;
+
+	input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!input_dev)
+		return -ENOMEM;
+
+	keypad->input_dev = input_dev;
+
+	device_property_read_u32(&pdev->dev, "poll-interval", &poll_interval_ms);
+	device_property_read_u32(&pdev->dev, "debounce-delay-ms", &debounce_interval_ms);
+	device_property_read_u32(&pdev->dev, "line-scan-delay-us", &keypad->line_scan_delay_us);
+
+	keypad->current_code = -1;
+	keypad->debounce_code = -1;
+	keypad->debounce_threshold = DIV_ROUND_UP(debounce_interval_ms, poll_interval_ms);
+
+	err = charlieplex_keypad_init_gpio(pdev, keypad);
+	if (err)
+		return err;
+
+	input_dev->name		= pdev->name;
+	input_dev->id.bustype	= BUS_HOST;
+
+	err = matrix_keypad_build_keymap(NULL, NULL, keypad->nlines,
+					 keypad->nlines, NULL, input_dev);
+	if (err)
+		dev_err_probe(&pdev->dev, -ENOMEM, "failed to build keymap\n");
+
+	if (device_property_read_bool(&pdev->dev, "autorepeat"))
+		__set_bit(EV_REP, input_dev->evbit);
+
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+
+	err = input_setup_polling(input_dev, charlieplex_keypad_poll);
+	if (err)
+		dev_err_probe(&pdev->dev, err, "unable to set up polling\n");
+
+	input_set_poll_interval(input_dev, poll_interval_ms);
+
+	input_set_drvdata(input_dev, keypad);
+
+	err = input_register_device(keypad->input_dev);
+	if (err)
+		return err;
+
+	platform_set_drvdata(pdev, keypad);
+
+	return 0;
+}
+
+static const struct of_device_id charlieplex_keypad_dt_match[] = {
+	{ .compatible = "gpio-charlieplex-keypad" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, charlieplex_keypad_dt_match);
+
+static struct platform_driver charlieplex_keypad_driver = {
+	.probe		= charlieplex_keypad_probe,
+	.driver		= {
+		.name	= "charlieplex-keypad",
+		.of_match_table = of_match_ptr(charlieplex_keypad_dt_match),
+	},
+};
+module_platform_driver(charlieplex_keypad_driver);
+
+MODULE_AUTHOR("Hugo Villeneuve <hvilleneuve@dimonoff.com>");
+MODULE_DESCRIPTION("GPIO driven charlieplex keypad driver");
+MODULE_LICENSE("GPL");
-- 
2.47.3

