From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] input/touchscreen: use EXPERT instead of EMBEDDED
Date: Mon, 25 Sep 2017 18:47:00 -0700
Message-ID: <ca02ff04-9ee4-eb3d-377b-f1fa73cce1ee@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Change control of TOUCHSCREEN_USB_EASYTOUCH prompt string from
EMBEDDED to EXPERT to match the rest of this Kconfig file.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-414-rc2.orig/drivers/input/touchscreen/Kconfig
+++ lnx-414-rc2/drivers/input/touchscreen/Kconfig
@@ -949,7 +949,7 @@ config TOUCHSCREEN_USB_NEXIO
 
 config TOUCHSCREEN_USB_EASYTOUCH
 	default y
-	bool "EasyTouch USB Touch controller device support" if EMBEDDED
+	bool "EasyTouch USB Touch controller device support" if EXPERT
 	depends on TOUCHSCREEN_USB_COMPOSITE
 	help
 	  Say Y here if you have an EasyTouch USB Touch controller.
