Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F83DBD4E
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650692; cv=none; b=aSzj0TjDjKjOMV7NnfhzrSk/SOdG4EmNcSe7E8SKXtz6omJkBE1tzDuCtCVgkxK0e8txHlUVLyn9h02IOc9HkzzaZ9BCdpr4OG3RoxhtTiog/078amlBpEvKBH9II/7Kc/377DetxpSvZ7NmFKGJuZGwoODOHNsKbs7xpJ8makU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650692; c=relaxed/simple;
	bh=LOjxMtUEiS4cNMWq1QoDk6BPRM0HvYSyeLI5k5nkNkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hs9FcAjNcOJmr4zpKLlyLYL32f7owmftOQ2fdlnoe7LHdb7QSdi4kCwv0pFLLWtVg1OCT7aN0mVRQPjck2g9J/wRXDBCvQIKfq9mhiP3/W5fwOodQHfsJsW9lEfflXxIVSNTn7Z6c/ZDDGjIC6W0rXd/3edNL3K791xFCnyoajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3tIqnfK; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3tIqnfK"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a33a542aeso2963691fa.3
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2026 10:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772650686; x=1773255486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNOE7jd4qzR4EDDWV5mqgo/ldDWXaWc2vNzYIUVYGLw=;
        b=U3tIqnfK6gkeE5YaFC2VhekSRhAaajtqSezo/ae+4TRPMEgwTYordw3tie60+eu32K
         dcpLN0QxkfIAm+juNSM6MdRQwuaP93uJNS8PVAMTM655HsQ1O419cKrvJH4DoAD5cPkY
         ybYtRnNo3HcBNl87DawCdbx0rzlQXkgGqVumMF5Ccln3EU5XYP+GfidHsIIb8468zapj
         CR05XHODUJYIewPoHAu6ZvsMzvQXLbgPw+qkFqX7hBb49JbuHtohhTdJqbrFDCPTxVDS
         Rj29CC/a+GFlNm492Fs3hwRMM8FtCFQmKRoQkrzyjZi6vNt++NyyXv9Rh2/3vVbnWtUL
         DT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772650686; x=1773255486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DNOE7jd4qzR4EDDWV5mqgo/ldDWXaWc2vNzYIUVYGLw=;
        b=GLQKaHlCTRyO52A0FNPpXLQGblrt4n7p5XIa15S/gWgqf9naEu5HBcNTrl+L3hNN6x
         G/cvRqfOp5n9PstwctsCaBMiJoiiv2T5+t0rJO6HNhmNTE06UM3r17f4ybDTBL2/wXhj
         7fBWSsBJFhCrtccTA0YNtCVAaqzMenqCmfcU8z0kUpWyldnjFuoE26avn/ZGO8+z0xuU
         oz6gAhh+SfCd6feaF83aAmPcU3IyrhEkuIQGzsXFXM0RNzV701Ub4hOamwaYQXHSCzFy
         H117hWCWox6HjcfERihZjUe1FhysL1233NL0g1Uuucl0sC/Pjbk18uk6P23t4pHm2dK4
         cHMg==
X-Forwarded-Encrypted: i=1; AJvYcCVwvH1E9i4HYMs4fqa8/Fq/zzqmhuIYsplOE9Vtl6s9h2USMz7FLUZYezYnKapQFXgsT5ZYVE9hrpiAaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2h9JQCtXunEGudiG2D4Hr1PxxFc1E7VoFGfowH7a5qb1zFyBU
	0ek1Ghs+RTKQlKRRwtPP4zZNxfokAOL0tW0tSd/NglRW31w9xhIqvnNY
X-Gm-Gg: ATEYQzyGujz34d+xTdVIK/m802y6Um6Mc+aK+Emxwl1cQfCo5Bm2FFgI7Hsv/h2DoMK
	OMjWnSJppKer5LFgf9+gT3aXdChn6Hz6WL0ofINa5eEhP7W/ihFexKJEVFo4H6dn0LEO83lW0PO
	u8eROqJlVFSo1eN/9rLK23rbS+a6JOEw8lpUcq5xeu9VDqN2cDC/yZoj5iYdIHh7tQA1tAsuo+i
	Krqrzv8LfTBlIY48U7jfmdYc1Rw3NGWH9xmrdaj9CGPVs7OUzXr8lSHuOILYTYgYqF+c/vQW7yk
	qj8itER/CzfBPd/aiBpvxMJkhZD2P+8i6U/roOlx7/roFb7D5ZMEi7SyacG0p5/6AgJUoizHv+5
	WfOAOiQkbY5CnAnSxX3LmYG1hnMJcr3nYvfjklhdMRzgX8YMOCOO/JLZ1ugYdSQEC2qryF+8Wil
	8WQ6y85Ha9QYfE
X-Received: by 2002:a2e:b88f:0:b0:380:c72:d495 with SMTP id 38308e7fff4ca-38a2c7d4f0dmr26972481fa.32.1772650685991;
        Wed, 04 Mar 2026 10:58:05 -0800 (PST)
Received: from xeon ([188.163.112.72])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12a6ddd3bsm704985e87.0.2026.03.04.10.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:58:05 -0800 (PST)
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
Subject: [PATCH v5 3/7] input: serio: Add driver for ASUS Transformer dock keyboard and touchpad
Date: Wed,  4 Mar 2026 20:57:47 +0200
Message-ID: <20260304185751.83494-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260304185751.83494-1-clamor95@gmail.com>
References: <20260304185751.83494-1-clamor95@gmail.com>
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
 drivers/input/serio/asus-transformer-ec-kbc.c | 147 ++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index c7ef347a4dff..1ca17ba632cc 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -97,6 +97,21 @@ config SERIO_RPCKBD
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
index 6d97bad7b844..9ecf0d011863 100644
--- a/drivers/input/serio/Makefile
+++ b/drivers/input/serio/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_SERIO_CT82C710)	+= ct82c710.o
 obj-$(CONFIG_SERIO_RPCKBD)	+= rpckbd.o
 obj-$(CONFIG_SERIO_SA1111)	+= sa1111ps2.o
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
+obj-$(CONFIG_SERIO_ASUS_TRANSFORMER_EC)	+= asus-transformer-ec-kbc.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
 obj-$(CONFIG_SERIO_GSCPS2)	+= gscps2.o
 obj-$(CONFIG_HP_SDC)		+= hp_sdc.o
diff --git a/drivers/input/serio/asus-transformer-ec-kbc.c b/drivers/input/serio/asus-transformer-ec-kbc.c
new file mode 100644
index 000000000000..47fd6e48c989
--- /dev/null
+++ b/drivers/input/serio/asus-transformer-ec-kbc.c
@@ -0,0 +1,147 @@
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
+	struct asusec_info *ec;
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
+	n = data[0] - 1;
+	data += 2;
+
+	/*
+	 * We need to replace these incoming data for keys:
+	 * RIGHT_META Press   0xE0 0x27      -> LEFT_ALT   Press   0x11
+	 * RIGHT_META Release 0xE0 0xF0 0x27 -> LEFT_ALT   Release 0xF0 0x11
+	 * COMPOSE    Press   0xE0 0x2F      -> RIGHT_META Press   0xE0 0x27
+	 * COMPOSE    Release 0xE0 0xF0 0x2F -> RIGHT_META Release 0xE0 0xF0 0x27
+	 */
+
+	if (port_idx == 0 && n >= 2 && data[0] == 0xE0) {
+		if (n == 3 && data[1] == 0xF0) {
+			switch (data[2]) {
+			case 0x27:
+				data[0] = 0xF0;
+				data[1] = 0x11;
+				n = 2;
+				break;
+			case 0x2F:
+				data[2] = 0x27;
+				break;
+			}
+		} else if (n == 2) {
+			switch (data[1]) {
+			case 0x27:
+				data[0] = 0x11;
+				n = 1;
+				break;
+			case 0x2F:
+				data[1] = 0x27;
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
+	const struct asusec_info *ec = port->port_data;
+
+	return asus_ec_i2c_command(ec, (data << 8) | port->id.extra);
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
+	struct i2c_client *parent = to_i2c_client(pdev->dev.parent);
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
+	port->port_data = (void *)priv->ec;
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
+static int asus_ec_kbc_probe(struct platform_device *pdev)
+{
+	struct asusec_info *ec = cell_to_ec(pdev);
+	struct asus_ec_kbc_data *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->ec = ec;
+
+	ret = asus_ec_register_serio(pdev, 0, "Keyboard", 0);
+	if (ret < 0)
+		return ret;
+
+	ret = asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_AUX_SEND);
+	if (ret < 0)
+		return ret;
+
+	priv->nb.notifier_call = asus_ec_kbc_notify;
+
+	return devm_asus_ec_register_notifier(pdev, &priv->nb);
+}
+
+static struct platform_driver asus_ec_kbc_driver = {
+	.driver.name = "asus-transformer-ec-kbc",
+	.probe = asus_ec_kbc_probe,
+};
+module_platform_driver(asus_ec_kbc_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer's Dock keyboard and touchpad controller driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0

