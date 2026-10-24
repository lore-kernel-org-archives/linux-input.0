Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803120;
	b=Epe7mQyD5mUx4i1w/4pqRmwHxOMudhW7RHZAf1pngOr3HX3c0QTkNNe6Pjq281n38CvO
	 Kam3kfnPtilzMfaHmRaePcbadGAaOAcxiVs1FNmG6oT8ofOsTf4mvW002E1ONUa87HoN/
	 mZHzEsZrJBnEmRViz70hNtugwSEu8UGA9vonQIR80hQvnfVYgWT4UurEzQ/cv3iW/Wakp
	 D1Nkk5Vd07uN9OD+dtICt4KKm8f8+9PAGmd/U83fyykYtq40ZJ9KkOtklZCcOEvvoTgI/
	 gwvtgtimzaWg1yZBaXL6wvdOgs5ixf6cwwJjn6VjkLai2Eoi8Q8exC3ZWUHWRv6ac5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=qhROuWKNB1zu9GN0+zWtwkE2StJd098hmWLDpMHCuHw=;
	b=gbvJ/XyCIEpeyjRz1dB8AY94Tem5+aDNc1dRD6w8by+c6m7G3la7NOQHAc2AMimspjSK
	 Bq0+/yNFZMmLCBWGSqkoE6RVKxEoBBQpiN6Z17tYR5KHGJbNzhpT79ijSqfRPn66K5sWe
	 u5vBFrwGMqu/6vEcWTVwltDwyedxPhgOPykG6AT/8qmTXt4dcYIfvIFP2nqxLcYQkImix
	 ineOVBdmR1vxKJqJVWIeYiN+m2c7BT4mW+OQhKHygPnjDIlSVrHhH9CL/MOaswiCIriph
	 7o//XeMBYA9gtHtJES0puh4v5AfJ6FP3Jl3xLVzmDwqi0wWu8IC/o6ZQ9EYSFDShDqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RLtLcn9L;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959D60A380C
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 00:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A959D60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RLtLcn9L
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso817991a91.1
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 17:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803119; x=1793407919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qhROuWKNB1zu9GN0+zWtwkE2StJd098hmWLDpMHCuHw=;
        b=RLtLcn9LajDMTUG4e+brYlO8O8fLxgyQJvbrTx5vRJIknt12EczmRKkqtdKbofOvXK
         lMlIKXCU0ip9IujT4eDHRJTaWv6ExERqP5JqNyM80ZggSP5E+SezOdf+7gz4cm32Memi
         r1TVe8bYt43+Ht8K0n8KrS2La3cPrpG84I0QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803119; x=1793407919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qhROuWKNB1zu9GN0+zWtwkE2StJd098hmWLDpMHCuHw=;
        b=dT4iw0FwU7jyLzvxU9eKdeDhc2EMrBFWLRaH0BESWhpQqHNREq6EFjtYNghWOxVlsX
         DDb1U4NqCi60iRBDVIHnqikh0uVH7bXvtLE+bowSfT+FSecFyvdKbmjG5yD8IcI8wDeG
         cH2RG98tphmpLoYXEWBXXLD+q0pEwL0kQaq5XgvoYUez5BELjRKfWi8+Mv1GosNYenks
         pqNf5X5bGUh/kaJi5Su1zl3Oasrnf3gvOKNCa1BiM7aCNbl6aYF9bVX81TwoTLuhZDe/
         M+Jlsh40pxBwnlCmVoi0vjJEY2TIrGaGrSBko5k28wqvf35MQ7MIGayEVRx6Mv3MyrGJ
         KZlw==
X-Gm-Message-State: AFq9FYKSf9G3epJMOj6/+maK0XJMC+UwogZD5NPVkiyzEufTWfXFvjFE
	OS5kNxybX0ha24cfs+MLNy5mDaZAtMBoHPkefX098HsEUKxgqGO58MbHkAJ5HOetey0uK8WffHI
	BU9g=
X-Gm-Gg: AYBFou3lozm6mjhUkfrbhIXIENvwfIgUCbzgXcdxQrG7zkXHQbAbRyL/nwnWRTl7ffN
	MGhvMPoGJ1UtXSiQLBECd/qTm0d2A2D8EB1sf9RrjSPi4MZQobmBSjXssOsCER2LUFyhd2hfuT8
	E28X7pbl3Vb/04eF34vJ4FNwXknvU8nBnJs+Y2IHmYG21SwfYCxRaftbeQ2kcRVm9j0baSkxJ4v
	Z7a3TCo0HWaQv6yAgNXrSERH9//+SSBoAdLEpjbGShzYFrahivAIFCjui5ovduSCyxy2dzBs9ej
	Yz2DMpM2eGwEQwKm0jZ2hxdX3s706Hm9aNbEmp+Bo1yyX8QWFqqIDqK1m9oHBCcaQCXrJMeAYV+
	9ey8fShqCp3vfMGh/vxG3ZmmN7IYuCuqoLDZrdfPTLYZb//WWHIQzp6TRbhwdzmVMFf2Aq626AL
	r/IvO/PYN2nayVqlH0UtJQefW6rXj4UQ7G1ulFTjNjPN2GG1XAAyRX1Q26MtzjEXRHf82YlH7/T
	y5O5oE1ekqHwguld+ghAL7HGC5CKW86mZt+QPVuzFRXMyCLWIzenhOIypruH9AK22WAToAWs/6+
	MClCupWG1yMnYJZ6b6L1Evfwqz7ekVMqIsPTXaaPklliQWH8Wx+9Ckt/gaMueXU=
X-Received: by 2002:a17:90b:5787:b0:3ac:a139:1b13 with SMTP id 98e67ed59e1d1-3adeabe4318mr657663a91.29.1792803118943;
        Fri, 23 Oct 2026 17:51:58 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:58 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:43 +0000
Subject: [PATCH v7 09/11] HID: spi-hid: add device tree support for HID
 over SPI
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-send-upstream-v7-9-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
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
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=7909;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=d3PymUtLWxe99doziaHIYJBPfLQ/rKkR0CjPyLuledA=;
 b=HYYjnGNbkyh3fZZpXhyedWvrRYvZqZYx97jmI7aJXcMi0wFN0CAIwXs8IizWJ6Wmqs12BPKIO
 Se0/gf9HIVkD0xH6JAOWiVmPARO82ZGh1vMVOLcLXknY8haBXi74hD3
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Detect SPI HID devices described in Device Tree.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig      |  15 +++
 drivers/hid/spi-hid/Makefile     |   1 +
 drivers/hid/spi-hid/spi-hid-of.c | 210 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 303ada03a1bf..63f202975ac3 100644
--- a/drivers/hid/spi-hid/Kconfig
+++ b/drivers/hid/spi-hid/Kconfig
@@ -26,6 +26,21 @@ config SPI_HID_ACPI
 	  will be called spi-hid-acpi. It will also build/depend on the
 	  module spi-hid.
 
+config SPI_HID_OF
+	tristate "HID over SPI transport layer Open Firmware driver"
+	depends on OF
+	select SPI_HID_CORE
+	help
+	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
+	  other HID based devices which are connected to your computer via SPI.
+	  This driver supports Open Firmware (Device Tree)-based systems.
+
+	  If unsure, say N.
+
+	  This support is also available as a module.  If so, the module
+	  will be called spi-hid-of. It will also build/depend on the
+	  module spi-hid.
+
 config SPI_HID_CORE
 	tristate
 endif
diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
index 3ca326602643..31192e71edae 100644
--- a/drivers/hid/spi-hid/Makefile
+++ b/drivers/hid/spi-hid/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
 spi-hid-objs 			= spi-hid-core.o
 CFLAGS_spi-hid-core.o 		:= -I$(src)
 obj-$(CONFIG_SPI_HID_ACPI)	+= spi-hid-acpi.o
+obj-$(CONFIG_SPI_HID_OF)	+= spi-hid-of.o
diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-hid-of.c
new file mode 100644
index 000000000000..d1bbdc17102e
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID over SPI protocol, Open Firmware related code
+ *
+ * Copyright (c) 2021 Microsoft Corporation
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
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "spi-hid.h"
+
+/* Per-compatible data: protocol parameters and timings */
+struct spi_hid_of_data {
+	struct spi_hid_conf conf;
+	u32 post_power_on_delay_ms;
+	u32 minimal_reset_delay_ms;
+};
+
+/* Config structure is filled with match data and Device Tree resources */
+struct spi_hid_of_config {
+	struct spihid_ops ops;
+
+	struct spi_hid_of_data data;
+
+	struct gpio_desc *reset_gpio;
+	struct regulator *supply;
+	bool supply_enabled;
+};
+
+static const struct spi_hid_of_data microsoft_g6_data = {
+	.conf = {
+		.input_report_header_address = 0x1000,
+		.input_report_body_address = 0x1004,
+		.output_report_address = 0x2000,
+		.read_opcode = 0x0b,
+		.write_opcode = 0x02,
+	},
+	.post_power_on_delay_ms = 10,
+	.minimal_reset_delay_ms = 100,
+};
+
+static int spi_hid_of_populate_config(struct spi_hid_of_config *conf,
+				      struct device *dev)
+{
+	conf->supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(conf->supply))
+		return dev_err_probe(dev, PTR_ERR(conf->supply),
+				     "Failed to get regulator\n");
+	conf->supply_enabled = false;
+
+	conf->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(conf->reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	return 0;
+}
+
+static int spi_hid_of_power_down(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+	int error;
+
+	if (!conf->supply_enabled)
+		return 0;
+
+	error = regulator_disable(conf->supply);
+	if (error == 0)
+		conf->supply_enabled = false;
+
+	return error;
+}
+
+static int spi_hid_of_power_up(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+	int error;
+
+	if (conf->supply_enabled)
+		return 0;
+
+	error = regulator_enable(conf->supply);
+
+	if (error == 0) {
+		conf->supply_enabled = true;
+		fsleep(1000 * conf->data.post_power_on_delay_ms);
+	}
+
+	return error;
+}
+
+static int spi_hid_of_assert_reset(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+
+	return gpiod_set_value_cansleep(conf->reset_gpio, 1);
+}
+
+static int spi_hid_of_deassert_reset(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+
+	return gpiod_set_value_cansleep(conf->reset_gpio, 0);
+}
+
+static void spi_hid_of_sleep_minimal_reset_delay(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+	fsleep(1000 * conf->data.minimal_reset_delay_ms);
+}
+
+static int spi_hid_of_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	const struct spi_hid_of_data *data;
+	struct spi_hid_of_config *config;
+	int error;
+
+	config = devm_kzalloc(dev, sizeof(struct spi_hid_of_config),
+			      GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	config->ops.power_up = spi_hid_of_power_up;
+	config->ops.power_down = spi_hid_of_power_down;
+	config->ops.assert_reset = spi_hid_of_assert_reset;
+	config->ops.deassert_reset = spi_hid_of_deassert_reset;
+	config->ops.sleep_minimal_reset_delay =
+		spi_hid_of_sleep_minimal_reset_delay;
+
+	data = spi_get_device_match_data(spi);
+	if (!data)
+		return dev_err_probe(dev, -ENODEV, "No match data\n");
+
+	config->data = *data;
+
+	/*
+	 * FIXME: multi-SPI not supported. Once it is, derive the
+	 * HID-over-SPI flags from spi->mode.
+	 */
+
+	error = spi_hid_of_populate_config(config, dev);
+	if (error)
+		return dev_err_probe(dev, error, "Unable to populate config data\n");
+
+	return spi_hid_core_probe(spi, &config->ops, &config->data.conf);
+}
+
+static const struct of_device_id spi_hid_of_match[] = {
+	{ .compatible = "microsoft,g6-touch-digitizer", .data = &microsoft_g6_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spi_hid_of_match);
+
+static const struct spi_device_id spi_hid_of_id_table[] = {
+	{ .name = "g6-touch-digitizer", .driver_data = (kernel_ulong_t)&microsoft_g6_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, spi_hid_of_id_table);
+
+static struct spi_driver spi_hid_of_driver = {
+	.driver = {
+		.name = "spi_hid_of",
+		.owner = THIS_MODULE,
+		.of_match_table = spi_hid_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = spi_hid_of_probe,
+	.remove = spi_hid_core_remove,
+	.id_table = spi_hid_of_id_table,
+};
+
+module_spi_driver(spi_hid_of_driver);
+
+MODULE_DESCRIPTION("HID over SPI OF transport driver");
+MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
+MODULE_LICENSE("GPL");

-- 
2.56.0.257.gf7497c7d27-goog

