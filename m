From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] input: touchscreen: fix wm97xx-ts exit path
Date: Sat, 13 Oct 2018 10:06:18 -0700
Message-ID: <c522fb84-20cd-39e6-bd2d-79ed8709fd5d@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
List-Id: linux-input@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Loading then unloading wm97xx-ts.ko when CONFIG_AC97_BUS=m
causes a WARNING: from drivers/base/driver.c:

Unexpected driver unregister!
WARNING: CPU: 0 PID: 1709 at ../drivers/base/driver.c:193 driver_unregister+0x30/0x40

Fix this by only calling driver_unregister() with the same
condition that driver_register() is called.

Fixes: ae9d1b5fbd7b ("Input: wm97xx: add new AC97 bus support")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.cirrus.com
Cc: linux-input@vger.kernel.org
---
 drivers/input/touchscreen/wm97xx-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- lnx-419-rc7.orig/drivers/input/touchscreen/wm97xx-core.c
+++ lnx-419-rc7/drivers/input/touchscreen/wm97xx-core.c
@@ -929,7 +929,8 @@ static int __init wm97xx_init(void)
 
 static void __exit wm97xx_exit(void)
 {
-	driver_unregister(&wm97xx_driver);
+	if (IS_BUILTIN(CONFIG_AC97_BUS))
+		driver_unregister(&wm97xx_driver);
 	platform_driver_unregister(&wm97xx_mfd_driver);
 }
 
