From: David Brownell <dmitry.torokhov@gmail.com>
Subject: [PATCH 24/37] Input: omap-keypad - fix build warning
Date: Tue, 15 Apr 2008 01:31:33 -0400
Message-ID: <da3e4c885e5ebbccc8181f53d8ae74c4c22d506f.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:9129 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759874AbYDUNS6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:18:58 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106316waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:18:58 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

Fix the following build warning:

drivers/input/keyboard/omap-keypad.c: In function 'omap_kp_probe':
drivers/input/keyboard/omap-keypad.c:418: warning: 'row_idx' is used uninitialized in this function
drivers/input/keyboard/omap-keypad.c:421: warning: 'col_idx' is used uninitialized in this function

These variables are useful when cpu_is_omap24xx(), and otherwise just
for useless cleanup.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/keyboard/omap-keypad.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index babc913..eec3281 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -352,6 +352,9 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 			}
 			omap_set_gpio_direction(row_gpios[row_idx], 1);
 		}
+	} else {
+		col_idx = 0;
+		row_idx = 0;
 	}
 
 	setup_timer(&omap_kp->timer, omap_kp_timer, (unsigned long)omap_kp);
@@ -415,10 +418,10 @@ err4:
 err3:
 	device_remove_file(&pdev->dev, &dev_attr_enable);
 err2:
-	for (i = row_idx-1; i >=0; i--)
+	for (i = row_idx - 1; i >=0; i--)
 		omap_free_gpio(row_gpios[i]);
 err1:
-	for (i = col_idx-1; i >=0; i--)
+	for (i = col_idx - 1; i >=0; i--)
 		omap_free_gpio(col_gpios[i]);
 
 	kfree(omap_kp);
-- 
1.5.5.rc2.6.gf58d


