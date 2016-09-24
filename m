From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/4] Input-gameport: Replace some printk() calls by pr_info()
 in joydump_connect()
Date: Sat, 24 Sep 2016 15:50:36 +0200
Message-ID: <f486d64d-0759-9cd6-1e4e-df723acb6fea@users.sourceforge.net>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:57199 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933339AbcIXNul (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 24 Sep 2016 09:50:41 -0400
In-Reply-To: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 15:12:21 +0200

* Prefer usage of the macro "pr_info" over the interface "printk"
  in this function.

* Reduce number of output function calls.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/joystick/joydump.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
index a38f10e..02ea60c 100644
--- a/drivers/input/joystick/joydump.c
+++ b/drivers/input/joystick/joydump.c
@@ -57,27 +57,29 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
 	unsigned long flags;
 	unsigned char u;
 
-	printk(KERN_INFO "joydump: ,------------------ START ----------------.\n");
-	printk(KERN_INFO "joydump: | Dumping: %30s |\n", gameport->phys);
-	printk(KERN_INFO "joydump: | Speed: %28d kHz |\n", gameport->speed);
+	pr_info(",------------------ START ----------------.\n"
+		"| Dumping: %30s |\n"
+		"| Speed: %28d kHz |\n",
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
+			"`------------------- END -----------------'\n",
+			buttons);
 	}
 
 	timeout = gameport_time(gameport, 10000); /* 10 ms */
@@ -121,16 +123,15 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
 	t = i;
 	dump = buf;
 	prev = dump;
-
-	printk(KERN_INFO "joydump: >------------------ DATA -----------------<\n");
-	printk(KERN_INFO "joydump: | index: %3d delta: %3d us data: ", 0, 0);
+	pr_info(">------------------ DATA -----------------<\n"
+		"| index: %3d delta: %3d us data: ", 0, 0);
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
@@ -139,8 +140,7 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
 	kfree(buf);
 
 jd_end:
-	printk(KERN_INFO "joydump: `------------------- END -----------------'\n");
-
+	pr_info("`------------------- END -----------------'\n");
 	return 0;
 }
 
-- 
2.10.0

