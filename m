Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E4A349B1C
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775095191; cv=none; b=E7s+FO2iJIKXq5S2Wpdzp3Hvuq8fMDaoi17E/hPR2JEfyLy55CtOTJIvgpFLLSVEZT0RsrAWgScQ51Xawjqp4KDLw/8+KDMPb+j5Nh/4KH01TAuvmp1NQo9RVLBwJMkKQyxtzKf840GOaeSUDWTFjMNuWBwkuGY68a7/HEBuUTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775095191; c=relaxed/simple;
	bh=kCXFWP6q7VRlod3hAJwQuCfya5h/Q/xKdqbSjbVDbVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsh2uIOfzRS+KcWexDKc2LfwZbOHp/NfR8Jma8rZ8BSWez6oL14h4203y4vanSP14YM5XncLpe4PbYf8IKcbOwaZtYwM4RR61eYP+MefgQX4W0/rWR1r178VLVL5NtbIA45XdhVmqlzdd28goLgkS4W6mtk67SVBVFQj/AAQEpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PncTnOMO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PncTnOMO"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b23fcf90b2so2968075ad.3
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 18:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775095187; x=1775699987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADOckTKec790d3noJR2HqtEZOwwgU6ZvDblTuQ8Ardw=;
        b=PncTnOMOUKIkvdgdWr9fDe6kn+Nf2Dp9u1Mp2G6uJ/Zks4sE4A6BLBr4zlzdnbCABU
         arsofUetTQkMyNuPRToQcY/qtTnM7BDOt5eXS/cB7pUlR0vAm2LmeZagDOWyQan5n+TY
         d7oLE9URN4EOErbGhh6b2luHD7b74G/BXJXtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775095187; x=1775699987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ADOckTKec790d3noJR2HqtEZOwwgU6ZvDblTuQ8Ardw=;
        b=jqdgPO6fJ6WYsmdyuvOjkAHKw4hxkLWeeoOPInEKwa/SaMKhmNx1bYQTyDaPxPk6fW
         uK0THZHLjKl29oCmR+M8c5btzhLpU3ALcgLgqZuU+8zdzpSUi0qk+Gd6mSA4DO7CiBKa
         QzAwBmPmLdbB0MAfHn3ueQKrroGCHGq64LObiYdnmT9fqGgOTftqFEZNWLzGji+nmCTI
         TkgVSxmf/0EQ9KQLs0/UyFVOD4KGd91y3H6F8nSWR6oE66+HWeC1oFyWGanpDo863MZb
         eMEG1Mvwqh5JnlCI+xHs2gfmpsGBUE4ftHzXpcH0jiK/Gp+6cOezQbiLd2kJxpuNF5r6
         QMYg==
X-Gm-Message-State: AOJu0YyzeFuSbW3pjjbu+5PK1PxDFGNJaAwy3Npff7OddTgjLtOeSgK8
	+AAQe6o5BLhq6N+tTSxpJ+kKzviOqsybuByMDsNj3pD0yXOfr0L/uJCI8vjqJGb9mTEbypPCK8Q
	+l0s=
X-Gm-Gg: ATEYQzyCD3tb+0aKmtiT+6W2tAinzRTvQVE6KgG0q2myCwtunP38w3hDUiieeOu8VPG
	WppAkiPxcEu+ZGSTThGkHxcDobp414qSp6GTM1vGWHGxjvGs9R6eZXWeV7w60+x5qpDv7atnLoN
	tcIzBYO8UGgwsqWo0+tdNo9oEMr8XFlakOBDMIQSxtRFOPCxByjauXrNX1eRMrANv6VA2zd5n1i
	rZbE+up1BX4StEErZbQRLJI0muDySj7rqpHNoR7FBTm8NhnkoRRA97d0k+uVfaga5CGZdEbd/O2
	PRgQZfyxMv0u/dt00CB3eTRIZ3v4l+faO3BH2VRVTJ5OqrPNoPne7eC9w0KF+bdXeLZM3DLixus
	1ypw76esSG7+bDmjPbc9sOXFBmbycdn/p28/RejVlPyGwapFLYLgUNq5JdmLzpxP9ofCdtmq/ZI
	g3/yJXJuOlUu+boy8EQPqsgH+fcvCy6HJI2oVMH/nOTKQGc8D5FiiLVl9HXV6JWFHzFFDk9A6Nh
	p9AFTPewLl2yyNFDmSXA5DUkp8WAf/Qgg==
X-Received: by 2002:a17:903:3807:b0:2b2:50bd:83b3 with SMTP id d9443c01a7336-2b269a8c61cmr55995685ad.10.1775095186935;
        Wed, 01 Apr 2026 18:59:46 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478cb4fsm11187535ad.29.2026.04.01.18.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:59:45 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Thu, 02 Apr 2026 01:59:44 +0000
Subject: [PATCH v3 07/11] HID: spi_hid: add ACPI support for SPI over HID
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-send-upstream-v3-7-6091c458d357@chromium.org>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
In-Reply-To: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
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
 Jingyuan Liang <jingyliang@chromium.org>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775095180; l=12288;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=+z3XgfP7gaQKNpPG0pzbt5WpGtYXleKwSkc9YuyC0Qc=;
 b=KyjFsleYgB2Cu7t86FhoA5eQDnIzDp4k4NwkHy0U3nEC4MbwZOFGuustLrlYFodv2xxOgoxvE
 SC1Ru1W/4cAAzCQdkv4Faag7TUIHvd86mLzRAn0PFMLptfTT4mkGvgs
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Angela Czubak <acz@semihalf.com>

Detect SPI HID devices described in ACPI.

Signed-off-by: Angela Czubak <acz@semihalf.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig        |  15 +++
 drivers/hid/spi-hid/Makefile       |   1 +
 drivers/hid/spi-hid/spi-hid-acpi.c | 253 +++++++++++++++++++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.c |  26 +---
 drivers/hid/spi-hid/spi-hid.h      |  45 +++++++
 5 files changed, 315 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 836fdefe8345..114b1e00da39 100644
--- a/drivers/hid/spi-hid/Kconfig
+++ b/drivers/hid/spi-hid/Kconfig
@@ -10,6 +10,21 @@ menuconfig SPI_HID
 
 if SPI_HID
 
+config SPI_HID_ACPI
+	tristate "HID over SPI transport layer ACPI driver"
+	depends on ACPI
+	select SPI_HID_CORE
+	help
+	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
+	  other HID based devices which are connected to your computer via SPI.
+	  This driver supports ACPI-based systems.
+
+	  If unsure, say N.
+
+	  This support is also available as a module.  If so, the module
+	  will be called spi-hid-acpi. It will also build/depend on the
+	  module spi-hid.
+
 config SPI_HID_CORE
 	tristate
 endif
diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
index 733e006df56e..3ca326602643 100644
--- a/drivers/hid/spi-hid/Makefile
+++ b/drivers/hid/spi-hid/Makefile
@@ -8,3 +8,4 @@
 obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
 spi-hid-objs 			= spi-hid-core.o
 CFLAGS_spi-hid-core.o 		:= -I$(src)
+obj-$(CONFIG_SPI_HID_ACPI)	+= spi-hid-acpi.o
diff --git a/drivers/hid/spi-hid/spi-hid-acpi.c b/drivers/hid/spi-hid/spi-hid-acpi.c
new file mode 100644
index 000000000000..298e3ba44d8a
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-acpi.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID over SPI protocol, ACPI related code
+ *
+ * Copyright (c) 2021 Microsoft Corporation
+ * Copyright (c) 2026 Google LLC
+ *
+ * This code was forked out of the HID over SPI core code, which is partially
+ * based on "HID over I2C protocol implementation:
+ *
+ * Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+ * Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
+ * Copyright (c) 2012 Red Hat, Inc
+ *
+ * which in turn is partially based on "USB HID support for Linux":
+ *
+ * Copyright (c) 1999 Andreas Gal
+ * Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ * Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ * Copyright (c) 2007-2008 Oliver Neukum
+ * Copyright (c) 2006-2010 Jiri Kosina
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/reset.h>
+#include <linux/uuid.h>
+
+#include "spi-hid.h"
+
+/* Config structure is filled with data from ACPI */
+struct spi_hid_acpi_config {
+	struct spihid_ops ops;
+
+	struct spi_hid_conf property_conf;
+	u32 post_power_on_delay_ms;
+	u32 minimal_reset_delay_ms;
+	struct acpi_device *adev;
+};
+
+/* HID SPI Device: 6e2ac436-0fcf41af-a265-b32a220dcfab */
+static guid_t spi_hid_guid =
+	GUID_INIT(0x6E2AC436, 0x0FCF, 0x41AF,
+		  0xA2, 0x65, 0xB3, 0x2A, 0x22, 0x0D, 0xCF, 0xAB);
+
+static int spi_hid_acpi_populate_config(struct spi_hid_acpi_config *conf,
+					struct acpi_device *adev)
+{
+	acpi_handle handle = acpi_device_handle(adev);
+	union acpi_object *obj;
+
+	conf->adev = adev;
+
+	/* Revision 3 for HID over SPI V1, see specification. */
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 1, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID input report header address failed");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_header_address = obj->integer.value;
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 2, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID input report body address failed");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_body_address = obj->integer.value;
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 3, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID output report header address failed");
+		return -ENODEV;
+	}
+	conf->property_conf.output_report_address = obj->integer.value;
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 4, NULL,
+				      ACPI_TYPE_BUFFER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID read opcode failed");
+		return -ENODEV;
+	}
+	if (obj->buffer.length == 1) {
+		conf->property_conf.read_opcode = obj->buffer.pointer[0];
+	} else {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID read opcode, too long buffer");
+		ACPI_FREE(obj);
+		return -ENODEV;
+	}
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 5, NULL,
+				      ACPI_TYPE_BUFFER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID write opcode failed");
+		return -ENODEV;
+	}
+	if (obj->buffer.length == 1) {
+		conf->property_conf.write_opcode = obj->buffer.pointer[0];
+	} else {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID write opcode, too long buffer");
+		ACPI_FREE(obj);
+		return -ENODEV;
+	}
+	ACPI_FREE(obj);
+
+	/* Value not provided in ACPI,*/
+	conf->post_power_on_delay_ms = 5;
+	conf->minimal_reset_delay_ms = 150;
+
+	if (!acpi_has_method(handle, "_RST")) {
+		acpi_handle_err(handle, "No reset method for acpi handle");
+		return -EINVAL;
+	}
+
+	/* FIXME: not reading hid-over-spi-flags, multi-SPI not supported */
+
+	return 0;
+}
+
+static int spi_hid_acpi_power_none(struct spihid_ops *ops)
+{
+	return 0;
+}
+
+static int spi_hid_acpi_power_down(struct spihid_ops *ops)
+{
+	struct spi_hid_acpi_config *conf = container_of(ops,
+							struct spi_hid_acpi_config,
+							ops);
+
+	return acpi_device_set_power(conf->adev, ACPI_STATE_D3);
+}
+
+static int spi_hid_acpi_power_up(struct spihid_ops *ops)
+{
+	struct spi_hid_acpi_config *conf = container_of(ops,
+							struct spi_hid_acpi_config,
+							ops);
+	int error;
+
+	error = acpi_device_set_power(conf->adev, ACPI_STATE_D0);
+	if (error) {
+		dev_err(&conf->adev->dev, "Error could not power up ACPI device: %d.", error);
+		return error;
+	}
+
+	if (conf->post_power_on_delay_ms)
+		msleep(conf->post_power_on_delay_ms);
+
+	return 0;
+}
+
+static int spi_hid_acpi_assert_reset(struct spihid_ops *ops)
+{
+	return 0;
+}
+
+static int spi_hid_acpi_deassert_reset(struct spihid_ops *ops)
+{
+	struct spi_hid_acpi_config *conf = container_of(ops,
+							struct spi_hid_acpi_config,
+							ops);
+
+	return device_reset(&conf->adev->dev);
+}
+
+static void spi_hid_acpi_sleep_minimal_reset_delay(struct spihid_ops *ops)
+{
+	struct spi_hid_acpi_config *conf = container_of(ops,
+							struct spi_hid_acpi_config,
+							ops);
+	fsleep(1000 * conf->minimal_reset_delay_ms);
+}
+
+static int spi_hid_acpi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct acpi_device *adev;
+	struct spi_hid_acpi_config *config;
+	int error;
+
+	adev = ACPI_COMPANION(dev);
+	if (!adev) {
+		dev_err(dev, "Error could not get ACPI device.");
+		return -ENODEV;
+	}
+
+	config = devm_kzalloc(dev, sizeof(struct spi_hid_acpi_config),
+			      GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	if (acpi_device_power_manageable(adev)) {
+		config->ops.power_up = spi_hid_acpi_power_up;
+		config->ops.power_down = spi_hid_acpi_power_down;
+	} else {
+		config->ops.power_up = spi_hid_acpi_power_none;
+		config->ops.power_down = spi_hid_acpi_power_none;
+	}
+	config->ops.assert_reset = spi_hid_acpi_assert_reset;
+	config->ops.deassert_reset = spi_hid_acpi_deassert_reset;
+	config->ops.sleep_minimal_reset_delay =
+		spi_hid_acpi_sleep_minimal_reset_delay;
+
+	error = spi_hid_acpi_populate_config(config, adev);
+	if (error) {
+		dev_err(dev, "%s: unable to populate config data.", __func__);
+		return error;
+	}
+
+	return spi_hid_core_probe(spi, &config->ops, &config->property_conf);
+}
+
+static const struct acpi_device_id spi_hid_acpi_match[] = {
+	{ "ACPI0C51", 0 },
+	{ "PNP0C51", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, spi_hid_acpi_match);
+
+static struct spi_driver spi_hid_acpi_driver = {
+	.driver = {
+		.name	= "spi_hid_acpi",
+		.owner	= THIS_MODULE,
+		.acpi_match_table = spi_hid_acpi_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.dev_groups = spi_hid_groups,
+	},
+	.probe		= spi_hid_acpi_probe,
+	.remove		= spi_hid_core_remove,
+};
+
+module_spi_driver(spi_hid_acpi_driver);
+
+MODULE_DESCRIPTION("HID over SPI ACPI transport driver");
+MODULE_AUTHOR("Angela Czubak <aczubak@google.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index 802615565541..d48175c764b9 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -43,6 +43,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
+#include "spi-hid.h"
 #include "spi-hid-core.h"
 
 #define CREATE_TRACE_POINTS
@@ -110,31 +111,6 @@ struct spi_hid_output_report {
 	u8 *content;
 };
 
-/* struct spi_hid_conf - Conf provided to the core */
-struct spi_hid_conf {
-	u32 input_report_header_address;
-	u32 input_report_body_address;
-	u32 output_report_address;
-	u8 read_opcode;
-	u8 write_opcode;
-};
-
-/**
- * struct spihid_ops - Ops provided to the core
- * @power_up: do sequencing to power up the device
- * @power_down: do sequencing to power down the device
- * @assert_reset: do sequencing to assert the reset line
- * @deassert_reset: do sequencing to deassert the reset line
- * @sleep_minimal_reset_delay: minimal sleep delay during reset
- */
-struct spihid_ops {
-	int (*power_up)(struct spihid_ops *ops);
-	int (*power_down)(struct spihid_ops *ops);
-	int (*assert_reset)(struct spihid_ops *ops);
-	int (*deassert_reset)(struct spihid_ops *ops);
-	void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
-};
-
 static struct hid_ll_driver spi_hid_ll_driver;
 
 static void spi_hid_populate_read_approvals(const struct spi_hid_conf *conf,
diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hid.h
new file mode 100644
index 000000000000..f5a5f4d54beb
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Microsoft Corporation
+ * Copyright (c) 2026 Google LLC
+ */
+
+#ifndef SPI_HID_H
+#define SPI_HID_H
+
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
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
+int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
+		       struct spi_hid_conf *conf);
+
+void spi_hid_core_remove(struct spi_device *spi);
+
+extern const struct attribute_group *spi_hid_groups[];
+
+#endif /* SPI_HID_H */

-- 
2.53.0.1185.g05d4b7b318-goog

