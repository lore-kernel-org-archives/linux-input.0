Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1EE48A8D1
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912940; cv=none; b=CMzINYyQQUiJ6qzxhFbyIFAvmZJv6gAzuY43YZ8SLZ9WsdlrQmze8WZOoO81OIBxFoslaXaE9z4txnbgk5vJCLJxyzyJcPXI9bxSO3IA9ena7OknINzeIn0W+Rh82fe+SqBbl/Vbqh7xqTupJgkk/yQ/zEgUi3L1dE9FR52FWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912940; c=relaxed/simple;
	bh=fFoLexyRcNrB1eC7OtB3A58o+/m/Yq4r5cnWC8fsmyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQ3xMULPyFXUSTbUpSYD+Eb7JZyczvjCO9FuSDvqA585OVhuPXJ8FWRr9L4DS0NqOLs/GA4ALZP+MPSY+jsPC6LVGRC6V9AR41+AyRK0RzaFvz0IQHrW1QbL7lOIggQSI9wOvJPqYDgsdrWIWOEM54q83PHy+qVxuoBkDhxjgyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSv4kD9r; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSv4kD9r"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso1253335e9.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912934; x=1792517734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uDvZfdNd9v0/whisVO87Oe7GES9qepkpHXg/ZppMAZY=;
        b=nSv4kD9rTGNSvDYoR7Zmjc3qqpRt7dvM7L4LRWydyzafwzwYGQ4xhhfbEH0TuTVMe5
         sDW9fyFgz/EzfyqNKs6OjiuPaYXAYbeho1iKEUq3++QU1RMbjfR9IdU68AE2nJKf/NPf
         z/8uQ9ATpScRUP4Wn5EiPfgBkAielYUCBhbjYzUGr7ulhKPArx64WpAAAT+lWavD7HJ8
         /KnRtPhiJ11lHi04p+MyYneA6B04OIu6vip8dhhpB3GQEyXO4N4c5UMGfPwbI6wxkZ2L
         5YAUu0QHl0YMyZGuTVuZON+wwI1J2CDloUxsiWvtRdkTEOzJt4FGptMilUnnkJu81IzU
         DTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912934; x=1792517734;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uDvZfdNd9v0/whisVO87Oe7GES9qepkpHXg/ZppMAZY=;
        b=RbIHm7wzHYdNIf9UPccv1Xhz6jIBwUotjvaWMnJKtlhkHJbj2qoIBoF05iCZz66Eey
         eE6Fr41FaSI6VIo8cCYMp27RpFpNwem+Vw++IeiME7uOfi4gGxRmP76NGrLqpXxwr4Sn
         pgGTn3sfrdgmtgZ5LYGKuQhjSgE861jny9IEV7iW4jO44JK+hwzhq0hEeLMnmx2ZRLIk
         MfYsN2whAW5nu/mtGqqbmvcgwT1j8dBsv+bs7stlqXyNW2ftNtA0qjirdtstsyqiShw7
         xbhl/G/LKIIuTcNtEwADhO3HUsB9QT8kB2muyXE7kul1Bz/WETY8P7XEN6SunCCKsI/h
         IuHw==
X-Forwarded-Encrypted: i=1; AKwUvBzdPeKa5L+FlzAHTIx8dNGJvZqh24owdR3NVhZ8btARr3CWDpXZspB6YE9xJ63k15ogQajh4VIPJee0tw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL3v30zjdh8A49wRqkAywwr9gSCt/xd/H1Mo5UH9UTs6t8D927z
	EoxKOvIUPEACvqyIvodsmfSGcxImw/YM901f9YSkM92jD0qhLVJJQ0/+
X-Gm-Gg: AYBFou34Z0yy1tGR2x2V0tqPSmSBD/vL+l61Qe5nO3QK37NWc8yKcSK8btzL+QnOjLN
	6Sn+nTv0ibruCdJqXEFInJ0L8VVZyAGSCjNGLLGkE4rtAX8pnspOhu7qIq52GYoeAuPJxfALP4X
	9DTaQsApY95T6jX39C2P0dRPXbAlZ6jhRtq7ME71IvSTVKPxeoGbC2T7ODcDJXySo9nUW35ncpQ
	udFBYJ4ZeOJkxgsn4p50IiIluKxAYxQeya4wQzQaB9MrYOgqnj5uAmMxxfTQYgsjMbTaUAew2C3
	KPWCt+hZsHch9iPRiwd6Z2ps6sn598Qf0EcnezpfnqZalrYHuSNpcOVN4kcjfpWKFlJtpywJWvn
	1+2ZwrC8Z0hTmHwz5tgGvvS6bDkePZKHd1WuSNAUsUOuoFLm6dJxhwSEnKMvPb2OhoG37hAQsFL
	dVmGaCFPWCl8FjyydSwNSEzZ3dIzsnMHzvbngmhgEbdyQhcKWsSTodtt4/N4CFJWM1aVb7Fj5o6
	ledfg8Tho+11Alz5qg=
X-Received: by 2002:a05:600c:190a:b0:4a1:746e:589a with SMTP id 5b1f17b1804b1-4a18e4aea54mr286864835e9.18.1791912934216;
        Tue, 13 Oct 2026 10:35:34 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ca51465sm284127195e9.4.2026.10.13.10.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:35:33 -0700 (PDT)
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
Subject: [PATCH v11 3/7] input: serio: Add driver for ASUS Transformer dock keyboard and touchpad
Date: Tue, 13 Oct 2026 20:34:59 +0300
Message-ID: <20261013173504.451391-4-clamor95@gmail.com>
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

Add input driver for ASUS Transformer dock keyboard and touchpad.

Some keys in ASUS Dock report keycodes that don't make sense according to
their position, this patch modifies the incoming data that is sent to
serio to send proper scancodes.

Co-developed-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/serio/Kconfig                   |  15 ++
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 169 ++++++++++++++++++
 3 files changed, 185 insertions(+)
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
index 0000000000000..62ffaf4d43715
--- /dev/null
+++ b/drivers/input/serio/asus-transformer-ec-kbc.c
@@ -0,0 +1,169 @@
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
+};
+
+static int asus_ec_kbc_notify(struct notifier_block *nb,
+			      unsigned long action, void *data_)
+{
+	struct asus_ec_kbc_data *priv = container_of(nb, struct asus_ec_kbc_data, nb);
+	unsigned int port_idx, n;
+	u8 *data = data_;
+
+	if (action & (ASUSEC_SMI_MASK | ASUSEC_SCI_MASK))
+		return NOTIFY_DONE;
+	else if (action & ASUSEC_AUX_MASK)
+		port_idx = 1;
+	else if (action & priv->ec->keyboard_mask)
+		port_idx = 0;
+	else
+		return NOTIFY_DONE;
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
+		 * SEARCH: RIGHT-META [E0 27] -> LEFT-ALT   [11]
+		 * MENU:   COMPOSE    [E0 2F] -> RIGHT-META [E0 27]
+		 */
+		if ((n == 2 || (n == 3 && data[1] == 0xF0)) && data[0] == 0xE0) {
+			u8 *keycode = &data[n - 1];
+
+			switch (*keycode) {
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

