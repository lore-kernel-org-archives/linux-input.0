From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 11/14] input: spear-keyboard: use __maybe_unused to hide pm functions
Date: Wed,  2 Mar 2016 16:59:03 +0100
Message-ID: <1456934350-1389172-12-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The spear keyboard driver uses #ifdef CONFIG_PM to hide its
power management functions, but then uses references from
SIMPLE_DEV_PM_OPS that are only present if both CONFIG_PM
and CONFIG_PM_SLEEP are set, resulting in a warning about unused
functions:

drivers/input/keyboard/spear-keyboard.c:292:12: error: 'spear_kbd_suspend' defined but not used [-Werror=unused-function]
drivers/input/keyboard/spear-keyboard.c:345:12: error: 'spear_kbd_resume' defined but not used [-Werror=unused-function]

This removes the #ifdef and instead uses a __maybe_unused
annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/keyboard/spear-keyboard.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 623d451767e3..8083eaa0524a 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -288,8 +288,7 @@ static int spear_kbd_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int spear_kbd_suspend(struct device *dev)
+static int __maybe_unused spear_kbd_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spear_kbd *kbd = platform_get_drvdata(pdev);
@@ -342,7 +341,7 @@ static int spear_kbd_suspend(struct device *dev)
 	return 0;
 }
 
-static int spear_kbd_resume(struct device *dev)
+static int __maybe_unused spear_kbd_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spear_kbd *kbd = platform_get_drvdata(pdev);
@@ -368,7 +367,6 @@ static int spear_kbd_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(spear_kbd_pm_ops, spear_kbd_suspend, spear_kbd_resume);
 
-- 
2.7.0
