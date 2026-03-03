Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA150382365
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518436; cv=none; b=CJujnxQIzXmsHDe0UGK7MnRmFBggrm/S9PRXUygeqHB51wc/oFRs/B2QgPHViKhkK/HIMYXlnq2zNmlhn5OFkWTsPUluvsKjn0Yk0xzI9pdLTyTw6ZINtZNSccXvz7aEZ9mgxMSthnJwA3ixlQvFiQpMCIHY5zxRHpN2w1jo4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518436; c=relaxed/simple;
	bh=y2Cem10Qv1YmWLyFKJBsPz4T7G43UQJxTY5IpBrrdHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQN7ScOVRfyhXXX9Oq3gO4XKuzZon1cW3bYbs7o8trmL06FcBYzU+72gbvWE+8OzrjfcUuSoFIaDLBT6XI8/F7r6PEW18CwVCwp1qqlMDtBmVSKkZVoF8dkMkxcOf6pcpM7g6n9TqaQZ2jtg44NuIN5/S2vZR1cTcUQeSqDAYsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EW7uCRr5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EW7uCRr5"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae56f8776dso10516645ad.3
        for <linux-input@vger.kernel.org>; Mon, 02 Mar 2026 22:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772518432; x=1773123232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kui0y2+cGzzQv/dC2bho3UUUq5l8OpAeevb4T+wuEN0=;
        b=EW7uCRr5knO/a8NNsKShKCWEt/yum/GK0PM24VqApBpH8plfE+ixG0fPd7g8y0NEuN
         rzu2y0pmfds+5QQwfk+4LcArl2BHSiDDugOQUHlELQcpVaZAZADOAsdfly3K6BH1xS3V
         cbmaeSMIT6VC5WH6g1b76ek8vekVGLhyVPwUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518432; x=1773123232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kui0y2+cGzzQv/dC2bho3UUUq5l8OpAeevb4T+wuEN0=;
        b=ufLT+pjDWF59r2iX9ajtIpx4BQLLpxF7WmWEG5RU+X+47V/xAoiCPxRoEmRz6tnuxy
         AdCbg7uRqk/T4EEvEq1sF5QOzys4ro+MEekxxmzdtRp3P7MJNoJK6QPw4ckuPniMcIuP
         A4DPLsI15o2v4ySWJeniERIZfrmI1rAHt69fGPpXc24fgdk1v7gy5fZLVv0lpns6R3pI
         yKYTHXsL/X7u76BJDEBDDe+Bjfzm13gqnPbm43pUc4X2yIdNHJa4IVGh6TomSaOtwGrN
         FyhS03dxq5pmALrUG0B+PFnAeMgmIOFIWtFc5S5GdRHl9WLMoNVV8biqa2vgN2VZuA/R
         goeQ==
X-Gm-Message-State: AOJu0YzD4b6eFuBT3RyYkQgtHtYNZAx+X3VQZ+WFNbMdjAGCIvt0RAHq
	K0sdxI8bFkYhFwOceqLlUJ7dHS4wYrCO8Z7iLcZQdDjtI4athbBQqnXAsBQpKUqnbg==
X-Gm-Gg: ATEYQzyjw8GMKdM49lyvw274itQQrvH/M177SxGpjrF6n1/DgJxet0C1nS2EVB7SFWc
	B5P+PHwVZguCr/PlNNxPTUyyKDxDmUcJNg8uaEo9QjBEXrNrBoU2wVM35bo67PXBb5s5YTPYn2d
	IsXJ+ePuXVxDHye0Lpy9qhral1XgUX2693QgLZNqYsA+9UvlQEdXIDRk+dytlt/LOG9KI5SnDXZ
	+n5eqtzwf/liY6ocVr6v9ObIqBt2GFhpbN6KQS6nCX42Q6PeOyaTlLuX5UeDI1csgeXYArsalVW
	9ptk2pyu74/9ce9iJCmpierbxP+wHCwMjxyExrVm0jfbFllJxhwoxmXcrjTjjA7D56tzA5OdhRs
	J61pMRj5wCI9HQKtWmoxW0RL6j+l6MLnFwHKgCjJZbp8Rm3VEOlKHdQBYjtZdkN82Uf2EPrjdvI
	wXOYUYulKHGTvzKuK7k1vG8fI+mZ2UbyHxXopPUiAjpTV+T19+NFZLrOsDHTf79+ttWmzP3lLLJ
	wODdeyxFwLVQEbS6viQtUf5gIVgNzjCow==
X-Received: by 2002:a17:902:e74c:b0:2ae:5275:4d40 with SMTP id d9443c01a7336-2ae52755397mr54277375ad.56.1772518431896;
        Mon, 02 Mar 2026 22:13:51 -0800 (PST)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm152639735ad.91.2026.03.02.22.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:13:51 -0800 (PST)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 03 Mar 2026 06:12:59 +0000
Subject: [PATCH 07/12] HID: spi_hid: add ACPI support for SPI over HID
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-send-upstream-v1-7-1515ba218f3d@chromium.org>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
In-Reply-To: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
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
 hbarnor@chromium.org, Jingyuan Liang <jingyliang@chromium.org>, 
 Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772518424; l=12219;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=SxaOYdJ5yvt0fUwumywWmbgQu8LfGh+4B6mGGyxMnGw=;
 b=9tt1vrx/7LmyNQ4Jr15LFthLcr1k6rwnK7brbp8XbLBJdjdL+nK0G7hF4JLAWHTV+MNsLL0Iu
 HRLBPCShjcoDghDUNJZyF+cDeW3x27CWyiWlqWyYSOjEwRZpR+ZN/vg
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Angela Czubak <acz@semihalf.com>

Detect SPI HID devices described in ACPI.

Signed-off-by: Angela Czubak <acz@semihalf.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig        |  15 +++
 drivers/hid/spi-hid/Makefile       |   1 +
 drivers/hid/spi-hid/spi-hid-acpi.c | 253 +++++++++++++++++++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.c |  27 +---
 drivers/hid/spi-hid/spi-hid.h      |  44 +++++++
 5 files changed, 316 insertions(+), 24 deletions(-)

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
index 92e24cddbfc2..753c7b7a7844 100644
--- a/drivers/hid/spi-hid/Makefile
+++ b/drivers/hid/spi-hid/Makefile
@@ -7,3 +7,4 @@
 
 obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
 spi-hid-objs 			= spi-hid-core.o
+obj-$(CONFIG_SPI_HID_ACPI)	+= spi-hid-acpi.o
diff --git a/drivers/hid/spi-hid/spi-hid-acpi.c b/drivers/hid/spi-hid/spi-hid-acpi.c
new file mode 100644
index 000000000000..612e74fe72f9
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
+		return -ENODEV;
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
+	usleep_range(1000 * conf->minimal_reset_delay_ms,
+		     1000 * (conf->minimal_reset_delay_ms + 1));
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
+	return spi_hid_core_probe(spi, &config->ops, &config->property_conf);
+}
+
+static const struct acpi_device_id spi_hid_acpi_match[] = {
+	{ "ACPI0C51", 0 },
+	{ "PNP0C51", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, spi_hid_acpi_match);
+
+static struct spi_driver spi_hid_acpi_driver = {
+	.driver = {
+		.name	= "spi_hid_acpi",
+		.owner	= THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(spi_hid_acpi_match),
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
index e3273846267e..02beb209a92d 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -43,6 +43,9 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
+#include "spi-hid.h"
+#include "spi-hid-core.h"
+
 /* Protocol constants */
 #define SPI_HID_READ_APPROVAL_CONSTANT		0xff
 #define SPI_HID_INPUT_HEADER_SYNC_BYTE		0x5a
@@ -105,30 +108,6 @@ struct spi_hid_output_report {
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
index 000000000000..1fdd45262647
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid.h
@@ -0,0 +1,44 @@
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
2.53.0.473.g4a7958ca14-goog

