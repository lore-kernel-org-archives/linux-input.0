Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783A4C6525
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404272; cv=none; b=YyAOHeY+1Cx3V4WW4TTu/xRkpGrnf6PdiFM6t0rH7lDHw+leU9hH2CKrmiBpC1tnko/xBNRoKW1tf55kt1OLkuxDSEhrUslCCqOm3TGg3NBW1YB7EDgVLQ/UeyRw/NIe7vSunqfI5RSDulLbCgfgzvatVjOp3/LbeCxLWRSezHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404272; c=relaxed/simple;
	bh=USRFVQeS8cDd6ECY1XOmG4yXbLnmHO0XQocSe4wqUMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UweOHlaikTE2bxQHrPBW9mlOMuQGvHg1HJQ6u4ittjLAUZSXtmZuFG9q7181QIrzv5+l+T9JyWKedeneVcG7cRYZldFnOqsa0J7209xmaQb/gtTL0+RVeUUqCuKXP0k6YKYEvlXP9zfqYLzFEMMRdLDvb8kyIC1zgD9DT7KjWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN34b3qC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN34b3qC"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b0584ad71so1251994f8f.0
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 03:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792404267; x=1793009067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jxaZr3mzp46llJixKla1m55tHI0toVt6qt2rAqY5z3g=;
        b=jN34b3qCasn7ZKDFeVdB6aCTWKzx4ej1ZLrb4eyKd/TP25A5rhwI94LpxDL9SrOOpq
         yKAErYWHV3KCmn4wKLq4za0/y9MZ8g8LghlD7Fnaf+w+uz7TGvD9aB8nGngSEfpTUQB1
         qCqV1KPNTD6RU0MH6aFZ8Vlu8X7vgjoBZ31dJQssQGo2Q259yW4AiNcRfvJ/blZBqzVA
         3cJLu0tRikQGq1v+gYqELu4GV7Ld1G23rjdUir8bHx9nWX2IyfyqU/DDN1ke0z0cjv1g
         qTe0QRajwpflQwMmgkMcCGxQ8wqDoq3CsbAqc8Ks0VIT/6TPkwaGOuMr1kWQHDesqSBp
         fxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792404267; x=1793009067;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxaZr3mzp46llJixKla1m55tHI0toVt6qt2rAqY5z3g=;
        b=wwg6G2l0TvgXJlgzv74NPhHopHPntp3Hepvs6/lmBmLZWdFOC9asoMc9Gt+3yevq/1
         JJfes/yzhCKgCc5MKIjfHTTyRVZu9RZkoeLzG+zYckdHl3xFiuwcrI2fJgqPj14EtC2r
         mC+xoYIJ9UtNNnddySrXhzb2N2+DRja5bR8cctGTVkj5Abz1bPRwu0Y9vuwRwTxFFhIm
         tY1ziz70qMDmiVTNVNJgxAwpGp+4W/Eg6k1CU1NnRWvW2U5hvWhnzfLv5MW2Bp+Rhs1Q
         L9u0OKn2MpKlFaA+eNJN1ykRHVkNbsjxOFPXsb8vIkRjhbspyPUWxcTXm1+EkhHIdZYT
         RZMA==
X-Forwarded-Encrypted: i=1; AKwUvBwbq0zgaXZnm9huHq7vhrM5opFS45T0YF7pZAETzxSZZYC7TjAo4DVEjJv29vrejAt1C8XTw5xbtWJf7g==@vger.kernel.org
X-Gm-Message-State: AFq9FYIe9rKwVR2ffiUmm4HsJekB8Njajs1DbNQiMFfGj6mm6fU51kts
	rLYS4FSkfnte+wBI74B3CJzKkCVRIXGtoExdYV8uOjuvRwPXaGp0jfco
X-Gm-Gg: AYBFou2x2NzoNWh7HQ/gxpJAyUguB3OAgkzrkFHoT/ltympgk7qcRnAYnIXFbCdCK7H
	XYK0r1+aaczQiYFC/4i6ba1pvnidh0JaRud4UV2Dy90SvCgaq0s57DrcZHGDI6hMHKY+khGWj5N
	rI3quXJk0wANvv5ibGtbN96HTmppyRCZIPQhIBJWMLLlSx03ThkdMnMNhaqMA3XmLKdeLr8Fscg
	X8Tk+d6NvM96uJIxrNg5SWZfiBvtn1e1/mXpsriYWsAb8BMhPsc9apO6LQ6RYhOqHkgCfZhsrHg
	XT/u35E+UVg/+mR7yi+3V/abNa56Ip/lTjJgKeUwERReK+y2Mj6ZSxBgTzRBshI//wMbDRItVuL
	3URtgVLoNSL7uWjUZo4ZIoLXjudCDIs37AVCWozLhG4sAzJT2BSe3WY3cN6viSGLjb46npooC7m
	GZhkY9cznQ08L5DVg/j9K1y7HlZOoJxzcdjkiWw9EdQNbN96nxUCut6wahNy8YxK3i2LWmJuaQO
	FvOfStOoUoYOX852A4=
X-Received: by 2002:a05:600c:c4a1:b0:4a1:efd3:9862 with SMTP id 5b1f17b1804b1-4a1efd399c2mr3544885e9.21.1792404267013;
        Mon, 19 Oct 2026 03:04:27 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1df164777sm177811485e9.5.2026.10.19.03.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:04:25 -0700 (PDT)
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
Subject: [PATCH v12 3/7] input: serio: Add driver for ASUS Transformer dock keyboard and touchpad
Date: Mon, 19 Oct 2026 13:04:02 +0300
Message-ID: <20261019100406.103687-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019100406.103687-1-clamor95@gmail.com>
References: <20261019100406.103687-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add input driver for ASUS Transformer dock keyboard and touchpad.

Some keys in ASUS Dock report keycodes that don't make sense according to
their position, this patch modifies the incoming data that is sent to
serio to send proper scancodes.

Co-developed-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 264 ++++++++++++++++++
 3 files changed, 280 insertions(+)
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 087f0203fff99..58d415ca1d540 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -84,6 +84,21 @@ config SERIO_RPCKBD
 	  To compile this driver as a module, choose M here: the
 	  module will be called rpckbd.
 
+config SERIO_ASUS_TRANSFORMER_EC
+	tristate "Asus Transformer's Dock keyboard and touchpad controller"
+	depends on MFD_ASUS_TRANSFORMER_EC
+	help
+	  Say Y here if you want to use the keyboard and/or touchpad on
+	  Asus Transformed's Mobile Dock.
+
+	  For keyboard support you also need atkbd driver.
+
+	  For touchpad support you also need psmouse driver with Elantech
+	  touchpad option enabled.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called asus-transformer-ec-kbc.
+
 config SERIO_AMBAKMI
 	tristate "AMBA KMI keyboard controller"
 	depends on ARM_AMBA
diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
index 7f5137dc02e26..bed2a7a92a13d 100644
--- a/drivers/input/serio/Makefile
+++ b/drivers/input/serio/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SERIO_SERPORT)	+= serport.o
 obj-$(CONFIG_SERIO_RPCKBD)	+= rpckbd.o
 obj-$(CONFIG_SERIO_SA1111)	+= sa1111ps2.o
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
+obj-$(CONFIG_SERIO_ASUS_TRANSFORMER_EC)	+= asus-transformer-ec-kbc.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
 obj-$(CONFIG_SERIO_GSCPS2)	+= gscps2.o
 obj-$(CONFIG_HP_SDC)		+= hp_sdc.o
diff --git a/drivers/input/serio/asus-transformer-ec-kbc.c b/drivers/input/serio/asus-transformer-ec-kbc.c
new file mode 100644
index 0000000000000..fa7f7c3f037db
--- /dev/null
+++ b/drivers/input/serio/asus-transformer-ec-kbc.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/i8042.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/serio.h>
+
+struct asus_ec_kbc_data {
+	struct notifier_block nb;
+	struct asusec_core *ec;
+	struct i2c_client *parent;
+	struct serio *sdev[2];
+	bool altgr_delayed;
+	bool altgr_suppressed;
+};
+
+static bool asus_ec_kbc_altgr_active(struct asus_ec_kbc_data *priv)
+{
+	return IS_ENABLED(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC) &&
+		(priv->ec->ext_keys_enabled || priv->altgr_delayed ||
+		 priv->altgr_suppressed);
+}
+
+static void asus_ec_kbc_reset_altgr(struct asus_ec_kbc_data *priv)
+{
+	if (!IS_ENABLED(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC))
+		return;
+
+	priv->ec->right_alt_pressed = false;
+	priv->ec->special_combo_triggered = false;
+	priv->altgr_delayed = false;
+	priv->altgr_suppressed = false;
+}
+
+static void asus_ec_kbc_sync_altgr_combo(struct asus_ec_kbc_data *priv)
+{
+	if (priv->ec->special_combo_triggered) {
+		priv->ec->special_combo_triggered = false;
+		if (priv->altgr_delayed) {
+			priv->altgr_delayed = false;
+			priv->altgr_suppressed = true;
+		}
+	}
+}
+
+static void asus_ec_kbc_flush_altgr(struct asus_ec_kbc_data *priv)
+{
+	if (!asus_ec_kbc_altgr_active(priv))
+		return;
+
+	asus_ec_kbc_sync_altgr_combo(priv);
+
+	if (!priv->altgr_delayed)
+		return;
+
+	serio_interrupt(priv->sdev[0], 0xe0, 0);
+	serio_interrupt(priv->sdev[0], 0x11, 0);
+
+	priv->altgr_delayed = false;
+}
+
+static bool asus_ec_kbc_handle_altgr(struct asus_ec_kbc_data *priv, bool is_release)
+{
+	bool suppressed;
+
+	if (!asus_ec_kbc_altgr_active(priv)) {
+		asus_ec_kbc_reset_altgr(priv);
+		return false;
+	}
+
+	asus_ec_kbc_sync_altgr_combo(priv);
+
+	if (!is_release) {
+		if (!priv->ec->right_alt_pressed) {
+			asus_ec_kbc_reset_altgr(priv);
+			priv->ec->right_alt_pressed = true;
+			priv->altgr_delayed = true;
+			return true;
+		}
+
+		return priv->altgr_delayed || priv->altgr_suppressed;
+       }
+
+	suppressed = priv->altgr_suppressed;
+	if (!suppressed)
+		asus_ec_kbc_flush_altgr(priv);
+
+	asus_ec_kbc_reset_altgr(priv);
+	return suppressed;
+}
+
+static int asus_ec_kbc_notify(struct notifier_block *nb,
+			      unsigned long action, void *data_)
+{
+	struct asus_ec_kbc_data *priv = container_of(nb, struct asus_ec_kbc_data, nb);
+	unsigned int port_idx, n;
+	u8 *data = data_;
+
+	if (action & (ASUSEC_SMI_MASK | ASUSEC_SCI_MASK)) {
+		if (action == ASUSEC_SMI_ACTION(HANDSHAKE) ||
+		    action == ASUSEC_SMI_ACTION(RESET))
+			asus_ec_kbc_reset_altgr(priv);
+		return NOTIFY_DONE;
+	} else if (action & ASUSEC_AUX_MASK) {
+		port_idx = 1;
+	} else if (action & priv->ec->keyboard_mask) {
+		port_idx = 0;
+	} else {
+		return NOTIFY_DONE;
+	}
+
+	/*
+	 * The data[0] is the number of bytes following the count byte: one
+	 * status byte plus the payload. The SL101 EC, for example, reports
+	 * keyboard reset as 03 09 fa aa (status 09, ACK fa, BAT aa). Skip the
+	 * count and status bytes and forward every payload byte to serio.
+	 */
+	if (data[0] < 2 || data[0] > ASUSEC_ENTRY_SIZE)
+		return NOTIFY_BAD;
+
+	n = data[0] - 1;
+	data += 2;
+
+	if (port_idx == 0) {
+		/*
+		 * Remap keyboard key codes to match AT layout:
+		 * ALTGR:  RIGHT-ALT  [E0 11] -> delayed / suppressed
+		 * SEARCH: RIGHT-META [E0 27] -> LEFT-ALT   [11]
+		 * MENU:   COMPOSE    [E0 2F] -> RIGHT-META [E0 27]
+		 */
+		if ((n == 2 || (n == 3 && data[1] == 0xF0)) && data[0] == 0xE0) {
+			u8 *keycode = &data[n - 1];
+
+			switch (*keycode) {
+			case 0x11:
+				if (asus_ec_kbc_handle_altgr(priv, n == 3))
+					return NOTIFY_OK;
+				break;
+			case 0x27:
+				*keycode = 0x11;
+				++data;
+				--n;
+				break;
+			case 0x2F:
+				*keycode = 0x27;
+				break;
+			}
+		}
+
+		/*
+		 * Only flush delayed AltGr on key make events, ignoring
+		 * key break codes and PS/2 command responses (ACK, BAT, etc.).
+		 */
+		if ((n == 2 && data[0] == 0xe0) ||
+		    (n == 1 && data[0] > 0 && data[0] < 0x84) ||
+		    data[0] == 0xe1)
+			asus_ec_kbc_flush_altgr(priv);
+	}
+
+	while (n--)
+		serio_interrupt(priv->sdev[port_idx], *data++, 0);
+
+	return NOTIFY_OK;
+}
+
+static int asus_ec_serio_write(struct serio *port, unsigned char data)
+{
+	struct asus_ec_kbc_data *priv = port->port_data;
+
+	return i2c_smbus_write_word_data(priv->parent, ASUSEC_WRITE_BUF,
+					 (data << 8) | port->id.extra);
+}
+
+static void asus_ec_serio_remove(void *data)
+{
+	serio_unregister_port(data);
+}
+
+static int asus_ec_register_serio(struct platform_device *pdev, int idx,
+				  const char *name, int cmd)
+{
+	struct asus_ec_kbc_data *priv = platform_get_drvdata(pdev);
+	struct i2c_client *parent = priv->parent;
+	struct serio *port = kzalloc_obj(*port);
+
+	if (!port)
+		return -ENOMEM;
+
+	priv->sdev[idx] = port;
+	port->dev.parent = &pdev->dev;
+	port->id.type = SERIO_8042;
+	port->id.extra = cmd & 0xFF;
+	port->write = asus_ec_serio_write;
+	port->port_data = (void *)priv;
+	snprintf(port->name, sizeof(port->name), "%s %s",
+		 priv->ec->model, name);
+	snprintf(port->phys, sizeof(port->phys), "i2c-%u-%04x/serio%d",
+		 i2c_adapter_id(parent->adapter), parent->addr, idx);
+
+	serio_register_port(port);
+
+	return devm_add_action_or_reset(&pdev->dev, asus_ec_serio_remove, port);
+}
+
+static void asus_ec_notifier_chain_unregister(void *data)
+{
+	struct asus_ec_kbc_data *priv = data;
+	struct asusec_core *ec = priv->ec;
+
+	blocking_notifier_chain_unregister(&ec->notify_list, &priv->nb);
+}
+
+static int asus_ec_kbc_probe(struct platform_device *pdev)
+{
+	struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
+	struct asus_ec_kbc_data *priv;
+	int error;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->ec = ec;
+	priv->parent = to_i2c_client(pdev->dev.parent);
+
+	error = asus_ec_register_serio(pdev, 0, "Keyboard", 0);
+	if (error)
+		return error;
+
+	error = asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_AUX_SEND);
+	if (error)
+		return error;
+
+	priv->nb.notifier_call = asus_ec_kbc_notify;
+
+	error = blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				     "failed to register blocking notifier chain");
+
+	error = devm_add_action_or_reset(&pdev->dev,
+					 asus_ec_notifier_chain_unregister,
+					 priv);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static struct platform_driver asus_ec_kbc_driver = {
+	.driver.name = "asus-transformer-ec-kbc",
+	.probe = asus_ec_kbc_probe,
+};
+module_platform_driver(asus_ec_kbc_driver);
+
+MODULE_ALIAS("platform:asus-transformer-ec-kbc");
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer's Dock keyboard and touchpad driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

