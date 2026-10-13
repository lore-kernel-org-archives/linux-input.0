Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192848C3FA
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912946; cv=none; b=bHVyv/OTOuoOaFMJCc4tRG9HuPlx4dGffeadgxrmBhrlTvoTEhjJf5+W/O5q7QFaRu/mUgrxlcp/AIT6+rRV/EpVVhEEzjWtPtWinQkZIYZEXguZ2pzUK8OTOQY9SpwlxE5bV4GiWWorhKUxo6qAsjgAn1E6xxF4QibfpZFvKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912946; c=relaxed/simple;
	bh=BDqbAktDlHcNaXVuNgFvehSBr7L7Uj+zana2OBhQSBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1CNIBZ5E5cEnpBmTVrwOSn9+cl8+o7RSIVvWGmQh9VlSi9qB5pj+sfunEvXV+BKImi/jQkiKVAeEMmwkRjESCaxITAV13UtaLsHB/L0KLI+ofGHhV8+AxIdVuQT+CPUiEURrDDoOdTBjMPeAt43jYWlPx2Z74CBX68iJaz7of8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb3E/UdU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb3E/UdU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso659455e9.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912937; x=1792517737; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QXqO6RB1f6oD4M23FtS1tdaFXlmBo92voxy51qF78Vk=;
        b=Kb3E/UdUAljOV4khpQyp3Tz3Ek3DE1lqSe8O56XK6e1G3/jRle5pRZHYguxoj7kbl5
         nDsXERFkGXGxAxKdxSm15Ds76ut7JQsKIyWj67N6Y+uT6Ubhxmr/Lt5uOSIzHzQzfDi1
         E6LMzrFfxQW7EmXGQXAvNAd3w4jyKFy9XFT3nFNtJXZz/rlM3v0xxL2ZE6p7kH3NMb+D
         IOBX1v2yxWr1hU8N1Axew7XM4JZhfazNLJt/XHtv61BlIO8FXZGEDjnnodxkejjN/fxs
         UfUxjs2HMnMmJA0wDZDxbtE9fV83D1KaaJBfiDOtCDTzKVk6sQyFU0RbR8EUES22jKvt
         Jeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912937; x=1792517737;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXqO6RB1f6oD4M23FtS1tdaFXlmBo92voxy51qF78Vk=;
        b=BDk3HtU3C6XdoiS+HMbLHj1AyBhyHQ2yEkiSRgv5DR8b/QKVUyIBAuUp3Dhz3bTCKt
         GLOZHgSf4cI0epgf7Im9vU2lKgXw5pQ8uzXbLwJWJs+MVj692T1wFV9j5aou96bEYmzN
         gToXlKwp2U5nFbMEWIvWpboKTSiKwOlthkMPCaYh2uWI5omBrMt65IZ332AM2ngUac5F
         AfZWHUwMpQ7HBx7blFRXHwpLsMSISNol6vm11KxmQE4deR3lar7ubnT1k2GdVH6Dp8uN
         +KC9mrS/NGY43kfpQdNnUGOaKL/naGmtnl7eBYHX5OLRrCeA+HwU59MBzdL0IeuER8Hd
         1HNA==
X-Forwarded-Encrypted: i=1; AKwUvBy8lbpl6rQNgPF2pDRiko9IPszDo7ia6kGBw7TB5BGbOn1CnRel9iDXJSKfz4LyXIl39YJOI5dLwJY9sg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK0EtT1l3rRTQHkoZNyiBMkLYDjTdDmPGeLXBPi57zV0LBcP9Ag
	nr/2RKKsYjFl3lZWi3wgdnYSKLY7skwa/4DOeBvkD0epyVqOIWQjLQG3
X-Gm-Gg: AYBFou28TSO4UBnoSzO3/Coa7uqnUbDEm36+umW0/Rs7Oj+RyBexV4nLAMrhsHD8Xb6
	nLwmQeiNPHUd2kyC9AeKucECxDtfdOlLmiZOKk0zGHLAaccuctEFBRPVJKaYcI/xp9osAFQiWfH
	uADzUWNdxobhGutf9/SBWsxVQ+B62DgswWG5OFoYEbm+f5t6UHgdz72dnAAEzeIz0reVWrTsRFR
	F0UfIOQmMDPoDeDUUvcz0VbNWq54yxaM4TedzJsfeuQMVuHmoIlsz0t7/4JDrNB3NI3qwEWVUEp
	Y/Ot14FanT4bR61J86IdSyOmlH3tl4o7wm67Epf1dT0cqm+j2JG/CxP7SFByh0dgtbLU9tLoBDA
	i1w6nbBrEGDh5+fXn4w7Z1LbvsR66ri1UehgaDkfx2RiChbg/JazscjOy81r+ZY5uvvhanYgF2o
	hzk0HEP4U4ZK3jIqV+TyE4LpOEG6R3/xBXT6dlLxe3SrXCd5GeVuAuUbxryHMgjgHC4cbLnrAfk
	icrOyIiqyYt1VjcLH8e65NAHcS39w==
X-Received: by 2002:a05:600c:4fd5:b0:4a0:5b:7bc0 with SMTP id 5b1f17b1804b1-4a18e49a7e3mr273481405e9.21.1791912937098;
        Tue, 13 Oct 2026 10:35:37 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ca51465sm284127195e9.4.2026.10.13.10.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:35:35 -0700 (PDT)
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
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 4/7] input: keyboard: Add driver for ASUS Transformer dock multimedia keys
Date: Tue, 13 Oct 2026 20:35:00 +0300
Message-ID: <20261013173504.451391-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013173504.451391-1-clamor95@gmail.com>
References: <20261013173504.451391-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
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
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 .../input/keyboard/asus-transformer-ec-keys.c | 310 ++++++++++++++++++
 3 files changed, 321 insertions(+)
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
index 0000000000000..8e83b27ce60ee
--- /dev/null
+++ b/drivers/input/keyboard/asus-transformer-ec-keys.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/array_size.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define ASUSEC_EXT_KEY_CODES		0x20
+
+struct asus_ec_keys_data {
+	struct notifier_block nb;
+	struct asusec_core *ec;
+	struct input_dev *xidev;
+	struct input_handler input_handler;
+	unsigned short keymap[ASUSEC_EXT_KEY_CODES * 2];
+	const char *kbc_phys;
+	bool special_key_pressed;
+	bool special_key_mode;
+};
+
+static void asus_ec_input_event(struct input_handle *handle,
+				unsigned int event_type,
+				unsigned int event_code, int value)
+{
+	struct asus_ec_keys_data *priv = handle->handler->private;
+
+	/* Store special key state */
+	if (event_type == EV_KEY && event_code == KEY_RIGHTALT)
+		WRITE_ONCE(priv->special_key_pressed, !!value);
+}
+
+static int asus_ec_input_connect(struct input_handler *handler,
+				 struct input_dev *dev,
+				 const struct input_device_id *id)
+{
+	struct asus_ec_keys_data *priv = handler->private;
+	struct input_handle *handle;
+	int error;
+
+	if (!dev->phys || !strstr(dev->phys, priv->kbc_phys))
+		return -ENODEV;
+
+	handle = kzalloc_obj(*handle);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = handler->name;
+
+	error = input_register_handle(handle);
+	if (error)
+		goto err_free_handle;
+
+	error = input_open_device(handle);
+	if (error)
+		goto err_unregister_handle;
+
+	return 0;
+
+ err_unregister_handle:
+	input_unregister_handle(handle);
+ err_free_handle:
+	kfree(handle);
+
+	return error;
+}
+
+static void asus_ec_input_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static const struct input_device_id asus_ec_input_ids[] = {
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+	},
+	{ }
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
+	/* Flip special key mode state when pressing SCREEN LOCK + R ALT */
+	if (READ_ONCE(priv->special_key_pressed) && code == 1) {
+		priv->special_key_mode = !priv->special_key_mode;
+		return NOTIFY_DONE;
+	}
+
+	/*
+	 * Relocate code to second "page" if pressed state XOR's mode state
+	 * This way special key will invert the current mode
+	 */
+	if (priv->special_key_mode ^ READ_ONCE(priv->special_key_pressed))
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
+static int asus_ec_keys_notify(struct notifier_block *nb,
+			       unsigned long action, void *data_)
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
+		if (!code)
+			continue;
+
+		__set_bit(code, dev->keybit);
+		priv->keymap[i] = code;
+	}
+}
+
+static int asus_ec_keys_register_handler(struct device *dev,
+					 struct asus_ec_keys_data *priv)
+{
+	struct i2c_client *parent = to_i2c_client(dev->parent);
+	int error;
+
+	priv->input_handler.event = asus_ec_input_event;
+	priv->input_handler.connect = asus_ec_input_connect;
+	priv->input_handler.disconnect = asus_ec_input_disconnect;
+	priv->input_handler.id_table = asus_ec_input_ids;
+	priv->input_handler.passive_observer = true;
+	priv->input_handler.private = priv;
+	priv->input_handler.name = devm_kasprintf(dev, GFP_KERNEL,
+						  "%s-media-handler",
+						  priv->ec->name);
+	if (!priv->input_handler.name)
+		return -ENOMEM;
+
+	priv->kbc_phys = devm_kasprintf(dev, GFP_KERNEL, "i2c-%u-%04x/serio0",
+					i2c_adapter_id(parent->adapter),
+					parent->addr);
+	if (!priv->kbc_phys)
+		return -ENOMEM;
+
+	error = input_register_handler(&priv->input_handler);
+	if (error)
+		return error;
+
+	return 0;
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
+	priv->xidev->name = devm_kasprintf(dev, GFP_KERNEL, "%s Keyboard Ext",
+					   ec->model);
+	priv->xidev->phys = devm_kasprintf(dev, GFP_KERNEL, "i2c-%u-%04x",
+					   i2c_adapter_id(parent->adapter),
+					   parent->addr);
+
+	if (!priv->xidev->name || !priv->xidev->phys)
+		return -ENOMEM;
+
+	asus_ec_keys_setup_keymap(priv);
+
+	error = input_register_device(priv->xidev);
+	if (error)
+		return dev_err_probe(dev, error,
+				     "failed to register extension keys\n");
+
+	error = asus_ec_keys_register_handler(dev, priv);
+	if (error)
+		return error;
+
+	priv->nb.notifier_call = asus_ec_keys_notify;
+
+	error = blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
+	if (error) {
+		input_unregister_handler(&priv->input_handler);
+		return error;
+	}
+
+	return 0;
+}
+
+static void asus_ec_keys_remove(struct platform_device *pdev)
+{
+	struct asus_ec_keys_data *priv = platform_get_drvdata(pdev);
+	struct asusec_core *ec = priv->ec;
+
+	blocking_notifier_chain_unregister(&ec->notify_list, &priv->nb);
+	input_unregister_handler(&priv->input_handler);
+}
+
+static struct platform_driver asus_ec_keys_driver = {
+	.driver.name = "asus-transformer-ec-keys",
+	.probe = asus_ec_keys_probe,
+	.remove = asus_ec_keys_remove,
+};
+module_platform_driver(asus_ec_keys_driver);
+
+MODULE_ALIAS("platform:asus-transformer-ec-keys");
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer's multimedia keys driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

