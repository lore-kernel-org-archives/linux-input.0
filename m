From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/3] gpio: adp5588: move header file out of I2C realm
Date: Sun, 21 May 2017 23:57:27 +0200
Message-ID: <20170521215727.1243-4-wsa@the-dreams.de>
References: <20170521215727.1243-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170521215727.1243-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Steven Miao <realmz6@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

This driver could also go via the input-tree or my tree. I don't really care
and just picked some subsystem :) Let me know if you are okay with that.

 arch/blackfin/mach-bf537/boards/stamp.c        | 2 +-
 drivers/gpio/gpio-adp5588.c                    | 2 +-
 drivers/input/keyboard/adp5588-keys.c          | 2 +-
 include/linux/{i2c => platform_data}/adp5588.h | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/linux/{i2c => platform_data}/adp5588.h (100%)

diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index eaec7b4832a29a..24985e658c19cd 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -22,7 +22,7 @@
 #include <linux/usb/isp1362.h>
 #endif
 #include <linux/i2c.h>
-#include <linux/i2c/adp5588.h>
+#include <linux/platform_data/adp5588.h>
 #include <linux/etherdevice.h>
 #include <linux/ata_platform.h>
 #include <linux/irq.h>
diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index c0f718b1231727..e717f8dc39667c 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -16,7 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 
-#include <linux/i2c/adp5588.h>
+#include <linux/platform_data/adp5588.h>
 
 #define DRV_NAME	"adp5588-gpio"
 
diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 53fe9a3fb6204d..f9d273c8b30695 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -20,7 +20,7 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 
-#include <linux/i2c/adp5588.h>
+#include <linux/platform_data/adp5588.h>
 
 /* Key Event Register xy */
 #define KEY_EV_PRESSED		(1 << 7)
diff --git a/include/linux/i2c/adp5588.h b/include/linux/platform_data/adp5588.h
similarity index 100%
rename from include/linux/i2c/adp5588.h
rename to include/linux/platform_data/adp5588.h
-- 
2.11.0
