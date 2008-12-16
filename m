From: Deepak Saxena <dsaxena@laptop.org>
Subject: [PATCH 1/2] Add module parameters to control OLPC touchpad delays
Date: Tue, 16 Dec 2008 11:35:00 -0800
Message-ID: <20081216193500.GA15380@trantor.hsd1.or.comcast.net>
Reply-To: dsaxena@laptop.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plexity.net ([206.123.115.38]:39664 "EHLO plexity.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758240AbYLPToS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2008 14:44:18 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: pgf@laptop.org, Andres Salomon <dilinger@queued.net>

The HPGK touchpad that is found on the XO driver has
historically exhibitted eratic behaviour in various
environments (very dry, very humid, etc) that can be
worked around via some delays. This patch turns those
delays into module parameters to make testing simpler.

Signed-off-by: Paul Fox <pgf@laptop.org>
Signed-off-by: Deepak Saxena <dsaxena@laptop.org>
---
 drivers/input/mouse/hgpk.c |   32 ++++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 88f04bf..39cce65 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -48,6 +48,30 @@ module_param(recalib_delta, int, 0644);
 MODULE_PARM_DESC(recalib_delta,
 	"packets containing a delta this large will cause a recalibration.");
 
+static int jumpy_delay = 1000;
+module_param(jumpy_delay, int, 0644);
+MODULE_PARM_DESC(jumpy_delay,
+	"delay (ms) before recal after jumpiness detected");
+
+static int spew_delay = 1000;
+module_param(spew_delay, int, 0644);
+MODULE_PARM_DESC(spew_delay,
+	"delay (ms) before recal after packet spew detected");
+
+static int recal_guard_time = 2000;
+module_param(recal_guard_time, int, 0644);
+MODULE_PARM_DESC(recal_guard_time,
+	"interval (ms) during which recal will be restarted if packet received");
+
+static int post_interrupt_delay = 1000;
+module_param(post_interrupt_delay, int, 0644);
+MODULE_PARM_DESC(post_interrupt_delay,
+	"delay (ms) before recal after recal interrupt detected");
+
+static int autorecal = 1;
+module_param(autorecal, int, 0644);
+MODULE_PARM_DESC(autorecal, "enable recalibration in the driver?");
+
 /*
  * When the touchpad gets ultra-sensitive, one can keep their finger 1/2"
  * above the pad and still have it send packets.  This causes a jump cursor
@@ -66,7 +90,7 @@ static void hgpk_jumpy_hack(struct psmouse *psmouse, int x, int y)
 		/* My car gets forty rods to the hogshead and that's the
 		 * way I likes it! */
 		psmouse_queue_work(psmouse, &priv->recalib_wq,
-				msecs_to_jiffies(1000));
+				msecs_to_jiffies(jumpy_delay));
 	}
 }
 
@@ -103,7 +127,7 @@ static void hgpk_spewing_hack(struct psmouse *psmouse,
 			hgpk_dbg(psmouse, "packet spew detected (%d,%d)\n",
 				 priv->x_tally, priv->y_tally);
 			psmouse_queue_work(psmouse, &priv->recalib_wq,
-					   msecs_to_jiffies(1000));
+					   msecs_to_jiffies(spew_delay));
 		}
 		/* reset every 100 packets */
 		priv->count = 0;
@@ -181,7 +205,7 @@ static psmouse_ret_t hgpk_process_byte(struct psmouse *psmouse)
 				 "packet inside calibration window, "
 				 "queueing another recalibration\n");
 			psmouse_queue_work(psmouse, &priv->recalib_wq,
-					msecs_to_jiffies(1000));
+					msecs_to_jiffies(post_interrupt_delay));
 		}
 		priv->recalib_window = 0;
 	}
@@ -231,7 +255,7 @@ static int hgpk_force_recalibrate(struct psmouse *psmouse)
 	 * If someone's finger *was* on the touchpad, it's probably
 	 * miscalibrated.  So, we should schedule another recalibration
 	 */
-	priv->recalib_window = jiffies +  msecs_to_jiffies(2000);
+	priv->recalib_window = jiffies +  msecs_to_jiffies(recal_guard_time);
 
 	return 0;
 }
-- 
 Deepak Saxena - Kernel Developer, One Laptop Per Child
   _____   __o                                   (o>
------    -\<,  Give One Laptop, Get One Laptop  //\
 ----- ( )/ ( )  http://www.amazon.com/xo        V_/_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
