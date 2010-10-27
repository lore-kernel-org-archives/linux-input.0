From: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Subject: [PATCH] drivers/in,put/mouse/psmouse-base.c: fix messages to point
 to existing file
Date: Wed, 27 Oct 2010 08:16:28 +0100
Message-ID: <4CC7D1CC.8090008@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch makes it easier to find the file.

Signed-off-by: Yoshitake Kobayashi <yoshitake.kobayashi@toshiba.co.jp>
---
 drivers/input/mouse/psmouse-base.c |   36 ++++++++++++++++++++++++------------
 1 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 73a7af2..ecc476d 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -251,11 +251,13 @@ static int psmouse_handle_byte(struct psmouse *psmouse)
 	switch (rc) {
 	case PSMOUSE_BAD_DATA:
 		if (psmouse->state == PSMOUSE_ACTIVATED) {
-			printk(KERN_WARNING "psmouse.c: %s at %s lost sync at byte %d\n",
+			printk(KERN_WARNING
+				"psmouse-base.c: %s at %s lost sync at byte %d\n",
 				psmouse->name, psmouse->phys, psmouse->pktcnt);
 			if (++psmouse->out_of_sync_cnt == psmouse->resetafter) {
 				__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
-				printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
+				printk(KERN_NOTICE
+					"psmouse-base.c: issuing reconnect request\n");
 				serio_reconnect(psmouse->ps2dev.serio);
 				return -1;
 			}
@@ -267,7 +269,8 @@ static int psmouse_handle_byte(struct psmouse *psmouse)
 		psmouse->pktcnt = 0;
 		if (psmouse->out_of_sync_cnt) {
 			psmouse->out_of_sync_cnt = 0;
-			printk(KERN_NOTICE "psmouse.c: %s at %s - driver resynched.\n",
+			printk(KERN_NOTICE
+				"psmouse-base.c: %s at %s - driver resynched.\n",
 				psmouse->name, psmouse->phys);
 		}
 		break;
@@ -295,7 +298,8 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 		     ((flags & SERIO_PARITY) && !psmouse->ignore_parity))) {
 
 		if (psmouse->state == PSMOUSE_ACTIVATED)
-			printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
+			printk(KERN_WARNING
+				"psmouse-base.c: bad data from KBC -%s%s\n",
 				flags & SERIO_TIMEOUT ? " timeout" : "",
 				flags & SERIO_PARITY ? " bad parity" : "");
 		ps2_cmd_aborted(&psmouse->ps2dev);
@@ -315,8 +319,9 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 
 	if (psmouse->state == PSMOUSE_ACTIVATED &&
 	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
-		printk(KERN_INFO "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
-		       psmouse->name, psmouse->phys, psmouse->pktcnt);
+		printk(KERN_INFO
+			"psmouse-base.c: %s at %s lost synchronization, throwing %d bytes away.\n",
+			psmouse->name, psmouse->phys, psmouse->pktcnt);
 		psmouse->badbyte = psmouse->packet[0];
 		__psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
 		psmouse_queue_work(psmouse, &psmouse->resync_work, 0);
@@ -943,7 +948,9 @@ static int psmouse_probe(struct psmouse *psmouse)
  */
 
 	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_DIS))
-		printk(KERN_WARNING "psmouse.c: Failed to reset mouse on %s\n", ps2dev->serio->phys);
+		printk(KERN_WARNING
+			"psmouse-base.c: Failed to reset mouse on %s\n",
+			ps2dev->serio->phys);
 
 	return 0;
 }
@@ -1005,7 +1012,8 @@ static void psmouse_initialize(struct psmouse *psmouse)
 static void psmouse_activate(struct psmouse *psmouse)
 {
 	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE))
-		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n",
+		printk(KERN_WARNING
+			"psmouse-base.c: Failed to enable mouse on %s\n",
 			psmouse->ps2dev.serio->phys);
 
 	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
@@ -1020,7 +1028,8 @@ static void psmouse_activate(struct psmouse *psmouse)
 static void psmouse_deactivate(struct psmouse *psmouse)
 {
 	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DISABLE))
-		printk(KERN_WARNING "psmouse.c: Failed to deactivate mouse on %s\n",
+		printk(KERN_WARNING
+			"psmouse-base.c: Failed to deactivate mouse on %s\n",
 			psmouse->ps2dev.serio->phys);
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
@@ -1115,14 +1124,16 @@ static void psmouse_resync(struct work_struct *work)
 	}
 
 	if (!enabled) {
-		printk(KERN_WARNING "psmouse.c: failed to re-enable mouse on %s\n",
+		printk(KERN_WARNING
+			"psmouse-base.c: failed to re-enable mouse on %s\n",
 			psmouse->ps2dev.serio->phys);
 		failed = true;
 	}
 
 	if (failed) {
 		psmouse_set_state(psmouse, PSMOUSE_IGNORE);
-		printk(KERN_INFO "psmouse.c: resync failed, issuing reconnect request\n");
+		printk(KERN_INFO
+			"psmouse-base.c: resync failed, issuing reconnect request\n");
 		serio_reconnect(serio);
 	} else
 		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
@@ -1155,7 +1166,8 @@ static void psmouse_cleanup(struct serio *serio)
 	 * Disable stream mode so cleanup routine can proceed undisturbed.
 	 */
 	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DISABLE))
-		printk(KERN_WARNING "psmouse.c: Failed to disable mouse on %s\n",
+		printk(KERN_WARNING
+			"psmouse-base.c: Failed to disable mouse on %s\n",
 			psmouse->ps2dev.serio->phys);
 
 	if (psmouse->cleanup)
-- 
1.7.0.4
