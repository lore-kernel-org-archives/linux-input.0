From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.25-rc8] omap-keypad: fix build warning
Date: Fri, 11 Apr 2008 01:09:18 -0700
Message-ID: <200804110109.19349.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:28791 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750743AbYDKIJV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2008 04:09:21 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz

From: David Brownell <dbrownell@users.sourceforge.net>

Build fixes:

drivers/input/keyboard/omap-keypad.c: In function 'omap_kp_probe':
drivers/input/keyboard/omap-keypad.c:418: warning: 'row_idx' is used uninitialized in this function
drivers/input/keyboard/omap-keypad.c:421: warning: 'col_idx' is used uninitialized in this function

These variables are useful when cpu_is_omap24xx(), and otherwise just
for useless cleanup.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
This has been in the OMAP tree since 24-Feb.

 drivers/input/keyboard/omap-keypad.c |    3 +++
 1 files changed, 3 insertions(+)

--- a/drivers/input/keyboard/omap-keypad.c	2008-02-24 18:50:32.000000000 -0800
+++ b/drivers/input/keyboard/omap-keypad.c	2008-02-24 19:10:17.000000000 -0800
@@ -352,6 +352,9 @@ static int __init omap_kp_probe(struct p
 			}
 			omap_set_gpio_direction(row_gpios[row_idx], 1);
 		}
+	} else {
+		col_idx = 0;
+		row_idx = 0;
 	}
 
 	setup_timer(&omap_kp->timer, omap_kp_timer, (unsigned long)omap_kp);
