Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0D032B110
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980090; cv=none; b=LHXvF6zBMki2Hp/8TWA1R2HZMgD8KiFi6IK0at2YnybwLjQMBhTaNy6JEWUW5Z+UL0JcldVfU9HbgM2mfsSs6p3B12MO1BAYFK7zb5U2AFRUJCsDdwip9RCSQ0fFxnxmzxbvwcTCxd+Ir9OeqjCWNLwOv7qrsIZi24KmeEF0arE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980090; c=relaxed/simple;
	bh=1PmMFWa+4Uc2cG3vazlaFXkv17PoaHFqa/UZ4G0vpxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DC+10J+ThbQcMHli0/8CfCsNXk/90ptEguGWCaiBmAdaneIOwzEjdLyCfHhiN+wOoWzpk9M5M/hx9gb0nOufWh7XV8QnYSyg5KNfEw0U/dBioo9qZJH7bPh439+rtHVS7mOUn12v+N/9xt3yfEXEqye3MZCVinJ9XoXSg5QaoOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NYc8z+G3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NYc8z+G3"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c2d792c8so33855005ad.1
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 21:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780980087; x=1781584887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbL9o+HKDyj5no9OHzF6vn3WvXZ4hfH3COgoBu9DwFc=;
        b=NYc8z+G3GT1/jt+G7wZ6hts4j+CX22Gujbg/7LoxXrMdcDnAmScIjmDQNCk8DsP8dj
         twXE0/y7lOniVy/cAYb90cSa/JzncVqmAPRzETQZvRElgX+qR9pS7E0yvuxLfvLHKIE3
         D6r0+Qps/pkQsEVX+pglLHKWIqXsAlovp28pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980087; x=1781584887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VbL9o+HKDyj5no9OHzF6vn3WvXZ4hfH3COgoBu9DwFc=;
        b=ApHjY23sslMdAJtfKMQz9A2+mr7EDRiHEiX19CL0vauqLr7cFtwISxFjBC74dEA/4Q
         lnHjUPrEe/Pz26RI6FTxe6yuknjU//c+ValEeDzyN+ylfMsuP7qZzzYmANv6YbJatbmI
         CeG60NrhnElLpmlvsxCGB9uL3yiyBD/5m/jM2QqTMfyu66ifnrhQr/jUBv/pRJcOtYQa
         /rild5SdaYfHfnhQe+D4UXLhqUFFJmJli8TbU7SToERwfQkQHVTez/7zZObrdPtHVnWP
         CswGkEwEbG9ILhxCgQLg+Y7oZaHoea+blprHO0VWW3g1NajxnQ20z7dS+BOBi/7c+sml
         X0/A==
X-Gm-Message-State: AOJu0YxURPYkKYbJf1ILBGlh9NUAQKNTVRNgFH/z6ttrfI0ActdnyFzt
	kuDmzjU0xDUT8Nr9z5Pxezvlh88KIO1iHVjD2Oi/EN78CRRPF7HZ5f9gOt/HNFi5sQ==
X-Gm-Gg: Acq92OFNrK+zLfhoVv38jW334rPC1yKt1V/vfK1pVgUiHpqUPiB87QoROdsA0l92JRv
	5jroDr/MTs04h/EqJQAbP4LISgmWJhUgVGNnedQQn0w93SFn/spBoYh2kK3vKP+jbU1X7w71a3r
	sxNW7MCtM2NGd6Xc1mZgKYcM1u2ucGm6yCMHGyWQjw0k1cuBb2UsWbFM57lEFnxLVT72XXUuFJy
	J+7kyrolIkfdYNyMySRqvOl8Fc7xNBrbs+NgiTMSrI0uGdwz+sSEL4gKOcWRSr49kJBys8F4TJq
	Ctd6oMNmiqL9IxPfRrpJnIhVBS24BFz+ZOK/rQZyR7XI6XwJ9GvfQjFHerivdiqMuSYmMsrfprA
	KuOzUhdokIN1hZ7KDs49s4Iqa+Cfkw4q/hVXoZ2KFIoNs56+vONL/QxtP1YqqVhOcxjRy2U7fZh
	GsoBwRwF1QrP/xGMpvF8Lc/8lN/1hh4eAhsVI9XHhIFT0syEOqvj+MxJPZv9+spZebdWocn83q2
	okVuzh38znCy0lSQOfl8ptcGvB1KYTuzM1NM4Pz3i04
X-Received: by 2002:a17:903:4407:b0:2c1:d49c:8398 with SMTP id d9443c01a7336-2c1e78df934mr210656475ad.8.1780980087101;
        Mon, 08 Jun 2026 21:41:27 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664a67b0sm200736065ad.80.2026.06.08.21.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:41:26 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 09 Jun 2026 04:40:54 +0000
Subject: [PATCH v4 03/11] HID: spi-hid: add transport driver skeleton for
 HID over SPI bus
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-send-upstream-v4-3-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
In-Reply-To: <20260609-send-upstream-v4-0-b843d5e6ced3@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, 
 Jingyuan Liang <jingyliang@chromium.org>, Angela Czubak <acz@semihalf.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780980084; l=8516;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=8bBMUiMsVviaZgwuzHHEU3X1NGILbYyeA8p+dlIeuvM=;
 b=xUHJTZWf2/3aRrO9eyO+0GWkwrsElzBwxx80EM+S+nBUGj8ysPWKIWDTrfy5CAomOBK6nGr7k
 MnlNW59l7syA3Bh8EN0sb3IlX4VtzW92U8Sk76xezBmY/+Ik+YU7y38
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Angela Czubak <acz@semihalf.com>

Create spi-hid folder and add Kconfig and Makefile for spi-hid driver.
Add basic device structure, definitions, and probe/remove functions.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/Kconfig                |   2 +
 drivers/hid/Makefile               |   2 +
 drivers/hid/spi-hid/Kconfig        |  15 +++
 drivers/hid/spi-hid/Makefile       |   9 ++
 drivers/hid/spi-hid/spi-hid-core.c | 213 +++++++++++++++++++++++++++++++++++++
 5 files changed, 241 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 920a64b66b25..c6ae23bfb75d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1434,6 +1434,8 @@ source "drivers/hid/bpf/Kconfig"
 
 source "drivers/hid/i2c-hid/Kconfig"
 
+source "drivers/hid/spi-hid/Kconfig"
+
 source "drivers/hid/intel-ish-hid/Kconfig"
 
 source "drivers/hid/amd-sfh-hid/Kconfig"
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 361a7daedeb8..6b43e789b39a 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -169,6 +169,8 @@ obj-$(CONFIG_USB_KBD)		+= usbhid/
 
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
2.54.0.1064.gd145956f57-goog

