From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] input: touchscreen: make USB drivers depend on USB
Date: Wed, 17 Jan 2018 22:40:22 +0100
Message-ID: <20180117214022.1380-1-marcus.folkesson@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37084 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752778AbeAQVkk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Jan 2018 16:40:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, Andi Shyti <andi.shyti@samsung.com>, Michael Hennerich <michael.hennerich@analog.com>, Jelle van der Waa <jelle@vdwaa.nl>, Marcus Folkesson <marcus.folkesson@gmail.com>, Anthony Kim <anthony.kim@hideep.com>, hns@goldelico.com, Randy Dunlap <rdunlap@infradead.org>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Martin Kepplinger <martink@posteo.de>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

A driver should not enable an entire subsystem.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/touchscreen/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 38a226f9fcbd..08d2c1434493 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -837,8 +837,7 @@ config TOUCHSCREEN_WM97XX_ZYLONITE
 
 config TOUCHSCREEN_USB_COMPOSITE
 	tristate "USB Touchscreen Driver"
-	depends on USB_ARCH_HAS_HCD
-	select USB
+	depends on USB
 	help
 	  USB Touchscreen driver for:
 	  - eGalax Touchkit USB (also includes eTurboTouch CT-410/510/700)
-- 
2.15.1

