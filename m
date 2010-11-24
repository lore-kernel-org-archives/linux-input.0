From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH WIP 5/6] fixup gpio_buttons: move gpio_buttons.c to drivers/input/keyboard from drivers/input/misc
Date: Wed, 24 Nov 2010 16:01:39 -0500
Message-ID: <037ca045b9eca06e1ddb45c23ca02f8fb62f4426.1290631852.git.bengardiner@nanometrics.ca>
References: <1290524800-21419-10-git-send-email-juhosg@openwrt.org> <cover.1290631852.git.bengardiner@nanometrics.ca>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:41214 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756333Ab0KXVBu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 16:01:50 -0500
Received: by mail-yx0-f181.google.com with SMTP id 39so134981yxd.26
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 13:01:50 -0800 (PST)
In-Reply-To: <cover.1290631852.git.bengardiner@nanometrics.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-input@vger.kernel.org


Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 drivers/input/keyboard/Kconfig                  |   16 ++++++++++++++++
 drivers/input/keyboard/Makefile                 |    2 ++
 drivers/input/{misc => keyboard}/gpio_buttons.c |    0
 drivers/input/misc/Kconfig                      |   16 ----------------
 drivers/input/misc/Makefile                     |    1 -
 5 files changed, 18 insertions(+), 17 deletions(-)
 rename drivers/input/{misc => keyboard}/gpio_buttons.c (100%)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index b8c51b9..4ab13fc 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -485,4 +485,20 @@ config KEYBOARD_W90P910
 	  To compile this driver as a module, choose M here: the
 	  module will be called w90p910_keypad.
 
+config INPUT_GPIO_BUTTONS
+	tristate "Polled GPIO buttons interface"
+	depends on GENERIC_GPIO
+	select INPUT_POLLDEV
+	help
+	  This driver implements support for buttons connected
+	  to GPIO pins of various CPUs (and some other chips).
+
+	  Say Y here if your device has buttons connected
+	  directly to such GPIO pins.  Your board-specific
+	  setup logic must also provide a platform device,
+	  with configuration data saying which GPIOs are used.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gpio-buttons.
+
 endif
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index a34452e..2a52e0c 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -44,3 +44,5 @@ obj-$(CONFIG_KEYBOARD_TNETV107X)	+= tnetv107x-keypad.o
 obj-$(CONFIG_KEYBOARD_TWL4030)		+= twl4030_keypad.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
 obj-$(CONFIG_KEYBOARD_W90P910)		+= w90p910_keypad.o
+obj-$(CONFIG_INPUT_GPIO_BUTTONS)	+= gpio_buttons.o
+
diff --git a/drivers/input/misc/gpio_buttons.c b/drivers/input/keyboard/gpio_buttons.c
similarity index 100%
rename from drivers/input/misc/gpio_buttons.c
rename to drivers/input/keyboard/gpio_buttons.c
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index ef46534..a3adef6 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -457,20 +457,4 @@ config INPUT_ADXL34X_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called adxl34x-spi.
 
-config INPUT_GPIO_BUTTONS
-	tristate "Polled GPIO buttons interface"
-	depends on GENERIC_GPIO
-	select INPUT_POLLDEV
-	help
-	  This driver implements support for buttons connected
-	  to GPIO pins of various CPUs (and some other chips).
-
-	  Say Y here if your device has buttons connected
-	  directly to such GPIO pins.  Your board-specific
-	  setup logic must also provide a platform device,
-	  with configuration data saying which GPIOs are used.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called gpio-buttons.
-
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 1f9f7bd..b041f5f 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -43,5 +43,4 @@ obj-$(CONFIG_INPUT_WINBOND_CIR)		+= winbond-cir.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
 obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
 obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
-obj-$(CONFIG_INPUT_GPIO_BUTTONS)	+= gpio_buttons.o
 
-- 
1.7.0.4

