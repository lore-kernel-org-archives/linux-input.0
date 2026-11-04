Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795195;
	b=cVuburVVuih2/klaEJJw8dowBkZg0X8bcLdMtIBi8B8rY90+MtuIM9Hlcapc5mu+rxHt
	 3c1ezVMIgW/6wtCV9TVYbtNP2GJDGsLi12udaDAve17yKToeTBwd24kblDveHik4nbplD
	 urda2lkVXILZH3w5ggCNAhhMrAkVUrkVhi0Wp2suaHJ0ix5eNoFZFNqHqliVYDGPXfFtc
	 300UEg5+ukLACs98eXWBuAMht+te4HGlFhEwQkLxK0rCYj2II3VtuInCjoQ1cCafEOb3D
	 u0y8AVBILvZn6BWTW7g/yYTJe2NTQgoRE1j5Vl1PQWwFF78pZ1RGubihXLV0oquG7rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZrqYmFboseaWvyfG7gkwsiYJ19YZHfBqxK9w3RRraM0=;
	b=aZ8Gk5RTYyFVqFBfRsEuyFpVjhml18Z2IHqXWQIg9jCB2OlQUSyIzfpzSzQlak60T7Hs
	 Bln+fE9aGNO9J3C+Xhqgn9is4E/8VqVBDMV5p+AQD9iPCrIP7pn+mhTZisy68oJgdtIo1
	 xocEuSla4gq5OODcatKcM22IwcFka1jobR5E57SHTKYPfUYjvw7170Mj2KXooTX+JSPLU
	 m8dp1jTi098cyB3I0P6zBFqPalsPf6gSO1shYSx1clIARVgK0XmS1Ni2T6JILvAWDTd/p
	 Idf4qDLWEc18fuki1sqYJMN+vvLa93QoT68QvzfRLUclVxcCDTej2wHOGUnIf+PitKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0fsrhQFl;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51AC606EE90
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 12:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C51AC606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0fsrhQFl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso451953f8f.2
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 04:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793795193; x=1794399993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZrqYmFboseaWvyfG7gkwsiYJ19YZHfBqxK9w3RRraM0=;
        b=0fsrhQFlHNe2dyMAfTb9BQT9b3x/mmwIHn3FdwVoZmg7CJ9hFyIvSgdTCpZNoRzx/D
         BhhLO50OeSr0Q5h5QB2VItHYe3vzmkg/REA4sfo9sdvhcoAaEs0xZSjG+1r0+V2OvZVj
         kZ+Ul0eJ4D4C0Z9njF1Ho5HUM3CFWNZQZviF9P4FcQSDxaoeNrZTrF5/dfG8AMPbpAcP
         EK06LJ/70AONmf5TDaY2A/74yFnUydVOHm3iqVS5y8HUXKEQ97cVGlQ6hMtvz4RmtvPt
         H1wqrk6bMZYAi4/WXMQYyWMzWLGQbe3f6v6WJ+Vlz9t6Lh1UgtWA/r7VN0QIFpKGqYtj
         jtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793795193; x=1794399993;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZrqYmFboseaWvyfG7gkwsiYJ19YZHfBqxK9w3RRraM0=;
        b=DleqSNwQxsR9IP0ftxRwaVp2DuqJ7bMacYeDlIMUzZiAFtPtVSTCvbU1gyrT1mSXSO
         6H72fFPBWrZeYp/2G1iHPq69p2pwl38YjbXCSkNCEfXgDjCCOghUhNHqfJqDKfTCo9sx
         RueNN6mG7D4w13k+bHkSNnDOhTMaLdPFy5bkZL4w9sOYCeFk+FFd4XwmdXzAozLSrAmq
         f87bWb7XZreopO61IXjudoRrLAU68H5gwMK91mziOvfaqjVXGep+iDarMhQvxnpJbQjr
         dJvdFvrI82zw1Xy39jmrqQJA946YTj0zGfZSVdFVtvXX9BCNLDVle+Adcok4qpL9e9+j
         74Ww==
X-Forwarded-Encrypted: i=1; AKwUvBxYYH+IFohtk1/aA3hY0AUyPxHdSckKDJC7wnIbhsm9S6I/S0b+MkeSf+JgkLwO4qsuDpB6Ay9BcJ+k2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y85LBViJ/lneSLWNkALmmS1+Z7b2c3oeKbFiVl4RpNjd1260S
	2aQOT04tJh/XaAoKfmG7RnNLWn+8ooecvcJozu/1eJNcoTa13Ty8GviqXCwQMQ==
X-Gm-Gg: AYBFou20ohkvqDQlPnvy77pKmFo4Q+PlwSPuw/hjXMvQsLnYX6diY6ufDEos9WhR/5Y
	txFS6YPKuht3+5awEt1e2yyms7ERgUd0Scre1qa47uOvrxXXJrSFdNX2QSK4lUARZ9jojQ4rhlb
	i1hgEo4Ow0cUoeiRFjZUhQNG1vY7iNT67RlMCDT3sWlJDKBP1ddchLK6fF8VztGWMrR30t5VbCQ
	FXp3XZggFO0HtRxRueUSMgoD4pKq4GAO6XTOa0XTCfdrbZk/3iE/x+a6mdAKQliRXQ1f95nY5as
	RI4G6V6Y5BSm87h7/zkdEE/t3++iksc+kXCh44Hn2I6/m4uVwpp+iiP6UKmeIfaMFtrS+XctVls
	zccMQy9wKannbgA53Wvg3k0fPeY+JijZbGV0Rsh6tRI/XitWCL2MdYmFD3QIyLK5rkwfVH6hdOO
	k7K++kCEARJE7LmbJtdHvREu8LHORerXcvpnZnovPU7C1X4jMwYJ1doAKGtSoyPBWdUJ0Cpl3nh
	4nQFYp7wc11t7xVLF/m4Bm1pVzJM7c3h97i6MjWLwc3X9G27T50TWPWsMAlyCLj7kK1nlcVa/F/
	w46C1BEY59P8SxqzUy6a08LF621I3sUYhaQ7fXeSI2FZg2m1DQ==
X-Received: by 2002:a05:600c:a012:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4ac17b2ce18mr354317305e9.27.1793795193089;
        Wed, 04 Nov 2026 04:26:33 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43da9825bsm50492415e9.15.2026.11.04.04.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:26:31 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v13 4/7] input: keyboard: Add driver for ASUS Transformer dock multimedia keys
Date: Wed,  4 Nov 2026 14:26:03 +0200
Message-ID: <20261104122606.215629-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104122606.215629-1-clamor95@gmail.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add support for multimedia top button row of ASUS Transformer's Mobile
Dock keyboard. Driver is made that function keys (F1-F12) are used by
default which suits average Linux use better and with pressing
ScreenLock + AltGr function keys layout is switched to multimedia keys.
Only Dock keyboard input events are tracked for AltGr pressing.

Co-developed-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 .../input/keyboard/asus-transformer-ec-keys.c | 216 ++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index d8c64f333462c..728bc068667e7 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -89,6 +89,16 @@ config KEYBOARD_APPLESPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called applespi.
 
+config KEYBOARD_ASUS_TRANSFORMER_EC
+	tristate "Asus Transformer's Mobile Dock multimedia keys"
+	depends on MFD_ASUS_TRANSFORMER_EC
+	help
+	  Say Y here if you want to use multimedia keys present on Asus
+	  Transformer's Mobile Dock.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called asus-transformer-ec-keys.
+
 config KEYBOARD_ATARI
 	tristate "Atari keyboard"
 	depends on ATARI
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 60bb7baf802f7..0d81096887ada 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_KEYBOARD_ADP5585)		+= adp5585-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5588)		+= adp5588-keys.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_APPLESPI)		+= applespi.o
+obj-$(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC)	+= asus-transformer-ec-keys.o
 obj-$(CONFIG_KEYBOARD_ATARI)		+= atakbd.o
 obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
 obj-$(CONFIG_KEYBOARD_BCM)		+= bcm-keypad.o
diff --git a/drivers/input/keyboard/asus-transformer-ec-keys.c b/drivers/input/keyboard/asus-transformer-ec-keys.c
new file mode 100644
index 0000000000000..5a8fb86a97555
--- /dev/null
+++ b/drivers/input/keyboard/asus-transformer-ec-keys.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/array_size.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define ASUSEC_EXT_KEY_CODES		0x20
+
+struct asus_ec_keys_data {
+	struct notifier_block nb;
+	struct asusec_core *ec;
+	struct input_dev *xidev;
+	unsigned short keymap[ASUSEC_EXT_KEY_CODES * 2];
+	bool special_key_mode;
+};
+
+static const unsigned short asus_ec_dock_ext_keys[] = {
+	/* Function keys [0x00 - 0x19] */
+	[0x01] = KEY_DELETE,
+	[0x02] = KEY_F1,
+	[0x03] = KEY_F2,
+	[0x04] = KEY_F3,
+	[0x05] = KEY_F4,
+	[0x06] = KEY_F5,
+	[0x07] = KEY_F6,
+	[0x08] = KEY_F7,
+	[0x10] = KEY_F8,
+	[0x11] = KEY_F9,
+	[0x12] = KEY_F10,
+	[0x13] = KEY_F11,
+	[0x14] = KEY_F12,
+	[0x15] = KEY_MUTE,
+	[0x16] = KEY_VOLUMEDOWN,
+	[0x17] = KEY_VOLUMEUP,
+	/* Multimedia keys [0x20 - 0x39] */
+	[0x21] = KEY_SCREENLOCK,
+	[0x22] = KEY_WLAN,
+	[0x23] = KEY_BLUETOOTH,
+	[0x24] = KEY_TOUCHPAD_TOGGLE,
+	[0x25] = KEY_BRIGHTNESSDOWN,
+	[0x26] = KEY_BRIGHTNESSUP,
+	[0x27] = KEY_BRIGHTNESS_AUTO,
+	[0x28] = KEY_PRINT,
+	[0x30] = KEY_WWW,
+	[0x31] = KEY_CONFIG,
+	[0x32] = KEY_PREVIOUSSONG,
+	[0x33] = KEY_PLAYPAUSE,
+	[0x34] = KEY_NEXTSONG,
+	[0x35] = KEY_MUTE,
+	[0x36] = KEY_VOLUMEDOWN,
+	[0x37] = KEY_VOLUMEUP,
+};
+
+static void asus_ec_keys_report_key(struct input_dev *dev, unsigned int code,
+				    unsigned int key, bool value)
+{
+	input_event(dev, EV_MSC, MSC_SCAN, code);
+	input_report_key(dev, key, value);
+	input_sync(dev);
+}
+
+static int asus_ec_keys_process_key(struct input_dev *dev, u8 code)
+{
+	struct asus_ec_keys_data *priv = dev_get_drvdata(dev->dev.parent);
+	unsigned int key = 0;
+
+	if (code == 0)
+		return NOTIFY_DONE;
+
+	if (priv->ec->right_alt_pressed) {
+		priv->ec->special_combo_triggered = true;
+
+		/* Flip special key mode state when pressing SCREEN LOCK + R ALT */
+		if (code == 1) {
+			priv->special_key_mode = !priv->special_key_mode;
+			return NOTIFY_OK;
+		}
+	}
+
+	/*
+	 * Relocate code to second "page" if pressed state XOR's mode state
+	 * This way special key will invert the current mode
+	 */
+	if (priv->special_key_mode ^ priv->ec->right_alt_pressed)
+		code += ASUSEC_EXT_KEY_CODES;
+
+	if (code < dev->keycodemax) {
+		unsigned short *map = dev->keycode;
+
+		key = map[code];
+	}
+
+	if (!key)
+		key = KEY_UNKNOWN;
+
+	asus_ec_keys_report_key(dev, code, key, 1);
+	asus_ec_keys_report_key(dev, code, key, 0);
+
+	return NOTIFY_OK;
+}
+
+static int asus_ec_keys_notify(struct notifier_block *nb, unsigned long action, void *data_)
+{
+	struct asus_ec_keys_data *priv =
+		container_of(nb, struct asus_ec_keys_data, nb);
+	u8 *data = data_;
+
+	if (action & ASUSEC_SMI_MASK)
+		return NOTIFY_DONE;
+
+	if (action & ASUSEC_SCI_MASK)
+		return asus_ec_keys_process_key(priv->xidev, data[2]);
+
+	return NOTIFY_DONE;
+}
+
+static void asus_ec_keys_setup_keymap(struct asus_ec_keys_data *priv)
+{
+	struct input_dev *dev = priv->xidev;
+	unsigned int i;
+
+	BUILD_BUG_ON(ARRAY_SIZE(priv->keymap) < ARRAY_SIZE(asus_ec_dock_ext_keys));
+
+	dev->keycode = priv->keymap;
+	dev->keycodesize = sizeof(*priv->keymap);
+	dev->keycodemax = ARRAY_SIZE(priv->keymap);
+
+	input_set_capability(dev, EV_MSC, MSC_SCAN);
+	input_set_capability(dev, EV_KEY, KEY_UNKNOWN);
+
+	for (i = 0; i < ARRAY_SIZE(asus_ec_dock_ext_keys); i++) {
+		unsigned int code = asus_ec_dock_ext_keys[i];
+
+		__set_bit(code, dev->keybit);
+		priv->keymap[i] = code;
+	}
+}
+
+static int asus_ec_keys_open(struct input_dev *input)
+{
+	struct asus_ec_keys_data *priv = input_get_drvdata(input);
+	struct asusec_core *ec = priv->ec;
+	int error;
+
+	priv->nb.notifier_call = asus_ec_keys_notify;
+	error = blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
+	if (error)
+		return error;
+
+	ec->ext_keys_enabled = true;
+
+	return 0;
+}
+
+static void asus_ec_keys_close(struct input_dev *input)
+{
+	struct asus_ec_keys_data *priv = input_get_drvdata(input);
+	struct asusec_core *ec = priv->ec;
+
+	ec->ext_keys_enabled = false;
+	blocking_notifier_chain_unregister(&ec->notify_list, &priv->nb);
+}
+
+static int asus_ec_keys_probe(struct platform_device *pdev)
+{
+	struct i2c_client *parent = to_i2c_client(pdev->dev.parent);
+	struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct asus_ec_keys_data *priv;
+	int error;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->ec = ec;
+
+	priv->xidev = devm_input_allocate_device(dev);
+	if (!priv->xidev)
+		return -ENOMEM;
+
+	priv->xidev->name = devm_kasprintf(dev, GFP_KERNEL, "%s Keyboard Ext", ec->model);
+	priv->xidev->phys = devm_kasprintf(dev, GFP_KERNEL, "i2c-%u-%04x",
+					   i2c_adapter_id(parent->adapter), parent->addr);
+
+	if (!priv->xidev->name || !priv->xidev->phys)
+		return -ENOMEM;
+
+	priv->xidev->open = asus_ec_keys_open;
+	priv->xidev->close = asus_ec_keys_close;
+	input_set_drvdata(priv->xidev, priv);
+
+	asus_ec_keys_setup_keymap(priv);
+
+	error = input_register_device(priv->xidev);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to register extension keys\n");
+
+	return 0;
+}
+
+static struct platform_driver asus_ec_keys_driver = {
+	.driver.name = "asus-transformer-ec-keys",
+	.probe = asus_ec_keys_probe,
+};
+module_platform_driver(asus_ec_keys_driver);
+
+MODULE_ALIAS("platform:asus-transformer-ec-keys");
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer's multimedia keys driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

