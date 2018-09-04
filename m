From: Colin King <colin.king@canonical.com>
Subject: [PATCH] Input: wm97xx: only unregister wm97xx_driver if it has been registered
Date: Tue,  4 Sep 2018 19:35:05 +0100
Message-ID: <20180904183505.10693-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, patches@opensource.cirrus.com, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where IS_BUILTIN(CONFIG_AC97_BUS)) is not true, the
wm97xx_driver driver is being unregistered even it has not been
previously registered.  Fix this by only unregistering it if
IS_BUILTIN(CONFIG_AC97_BUS)) is true.  This fixes the warning
message:

[  834.111248] ------------[ cut here ]------------
[  834.111248] Unexpected driver unregister!
[  834.111319] WARNING: CPU: 2 PID: 11749 at drivers/base/driver.c:193 driver_unregister+0x3b/0x40
[  834.111319] Modules linked in: wm97xx_ts(-) ....

..and a stack trace.

To easily reproduce this, load and unload the module on a system where
the hardware is not supported.

Fixes: ae9d1b5fbd7b ("Input: wm97xx: add new AC97 bus support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/touchscreen/wm97xx-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 2566b4d8b342..73856c2a8ac0 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -929,7 +929,8 @@ static int __init wm97xx_init(void)
 
 static void __exit wm97xx_exit(void)
 {
-	driver_unregister(&wm97xx_driver);
+	if (IS_BUILTIN(CONFIG_AC97_BUS))
+		driver_unregister(&wm97xx_driver);
 	platform_driver_unregister(&wm97xx_mfd_driver);
 }
 
-- 
2.17.1
