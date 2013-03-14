From: Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH] drivers: misc: use module_platform_driver_probe()
Date: Thu, 14 Mar 2013 14:11:22 +0100
Message-ID: <1363266691-15757-3-git-send-email-fabio.porcedda@gmail.com>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-ide@vger.kernel.org, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-input@vger.kernel.org

This patch converts the drivers to use the
module_platform_driver_probe() macro which makes the code smaller and
a bit simpler.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/arm-charlcd.c | 13 +------------
 drivers/misc/atmel_pwm.c   | 12 +-----------
 drivers/misc/ep93xx_pwm.c  | 13 +------------
 3 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/arm-charlcd.c b/drivers/misc/arm-charlcd.c
index fe8616a..48651ef 100644
--- a/drivers/misc/arm-charlcd.c
+++ b/drivers/misc/arm-charlcd.c
@@ -378,18 +378,7 @@ static struct platform_driver charlcd_driver = {
 	.remove = __exit_p(charlcd_remove),
 };
 
-static int __init charlcd_init(void)
-{
-	return platform_driver_probe(&charlcd_driver, charlcd_probe);
-}
-
-static void __exit charlcd_exit(void)
-{
-	platform_driver_unregister(&charlcd_driver);
-}
-
-module_init(charlcd_init);
-module_exit(charlcd_exit);
+module_platform_driver_probe(charlcd_driver, charlcd_probe);
 
 MODULE_AUTHOR("Linus Walleij <triad@df.lth.se>");
 MODULE_DESCRIPTION("ARM Character LCD Driver");
diff --git a/drivers/misc/atmel_pwm.c b/drivers/misc/atmel_pwm.c
index 28f5aaa..494d050 100644
--- a/drivers/misc/atmel_pwm.c
+++ b/drivers/misc/atmel_pwm.c
@@ -393,17 +393,7 @@ static struct platform_driver atmel_pwm_driver = {
 	 */
 };
 
-static int __init pwm_init(void)
-{
-	return platform_driver_probe(&atmel_pwm_driver, pwm_probe);
-}
-module_init(pwm_init);
-
-static void __exit pwm_exit(void)
-{
-	platform_driver_unregister(&atmel_pwm_driver);
-}
-module_exit(pwm_exit);
+module_platform_driver_probe(atmel_pwm_driver, pwm_probe);
 
 MODULE_DESCRIPTION("Driver for AT32/AT91 PWM module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/misc/ep93xx_pwm.c b/drivers/misc/ep93xx_pwm.c
index 16d7179..96787ec 100644
--- a/drivers/misc/ep93xx_pwm.c
+++ b/drivers/misc/ep93xx_pwm.c
@@ -365,18 +365,7 @@ static struct platform_driver ep93xx_pwm_driver = {
 	.remove		= __exit_p(ep93xx_pwm_remove),
 };
 
-static int __init ep93xx_pwm_init(void)
-{
-	return platform_driver_probe(&ep93xx_pwm_driver, ep93xx_pwm_probe);
-}
-
-static void __exit ep93xx_pwm_exit(void)
-{
-	platform_driver_unregister(&ep93xx_pwm_driver);
-}
-
-module_init(ep93xx_pwm_init);
-module_exit(ep93xx_pwm_exit);
+module_platform_driver_probe(ep93xx_pwm_driver, ep93xx_pwm_probe);
 
 MODULE_AUTHOR("Matthieu Crapet <mcrapet@gmail.com>, "
 	      "H Hartley Sweeten <hsweeten@visionengravers.com>");
-- 
1.8.1.5
