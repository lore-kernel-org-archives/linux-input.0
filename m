Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4B332EBD
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375367; cv=none; b=Sg+ZgWJTsGW0L4CbpE9584rezU/+x56y17B2AyCWC3y0FIvzZxdPvYbVWYtAahFekGhucCq5+mHMV8ZPb9tPZasUiQKJjbpdgOcASHXTwpcytbX8msFcYwO3dFDpWDJi2gGQG6xMHo8+0ZfES4pDcmHfRBgFmFjO0IjPYMJdHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375367; c=relaxed/simple;
	bh=iAWv0A6q+CUyWdP3lyvQ+6bZid6jgphfO9Ltcb9vw9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMqOtmnxeAGVOtaDpZIiDf9B5vYjLoYJfGnWJQj+zmKSrMTsoA6w8UxtfQlMj7tgyFj+ts6Z2jo6cPE+4y0fKufa2EFLihGj06191KItWTUbNJJV748d6YfUuAaoMibPvOa0tygz/NWKSLEaD8y0c4y/n2CxEKy/geAxBj+/TtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp239ZMs; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp239ZMs"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa5edf347eso1337857e87.3
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375364; x=1782980164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGo625p3GtXwmedhKgT6604w6JvdgSETy0kRYi4ikK0=;
        b=Gp239ZMsvQBmwtX5/pWaTtRClpwrGSv7Yt4AkUH1wWrRmjPyJxkzJ6RAHuJ2awwctk
         yRR8kqnvQZB3QJnkC7YdBa/HXA1dDo1TIKx+ByqB49yizE3nfY1WeAOKNJgawZsVCyb7
         sAPZ/Aft4MjVmeXMn5YggjSbgOuu92vowWE2GTC1uPIW7TijsNP/Go7+EiTTCvqlCjsa
         b/LBTsMw2NHbCfjFOky/jObwK6TBq2ETJhJTq+xmzBo/OWv5lTeW1Cv0fJG8Gxrjp47H
         pRkU0q9liFK+gXklBiGrHjcHetR1QZYKmfmR8t18ZZUlsAkuG1OkTA10rjw32QhjE/DT
         nm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375364; x=1782980164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGo625p3GtXwmedhKgT6604w6JvdgSETy0kRYi4ikK0=;
        b=ggErwAAzCDZVnQ4+BQxSuhF9C1+lG66oKUzTMQhUQbUo1WO2v00SwFOmz0OICTJzh7
         QgexzPueiFWcLmaCV3JWoW+f8HwS6yjTqtA5s+C9UAOkec3MvceWI763F5ScDCgA6HG4
         xhqOy02OMi1t0dmMrzPEwT4zD8Bp3dF0M6XRiyq/CY7U9s3xpBmhvnIhDgvz2DvoysOr
         RyZIA1Msoyjp4UD74xU/Meu44+wmGLs7rKrpBbllSIbgITfOevPT0uQzfHaSD5Wsgg+8
         GZ/gCsc8zSavNk3RADhfSWB2lES+WsZ31Gr7S8X2gMwSrCO4nQTTBHD1dgbLArbLfHbS
         MqVw==
X-Forwarded-Encrypted: i=1; AHgh+RqxprmDbtTESOE3QbAGV4t4UcUDdj0XtvhtXOSGKyrp62f9Zqt804EkX/+mI6UqeOx554QSaDQ7t6Of6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO2CCLP8e7+OyFs1R0JU0UdzgShVTQLyg6DSomLyk/dL8FK58/
	DdJyPIwQaSQUyETtsIentdtDw0jXkIcaD97Q5zk5U+2ax/WN5E3txAxy
X-Gm-Gg: AfdE7ckTpKb71fK9OoN6pvu43kS6ap6zL2odrpooe0uYIwOtrBtyLM4jp/I8m3G+hKv
	VMnaU2RsGjqpxV+JZXVrxj4DGLp+iApUcHU4dbZvoxC3XyS5lGlVGxxGbsOsMoe4xngFfLdb/od
	Lhn7pwPVcv3/1CbMAkPNIBp22S7dM8o0bP/tItMIdQDpxjDOxw7DJSnmytKDq9PLWBlQstqxMm3
	9NtGez+3CQj+SrykaitRQZ9VJXytmWTQ6h+Jgb1x/WgiaeCZxc8xnOb9EMnWWca7Ol1CdSQewJn
	NVxd6Xqyh3QoCEsJpLjDtlpdIUjrmwxp02rC+cD6RKhZLvZfVgzKzTFTBzpWha5OKZfeoFDJHMW
	2DaH7ZRCVToyznRrRlIxUSYeKEm6aBOydnsUGq4936zyM8Z66i2e+16jQ3ICKWkdl3+q2/rbCtm
	owbSHmoXdBJ7seVXg0tSG823FSlrKrUDlp+Q==
X-Received: by 2002:ac2:4bcd:0:b0:5ae:a240:8d1c with SMTP id 2adb3069b0e04-5aea24094f8mr493794e87.12.1782375364091;
        Thu, 25 Jun 2026 01:16:04 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999afce64dsm39162221fa.14.2026.06.25.01.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:16:02 -0700 (PDT)
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
Subject: [PATCH v9 3/7] input: serio: Add driver for ASUS Transformer dock keyboard and touchpad
Date: Thu, 25 Jun 2026 11:15:25 +0300
Message-ID: <20260625081529.22447-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625081529.22447-1-clamor95@gmail.com>
References: <20260625081529.22447-1-clamor95@gmail.com>
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
 drivers/input/serio/asus-transformer-ec-kbc.c | 168 ++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 5f15a6462056..fad29b950309 100644
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
index 8ab98f4aa28d..fedc37ee102b 100644
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
index 000000000000..3ddfa9925b2b
--- /dev/null
+++ b/drivers/input/serio/asus-transformer-ec-kbc.c
@@ -0,0 +1,168 @@
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
+	else if (action & (ASUSEC_KBC_MASK | ASUSEC_KEY_MASK))
+		port_idx = 0;
+	else
+		return NOTIFY_DONE;
+
+	/*
+	 * The data[0] is the length of the packet including itself. The data[]
+	 * buffer has to be at least 3 bytes (length + ctrl + 1 data byte) and
+	 * must not exceed the EC buffer size.
+	 */
+	if (data[0] < 2 || data[0] > ASUSEC_ENTRY_BUFSIZE)
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

