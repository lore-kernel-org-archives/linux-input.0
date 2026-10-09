Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313E3CBE6D
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584803; cv=none; b=Xw/oiincj+89UZbYZhDBTbFb3zvcoKqmS0w/Nvw0smXPAAVtZw9KWnKZ46bnwLC97fZodq2GOPIxftC7YTX6j3pQYvF67XvmNt2l+fQpd9c3mwonwhcKi6FBk17iCmsuCxJRzrAKF0jnXjNEbmN1kxsafHnfZ/eNCpeIfyxBn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584803; c=relaxed/simple;
	bh=BBmH1dFN43VQNclnRV4atNEYfVS6kiBBHpOCUrnmyBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8CvMK0bs7qb2OUwvDaUWQBjT29pVXtA4fg/tbAw75AYhRNxnpr0NOJO/XKEN/iUCujf6XhaZgv5lQHS5izEhOq+C+COJvEx9AdGifrpajbBtSWcny+zEzF63Btykj0iZS7mSkcLsnBItE0TS3cicAbLyMsi8KEDoUifq01kTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nt05rODR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nt05rODR"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2db710396ffso14153995ad.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2026 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791584800; x=1792189600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+ZPVMPFed6TnJLqsJLeTtZ3eJcyECaIc2VEw+ZL8W0=;
        b=Nt05rODRao1KCUof8z3hhFotyIGza6VQmj9FxEsazuSKfcBA9cj19XmX5ge69T+5MI
         LdTKo8nb3tOjw1wUuhRt0+5DaVuLf6pICxYsTfEVo9WAppo1S7vIObBVGeuavXHXOafY
         zX3E6JhxO09t/KtQ6mhBeg+kD/dr38YHjXvkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584800; x=1792189600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+ZPVMPFed6TnJLqsJLeTtZ3eJcyECaIc2VEw+ZL8W0=;
        b=zqQaV9VX+gWfgyPbP55pPn1/kma+WpqP+jgm6b94OFkxu/vYQMHzk4u7GPPWvJmQNy
         DWa8k0gW1FL8WdVaWq8lIY8SLUyPPlYKRKfVUaX1GTnlYgaGLiNjHjqJhozn7HAtgAnq
         Nwj47nnNT+8LGmXp/I4DVyj6B6XeXqtOZcj9o5tyPcY2i98WDmAhmkAcNyJ86XCemrL9
         7JLohg+MDIzQ2eH8pzHYGZI/igTVCikFUL5uahu//Y5tMeheoJnHSaIssoVi/UXlKUsh
         dLaFDA5yVBAAAv1Jaw5E4n2gUO47KpJVkrkSFbJBUCqg0vwI4G5AEJG6S0PCS5p02J46
         H7bA==
X-Gm-Message-State: AFq9FYKtwhBXJ0fprS5AmH5EbucdPzDbUPF0oRN+bWg6Iwg222fxbTDT
	UemaL+wZo7KNXj6WzAciaIzsmSXtXs7KSgNaqWU9dE2H5zZe2gmKCutM+ehrgtfKQRiIucdSE2h
	SpDz+RA==
X-Gm-Gg: AYBFou3hqt+xdtfJY9hRsvg6j7xHVphzVIsqv69Inzi7UkAMCWK7wdGHJEigmvQwm2L
	eQFelp9noJ9DXuABMYMg20/CZavh6LwfHi2F0Gw+6wDOepQvgkBlxYRMeZ2sC6az4qLx9ool8Mh
	zjFdD/V5ScnBcq40wFM1Drv7G3v5HwoMka1bd6wlv1PMuIw5asYkEOvhEjc8kcLX5b1K0SIomCg
	HNdYFgG/1G52rqBuUKjOqKPgh0A+lSzPwhhzqsXrkRu4Cirj8/NlnZCMbkz3pJKTs0XzMpxtkzn
	UaV5azG7WcXJe80jY+XFHXfrGiaJd2QoxF7XHCUoz+9IvY5BKvEkqiIl5QKev5/iNMzbKm8MQut
	MOMVvl4RAaDpf4mOkqs+8WIZ89mFVz4RAO/pYC428VUeXayBAChi5Dygoe0ISuDWTpS5pmkWrAO
	S63z+eH6oWZt7gQP1aCaL8JFCR8UFhiEuED42PaPL4PnXgyKWhnGK5Q2RIhxEMP/Zv4Z7l5Mx8C
	Bg/4R635FQJaIbm/MvFmP86VlHgn14E6dSlcse63y6akxh8g0hxVck5CTzpUAetlOTRz+qkrO3K
X-Received: by 2002:a17:902:c40f:b0:2e8:6540:11b6 with SMTP id d9443c01a7336-2e86540122fmr9526845ad.37.1791584800315;
        Fri, 09 Oct 2026 15:26:40 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (35.152.82.34.bc.googleusercontent.com. [34.82.152.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e503sm16660725ad.17.2026.10.09.15.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:26:39 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 09 Oct 2026 22:25:28 +0000
Subject: [PATCH v5 03/11] HID: spi-hid: add transport driver skeleton for
 HID over SPI bus
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-send-upstream-v5-3-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
In-Reply-To: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, Angela Czubak <acz@semihalf.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791584797; l=8559;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=sQ82RdRNkd9xlM5jA9poGrrVf/4vhCRbRR43J1aCl94=;
 b=yqCsqFlmcm2KNOmhDjnCu7TLFnkZVXcp59E2fD117tDo4JMXpRXAKducZDvn6fMhTS7n/ze/P
 /xU1eF1IECZBzs6HciQeAiwdCtzl4KrhVphOTxn8g2bmTjP/oJXVLT9
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Angela Czubak <acz@semihalf.com>

Create spi-hid folder and add Kconfig and Makefile for spi-hid driver.
Add basic device structure, definitions, and probe/remove functions.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/Kconfig                |   2 +
 drivers/hid/Makefile               |   2 +
 drivers/hid/spi-hid/Kconfig        |  15 +++
 drivers/hid/spi-hid/Makefile       |   9 ++
 drivers/hid/spi-hid/spi-hid-core.c | 213 +++++++++++++++++++++++++++++++++++++
 5 files changed, 241 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c43e824428f0..17a42301875c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1527,6 +1527,8 @@ source "drivers/hid/bpf/Kconfig"
 
 source "drivers/hid/i2c-hid/Kconfig"
 
+source "drivers/hid/spi-hid/Kconfig"
+
 source "drivers/hid/intel-ish-hid/Kconfig"
 
 source "drivers/hid/amd-sfh-hid/Kconfig"
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 48a863b245ee..b5a7ef7f208f 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -177,6 +177,8 @@ obj-$(CONFIG_USB_KBD)		+= usbhid/
 
 obj-$(CONFIG_I2C_HID_CORE)	+= i2c-hid/
 
+obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid/
+
 obj-$(CONFIG_INTEL_ISH_HID)	+= intel-ish-hid/
 
 obj-$(CONFIG_AMD_SFH_HID)       += amd-sfh-hid/
diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
new file mode 100644
index 000000000000..836fdefe8345
--- /dev/null
+++ b/drivers/hid/spi-hid/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2021 Microsoft Corporation
+#
+
+menuconfig SPI_HID
+	tristate "SPI HID support"
+	default y
+	depends on SPI
+
+if SPI_HID
+
+config SPI_HID_CORE
+	tristate
+endif
diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
new file mode 100644
index 000000000000..92e24cddbfc2
--- /dev/null
+++ b/drivers/hid/spi-hid/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the SPI HID input drivers
+#
+# Copyright (c) 2021 Microsoft Corporation
+#
+
+obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
+spi-hid-objs 			= spi-hid-core.o
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
new file mode 100644
index 000000000000..02a7608c4b88
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID over SPI protocol implementation
+ *
+ * Copyright (c) 2021 Microsoft Corporation
+ * Copyright (c) 2026 Google LLC
+ *
+ * This code is partly based on "HID over I2C protocol implementation:
+ *
+ *  Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+ *  Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
+ *  Copyright (c) 2012 Red Hat, Inc
+ *
+ *  which in turn is partly based on "USB HID support for Linux":
+ *
+ *  Copyright (c) 1999 Andreas Gal
+ *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ *  Copyright (c) 2007-2008 Oliver Neukum
+ *  Copyright (c) 2006-2010 Jiri Kosina
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/hid-over-spi.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+/* struct spi_hid_conf - Conf provided to the core */
+struct spi_hid_conf {
+	u32 input_report_header_address;
+	u32 input_report_body_address;
+	u32 output_report_address;
+	u8 read_opcode;
+	u8 write_opcode;
+};
+
+/**
+ * struct spihid_ops - Ops provided to the core
+ * @power_up: do sequencing to power up the device
+ * @power_down: do sequencing to power down the device
+ * @assert_reset: do sequencing to assert the reset line
+ * @deassert_reset: do sequencing to deassert the reset line
+ * @sleep_minimal_reset_delay: minimal sleep delay during reset
+ */
+struct spihid_ops {
+	int (*power_up)(struct spihid_ops *ops);
+	int (*power_down)(struct spihid_ops *ops);
+	int (*assert_reset)(struct spihid_ops *ops);
+	int (*deassert_reset)(struct spihid_ops *ops);
+	void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
+};
+
+/* Driver context */
+struct spi_hid {
+	struct spi_device	*spi;	/* spi device. */
+	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
+
+	struct spihid_ops	*ops;
+	struct spi_hid_conf	*conf;
+
+	enum hidspi_power_state power_state;
+
+	u32 regulator_error_count;
+	int regulator_last_error;
+	u32 bus_error_count;
+	int bus_last_error;
+	u32 dir_count;	/* device initiated reset count. */
+};
+
+static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state)
+{
+	switch (power_state) {
+	case HIDSPI_ON:
+		return "d0";
+	case HIDSPI_SLEEP:
+		return "d2";
+	case HIDSPI_OFF:
+		return "d3";
+	default:
+		return "unknown";
+	}
+}
+
+static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
+{
+	return IRQ_HANDLED;
+}
+
+static ssize_t bus_error_count_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u (%d)\n",
+			  shid->bus_error_count, shid->bus_last_error);
+}
+static DEVICE_ATTR_RO(bus_error_count);
+
+static ssize_t regulator_error_count_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u (%d)\n",
+			  shid->regulator_error_count,
+			  shid->regulator_last_error);
+}
+static DEVICE_ATTR_RO(regulator_error_count);
+
+static ssize_t device_initiated_reset_count_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct spi_hid *shid = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", shid->dir_count);
+}
+static DEVICE_ATTR_RO(device_initiated_reset_count);
+
+static struct attribute *spi_hid_attrs[] = {
+	&dev_attr_bus_error_count.attr,
+	&dev_attr_regulator_error_count.attr,
+	&dev_attr_device_initiated_reset_count.attr,
+	NULL	/* Terminator */
+};
+
+static const struct attribute_group spi_hid_group = {
+	.attrs = spi_hid_attrs,
+};
+
+const struct attribute_group *spi_hid_groups[] = {
+	&spi_hid_group,
+	NULL
+};
+EXPORT_SYMBOL_GPL(spi_hid_groups);
+
+int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
+		       struct spi_hid_conf *conf)
+{
+	struct device *dev = &spi->dev;
+	struct spi_hid *shid;
+	int error;
+
+	if (spi->irq <= 0)
+		return dev_err_probe(dev, spi->irq ?: -EINVAL, "Missing IRQ\n");
+
+	shid = devm_kzalloc(dev, sizeof(*shid), GFP_KERNEL);
+	if (!shid)
+		return -ENOMEM;
+
+	shid->spi = spi;
+	shid->power_state = HIDSPI_ON;
+	shid->ops = ops;
+	shid->conf = conf;
+
+	spi_set_drvdata(spi, shid);
+
+	/*
+	 * At the end of probe we initialize the device:
+	 *   0) assert reset, bias the interrupt line
+	 *   1) sleep minimal reset delay
+	 *   2) request IRQ
+	 *   3) power up the device
+	 *   4) deassert reset (high)
+	 * After this we expect an IRQ with a reset response.
+	 */
+
+	shid->ops->assert_reset(shid->ops);
+
+	shid->ops->sleep_minimal_reset_delay(shid->ops);
+
+	error = devm_request_threaded_irq(dev, spi->irq, NULL, spi_hid_dev_irq,
+					  IRQF_ONESHOT, dev_name(&spi->dev), shid);
+	if (error) {
+		dev_err(dev, "%s: unable to request threaded IRQ\n", __func__);
+		return error;
+	}
+
+	error = shid->ops->power_up(shid->ops);
+	if (error) {
+		dev_err(dev, "%s: could not power up\n", __func__);
+		return error;
+	}
+
+	shid->ops->deassert_reset(shid->ops);
+
+	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
+		spi_hid_power_mode_string(shid->power_state));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_hid_core_probe);
+
+void spi_hid_core_remove(struct spi_device *spi)
+{
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	int error;
+
+	shid->ops->assert_reset(shid->ops);
+	error = shid->ops->power_down(shid->ops);
+	if (error)
+		dev_err(dev, "failed to disable regulator\n");
+}
+EXPORT_SYMBOL_GPL(spi_hid_core_remove);
+
+MODULE_DESCRIPTION("HID over SPI transport driver");
+MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
+MODULE_LICENSE("GPL");

-- 
2.56.0.385.gd3acb90ef8-goog

