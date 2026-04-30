Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF3345752;
	Thu, 30 Apr 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567412; cv=none; b=czWKBm8/k8YJQMhx0Rqy1zfIBYuNdxuwdjwuUop5Rwq3poDM5tqQTOR0hU9rqoSfno+aCTnVKMRf8mX3Bx4gA2PGpBCV9XvRtdZvLou5nL5pkCztIyeMPuYSIwRlf8idGq4/vCXypjNio1ZPRJwikY8ATkRY7fZfkKuPCoUpHao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567412; c=relaxed/simple;
	bh=M565umtdu9Syo58fcbFxl6b6T9zR7/CJ902enHvJjyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QK8DqihpdGKphTEo3nsCq9R+2Zp4XysSpw5EUGJQa3GeqSAs35rOTybEKQVxgfnSN1mPI/63D9X2ggOPHzMAgMi01sVREGm29O0rRy9T0c6lFdH0lGqLuWZhmEp3EW4YN0HBcv3/3d/xshpWSj44y+8Ygadr00IjCizz4O03gME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXuufgtG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXuufgtG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C29C2BCB3;
	Thu, 30 Apr 2026 16:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777567412;
	bh=M565umtdu9Syo58fcbFxl6b6T9zR7/CJ902enHvJjyk=;
	h=From:To:Cc:Subject:Date:From;
	b=lXuufgtGFdmoObEYgLFGYK3A3Iu82/UqO62xJIqVVFnR6SREOSu9C2O3+T9MhdvvJ
	 j/vFyw7F5VQG3zted75GrolPFqLOxLaf2EJ+WuyXve62CUG0rpYf4yBrBjfxAwSYe5
	 WEcFummYoX/+SRxX4f5BsLg7jihYqYstR/AC2nlOHoFnnHmVMANDcL27bfPWZ04bb6
	 mHRAK444Pgnz5y45x7zrlmPJwRGpF3yNOlo3yGFDxPR3yAYEXaadxE0mBnMLUOdV5+
	 s4BE4QI84bmQJ2accDbd8Jry81OB7ElEG+OZOZTNaR9ac+B69uYFiXqly1R8tz0mAd
	 o7oDtH2eSxK6Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH 1/2] Input: pcap_keys: remove unused driver
Date: Thu, 30 Apr 2026 18:42:47 +0200
Message-Id: <20260430164326.2766500-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Support for the ezx series of phones was removed in 2022, this
driver is just dead code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/misc/Kconfig     |  10 ---
 drivers/input/misc/Makefile    |   1 -
 drivers/input/misc/pcap_keys.c | 125 ---------------------------------
 3 files changed, 136 deletions(-)
 delete mode 100644 drivers/input/misc/pcap_keys.c

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 94a753fcb64f..1f6c57dba030 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -745,16 +745,6 @@ config INPUT_WM831X_ON
 	  To compile this driver as a module, choose M here: the module
 	  will be called wm831x_on.
 
-config INPUT_PCAP
-	tristate "Motorola EZX PCAP misc input events"
-	depends on EZX_PCAP
-	help
-	  Say Y here if you want to use Power key and Headphone button
-	  on Motorola EZX phones.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called pcap_keys.
-
 config INPUT_ADXL34X
 	tristate "Analog Devices ADXL34x Three-Axis Digital Accelerometer"
 	default n
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 415fc4e2918b..2281d6803fce 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -60,7 +60,6 @@ obj-$(CONFIG_INPUT_MAX8997_HAPTIC)	+= max8997_haptic.o
 obj-$(CONFIG_INPUT_MC13783_PWRBUTTON)	+= mc13783-pwrbutton.o
 obj-$(CONFIG_INPUT_MMA8450)		+= mma8450.o
 obj-$(CONFIG_INPUT_PALMAS_PWRBUTTON)	+= palmas-pwrbutton.o
-obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
 obj-$(CONFIG_INPUT_PCF8574)		+= pcf8574_keypad.o
 obj-$(CONFIG_INPUT_PCSPKR)		+= pcspkr.o
 obj-$(CONFIG_INPUT_PF1550_ONKEY)	+= pf1550-onkey.o
diff --git a/drivers/input/misc/pcap_keys.c b/drivers/input/misc/pcap_keys.c
deleted file mode 100644
index b19899b50d0b..000000000000
--- a/drivers/input/misc/pcap_keys.c
+++ /dev/null
@@ -1,125 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  Input driver for PCAP events:
- *   * Power key
- *   * Headphone button
- *
- *  Copyright (c) 2008,2009 Ilya Petrov <ilya.muromec@gmail.com>
- */
-
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/input.h>
-#include <linux/mfd/ezx-pcap.h>
-#include <linux/slab.h>
-
-struct pcap_keys {
-	struct pcap_chip *pcap;
-	struct input_dev *input;
-};
-
-/* PCAP2 interrupts us on keypress */
-static irqreturn_t pcap_keys_handler(int irq, void *_pcap_keys)
-{
-	struct pcap_keys *pcap_keys = _pcap_keys;
-	int pirq = irq_to_pcap(pcap_keys->pcap, irq);
-	u32 pstat;
-
-	ezx_pcap_read(pcap_keys->pcap, PCAP_REG_PSTAT, &pstat);
-	pstat &= 1 << pirq;
-
-	switch (pirq) {
-	case PCAP_IRQ_ONOFF:
-		input_report_key(pcap_keys->input, KEY_POWER, !pstat);
-		break;
-	case PCAP_IRQ_MIC:
-		input_report_key(pcap_keys->input, KEY_HP, !pstat);
-		break;
-	}
-
-	input_sync(pcap_keys->input);
-
-	return IRQ_HANDLED;
-}
-
-static int pcap_keys_probe(struct platform_device *pdev)
-{
-	int err = -ENOMEM;
-	struct pcap_keys *pcap_keys;
-	struct input_dev *input_dev;
-
-	pcap_keys = kmalloc_obj(*pcap_keys);
-	if (!pcap_keys)
-		return err;
-
-	pcap_keys->pcap = dev_get_drvdata(pdev->dev.parent);
-
-	input_dev = input_allocate_device();
-	if (!input_dev)
-		goto fail;
-
-	pcap_keys->input = input_dev;
-
-	platform_set_drvdata(pdev, pcap_keys);
-	input_dev->name = pdev->name;
-	input_dev->phys = "pcap-keys/input0";
-	input_dev->id.bustype = BUS_HOST;
-	input_dev->dev.parent = &pdev->dev;
-
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(KEY_POWER, input_dev->keybit);
-	__set_bit(KEY_HP, input_dev->keybit);
-
-	err = input_register_device(input_dev);
-	if (err)
-		goto fail_allocate;
-
-	err = request_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_ONOFF),
-			pcap_keys_handler, 0, "Power key", pcap_keys);
-	if (err)
-		goto fail_register;
-
-	err = request_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_MIC),
-			pcap_keys_handler, 0, "Headphone button", pcap_keys);
-	if (err)
-		goto fail_pwrkey;
-
-	return 0;
-
-fail_pwrkey:
-	free_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_ONOFF), pcap_keys);
-fail_register:
-	input_unregister_device(input_dev);
-	goto fail;
-fail_allocate:
-	input_free_device(input_dev);
-fail:
-	kfree(pcap_keys);
-	return err;
-}
-
-static void pcap_keys_remove(struct platform_device *pdev)
-{
-	struct pcap_keys *pcap_keys = platform_get_drvdata(pdev);
-
-	free_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_ONOFF), pcap_keys);
-	free_irq(pcap_to_irq(pcap_keys->pcap, PCAP_IRQ_MIC), pcap_keys);
-
-	input_unregister_device(pcap_keys->input);
-	kfree(pcap_keys);
-}
-
-static struct platform_driver pcap_keys_device_driver = {
-	.probe		= pcap_keys_probe,
-	.remove		= pcap_keys_remove,
-	.driver		= {
-		.name	= "pcap-keys",
-	}
-};
-module_platform_driver(pcap_keys_device_driver);
-
-MODULE_DESCRIPTION("Motorola PCAP2 input events driver");
-MODULE_AUTHOR("Ilya Petrov <ilya.muromec@gmail.com>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:pcap_keys");
-- 
2.39.5

