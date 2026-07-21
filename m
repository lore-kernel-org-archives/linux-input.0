Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76644C67F
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627597; cv=none; b=gJUpELzU92mYHeeTqJl48MmDJWbhjMEVZVcZb7mXh1bb3B+Y6milMziNkr6QDmpQwVUYS9Rk8jeUsW+KOBLaWSrNPtl7cAmLUnvoL/fj4SvQmGe6xD2hkgzk6kTfDIB0D8Ed2Aykm8eSDqsRk9LmO41R3Vz+5F33SbjQZrcfQ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627597; c=relaxed/simple;
	bh=WKmMyVJmmm3/p6J2LsRvBrQbLiDxoyq8N/mTapyKyU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MghwQ5SbWJmYzVxwe5rNymFcsp52zw8MOPgFmtZMXaE2QgJFFKxnTE81yRyzBH++j90WRi7t9f9RxmPdxab/wh4o1v3YqVZ8TYi2+afWAfMf7tf4DawKv7GHRdeogNHrsrWkExsfaMiNXSq3+tyE7QCV7fhuSGsJ9VId0tE1E2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4lAs18R; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4lAs18R"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so24470645e9.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627593; x=1785232393; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dzLAVPMJ+xd48Qvd/jRYNAR8Ds6btdovTB3v7WFVom8=;
        b=M4lAs18RiWvtV9SeMgYjGewLh0gy1LfEnLF5SKHnmc30b1aYclJzcrGHFWC+WpMmEZ
         X6wldj6KoPlKqojAxTXhFaK5fXMHIUvda+XuhwCUWBXap9p4IGOhr4zV7r/WEgPAq4x3
         tnsohwkA6yCxn7NMKFQ/DN/7eFJqbyuIrkSWJqsYN961KrIwIrRN3B/vze7zymRUyerv
         eafgkSShyCXpJvnL3K8bfvf1iGxjGlVd+yaIfRWou8w4t1S08VSAYDxv2ys27EGoRPxC
         a1/4GTZFXKop/QgD9e3gRWQdUz2+5/xxE899CAwD1a1pYKnFil7D64hpSWJgjF5w68B6
         9axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627593; x=1785232393;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzLAVPMJ+xd48Qvd/jRYNAR8Ds6btdovTB3v7WFVom8=;
        b=I9APX0WHpOy0ybcjkCKmWFm+Q7Q6/f02lkTEguYiNtRRxIIQQKax7j8q5/B6wvZHPU
         Es3hPM1qEPGz0f3Rf0doGZyzdgaGd5wlOebuPJTpBY+010O+dH1jXabDrHdNVmKiD4QY
         JJXVEt9HZWTyE1j4Cm0dpzXUupBlx89TeF8Blnp7Z35ZcioWGPBAkopdv4aCwOrKbr99
         dYUrkK1WIi165beSMEQzXSWSxukpdG/sAHQuyzaS1xJrQrOI0tNCqFYldmx1iPAnSemC
         +zpXSR2ZzE0yC4vagTE37dDlRo7GzYgN2wWKyh5l1ZfVV5htmllTbaHSsc4lq45hZ2Oc
         QyDA==
X-Forwarded-Encrypted: i=1; AHgh+RpDvFckv35jYPmIJ/ctBNAGfTLRWt37nFFLkLCKsN6Y+C+jIAxxEv0XTDv2eyxK9QmH0cdCtJ8D7pRcow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNbd4vGQUbRWa1xLlG1lR4xHHcukVgoG0kAG5vEM9/wo+KP5LW
	P5aEEkAtlG2NthBp3I3Uc31L7FU5Pgj0NYKTOi6+GA6zHndT4O126vC1
X-Gm-Gg: AfdE7cklaFCEEaqrL7YB/1TF4Q720MHmHi7E20XRjJg+s1j7LQvFCEF5lKqucVnziNS
	u158ak7fAnAbkrNt6eU4UKDz9yCZmpnsu6AXbH4EwiAjlBJfZDkcAll34omDelWNxbyuMG6apg5
	RTnm83teEEi0MankC8Ai4gko8CR/6QNTPikOgRNZaEU986uN5YyafmrZo6ZUa/1Ck7Xw7p45Gb0
	bdr5GQWBNS61ZL4Zjg3G12OQa8RKDC3iD7JfOk17ARQODXOBz3F4Agnn8PkzQuoFlH9XFbbpb2K
	T3bwsRv9cLTYhkLlRs2WrEWJHEj+7A5mIaaLqh0gAXA0abx71mNY+130YwS7+3Uw70BQ8HVerZC
	sUlM5irZitycVNq+6ZZvX7NS/eTo1NMpD1gBhSc9OE2UoQUDQFrvf3mnQbbhr6t8eOEvx+/Nkkf
	i7HErsNYkiinzlu0/9y8VkY+4=
X-Received: by 2002:a05:600c:19c8:b0:495:6134:6d61 with SMTP id 5b1f17b1804b1-4956202554emr66612155e9.19.1784627592871;
        Tue, 21 Jul 2026 02:53:12 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49565482c5asm82834285e9.10.2026.07.21.02.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:53:12 -0700 (PDT)
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
Subject: [PATCH v10 3/7] input: serio: Add driver for ASUS Transformer dock keyboard and touchpad
Date: Tue, 21 Jul 2026 12:52:29 +0300
Message-ID: <20260721095233.420823-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721095233.420823-1-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
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
index bacab1f584009..efb5aa59c364b 100644
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
index 0000000000000..c6d12c44449d0
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
+	 * must not exceed the EC entry size.
+	 */
+	if (data[0] < 2 || data[0] > ASUSEC_ENTRY_SIZE)
+		return NOTIFY_BAD;
+
+	n = data[0] - 2;
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
+	error = asus_ec_register_serio(pdev, 0, "Keyboard", 0);
+	if (error)
+		return error;
+
+	error = asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_AUX_SEND);
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

