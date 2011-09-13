From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 1/2] input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config
 option
Date: Tue, 13 Sep 2011 17:56:18 +0530
Message-ID: <1315916779-21793-2-git-send-email-thomas.abraham@linaro.org>
References: <1315916779-21793-1-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1315916779-21793-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com
List-Id: linux-input@vger.kernel.org

For platforms using device tree, the static keypad device instances
are not required and SAMSUNG_DEV_KEYPAD is not selected. Since,
samsung keypad driver has dependency on SAMSUNG_DEV_KEYPAD config
option, the driver is left out of the compilation for dt enabled
platforms.

An additional config option 'HAVE_SAMSUNG_KEYPAD' is added
which the device tree based platforms can select. This config
option is added as an alternative dependency for keypad driver.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/input/keyboard/Kconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index b4dee9d..7c322a3 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -423,9 +423,16 @@ config KEYBOARD_PMIC8XXX
 	  To compile this driver as a module, choose M here: the module will
 	  be called pmic8xxx-keypad.
 
+config HAVE_SAMSUNG_KEYPAD
+	bool
+	help
+	  This will include Samsung Keypad controller driver support. If you
+	  want to include Samsung Keypad support for any machine, kindly
+	  select this in the respective mach-xxxx/Kconfig file.
+
 config KEYBOARD_SAMSUNG
 	tristate "Samsung keypad support"
-	depends on SAMSUNG_DEV_KEYPAD
+	depends on SAMSUNG_DEV_KEYPAD || HAVE_SAMSUNG_KEYPAD
 	help
 	  Say Y here if you want to use the Samsung keypad.
 
-- 
1.6.6.rc2
