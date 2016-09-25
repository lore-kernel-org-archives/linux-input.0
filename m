From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 3/3] Input-gameport: Replace some printk() calls by
 pr_info() in joydump_connect()
Date: Sun, 25 Sep 2016 09:15:11 +0200
Message-ID: <814f7993-de4b-05d8-845e-3f0230122061@users.sourceforge.net>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
 <f486d64d-0759-9cd6-1e4e-df723acb6fea@users.sourceforge.net>
 <1474733610.23838.2.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:49739 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934317AbcIYHP2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 25 Sep 2016 03:15:28 -0400
In-Reply-To: <1474733610.23838.2.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 25 Sep 2016 08:40:34 +0200

1. Add a definition for the macros "MY_LOG_PREFIX" and "pr_fmt" so that
   their information can be used for consistent message output.

2. Prefer usage of the macro "pr_info" over the interface "printk"
   in this function.

3. Reduce number of output function calls.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2: Yesterday a software development discussion pointed weaknesses out around
    the previous update steps "3" and "4".
    Now I propose this update variant in the hope that my second approach
    for this software module will work as desired and can be accepted
    a bit easier.

    Will the script "checkpatch.pl" need another improvement so that
    the following information can be avoided for my use case anyhow?

    ERROR: Macros with complex values should be enclosed in parentheses


 drivers/input/joystick/joydump.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
index f9f6cbe..e23c499 100644
--- a/drivers/input/joystick/joydump.c
+++ b/drivers/input/joystick/joydump.c
@@ -27,6 +27,8 @@
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
+#define MY_LOG_PREFIX KBUILD_MODNAME ": "
+#define pr_fmt(fmt) MY_LOG_PREFIX fmt
 #include <linux/module.h>
 #include <linux/gameport.h>
 #include <linux/kernel.h>
@@ -55,27 +57,31 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
 	unsigned long flags;
 	unsigned char u;
 
-	printk(KERN_INFO "joydump: ,------------------ START ----------------.\n");
-	printk(KERN_INFO "joydump: | Dumping: %30s |\n", gameport->phys);
-	printk(KERN_INFO "joydump: | Speed: %28d kHz |\n", gameport->speed);
+	pr_info(",------------------ START ----------------.\n"
+		MY_LOG_PREFIX "| Dumping: %30s |\n"
+		MY_LOG_PREFIX "| Speed: %28d kHz |\n",
+		gameport->phys,
+		gameport->speed);
 
 	if (gameport_open(gameport, drv, GAMEPORT_MODE_RAW)) {
-
-		printk(KERN_INFO "joydump: | Raw mode not available - trying cooked.    |\n");
-
+		pr_info("| Raw mode not available - trying cooked.    |\n");
 		if (gameport_open(gameport, drv, GAMEPORT_MODE_COOKED)) {
-
-			printk(KERN_INFO "joydump: | Cooked not available either. Failing.   |\n");
-			printk(KERN_INFO "joydump: `------------------- END -----------------'\n");
+			pr_info("| Cooked not available either. Failing.   |\n"
+				MY_LOG_PREFIX
+				"`------------------- END -----------------'\n");
 			return -ENODEV;
 		}
 
 		gameport_cooked_read(gameport, axes, &buttons);
 
 		for (i = 0; i < 4; i++)
-			printk(KERN_INFO "joydump: | Axis %d: %4d.                           |\n", i, axes[i]);
-		printk(KERN_INFO "joydump: | Buttons %02x.                             |\n", buttons);
-		printk(KERN_INFO "joydump: `------------------- END -----------------'\n");
+			pr_info("| Axis %d: %4d.                           |\n",
+				i,
+				axes[i]);
+		pr_info("| Buttons %02x.                             |\n"
+			MY_LOG_PREFIX
+			"`------------------- END -----------------'\n",
+			buttons);
 	}
 
 	timeout = gameport_time(gameport, 10000); /* 10 ms */
@@ -119,16 +125,15 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
 	t = i;
 	dump = buf;
 	prev = dump;
-
-	printk(KERN_INFO "joydump: >------------------ DATA -----------------<\n");
-	printk(KERN_INFO "joydump: | index: %3d delta: %3d us data: ", 0, 0);
+	pr_info(">------------------ DATA -----------------<\n"
+		MY_LOG_PREFIX "| index: %3d delta: %3d us data: ", 0, 0);
 	for (j = 7; j >= 0; j--)
 		printk("%d", (dump->data >> j) & 1);
 	printk(" |\n");
 	dump++;
 
 	for (i = 1; i < t; i++, dump++, prev++) {
-		printk(KERN_INFO "joydump: | index: %3d delta: %3d us data: ",
+		pr_info("| index: %3d delta: %3d us data: ",
 			i, dump->time - prev->time);
 		for (j = 7; j >= 0; j--)
 			printk("%d", (dump->data >> j) & 1);
@@ -137,8 +142,7 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
 	kfree(buf);
 
 jd_end:
-	printk(KERN_INFO "joydump: `------------------- END -----------------'\n");
-
+	pr_info("`------------------- END -----------------'\n");
 	return 0;
 }
 
-- 
2.10.0

