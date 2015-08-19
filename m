From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 6/6] Input: Replace KEYBOARD_CROS_EC dependency
Date: Wed, 19 Aug 2015 13:19:58 +0200
Message-ID: <1439983198-4696-7-git-send-email-javier@osg.samsung.com>
References: <1439983198-4696-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439983198-4696-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, Doug Anderson <dianders@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The ChromeOS EC keyboard driver config depend on CROS_EC_PROTO but
MFD_CROS_EC select CROS_EC_PROTO instead. Mixing select and depends
on is bad practice as it may lead to circular Kconfig dependencies.

Since the platform device that is matched with the keyboard driver
is registered by the ChromeOS EC mfd driver, KEYBOARD_CROS_EC really
should depend on MFD_CROS_EC. And because this config option selects
CROS_EC_PROTO, that dependency is met as well. So make the driver
to depend on MFD_CROS_EC instead of CROS_EC_PROTO.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>



---

 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index da53ae6a9334..2e80107ff630 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -689,7 +689,7 @@ config KEYBOARD_W90P910
 config KEYBOARD_CROS_EC
 	tristate "ChromeOS EC keyboard"
 	select INPUT_MATRIXKMAP
-	depends on CROS_EC_PROTO
+	depends on MFD_CROS_EC
 	help
 	  Say Y here to enable the matrix keyboard used by ChromeOS devices
 	  and implemented on the ChromeOS EC. You must enable one bus option
-- 
2.4.3
