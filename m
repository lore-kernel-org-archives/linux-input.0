Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803118;
	b=2Mb+L/gwUXtnkl02oKR5DgA1pLHAeaAgtsw5dD9K1Izo+x8dCq3Yez4uXboMRcjsK9Jr
	 vgimOxAT38VDIXh7VMqfBugAsX+dHmh4xEnZoPKswkCD+++Q4zqcsOKArM6bb8HLEYgT6
	 +rPZjrTrLqdQmJIrpm4GN96DHyV4CDJq7aaGsqHcRkBvdjxNEvQjSoyD8JOT/ta/KOcJO
	 kAgVGju4V+b6gSrz7oh0EdKhI9d6E1zJTTyLMKhf3yXnr/i/g0jWSrUYbAcz6IGgeE51G
	 8TnRisx1KXP2L0X7Bw9g0BVrWyfiSsTW4ZiWEHdEbxzD2QEGxyewFi7uDhcsgpgQ4tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=DKs0C0YoP+V/lqrwrGkxTjtcpqX1eY4Y6D+S/s/oFD8=;
	b=c9vjLINJ5q4r9R8Mru8/2AhFTolP2nd7HJAIbtEQ6XNMfsRcruxT1XcDh/pkHTEFdDqX
	 5BEBJhIijudRFZOAynDAdingj2uQ+hY5/UydOIB6fB2tT3X/NoOjJ+UaFUdaOuP0yzLBv
	 ZbVK657UfCx7TzeS1HINMAr+fmy/wngBcyR3BxZM7/jqt/5yUEAirAHqQIRHE/T7jrpf5
	 t2M/XVXshGC1AukSVuU4gxsRx9pfLyFE6C99UxPHqhDD21mNIOhMvsMa3WhElFhEic0NC
	 zmmwKjvwKvEAgDgQxmKMycLOfPQmbcu0Af6ZIB61udKLHSOUN6L0+eTa3p3hRLsfe9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YrJD5om4;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6AB606A32C
	for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 00:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA6AB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YrJD5om4
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so1198940a91.2
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803117; x=1793407917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKs0C0YoP+V/lqrwrGkxTjtcpqX1eY4Y6D+S/s/oFD8=;
        b=YrJD5om4mfu0/uAkT8JY9i7abOMa3C10LB9UW5tYXqmVBoRHv+yZ3c3SOIBzPMxoDZ
         5xZ4CFZs9w6Wp1kJPgggOR52OQ30wklwJRFYSAAd7NqpVOaRn2cSKMeo/4yCEUKkG5Ic
         oKiNhaThmbreL9PNuA+0H8XVVU7ozh6nzJ/C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803117; x=1793407917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DKs0C0YoP+V/lqrwrGkxTjtcpqX1eY4Y6D+S/s/oFD8=;
        b=DReBIFqwilEHsJoG6Cz63xOq+aXRSnGJghXkkAZRgPmmH+kgzjNoYxLOCvQa95XfIm
         raXhaFSBcDIBtO7cYbC6DgahtstDH6RFNOVuyuvWjEXEDB8xCXx5qe5Yqu07ICyu9IVD
         zPVznrAhPDrqUqIz2e7P7OzfgF4HcY+gUsYjaKV1q1RoQFutvE096FV/y20aNxYxxq9+
         yCE9JGHfR871rk4AgLYTpGJJWBbEuRC+E7Nr2x2nx5w1cwyuPgTP3tQTP8h1kILS+KHe
         HKL6WnaVmMaqbila+GUWDoFtaaUWsHOKSEu1aQ54JzW2QgYhA06qyJBzyXDHe/rxgKeY
         eV5w==
X-Gm-Message-State: AFq9FYK+XboXbaT+ZODHitx/aY6qh+ar2yVfYMQqismI0i1ix1h9TtiA
	BFx1zVPSbxPetM+0wg4WBHZ4hjoG4U9DbaE2JvQgkioskksEZ3zpRHm/yAPOjkv1crtY4nQ3uyW
	W2b8=
X-Gm-Gg: AYBFou3cUOHqIs77jqUiHVTpuSpr3U5KeiXJzShunRLg4p0aZczgSvNmcpkawRLVsGj
	V/3G9FvGcvxzAIo9Yvksg244oCjD4LUt+JuFFDuOvZTaWqbfc8pMHDAXr8s3d/FvM1GBLY2T8cq
	YX/a/gVeMZJeHdNCjTf3PY05JN2EJjO/LJQfs5CQzW1gQi67dUuzISGuHD5xemlXXAYdJnrlYyk
	dLlRN5McOEomdet/zaqSqbzG0jEHD89aZQzgLJwZW1pmAwvrMlzSA72pCnfD5Ui11djRzSVvqaf
	eUa5JCxNcw2dDJ0fTaIqNa3QkMPxNLsjPpnnDOQ0xTCOHXsRfiHxnZus1TXpkJZy4HWkvFa7op6
	xrWuD6nuJvKtV7pZW2RaPnjHBUuFZwJXNUQYM2Ns67Ep3kILeBGKoJV7M/bAcQUsTAaKP0DBwdV
	DPtZ+7aqN2C2o15HRl1TK1tVlijLLEVyQwSa/gs4Uj5+fSx66RwZgi+qdyrxVNhSWwY6SLf/2/Q
	5X+SBovoneVMI/fo3g9lwRDbjq6Pc9T+GjKThk9FIL/LSm1fX1J3NXICqE2DsafHrvC6pTiwxpt
	K3tX/gew5mS/Civ0aCldeP5OwbKjLYg6ck0McbkVah3nBoFKGRLR8LZkJBqY4so=
X-Received: by 2002:a17:90b:50cb:b0:3ad:a462:f07f with SMTP id 98e67ed59e1d1-3adeae7796emr731665a91.45.1792803117082;
        Fri, 23 Oct 2026 17:51:57 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:56 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:41 +0000
Subject: [PATCH v7 07/11] HID: spi-hid: add ACPI support for HID over SPI
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
Message-Id: <20261024-send-upstream-v7-7-abad13174b43@chromium.org>
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
 Jingyuan Liang <jingyliang@chromium.org>, Angela Czubak <acz@semihalf.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=13635;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=LeaWOWbToM8BykW/HV5XCn2x3t38w7x9iKLJ6FmYAAM=;
 b=/Fc4DL1fcUzn6g0UY2LVURKHNKH1i7U2i11wx1hsJBdpFF63Nr/KTqS20Seud7OrXgvG6QJWi
 zTOts8szIJkBtLPnjU+lLOEDGIrtHZeX2GSUd32drQifrV6vEqzApYD
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Angela Czubak <acz@semihalf.com>

Detect SPI HID devices described in ACPI.

Signed-off-by: Angela Czubak <acz@semihalf.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig        |  16 +++
 drivers/hid/spi-hid/Makefile       |   1 +
 drivers/hid/spi-hid/spi-hid-acpi.c | 260 +++++++++++++++++++++++++++++++++++++
 drivers/hid/spi-hid/spi-hid-core.c |  46 +++----
 drivers/hid/spi-hid/spi-hid.h      |  43 ++++++
 5 files changed, 339 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 836fdefe8345..303ada03a1bf 100644
--- a/drivers/hid/spi-hid/Kconfig
+++ b/drivers/hid/spi-hid/Kconfig
@@ -10,6 +10,22 @@ menuconfig SPI_HID
 
 if SPI_HID
 
+config SPI_HID_ACPI
+	tristate "HID over SPI transport layer ACPI driver"
+	depends on ACPI
+	select RESET_CONTROLLER
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
index 000000000000..df459c71e209
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-acpi.c
@@ -0,0 +1,260 @@
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
+	struct device *dev;
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
+				"Error _DSM call to get HID input report header address failed\n");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_header_address = obj->integer.value;
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 2, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID input report body address failed\n");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_body_address = obj->integer.value;
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 3, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID output report header address failed\n");
+		return -ENODEV;
+	}
+	conf->property_conf.output_report_address = obj->integer.value;
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 4, NULL,
+				      ACPI_TYPE_BUFFER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID read opcode failed\n");
+		return -ENODEV;
+	}
+	if (obj->buffer.length == 1) {
+		conf->property_conf.read_opcode = obj->buffer.pointer[0];
+	} else {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID read opcode, too long buffer\n");
+		ACPI_FREE(obj);
+		return -ENODEV;
+	}
+	ACPI_FREE(obj);
+
+	obj = acpi_evaluate_dsm_typed(handle, &spi_hid_guid, 3, 5, NULL,
+				      ACPI_TYPE_BUFFER);
+	if (!obj) {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID write opcode failed\n");
+		return -ENODEV;
+	}
+	if (obj->buffer.length == 1) {
+		conf->property_conf.write_opcode = obj->buffer.pointer[0];
+	} else {
+		acpi_handle_err(handle,
+				"Error _DSM call to get HID write opcode, too long buffer\n");
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
+		acpi_handle_err(handle, "No reset method for acpi handle\n");
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
+		dev_err(&conf->adev->dev, "Error could not power up ACPI device: %d\n", error);
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
+	/*
+	 * Probe guarantees an ACPI reset method exists. Use the optional
+	 * variant so that the absence of an additional reset controller
+	 * binding is not reported as an error after a successful reset.
+	 */
+	return device_reset_optional(conf->dev);
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
+		dev_err(dev, "Error could not get ACPI device\n");
+		return -ENODEV;
+	}
+
+	config = devm_kzalloc(dev, sizeof(struct spi_hid_acpi_config),
+			      GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	config->dev = dev;
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
+		dev_err(dev, "%s: unable to populate config data\n", __func__);
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
index f30892a4f91f..4ff93d22715c 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -44,6 +44,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
+#include "spi-hid.h"
 #include "spi-hid-core.h"
 
 #define CREATE_TRACE_POINTS
@@ -115,31 +116,6 @@ struct spi_hid_output_report {
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
@@ -318,8 +294,19 @@ static void spi_hid_error_handler(struct spi_hid *shid)
 
 	shid->power_state = HIDSPI_ON;
 
-	shid->ops->deassert_reset(shid->ops);
+	error = shid->ops->deassert_reset(shid->ops);
+	if (error) {
+		dev_err(dev, "failed to deassert reset: %d\n", error);
+		/*
+		 * Without a successful reset the device will not send a reset
+		 * response, so no IRQ would trigger another recovery attempt.
+		 * Retry from here; reset_attempts bounds the number of tries.
+		 */
+		set_bit(SPI_HID_ERROR, &shid->flags);
+		schedule_work(&shid->reset_work);
+	}
 
+	/* Balance disable_irq() above; a retry disables it again. */
 	enable_irq(shid->spi->irq);
 }
 
@@ -1377,7 +1364,12 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		return error;
 	}
 
-	shid->ops->deassert_reset(shid->ops);
+	error = shid->ops->deassert_reset(shid->ops);
+	if (error) {
+		dev_err(dev, "%s: failed to deassert reset: %d\n", __func__, error);
+		shid->ops->power_down(shid->ops);
+		return error;
+	}
 
 	enable_irq(spi->irq);
 
diff --git a/drivers/hid/spi-hid/spi-hid.h b/drivers/hid/spi-hid/spi-hid.h
new file mode 100644
index 000000000000..a31956ef24ef
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid.h
@@ -0,0 +1,43 @@
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
+#endif /* SPI_HID_H */

-- 
2.56.0.257.gf7497c7d27-goog

