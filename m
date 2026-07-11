Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76D3845D0
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761700; cv=none; b=JRBk3hvPj2ecpBZkHCv8aMHoX2FBuuiWIiv7ouiUmSsU0ki92JcHfwk/m98xNxN8fh9Gk7edd1blgVmH63EztWTordlSSM1WEm1Z0P+T/jQHN/iaoY2mzmypnlpJy3QvVQc+g6z7fM5sp/IUHNCqreHjy/WlhbcY4ZfC1QR1iCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761700; c=relaxed/simple;
	bh=wJMAVoV26Wxtc9n53dd5rXmHTRFOtEAhBau0xCJPIic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fkDLzENf/hpTwUxIAxDa0oh4SuZ7Rtqojiy+BCh17KMmwEDpatj1oawfMAgADW0Mq7jGae4UuhY8juAFr3ckSeVdxvnvso0GgVQ189AK6ActOgLLRrvQJjodOwpJLPr0+g2sYj0azs3CzN85a70c5Ae5XJZnKquKD8Su4IH372o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9aea40d799so752195a12.0
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 02:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761699; x=1784366499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tlnA7fLt+6hyELPfR2jAqKN6onKfTqXw2YAeru37F4c=;
        b=AXQPEWbh2j2YiFk7hTvfR69eHq/jxjxtN+4xHyjNGEm8ziLsyFsojw15T2qpmnBXz8
         Uoz1kXcfHLXYhiKFpC87H9iS9/qi2/ZjB7VIDUDDG3WtTPrqeZLL6EeHjIJuLSitzXaX
         2yP2Mg4mMsbSYJjAq7cLgtQYzSf4tQImCSxJrX59OtFxVRglajOB0N5UfFPaayk+G6oU
         UzrKAzWSTraXfN2q7NXvsNzqYV4t4bkm/Mz797KubHCOgizw90Pi3c4Y9YBVaGZjzbqX
         aeBHvJRYaxVgX5O1c26tPMyn9E/Kj/uwF06s+6R/jIFhqyMpvODHozfAPnQRtpL+w/Wu
         pfzw==
X-Gm-Message-State: AOJu0Ywi6BcosFyNUWHOft1Ebq0A8cnYXDwZEq5Wzp3uYop/7onj2Tdt
	U+6C0X5dxKwIdaQo47cwWwXjW2G54RMnRE9C6/gWpMOu6va5BWVwjHA=
X-Gm-Gg: AfdE7cmx8p6MauvOSJhkLEX7opWXZOdOX3O0zHRCDJPtQh/zG62rm/Pi9SfoR2icG1J
	oH0CO15Rpw8NMO2RmOD8ni916ck8sD4PuQDgSGUHbGuJ39uMWVTMA1GWNQSDCiMN55Lx1gATT1n
	tO+0BGXoA6twB0BipK1SYqN65t+/paaj5aF4t0lcPUNMDVVivY65w7P1l/HNIh+DrYY0X7n/BiF
	mcxX6acBAABN9RHcU2qLFAlK7VMdwHdJd4sBuAltDxhOw1Oq7cU/FbgRBNRkQb+3MriUXvE88cS
	4gnA9hpHOHVccMqJtT4KoZdpu2Ts34qZPF7XT2usHhcUHOPJksV6LYyAiEe678c4Ux2IYpML2pl
	+FHwI7pte3IkUq212XoPHdvsfHTNuzwJPaZz/piD7qqHth+TPkwv6aTvHE9etgrcVo74NVDaQs7
	pIgFBZQWUkCykiGUt3ba2BCknyYdAjH7Vhq3yRsHIfzPjeoBCqByLAY0GZ1XdAS+LQ4HiOrLaaY
	/Wd5bq3UbQwVlUpq+XRXSiTbw==
X-Received: by 2002:a05:6a00:2441:b0:848:5eae:3695 with SMTP id d2e1a72fcca58-84889883eebmr2183357b3a.78.1783761698716;
        Sat, 11 Jul 2026 02:21:38 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6dbfd41sm11468726b3a.57.2026.07.11.02.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:21:38 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 1/3] Input: applespi - force PIO mode on MacBook8,1
Date: Sat, 11 Jul 2026 17:20:52 +0800
Message-Id: <20260711092054.13818-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711092054.13818-1-fourdollars@debian.org>
References: <20260711092054.13818-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller's DMA
handshake and interrupt routing frequently fail or time out on boot,
causing the keyboard and trackpad to become unresponsive.

Address this by introducing a DMI quirk and a `force_pio` module
parameter. If either is true, override the SPI controller's `can_dma`
callback to a helper that always returns false. This forces all SPI
transfers to fall back to the reliable PIO mode.

To ensure correct timing and architectural safety:
1. Perform the override at the very beginning of applespi_probe() so
   that all early initialization transfers use PIO.
2. In case of probe failures or module unload (remove), unconditionally
   restore the original `can_dma` callback (even if it was NULL) to
   prevent any execute-after-free or dangling pointer vulnerability in
   the shared host controller.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 66 +++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..79e5cb5001c7 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -46,6 +46,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/efi.h>
+#include <linux/dmi.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/ktime.h>
@@ -110,6 +111,10 @@ module_param_string(touchpad_dimensions, touchpad_dimensions,
 		    sizeof(touchpad_dimensions), 0444);
 MODULE_PARM_DESC(touchpad_dimensions, "The pixel dimensions of the touchpad, as XxY+W+H .");
 
+static bool applespi_force_pio;
+module_param_named(force_pio, applespi_force_pio, bool, 0444);
+MODULE_PARM_DESC(force_pio, "Force PIO mode (disables DMA) for SPI transfers. ([0] = disabled, 1 = enabled)");
+
 /**
  * struct keyboard_protocol - keyboard message.
  * message.type = 0x0110, message.length = 0x000a
@@ -431,6 +436,10 @@ struct applespi_data {
 	int				tp_dim_max_x;
 	int				tp_dim_min_y;
 	int				tp_dim_max_y;
+
+	bool				(*original_can_dma)(struct spi_controller *controller,
+							    struct spi_device *spi,
+							    struct spi_transfer *xfer);
 };
 
 static const unsigned char applespi_scancodes[] = {
@@ -1605,6 +1614,13 @@ static void applespi_save_bl_level(struct applespi_data *applespi,
 			 "Error saving backlight level to EFI vars: 0x%lx\n", sts);
 }
 
+static bool applespi_can_not_dma(struct spi_controller *controller,
+				 struct spi_device *spi,
+				 struct spi_transfer *xfer)
+{
+	return false;
+}
+
 static int applespi_probe(struct spi_device *spi)
 {
 	struct applespi_data *applespi;
@@ -1612,6 +1628,7 @@ static int applespi_probe(struct spi_device *spi)
 	acpi_status acpi_sts;
 	int sts, i;
 	unsigned long long gpe, usb_status;
+	bool override_dma = applespi_force_pio || dmi_match(DMI_PRODUCT_NAME, "MacBook8,1");
 
 	/* check if the USB interface is present and enabled already */
 	acpi_sts = acpi_evaluate_integer(spi_handle, "UIST", NULL, &usb_status);
@@ -1628,6 +1645,13 @@ static int applespi_probe(struct spi_device *spi)
 
 	applespi->spi = spi;
 
+	/* Save original can_dma and override if requested or needed */
+	applespi->original_can_dma = spi->controller->can_dma;
+	if (override_dma) {
+		dev_info(&spi->dev, "Disabling DMA for SPI to force PIO mode\n");
+		spi->controller->can_dma = applespi_can_not_dma;
+	}
+
 	INIT_WORK(&applespi->work, applespi_worker);
 
 	/* store the driver data */
@@ -1645,8 +1669,10 @@ static int applespi_probe(struct spi_device *spi)
 					       GFP_KERNEL);
 
 	if (!applespi->tx_buffer || !applespi->tx_status ||
-	    !applespi->rx_buffer || !applespi->msg_buf)
-		return -ENOMEM;
+	    !applespi->rx_buffer || !applespi->msg_buf) {
+		sts = -ENOMEM;
+		goto err_restore_dma;
+	}
 
 	/* set up our spi messages */
 	applespi_setup_read_txfrs(applespi);
@@ -1658,7 +1684,8 @@ static int applespi_probe(struct spi_device *spi)
 		dev_err(&applespi->spi->dev,
 			"Failed to get SIEN ACPI method handle: %s\n",
 			acpi_format_exception(acpi_sts));
-		return -ENODEV;
+		sts = -ENODEV;
+		goto err_restore_dma;
 	}
 
 	acpi_sts = acpi_get_handle(spi_handle, "SIST", &applespi->sist);
@@ -1666,23 +1693,26 @@ static int applespi_probe(struct spi_device *spi)
 		dev_err(&applespi->spi->dev,
 			"Failed to get SIST ACPI method handle: %s\n",
 			acpi_format_exception(acpi_sts));
-		return -ENODEV;
+		sts = -ENODEV;
+		goto err_restore_dma;
 	}
 
 	/* switch on the SPI interface */
 	sts = applespi_setup_spi(applespi);
 	if (sts)
-		return sts;
+		goto err_restore_dma;
 
 	sts = applespi_enable_spi(applespi);
 	if (sts)
-		return sts;
+		goto err_restore_dma;
 
 	/* setup the keyboard input dev */
 	applespi->keyboard_input_dev = devm_input_allocate_device(&spi->dev);
 
-	if (!applespi->keyboard_input_dev)
-		return -ENOMEM;
+	if (!applespi->keyboard_input_dev) {
+		sts = -ENOMEM;
+		goto err_restore_dma;
+	}
 
 	applespi->keyboard_input_dev->name = "Apple SPI Keyboard";
 	applespi->keyboard_input_dev->phys = "applespi/input0";
@@ -1717,7 +1747,7 @@ static int applespi_probe(struct spi_device *spi)
 	if (sts) {
 		dev_err(&applespi->spi->dev,
 			"Unable to register keyboard input device (%d)\n", sts);
-		return -ENODEV;
+		goto err_restore_dma;
 	}
 
 	/*
@@ -1729,7 +1759,8 @@ static int applespi_probe(struct spi_device *spi)
 		dev_err(&applespi->spi->dev,
 			"Failed to obtain GPE for SPI slave device: %s\n",
 			acpi_format_exception(acpi_sts));
-		return -ENODEV;
+		sts = -ENODEV;
+		goto err_restore_dma;
 	}
 	applespi->gpe = (int)gpe;
 
@@ -1740,7 +1771,8 @@ static int applespi_probe(struct spi_device *spi)
 		dev_err(&applespi->spi->dev,
 			"Failed to install GPE handler for GPE %d: %s\n",
 			applespi->gpe, acpi_format_exception(acpi_sts));
-		return -ENODEV;
+		sts = -ENODEV;
+		goto err_restore_dma;
 	}
 
 	applespi->suspended = false;
@@ -1751,7 +1783,8 @@ static int applespi_probe(struct spi_device *spi)
 			"Failed to enable GPE handler for GPE %d: %s\n",
 			applespi->gpe, acpi_format_exception(acpi_sts));
 		acpi_remove_gpe_handler(NULL, applespi->gpe, applespi_notify);
-		return -ENODEV;
+		sts = -ENODEV;
+		goto err_restore_dma;
 	}
 
 	/* trigger touchpad setup */
@@ -1789,6 +1822,11 @@ static int applespi_probe(struct spi_device *spi)
 			    &applespi_tp_dim_fops);
 
 	return 0;
+
+err_restore_dma:
+	if (override_dma)
+		spi->controller->can_dma = applespi->original_can_dma;
+	return sts;
 }
 
 static void applespi_drain_writes(struct applespi_data *applespi)
@@ -1813,6 +1851,7 @@ static void applespi_drain_reads(struct applespi_data *applespi)
 static void applespi_remove(struct spi_device *spi)
 {
 	struct applespi_data *applespi = spi_get_drvdata(spi);
+	bool override_dma = applespi_force_pio || dmi_match(DMI_PRODUCT_NAME, "MacBook8,1");
 
 	applespi_drain_writes(applespi);
 
@@ -1822,6 +1861,9 @@ static void applespi_remove(struct spi_device *spi)
 
 	applespi_drain_reads(applespi);
 
+	if (override_dma)
+		spi->controller->can_dma = applespi->original_can_dma;
+
 	debugfs_remove_recursive(applespi->debugfs_root);
 }
 
-- 
2.39.5

