From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/4] ARM: ep93xx: keypad: stop using mach/platform.h
Date: Mon, 15 Apr 2019 21:25:24 +0200
Message-ID: <20190415192734.935387-2-arnd@arndb.de>
References: <20190415192734.935387-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415192734.935387-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Hartley Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stefan Agner <stefan@agner.ch>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We can communicate the clock rate using platform data rather than setting
a flag to use a particular value in the driver, which is cleaner and
avoids the dependency.

No platform in the kernel currently defines the ep93xx keypad device
structure, so this is a rather pointless excercise.  Any out of tree
users are probably dead now, but if not, they have to change their
platform code to match the new platform_data structure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/Kconfig              | 2 +-
 drivers/input/keyboard/ep93xx_keypad.c      | 5 +----
 include/linux/platform_data/keypad-ep93xx.h | 4 ++--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a878351f1643..b373f3274542 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -194,7 +194,7 @@ config KEYBOARD_LKKBD
 
 config KEYBOARD_EP93XX
 	tristate "EP93xx Matrix Keypad support"
-	depends on ARCH_EP93XX
+	depends on ARCH_EP93XX || COMPILE_TEST
 	select INPUT_MATRIXKMAP
 	help
 	  Say Y here to enable the matrix keypad on the Cirrus EP93XX.
diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index f77b295e0123..71472f6257c0 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -137,10 +137,7 @@ static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
 	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
 	unsigned int val = 0;
 
-	if (pdata->flags & EP93XX_KEYPAD_KDIV)
-		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLK_DIV4);
-	else
-		clk_set_rate(keypad->clk, EP93XX_KEYTCHCLK_DIV16);
+	clk_set_rate(keypad->clk, pdata->clk_rate);
 
 	if (pdata->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
 		val |= KEY_INIT_DIS3KY;
diff --git a/include/linux/platform_data/keypad-ep93xx.h b/include/linux/platform_data/keypad-ep93xx.h
index 0e36818e3680..3054fced8509 100644
--- a/include/linux/platform_data/keypad-ep93xx.h
+++ b/include/linux/platform_data/keypad-ep93xx.h
@@ -9,8 +9,7 @@ struct matrix_keymap_data;
 #define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic mode */
 #define EP93XX_KEYPAD_BACK_DRIVE	(1<<2)	/* back driving mode */
 #define EP93XX_KEYPAD_TEST_MODE		(1<<3)	/* scan only column 0 */
-#define EP93XX_KEYPAD_KDIV		(1<<4)	/* 1/4 clock or 1/16 clock */
-#define EP93XX_KEYPAD_AUTOREPEAT	(1<<5)	/* enable key autorepeat */
+#define EP93XX_KEYPAD_AUTOREPEAT	(1<<4)	/* enable key autorepeat */
 
 /**
  * struct ep93xx_keypad_platform_data - platform specific device structure
@@ -24,6 +23,7 @@ struct ep93xx_keypad_platform_data {
 	unsigned int	debounce;
 	unsigned int	prescale;
 	unsigned int	flags;
+	unsigned int	clk_rate;
 };
 
 #define EP93XX_MATRIX_ROWS		(8)
-- 
2.20.0
