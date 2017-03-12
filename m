From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] hid: cp2112: select GPIOLIB_IRQCHIP instead of depending on it
Date: Sun, 12 Mar 2017 19:56:08 +0100
Message-ID: <1489344968-12813-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35480 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934579AbdCLS4W (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Mar 2017 14:56:22 -0400
Received: by mail-wr0-f178.google.com with SMTP id g10so91767117wrg.2
        for <linux-input@vger.kernel.org>; Sun, 12 Mar 2017 11:56:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

GPIOLIB_IRQCHIP is not visible to user, so we can't depend on it.

Depend on GPIOLIB but select GPIOLIB_IRQCHIP.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hid/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 1aeb80e..00e2809 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -214,7 +214,8 @@ config HID_CMEDIA
 
 config HID_CP2112
 	tristate "Silicon Labs CP2112 HID USB-to-SMBus Bridge support"
-	depends on USB_HID && I2C && GPIOLIB && GPIOLIB_IRQCHIP
+	depends on USB_HID && I2C && GPIOLIB
+	select GPIOLIB_IRQCHIP
 	---help---
 	Support for Silicon Labs CP2112 HID USB to SMBus Master Bridge.
 	This is a HID device driver which registers as an i2c adapter
-- 
2.9.3

