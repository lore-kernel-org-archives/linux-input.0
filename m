Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0BF329E6B
	for <linux-input@vger.kernel.org>; Sun,  1 Feb 2026 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769942662; cv=none; b=f2zzEZ+mMM4aNVI/h0LVj7LUY/7bCpIUMYAXc+N/JDltDYr8o3P/OFvVUctVWvLFdLJuS4ygPgsRb67fZJZEDfUqUA4xf1XECu8kp/Q4LFSqxl3FkDMSMtdg2vWoN3rDvylZohSxJYNNX8hgPQVvOt8vw9xb2TFoP/Wmp+0YKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769942662; c=relaxed/simple;
	bh=3GFKhpWfEd4wx9op/cPLQRg9NIiBv/Np5fjkxtlpOAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5zUDcw9RCT6Eko/f+85TI7bV78dadflV19u60sAywmwzTzuclCXCPv+HJkKfPNMc/De2BWx4sE3ucJUWrfipStqQ9KdpZf8trQsU4TY7Y+Q1fWxaTzlrAzU8Aopx1V5t89jUAgYGKXCuU56tFaTXIyIptR2et0FYBpzTk5q0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc7KkNUu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc7KkNUu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so46875425e9.0
        for <linux-input@vger.kernel.org>; Sun, 01 Feb 2026 02:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769942658; x=1770547458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSm3jMIbP4801iaRvLpNxizE8IF0rCGULRQu9fembFY=;
        b=Hc7KkNUu8AYpubs78AjdVzEU6ssuUBW/B58xhwNUUXYvxG0IAgnSaviGteRtCC4pGg
         tEJnBdIbeMqV2EcsYM8EDTF7ebzgZw7oiJDVAgtiCKEN1QNnqdWo/iD5YWPEoIUJI+qt
         ezaMty+iFXPa3nqywnmKB+EmtRPL4bN8jJntRm01BYhtuNb0X2IVr7T9gYw8R4zTpKYx
         RknDAMSUsYCM+Oz8h8WQuRMe1IkshHQT55fP9HPetaXabfFLJmf/vwGAB2jc64XhRjtz
         XwWBQwZEdyoQCewt8y1745OpVH1qmz+rFx0aZowRRWBJ43jNGKb//G0rQamdecZR3BjZ
         lnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769942658; x=1770547458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tSm3jMIbP4801iaRvLpNxizE8IF0rCGULRQu9fembFY=;
        b=ITsXGQz3D/kQa/lKRuPA1t3sV/uKJ6aa/KqUWnpb0xeDL42PLw8Q4atCWj6pnsz19x
         CQ0bqcGF3nn7E5BNkhVh3aDFKCRJjdm4ch3xnYsyKnGC/CSSsP6qusnlyq+8vYiOeh9r
         dKYpTWC56sCdp/gD7EddGu2E++3f2hcCqhTeOjmDnUg3UQlbzy3ez6EB84bQzlXbf63+
         cyGeOjQA/rgE792yXaGPPo9GhT1RWL5mdzqZ+ndeV8L8jtXFDqCgsEvQflBtsYkiDORy
         crC0l99nTMCDAOEknotBOjxbh/UC1MhXKg8yTo8yiBbpGCtV8dAjqpM/NfB4MIiirskc
         KB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOyjEDw+Pcw51JMcyTh5iKE/Haao2WjnG3wDN8iZ7ZJKm3Iz5QSWuJMDC9qZn1/bLC+vy0LuvcGNzG0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwU+ItPjOxGOStPh4VUz2WMyOE2HiN9hNB9+6riGsb3S7/aaJN
	chC3Wh6QRw9zxl1EjA7kzRnO4an8GVKGOXHt3lNve2FtIidvpjR25+Xz
X-Gm-Gg: AZuq6aI2jtsh3VaCsNPpe41tboycWACYS2VVUjoAtZ708TZMQW3cBCFJrmdscbYsAMa
	nULYyZdnqA/WhddcAnXBg/XxTPWDcRJHKLVoIvdW9AI9Nz6eO8P+fCt5k5cpQAKFJDIkaneqZRm
	a37U/Mhli1ZGrDVi5rMsA4eiufUiZQ7qC7L+BUDenCKfxwQ/5sFC6x7u4mNb+MDB4u72Ka0ZFi8
	J4Oz4+kxsXmhwgpho+Q4bg5cfqJjlRK/4lI7eX7eQblamuXZnRKWWCGoCog/OMpKhlJFS6HxESK
	kCRu9Gmeu6b92a8Sr9G85ZiXho34oQKL2nIHbEDVEjQDfYBpohIsK6Zo8nrnisGoFABCEWcY/k/
	CxdEZsHtqHTl+cTNR4dS8xZj7YZLAbsK7Rytggb6CG+yqNooyC0wTxmAcBkOc7zxThRR8Ew73Bx
	Av
X-Received: by 2002:a05:600c:1f16:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-482db4a0bb2mr124686615e9.31.1769942657686;
        Sun, 01 Feb 2026 02:44:17 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce56490sm308947455e9.12.2026.02.01.02.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 02:44:17 -0800 (PST)
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
Subject: [PATCH v1 6/9] input: keyboard: Add driver for Asus Transformer dock multimedia keys
Date: Sun,  1 Feb 2026 12:43:40 +0200
Message-ID: <20260201104343.79231-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260201104343.79231-1-clamor95@gmail.com>
References: <20260201104343.79231-1-clamor95@gmail.com>
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
Since this only modifies codes sent by asus-ec-keys it doesn't affect
normal keyboards at all.

Co-developed-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/keyboard/Kconfig        |  10 +
 drivers/input/keyboard/Makefile       |   1 +
 drivers/input/keyboard/asus-ec-keys.c | 285 ++++++++++++++++++++++++++
 3 files changed, 296 insertions(+)
 create mode 100644 drivers/input/keyboard/asus-ec-keys.c

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 2ff4fef322c2..9eef1ff279c3 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -89,6 +89,16 @@ config KEYBOARD_APPLESPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called applespi.
 
+config KEYBOARD_ASUSEC
+	tristate "Asus Transformer Mobile Dock multimedia keys"
+	depends on MFD_ASUSEC
+	help
+	  Say Y here if you want to use multimedia keys present on Asus
+	  Transformer's Mobile Dock.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called asusec-ext-keys.
+
 config KEYBOARD_ATARI
 	tristate "Atari keyboard"
 	depends on ATARI
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 2d906e14f3e2..7226aafddf7a 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_KEYBOARD_ADP5585)		+= adp5585-keys.o
 obj-$(CONFIG_KEYBOARD_ADP5588)		+= adp5588-keys.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
 obj-$(CONFIG_KEYBOARD_APPLESPI)		+= applespi.o
+obj-$(CONFIG_KEYBOARD_ASUSEC)		+= asus-ec-keys.o
 obj-$(CONFIG_KEYBOARD_ATARI)		+= atakbd.o
 obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
 obj-$(CONFIG_KEYBOARD_BCM)		+= bcm-keypad.o
diff --git a/drivers/input/keyboard/asus-ec-keys.c b/drivers/input/keyboard/asus-ec-keys.c
new file mode 100644
index 000000000000..42365db63bdf
--- /dev/null
+++ b/drivers/input/keyboard/asus-ec-keys.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ASUS Transformer Pad - multimedia keys
+ */
+
+#include <linux/array_size.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/mfd/asus-ec.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define ASUSEC_EXT_KEY_CODES		0x20
+
+struct asus_ec_keys_data {
+	struct notifier_block nb;
+	struct asusec_info *ec;
+	struct input_dev *xidev;
+	bool special_key_pressed;
+	bool special_key_mode;
+	unsigned short keymap[ASUSEC_EXT_KEY_CODES * 2];
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
+		priv->special_key_pressed = !!value;
+}
+
+static int asus_ec_input_connect(struct input_handler *handler, struct input_dev *dev,
+				 const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int error;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = "asusec-media-handler";
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
+static struct input_handler asus_ec_input_handler = {
+	.name =	"asusec-media-handler",
+	.event = asus_ec_input_event,
+	.connect = asus_ec_input_connect,
+	.disconnect = asus_ec_input_disconnect,
+	.id_table = asus_ec_input_ids,
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
+	/* Flip special key mode state when pressing key 1 with special key pressed */
+	if (priv->special_key_pressed && code == 1) {
+		priv->special_key_mode = !priv->special_key_mode;
+		return NOTIFY_DONE;
+	}
+
+	/*
+	 * Relocate code to second "page" if pressed state XOR's mode state
+	 * This way special key will invert the current mode
+	 */
+	if (priv->special_key_mode ^ priv->special_key_pressed)
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
+	struct asus_ec_keys_data *priv = container_of(nb, struct asus_ec_keys_data, nb);
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
+static void asus_ec_input_handler_deregister(void *priv)
+{
+	input_unregister_handler(&asus_ec_input_handler);
+}
+
+static int asus_ec_keys_probe(struct platform_device *pdev)
+{
+	struct asusec_info *ec = cell_to_ec(pdev);
+	struct i2c_client *parent = to_i2c_client(pdev->dev.parent);
+	struct asus_ec_keys_data *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->ec = ec;
+
+	priv->xidev = devm_input_allocate_device(&pdev->dev);
+	if (!priv->xidev)
+		return -ENOMEM;
+
+	priv->xidev->name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+					   "%s Keyboard Ext", ec->model);
+	priv->xidev->phys = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+					   "i2c-%u-%04x",
+					   i2c_adapter_id(parent->adapter),
+					   parent->addr);
+	asus_ec_keys_setup_keymap(priv);
+
+	ret = input_register_device(priv->xidev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register extension keys: %d\n",
+			ret);
+		return ret;
+	}
+
+	asus_ec_input_handler.private = priv;
+
+	ret = input_register_handler(&asus_ec_input_handler);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, asus_ec_input_handler_deregister,
+				       priv);
+	if (ret)
+		return ret;
+
+	priv->nb.notifier_call = asus_ec_keys_notify;
+
+	return devm_asus_ec_register_notifier(pdev, &priv->nb);
+}
+
+static const struct of_device_id asus_ec_keys_match[] = {
+	{ .compatible = "asus,ec-keys" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, asus_ec_keys_match);
+
+static struct platform_driver asus_ec_keys_driver = {
+	.driver = {
+		.name = "asus-ec-keys",
+		.of_match_table = asus_ec_keys_match,
+	},
+	.probe = asus_ec_keys_probe,
+};
+module_platform_driver(asus_ec_keys_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer's multimedia keys driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0

