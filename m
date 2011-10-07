From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: psmouse - change log messages from psmouse.c to
 psmouse
Date: Thu, 6 Oct 2011 23:39:26 -0700
Message-ID: <20111007063926.GA32142@core.coreip.homeip.net>
References: <1317273295-4931-1-git-send-email-jj_ding@emc.com.tw>
 <4E83FF81.700@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60189 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab1JGGjd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 02:39:33 -0400
Received: by iakk32 with SMTP id k32so3853176iak.19
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2011 23:39:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E83FF81.700@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, JJ Ding <dgdunix@gmail.com>

Hi JJ, Wanlong,

On Thu, Sep 29, 2011 at 01:17:53PM +0800, Wanlong Gao wrote:
> On 09/29/2011 01:14 PM, JJ Ding wrote:
> 
> > From: JJ Ding <dgdunix@gmail.com>
> > 
> > psmouse.c had long been renamed to psmouse-base.c back in 2003, when we
> > were still at Linux 2.5.xx. This change makes the log less misleading.
> > 
> > Signed-off-by: JJ Ding <dgdunix@gmail.com>
> 
> Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> 

Actually, I (and other people) wanted to go through psmouse logging and
make it all consistent. What do you think about the patch below?

Thanks.

-- 
Dmitry

Input: psmouse - switch to using dev_*() for messages

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This will ensure our reporting is consistent with the rest of the system
and we do not refer to obsolete source file names.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/alps.c         |   52 +++++++++++-----------
 drivers/input/mouse/elantech.c     |   84 ++++++++++++++++++++----------------
 drivers/input/mouse/hgpk.c         |   84 ++++++++++++++++++------------------
 drivers/input/mouse/hgpk.h         |   11 -----
 drivers/input/mouse/lifebook.c     |    6 +--
 drivers/input/mouse/logips2pp.c    |   16 +++----
 drivers/input/mouse/psmouse-base.c |   67 +++++++++++++++++-----------
 drivers/input/mouse/psmouse.h      |   25 +++++++++++
 drivers/input/mouse/sentelic.c     |   13 +++---
 drivers/input/mouse/synaptics.c    |   85 ++++++++++++++++++++----------------
 10 files changed, 245 insertions(+), 198 deletions(-)


diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 99d5876..003587c 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -23,13 +23,6 @@
 #include "psmouse.h"
 #include "alps.h"
 
-#undef DEBUG
-#ifdef DEBUG
-#define dbg(format, arg...) printk(KERN_INFO "alps.c: " format "\n", ## arg)
-#else
-#define dbg(format, arg...) do {} while (0)
-#endif
-
 #define ALPS_OLDPROTO		0x01	/* old style input */
 #define ALPS_DUALPOINT		0x02	/* touchpad has trackstick */
 #define ALPS_PASS		0x04	/* device has a pass-through port */
@@ -297,10 +290,10 @@ static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
 		      psmouse->packet[4] |
 		      psmouse->packet[5]) & 0x80) ||
 		    (!alps_is_valid_first_byte(priv->i, psmouse->packet[6]))) {
-			dbg("refusing packet %x %x %x %x "
-			    "(suspected interleaved ps/2)\n",
-			    psmouse->packet[3], psmouse->packet[4],
-			    psmouse->packet[5], psmouse->packet[6]);
+			psmouse_dbg(psmouse,
+				    "refusing packet %x %x %x %x (suspected interleaved ps/2)\n",
+				    psmouse->packet[3], psmouse->packet[4],
+				    psmouse->packet[5], psmouse->packet[6]);
 			return PSMOUSE_BAD_DATA;
 		}
 
@@ -319,13 +312,13 @@ static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
 		 * There is also possibility that we got 6-byte ALPS
 		 * packet followed  by 3-byte packet from trackpoint. We
 		 * can not distinguish between these 2 scenarios but
-		 * becase the latter is unlikely to happen in course of
+		 * because the latter is unlikely to happen in course of
 		 * normal operation (user would need to press all
 		 * buttons on the pad and start moving trackpoint
 		 * without touching the pad surface) we assume former.
 		 * Even if we are wrong the wost thing that would happen
 		 * the cursor would jump but we should not get protocol
-		 * desynchronization.
+		 * de-synchronization.
 		 */
 
 		alps_report_bare_ps2_packet(psmouse, &psmouse->packet[3],
@@ -361,10 +354,10 @@ static void alps_flush_packet(unsigned long data)
 		if ((psmouse->packet[3] |
 		     psmouse->packet[4] |
 		     psmouse->packet[5]) & 0x80) {
-			dbg("refusing packet %x %x %x "
-			    "(suspected interleaved ps/2)\n",
-			    psmouse->packet[3], psmouse->packet[4],
-			    psmouse->packet[5]);
+			psmouse_dbg(psmouse,
+				    "refusing packet %x %x %x (suspected interleaved ps/2)\n",
+				    psmouse->packet[3], psmouse->packet[4],
+				    psmouse->packet[5]);
 		} else {
 			alps_process_packet(psmouse);
 		}
@@ -396,16 +389,18 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 	}
 
 	if (!alps_is_valid_first_byte(model, psmouse->packet[0])) {
-		dbg("refusing packet[0] = %x (mask0 = %x, byte0 = %x)\n",
-		    psmouse->packet[0], model->mask0, model->byte0);
+		psmouse_dbg(psmouse,
+			    "refusing packet[0] = %x (mask0 = %x, byte0 = %x)\n",
+			    psmouse->packet[0], model->mask0, model->byte0);
 		return PSMOUSE_BAD_DATA;
 	}
 
 	/* Bytes 2 - 6 should have 0 in the highest bit */
 	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 6 &&
 	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80)) {
-		dbg("refusing packet[%i] = %x\n",
-		    psmouse->pktcnt - 1, psmouse->packet[psmouse->pktcnt - 1]);
+		psmouse_dbg(psmouse, "refusing packet[%i] = %x\n",
+			    psmouse->pktcnt - 1,
+			    psmouse->packet[psmouse->pktcnt - 1]);
 		return PSMOUSE_BAD_DATA;
 	}
 
@@ -439,7 +434,8 @@ static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
 		return NULL;
 
-	dbg("E6 report: %2.2x %2.2x %2.2x", param[0], param[1], param[2]);
+	psmouse_dbg(psmouse, "E6 report: %2.2x %2.2x %2.2x",
+		    param[0], param[1], param[2]);
 
 	if (param[0] != 0 || param[1] != 0 || (param[2] != 10 && param[2] != 100))
 		return NULL;
@@ -459,7 +455,8 @@ static const struct alps_model_info *alps_get_model(struct psmouse *psmouse, int
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
 		return NULL;
 
-	dbg("E7 report: %2.2x %2.2x %2.2x", param[0], param[1], param[2]);
+	psmouse_dbg(psmouse, "E7 report: %2.2x %2.2x %2.2x",
+		    param[0], param[1], param[2]);
 
 	if (version) {
 		for (i = 0; i < ARRAY_SIZE(rates) && param[2] != rates[i]; i++)
@@ -527,7 +524,8 @@ static int alps_get_status(struct psmouse *psmouse, char *param)
 	    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
 		return -1;
 
-	dbg("Status: %2.2x %2.2x %2.2x", param[0], param[1], param[2]);
+	psmouse_dbg(psmouse, "Status: %2.2x %2.2x %2.2x",
+		    param[0], param[1], param[2]);
 
 	return 0;
 }
@@ -605,12 +603,12 @@ static int alps_hw_init(struct psmouse *psmouse)
 	}
 
 	if (alps_tap_mode(psmouse, true)) {
-		printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
+		psmouse_warn(psmouse, "Failed to enable hardware tapping\n");
 		return -1;
 	}
 
 	if (alps_absolute_mode(psmouse)) {
-		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
+		psmouse_err(psmouse, "Failed to enable absolute mode\n");
 		return -1;
 	}
 
@@ -621,7 +619,7 @@ static int alps_hw_init(struct psmouse *psmouse)
 
 	/* ALPS needs stream mode, otherwise it won't report any data */
 	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSTREAM)) {
-		printk(KERN_ERR "alps.c: Failed to enable stream mode\n");
+		psmouse_err(psmouse, "Failed to enable stream mode\n");
 		return -1;
 	}
 
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 25290b3..09b93b1 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -10,8 +10,6 @@
  * Trademarks are the property of their respective owners.
  */
 
-#define pr_fmt(fmt) KBUILD_BASENAME ": " fmt
-
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -25,7 +23,8 @@
 #define elantech_debug(fmt, ...)					\
 	do {								\
 		if (etd->debug)						\
-			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
+			psmouse_printk(KERN_DEBUG, psmouse,		\
+					fmt, ##__VA_ARGS__);		\
 	} while (0)
 
 /*
@@ -36,7 +35,7 @@ static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c,
 {
 	if (psmouse_sliced_command(psmouse, c) ||
 	    ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETINFO)) {
-		pr_err("synaptics_send_cmd query 0x%02x failed.\n", c);
+		psmouse_err(psmouse, "%s query 0x%02x failed.\n", __func__, c);
 		return -1;
 	}
 
@@ -65,7 +64,7 @@ static int elantech_ps2_command(struct psmouse *psmouse,
 	} while (tries > 0);
 
 	if (rc)
-		pr_err("ps2 command 0x%02x failed.\n", command);
+		psmouse_err(psmouse, "ps2 command 0x%02x failed.\n", command);
 
 	return rc;
 }
@@ -117,7 +116,7 @@ static int elantech_read_reg(struct psmouse *psmouse, unsigned char reg,
 	}
 
 	if (rc)
-		pr_err("failed to read register 0x%02x.\n", reg);
+		psmouse_err(psmouse, "failed to read register 0x%02x.\n", reg);
 	else if (etd->hw_version != 4)
 		*val = param[0];
 	else
@@ -191,8 +190,9 @@ static int elantech_write_reg(struct psmouse *psmouse, unsigned char reg,
 	}
 
 	if (rc)
-		pr_err("failed to write register 0x%02x with value 0x%02x.\n",
-			reg, val);
+		psmouse_err(psmouse,
+			    "failed to write register 0x%02x with value 0x%02x.\n",
+			    reg, val);
 
 	return rc;
 }
@@ -200,13 +200,13 @@ static int elantech_write_reg(struct psmouse *psmouse, unsigned char reg,
 /*
  * Dump a complete mouse movement packet to the syslog
  */
-static void elantech_packet_dump(unsigned char *packet, int size)
+static void elantech_packet_dump(struct psmouse *psmouse)
 {
 	int	i;
 
-	printk(KERN_DEBUG pr_fmt("PS/2 packet ["));
-	for (i = 0; i < size; i++)
-		printk("%s0x%02x ", (i) ? ", " : " ", packet[i]);
+	psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [");
+	for (i = 0; i < psmouse->pktsize; i++)
+		printk("%s0x%02x ", i ? ", " : " ", psmouse->packet[i]);
 	printk("]\n");
 }
 
@@ -705,7 +705,7 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 		return PSMOUSE_GOOD_DATA;
 
 	if (etd->debug > 1)
-		elantech_packet_dump(psmouse->packet, psmouse->pktsize);
+		elantech_packet_dump(psmouse);
 
 	switch (etd->hw_version) {
 	case 1:
@@ -801,7 +801,7 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 		/*
 		 * Read back reg 0x10. For hardware version 1 we must make
 		 * sure the absolute mode bit is set. For hardware version 2
-		 * the touchpad is probably initalising and not ready until
+		 * the touchpad is probably initializing and not ready until
 		 * we read back the value we just wrote.
 		 */
 		do {
@@ -814,17 +814,19 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 		} while (tries > 0);
 
 		if (rc) {
-			pr_err("failed to read back register 0x10.\n");
+			psmouse_err(psmouse,
+				    "failed to read back register 0x10.\n");
 		} else if (etd->hw_version == 1 &&
 			   !(val & ETP_R10_ABSOLUTE_MODE)) {
-			pr_err("touchpad refuses to switch to absolute mode.\n");
+			psmouse_err(psmouse,
+				    "touchpad refuses to switch to absolute mode.\n");
 			rc = -1;
 		}
 	}
 
  skip_readback_reg_10:
 	if (rc)
-		pr_err("failed to initialise registers.\n");
+		psmouse_err(psmouse, "failed to initialise registers.\n");
 
 	return rc;
 }
@@ -1131,7 +1133,7 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
 	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11) ||
 	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11) ||
 	    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO)) {
-		pr_debug("sending Elantech magic knock failed.\n");
+		psmouse_dbg(psmouse, "sending Elantech magic knock failed.\n");
 		return -1;
 	}
 
@@ -1141,8 +1143,9 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
 	 */
 	if (param[0] != 0x3c || param[1] != 0x03 ||
 	    (param[2] != 0xc8 && param[2] != 0x00)) {
-		pr_debug("unexpected magic knock result 0x%02x, 0x%02x, 0x%02x.\n",
-			 param[0], param[1], param[2]);
+		psmouse_dbg(psmouse,
+			    "unexpected magic knock result 0x%02x, 0x%02x, 0x%02x.\n",
+			    param[0], param[1], param[2]);
 		return -1;
 	}
 
@@ -1152,15 +1155,17 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
 	 * to Elantech magic knock and there might be more.
 	 */
 	if (synaptics_send_cmd(psmouse, ETP_FW_VERSION_QUERY, param)) {
-		pr_debug("failed to query firmware version.\n");
+		psmouse_dbg(psmouse, "failed to query firmware version.\n");
 		return -1;
 	}
 
-	pr_debug("Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
-		 param[0], param[1], param[2]);
+	psmouse_dbg(psmouse,
+		    "Elantech version query result 0x%02x, 0x%02x, 0x%02x.\n",
+		    param[0], param[1], param[2]);
 
 	if (!elantech_is_signature_valid(param)) {
-		pr_debug("Probably not a real Elantech touchpad. Aborting.\n");
+		psmouse_dbg(psmouse,
+			    "Probably not a real Elantech touchpad. Aborting.\n");
 		return -1;
 	}
 
@@ -1192,7 +1197,8 @@ static int elantech_reconnect(struct psmouse *psmouse)
 		return -1;
 
 	if (elantech_set_absolute_mode(psmouse)) {
-		pr_err("failed to put touchpad back into absolute mode.\n");
+		psmouse_err(psmouse,
+			    "failed to put touchpad back into absolute mode.\n");
 		return -1;
 	}
 
@@ -1262,42 +1268,46 @@ int elantech_init(struct psmouse *psmouse)
 	 * Do the version query again so we can store the result
 	 */
 	if (synaptics_send_cmd(psmouse, ETP_FW_VERSION_QUERY, param)) {
-		pr_err("failed to query firmware version.\n");
+		psmouse_err(psmouse, "failed to query firmware version.\n");
 		goto init_fail;
 	}
 	etd->fw_version = (param[0] << 16) | (param[1] << 8) | param[2];
 
 	if (elantech_set_properties(etd)) {
-		pr_err("unknown hardware version, aborting...\n");
+		psmouse_err(psmouse, "unknown hardware version, aborting...\n");
 		goto init_fail;
 	}
-	pr_info("assuming hardware version %d "
-		"(with firmware version 0x%02x%02x%02x)\n",
-		etd->hw_version, param[0], param[1], param[2]);
+	psmouse_info(psmouse,
+		     "assuming hardware version %d (with firmware version 0x%02x%02x%02x)\n",
+		     etd->hw_version, param[0], param[1], param[2]);
 
 	if (synaptics_send_cmd(psmouse, ETP_CAPABILITIES_QUERY,
 	    etd->capabilities)) {
-		pr_err("failed to query capabilities.\n");
+		psmouse_err(psmouse, "failed to query capabilities.\n");
 		goto init_fail;
 	}
-	pr_info("Synaptics capabilities query result 0x%02x, 0x%02x, 0x%02x.\n",
-		etd->capabilities[0], etd->capabilities[1],
-		etd->capabilities[2]);
+	psmouse_info(psmouse,
+		     "Synaptics capabilities query result 0x%02x, 0x%02x, 0x%02x.\n",
+		     etd->capabilities[0], etd->capabilities[1],
+		     etd->capabilities[2]);
 
 	if (elantech_set_absolute_mode(psmouse)) {
-		pr_err("failed to put touchpad into absolute mode.\n");
+		psmouse_err(psmouse,
+			    "failed to put touchpad into absolute mode.\n");
 		goto init_fail;
 	}
 
 	if (elantech_set_input_params(psmouse)) {
-		pr_err("failed to query touchpad range.\n");
+		psmouse_err(psmouse, "failed to query touchpad range.\n");
 		goto init_fail;
 	}
 
 	error = sysfs_create_group(&psmouse->ps2dev.serio->dev.kobj,
 				   &elantech_attr_group);
 	if (error) {
-		pr_err("failed to create sysfs attributes, error: %d.\n", error);
+		psmouse_err(psmouse,
+			    "failed to create sysfs attributes, error: %d.\n",
+			    error);
 		goto init_fail;
 	}
 
diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 4d17d9f..0470dd4 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -136,10 +136,10 @@ static int hgpk_discard_decay_hack(struct psmouse *psmouse, int x, int y)
 	/* discard if too big, or half that but > 4 times the prev delta */
 	if (avx > recalib_delta ||
 		(avx > recalib_delta / 2 && ((avx / 4) > priv->xlast))) {
-		hgpk_err(psmouse, "detected %dpx jump in x\n", x);
+		psmouse_warn(psmouse, "detected %dpx jump in x\n", x);
 		priv->xbigj = avx;
 	} else if (approx_half(avx, priv->xbigj)) {
-		hgpk_err(psmouse, "detected secondary %dpx jump in x\n", x);
+		psmouse_warn(psmouse, "detected secondary %dpx jump in x\n", x);
 		priv->xbigj = avx;
 		priv->xsaw_secondary++;
 	} else {
@@ -151,10 +151,10 @@ static int hgpk_discard_decay_hack(struct psmouse *psmouse, int x, int y)
 
 	if (avy > recalib_delta ||
 		(avy > recalib_delta / 2 && ((avy / 4) > priv->ylast))) {
-		hgpk_err(psmouse, "detected %dpx jump in y\n", y);
+		psmouse_warn(psmouse, "detected %dpx jump in y\n", y);
 		priv->ybigj = avy;
 	} else if (approx_half(avy, priv->ybigj)) {
-		hgpk_err(psmouse, "detected secondary %dpx jump in y\n", y);
+		psmouse_warn(psmouse, "detected secondary %dpx jump in y\n", y);
 		priv->ybigj = avy;
 		priv->ysaw_secondary++;
 	} else {
@@ -168,7 +168,7 @@ static int hgpk_discard_decay_hack(struct psmouse *psmouse, int x, int y)
 	priv->ylast = avy;
 
 	if (do_recal && jumpy_delay) {
-		hgpk_err(psmouse, "scheduling recalibration\n");
+		psmouse_warn(psmouse, "scheduling recalibration\n");
 		psmouse_queue_work(psmouse, &priv->recalib_wq,
 				msecs_to_jiffies(jumpy_delay));
 	}
@@ -260,8 +260,8 @@ static void hgpk_spewing_hack(struct psmouse *psmouse,
 		 * movement, it is probably a case of the user moving the
 		 * cursor very slowly across the screen. */
 		if (abs(priv->x_tally) < 3 && abs(priv->y_tally) < 3) {
-			hgpk_err(psmouse, "packet spew detected (%d,%d)\n",
-				 priv->x_tally, priv->y_tally);
+			psmouse_warn(psmouse, "packet spew detected (%d,%d)\n",
+				     priv->x_tally, priv->y_tally);
 			priv->spew_flag = RECALIBRATING;
 			psmouse_queue_work(psmouse, &priv->recalib_wq,
 					   msecs_to_jiffies(spew_delay));
@@ -333,12 +333,12 @@ static bool hgpk_is_byte_valid(struct psmouse *psmouse, unsigned char *packet)
 	}
 
 	if (!valid)
-		hgpk_dbg(psmouse,
-			 "bad data, mode %d (%d) %02x %02x %02x %02x %02x %02x\n",
-			 priv->mode, pktcnt,
-			 psmouse->packet[0], psmouse->packet[1],
-			 psmouse->packet[2], psmouse->packet[3],
-			 psmouse->packet[4], psmouse->packet[5]);
+		psmouse_dbg(psmouse,
+			    "bad data, mode %d (%d) %02x %02x %02x %02x %02x %02x\n",
+			    priv->mode, pktcnt,
+			    psmouse->packet[0], psmouse->packet[1],
+			    psmouse->packet[2], psmouse->packet[3],
+			    psmouse->packet[4], psmouse->packet[5]);
 
 	return valid;
 }
@@ -361,19 +361,20 @@ static void hgpk_process_advanced_packet(struct psmouse *psmouse)
 
 		input_report_abs(idev, ABS_PRESSURE, z);
 		if (tpdebug)
-			hgpk_dbg(psmouse, "pd=%d fd=%d z=%d",
-				 pt_down, finger_down, z);
+			psmouse_dbg(psmouse, "pd=%d fd=%d z=%d",
+				    pt_down, finger_down, z);
 	} else {
 		/*
 		 * PenTablet mode does not report pressure, so we don't
 		 * report it here
 		 */
 		if (tpdebug)
-			hgpk_dbg(psmouse, "pd=%d ", down);
+			psmouse_dbg(psmouse, "pd=%d ", down);
 	}
 
 	if (tpdebug)
-		hgpk_dbg(psmouse, "l=%d r=%d x=%d y=%d\n", left, right, x, y);
+		psmouse_dbg(psmouse, "l=%d r=%d x=%d y=%d\n",
+			    left, right, x, y);
 
 	input_report_key(idev, BTN_TOUCH, down);
 	input_report_key(idev, BTN_LEFT, left);
@@ -395,7 +396,7 @@ static void hgpk_process_advanced_packet(struct psmouse *psmouse)
 	if (x == priv->abs_x && y == priv->abs_y) {
 		if (++priv->dupe_count > SPEW_WATCH_COUNT) {
 			if (tpdebug)
-				hgpk_dbg(psmouse, "hard spew detected\n");
+				psmouse_dbg(psmouse, "hard spew detected\n");
 			priv->spew_flag = RECALIBRATING;
 			psmouse_queue_work(psmouse, &priv->recalib_wq,
 					   msecs_to_jiffies(spew_delay));
@@ -412,7 +413,7 @@ static void hgpk_process_advanced_packet(struct psmouse *psmouse)
 		int y_diff = priv->abs_y - y;
 		if (hgpk_discard_decay_hack(psmouse, x_diff, y_diff)) {
 			if (tpdebug)
-				hgpk_dbg(psmouse, "discarding\n");
+				psmouse_dbg(psmouse, "discarding\n");
 			goto done;
 		}
 		hgpk_spewing_hack(psmouse, left, right, x_diff, y_diff);
@@ -437,20 +438,21 @@ static void hgpk_process_simple_packet(struct psmouse *psmouse)
 	int y = ((packet[0] << 3) & 0x100) - packet[2];
 
 	if (packet[0] & 0xc0)
-		hgpk_dbg(psmouse,
-			 "overflow -- 0x%02x 0x%02x 0x%02x\n",
-			 packet[0], packet[1], packet[2]);
+		psmouse_dbg(psmouse,
+			    "overflow -- 0x%02x 0x%02x 0x%02x\n",
+			    packet[0], packet[1], packet[2]);
 
 	if (hgpk_discard_decay_hack(psmouse, x, y)) {
 		if (tpdebug)
-			hgpk_dbg(psmouse, "discarding\n");
+			psmouse_dbg(psmouse, "discarding\n");
 		return;
 	}
 
 	hgpk_spewing_hack(psmouse, left, right, x, y);
 
 	if (tpdebug)
-		hgpk_dbg(psmouse, "l=%d r=%d x=%d y=%d\n", left, right, x, y);
+		psmouse_dbg(psmouse, "l=%d r=%d x=%d y=%d\n",
+			    left, right, x, y);
 
 	input_report_key(dev, BTN_LEFT, left);
 	input_report_key(dev, BTN_RIGHT, right);
@@ -482,9 +484,8 @@ static psmouse_ret_t hgpk_process_byte(struct psmouse *psmouse)
 			 * ugh, got a packet inside our recalibration
 			 * window, schedule another recalibration.
 			 */
-			hgpk_dbg(psmouse,
-				 "packet inside calibration window, "
-				 "queueing another recalibration\n");
+			psmouse_dbg(psmouse,
+				    "packet inside calibration window, queueing another recalibration\n");
 			psmouse_queue_work(psmouse, &priv->recalib_wq,
 					msecs_to_jiffies(post_interrupt_delay));
 		}
@@ -628,7 +629,7 @@ static int hgpk_reset_device(struct psmouse *psmouse, bool recalibrate)
 
 	err = hgpk_select_mode(psmouse);
 	if (err) {
-		hgpk_err(psmouse, "failed to select mode\n");
+		psmouse_err(psmouse, "failed to select mode\n");
 		return err;
 	}
 
@@ -648,11 +649,11 @@ static int hgpk_force_recalibrate(struct psmouse *psmouse)
 		return 0;
 
 	if (!autorecal) {
-		hgpk_dbg(psmouse, "recalibrations disabled, ignoring\n");
+		psmouse_dbg(psmouse, "recalibration disabled, ignoring\n");
 		return 0;
 	}
 
-	hgpk_dbg(psmouse, "recalibrating touchpad..\n");
+	psmouse_dbg(psmouse, "recalibrating touchpad..\n");
 
 	/* we don't want to race with the irq handler, nor with resyncs */
 	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
@@ -675,7 +676,7 @@ static int hgpk_force_recalibrate(struct psmouse *psmouse)
 	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 
 	if (tpdebug)
-		hgpk_dbg(psmouse, "touchpad reactivated\n");
+		psmouse_dbg(psmouse, "touchpad reactivated\n");
 
 	/*
 	 * If we get packets right away after recalibrating, it's likely
@@ -727,16 +728,16 @@ static int hgpk_toggle_powersave(struct psmouse *psmouse, int enable)
 
 		err = hgpk_reset_device(psmouse, false);
 		if (err) {
-			hgpk_err(psmouse, "Failed to reset device!\n");
+			psmouse_err(psmouse, "Failed to reset device!\n");
 			return err;
 		}
 
 		/* should be all set, enable the touchpad */
 		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
 		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
-		hgpk_dbg(psmouse, "Touchpad powered up.\n");
+		psmouse_dbg(psmouse, "Touchpad powered up.\n");
 	} else {
-		hgpk_dbg(psmouse, "Powering off touchpad.\n");
+		psmouse_dbg(psmouse, "Powering off touchpad.\n");
 
 		if (ps2_command(ps2dev, NULL, 0xec) ||
 		    ps2_command(ps2dev, NULL, 0xec) ||
@@ -923,7 +924,7 @@ static void hgpk_recalib_work(struct work_struct *work)
 	struct psmouse *psmouse = priv->psmouse;
 
 	if (hgpk_force_recalibrate(psmouse))
-		hgpk_err(psmouse, "recalibration failed!\n");
+		psmouse_err(psmouse, "recalibration failed!\n");
 }
 
 static int hgpk_register(struct psmouse *psmouse)
@@ -947,14 +948,15 @@ static int hgpk_register(struct psmouse *psmouse)
 	err = device_create_file(&psmouse->ps2dev.serio->dev,
 				 &psmouse_attr_powered.dattr);
 	if (err) {
-		hgpk_err(psmouse, "Failed creating 'powered' sysfs node\n");
+		psmouse_err(psmouse, "Failed creating 'powered' sysfs node\n");
 		return err;
 	}
 
 	err = device_create_file(&psmouse->ps2dev.serio->dev,
 				 &psmouse_attr_hgpk_mode.dattr);
 	if (err) {
-		hgpk_err(psmouse, "Failed creating 'hgpk_mode' sysfs node\n");
+		psmouse_err(psmouse,
+			    "Failed creating 'hgpk_mode' sysfs node\n");
 		goto err_remove_powered;
 	}
 
@@ -963,8 +965,8 @@ static int hgpk_register(struct psmouse *psmouse)
 		err = device_create_file(&psmouse->ps2dev.serio->dev,
 					 &psmouse_attr_recalibrate.dattr);
 		if (err) {
-			hgpk_err(psmouse,
-				"Failed creating 'recalibrate' sysfs node\n");
+			psmouse_err(psmouse,
+				    "Failed creating 'recalibrate' sysfs node\n");
 			goto err_remove_mode;
 		}
 	}
@@ -1027,13 +1029,13 @@ static enum hgpk_model_t hgpk_get_model(struct psmouse *psmouse)
 		return -EIO;
 	}
 
-	hgpk_dbg(psmouse, "ID: %02x %02x %02x\n", param[0], param[1], param[2]);
+	psmouse_dbg(psmouse, "ID: %02x %02x %02x\n", param[0], param[1], param[2]);
 
 	/* HGPK signature: 0x67, 0x00, 0x<model> */
 	if (param[0] != 0x67 || param[1] != 0x00)
 		return -ENODEV;
 
-	hgpk_info(psmouse, "OLPC touchpad revision 0x%x\n", param[2]);
+	psmouse_info(psmouse, "OLPC touchpad revision 0x%x\n", param[2]);
 
 	return param[2];
 }
diff --git a/drivers/input/mouse/hgpk.h b/drivers/input/mouse/hgpk.h
index 311c0e8..dd68677 100644
--- a/drivers/input/mouse/hgpk.h
+++ b/drivers/input/mouse/hgpk.h
@@ -46,17 +46,6 @@ struct hgpk_data {
 	int xsaw_secondary, ysaw_secondary; /* jumpiness detection */
 };
 
-#define hgpk_dbg(psmouse, format, arg...)		\
-	dev_dbg(&(psmouse)->ps2dev.serio->dev, format, ## arg)
-#define hgpk_err(psmouse, format, arg...)		\
-	dev_err(&(psmouse)->ps2dev.serio->dev, format, ## arg)
-#define hgpk_info(psmouse, format, arg...)		\
-	dev_info(&(psmouse)->ps2dev.serio->dev, format, ## arg)
-#define hgpk_warn(psmouse, format, arg...)		\
-	dev_warn(&(psmouse)->ps2dev.serio->dev, format, ## arg)
-#define hgpk_notice(psmouse, format, arg...)		\
-	dev_notice(&(psmouse)->ps2dev.serio->dev, format, ## arg)
-
 #ifdef CONFIG_MOUSE_PS2_OLPC
 void hgpk_module_init(void);
 int hgpk_detect(struct psmouse *psmouse, bool set_properties);
diff --git a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lifebook.c
index 83bcaba..2c4db63 100644
--- a/drivers/input/mouse/lifebook.c
+++ b/drivers/input/mouse/lifebook.c
@@ -169,8 +169,8 @@ static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse)
 
 	if (relative_packet) {
 		if (!dev2)
-			printk(KERN_WARNING "lifebook.c: got relative packet "
-				"but no relative device set up\n");
+			psmouse_warn(psmouse,
+				     "got relative packet but no relative device set up\n");
 	} else {
 		if (lifebook_use_6byte_proto) {
 			input_report_abs(dev1, ABS_X,
@@ -212,7 +212,7 @@ static int lifebook_absolute_mode(struct psmouse *psmouse)
 
 	/*
 	 * Enable absolute output -- ps2_command fails always but if
-	 * you leave this call out the touchsreen will never send
+	 * you leave this call out the touchscreen will never send
 	 * absolute coordinates
 	 */
 	param = lifebook_use_6byte_proto ? 0x08 : 0x07;
diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index c9983ae..faac2c3 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -82,11 +82,11 @@ static psmouse_ret_t ps2pp_process_byte(struct psmouse *psmouse)
 			packet[0] = packet[2] | 0x08;
 			break;
 
-#ifdef DEBUG
 		default:
-			printk(KERN_WARNING "psmouse.c: Received PS2++ packet #%x, but don't know how to handle.\n",
-				(packet[1] >> 4) | (packet[0] & 0x30));
-#endif
+			psmouse_dbg(psmouse,
+				    "Received PS2++ packet #%x, but don't know how to handle.\n",
+				    (packet[1] >> 4) | (packet[0] & 0x30));
+			break;
 		}
 	} else {
 		/* Standard PS/2 motion data */
@@ -382,7 +382,7 @@ int ps2pp_init(struct psmouse *psmouse, bool set_properties)
 		}
 
 	} else {
-		printk(KERN_WARNING "logips2pp: Detected unknown logitech mouse model %d\n", model);
+		psmouse_warn(psmouse, "Detected unknown Logitech mouse model %d\n", model);
 	}
 
 	if (set_properties) {
@@ -400,9 +400,9 @@ int ps2pp_init(struct psmouse *psmouse, bool set_properties)
 				error = device_create_file(&psmouse->ps2dev.serio->dev,
 							   &psmouse_attr_smartscroll.dattr);
 				if (error) {
-					printk(KERN_ERR
-						"logips2pp.c: failed to create smartscroll "
-						"sysfs attribute, error: %d\n", error);
+					psmouse_err(psmouse,
+						    "failed to create smartscroll sysfs attribute, error: %d\n",
+						    error);
 					return -1;
 				}
 			}
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 3f74bae..9f352fb 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -11,6 +11,9 @@
  * the Free Software Foundation.
  */
 
+#define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
+#define psmouse_fmt(fmt)	fmt
+
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -251,11 +254,14 @@ static int psmouse_handle_byte(struct psmouse *psmouse)
 	switch (rc) {
 	case PSMOUSE_BAD_DATA:
 		if (psmouse->state == PSMOUSE_ACTIVATED) {
-			printk(KERN_WARNING "psmouse.c: %s at %s lost sync at byte %d\n",
-				psmouse->name, psmouse->phys, psmouse->pktcnt);
+			psmouse_warn(psmouse,
+				     "%s at %s lost sync at byte %d\n",
+				     psmouse->name, psmouse->phys,
+				     psmouse->pktcnt);
 			if (++psmouse->out_of_sync_cnt == psmouse->resetafter) {
 				__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
-				printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
+				psmouse_notice(psmouse,
+						"issuing reconnect request\n");
 				serio_reconnect(psmouse->ps2dev.serio);
 				return -1;
 			}
@@ -267,8 +273,9 @@ static int psmouse_handle_byte(struct psmouse *psmouse)
 		psmouse->pktcnt = 0;
 		if (psmouse->out_of_sync_cnt) {
 			psmouse->out_of_sync_cnt = 0;
-			printk(KERN_NOTICE "psmouse.c: %s at %s - driver resynched.\n",
-				psmouse->name, psmouse->phys);
+			psmouse_notice(psmouse,
+					"%s at %s - driver resynced.\n",
+					psmouse->name, psmouse->phys);
 		}
 		break;
 
@@ -295,9 +302,10 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 		     ((flags & SERIO_PARITY) && !psmouse->ignore_parity))) {
 
 		if (psmouse->state == PSMOUSE_ACTIVATED)
-			printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
-				flags & SERIO_TIMEOUT ? " timeout" : "",
-				flags & SERIO_PARITY ? " bad parity" : "");
+			psmouse_warn(psmouse,
+				     "bad data from KBC -%s%s\n",
+				     flags & SERIO_TIMEOUT ? " timeout" : "",
+				     flags & SERIO_PARITY ? " bad parity" : "");
 		ps2_cmd_aborted(&psmouse->ps2dev);
 		goto out;
 	}
@@ -315,8 +323,8 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 
 	if (psmouse->state == PSMOUSE_ACTIVATED &&
 	    psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/2)) {
-		printk(KERN_INFO "psmouse.c: %s at %s lost synchronization, throwing %d bytes away.\n",
-		       psmouse->name, psmouse->phys, psmouse->pktcnt);
+		psmouse_info(psmouse, "%s at %s lost synchronization, throwing %d bytes away.\n",
+			     psmouse->name, psmouse->phys, psmouse->pktcnt);
 		psmouse->badbyte = psmouse->packet[0];
 		__psmouse_set_state(psmouse, PSMOUSE_RESYNCING);
 		psmouse_queue_work(psmouse, &psmouse->resync_work, 0);
@@ -943,7 +951,8 @@ static int psmouse_probe(struct psmouse *psmouse)
  */
 
 	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_DIS))
-		printk(KERN_WARNING "psmouse.c: Failed to reset mouse on %s\n", ps2dev->serio->phys);
+		psmouse_warn(psmouse, "Failed to reset mouse on %s\n",
+			     ps2dev->serio->phys);
 
 	return 0;
 }
@@ -1005,8 +1014,8 @@ static void psmouse_initialize(struct psmouse *psmouse)
 static void psmouse_activate(struct psmouse *psmouse)
 {
 	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE))
-		printk(KERN_WARNING "psmouse.c: Failed to enable mouse on %s\n",
-			psmouse->ps2dev.serio->phys);
+		psmouse_warn(psmouse, "Failed to enable mouse on %s\n",
+			     psmouse->ps2dev.serio->phys);
 
 	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
 }
@@ -1020,14 +1029,14 @@ static void psmouse_activate(struct psmouse *psmouse)
 static void psmouse_deactivate(struct psmouse *psmouse)
 {
 	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DISABLE))
-		printk(KERN_WARNING "psmouse.c: Failed to deactivate mouse on %s\n",
-			psmouse->ps2dev.serio->phys);
+		psmouse_warn(psmouse, "Failed to deactivate mouse on %s\n",
+			     psmouse->ps2dev.serio->phys);
 
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 }
 
 /*
- * psmouse_poll() - default poll hanlder. Everyone except for ALPS uses it.
+ * psmouse_poll() - default poll handler. Everyone except for ALPS uses it.
  */
 
 static int psmouse_poll(struct psmouse *psmouse)
@@ -1115,14 +1124,15 @@ static void psmouse_resync(struct work_struct *work)
 	}
 
 	if (!enabled) {
-		printk(KERN_WARNING "psmouse.c: failed to re-enable mouse on %s\n",
-			psmouse->ps2dev.serio->phys);
+		psmouse_warn(psmouse, "failed to re-enable mouse on %s\n",
+			     psmouse->ps2dev.serio->phys);
 		failed = true;
 	}
 
 	if (failed) {
 		psmouse_set_state(psmouse, PSMOUSE_IGNORE);
-		printk(KERN_INFO "psmouse.c: resync failed, issuing reconnect request\n");
+		psmouse_info(psmouse,
+			     "resync failed, issuing reconnect request\n");
 		serio_reconnect(serio);
 	} else
 		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
@@ -1155,8 +1165,8 @@ static void psmouse_cleanup(struct serio *serio)
 	 * Disable stream mode so cleanup routine can proceed undisturbed.
 	 */
 	if (ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_DISABLE))
-		printk(KERN_WARNING "psmouse.c: Failed to disable mouse on %s\n",
-			psmouse->ps2dev.serio->phys);
+		psmouse_warn(psmouse, "Failed to disable mouse on %s\n",
+			     psmouse->ps2dev.serio->phys);
 
 	if (psmouse->cleanup)
 		psmouse->cleanup(psmouse);
@@ -1400,7 +1410,8 @@ static int psmouse_reconnect(struct serio *serio)
 	int rc = -1;
 
 	if (!drv || !psmouse) {
-		printk(KERN_DEBUG "psmouse: reconnect request, but serio is disconnected, ignoring...\n");
+		psmouse_dbg(psmouse,
+			    "reconnect request, but serio is disconnected, ignoring...\n");
 		return -1;
 	}
 
@@ -1427,8 +1438,9 @@ static int psmouse_reconnect(struct serio *serio)
 			goto out;
 	}
 
-	/* ok, the device type (and capabilities) match the old one,
-	 * we can continue using it, complete intialization
+	/*
+	 * OK, the device type (and capabilities) match the old one,
+	 * we can continue using it, complete initialization
 	 */
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
@@ -1586,9 +1598,8 @@ static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, void *data, co
 
 	while (!list_empty(&serio->children)) {
 		if (++retry > 3) {
-			printk(KERN_WARNING
-				"psmouse: failed to destroy children ports, "
-				"protocol change aborted.\n");
+			psmouse_warn(psmouse,
+				     "failed to destroy children ports, protocol change aborted.\n");
 			input_free_device(new_dev);
 			return -EIO;
 		}
@@ -1715,7 +1726,7 @@ static int __init psmouse_init(void)
 
 	kpsmoused_wq = create_singlethread_workqueue("kpsmoused");
 	if (!kpsmoused_wq) {
-		printk(KERN_ERR "psmouse: failed to create kpsmoused workqueue\n");
+		pr_err("failed to create kpsmoused workqueue\n");
 		return -ENOMEM;
 	}
 
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 593e910..9b84b0c 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -150,4 +150,29 @@ static struct psmouse_attribute psmouse_attr_##_name = {			\
 	static ssize_t _set(struct psmouse *, void *, const char *, size_t);	\
 	__PSMOUSE_DEFINE_ATTR_VAR(_name, _mode, _data, NULL, _set, true)
 
+#ifndef psmouse_fmt
+#define psmouse_fmt(fmt)	KBUILD_BASENAME ": " fmt
+#endif
+
+#define psmouse_dbg(psmouse, format, ...)		\
+	dev_dbg(&(psmouse)->ps2dev.serio->dev,		\
+		psmouse_fmt(format), ##__VA_ARGS__)
+#define psmouse_info(psmouse, format, ...)		\
+	dev_info(&(psmouse)->ps2dev.serio->dev,		\
+		 psmouse_fmt(format), ##__VA_ARGS__)
+#define psmouse_warn(psmouse, format, ...)		\
+	dev_warn(&(psmouse)->ps2dev.serio->dev,		\
+		 psmouse_fmt(format), ##__VA_ARGS__)
+#define psmouse_err(psmouse, format, ...)		\
+	dev_err(&(psmouse)->ps2dev.serio->dev,		\
+		psmouse_fmt(format), ##__VA_ARGS__)
+#define psmouse_notice(psmouse, format, ...)		\
+	dev_notice(&(psmouse)->ps2dev.serio->dev,	\
+		   psmouse_fmt(format), ##__VA_ARGS__)
+#define psmouse_printk(level, psmouse, format, ...)	\
+	dev_printk(level,				\
+		   &(psmouse)->ps2dev.serio->dev,	\
+		   psmouse_fmt(format), ##__VA_ARGS__)
+
+
 #endif /* _PSMOUSE_H */
diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index 2fc887a..c5b12d2 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -607,11 +607,12 @@ static void fsp_packet_debug(unsigned char packet[])
 
 	ps2_packet_cnt++;
 	jiffies_msec = jiffies_to_msecs(jiffies);
-	printk(KERN_DEBUG "%08dms PS/2 packets: %02x, %02x, %02x, %02x\n",
-		jiffies_msec, packet[0], packet[1], packet[2], packet[3]);
+	psmouse_dbg(psmouse,
+		    "%08dms PS/2 packets: %02x, %02x, %02x, %02x\n",
+		    jiffies_msec, packet[0], packet[1], packet[2], packet[3]);
 
 	if (jiffies_msec - ps2_last_second > 1000) {
-		printk(KERN_DEBUG "PS/2 packets/sec = %d\n", ps2_packet_cnt);
+		psmouse_dbg(psmouse, "PS/2 packets/sec = %d\n", ps2_packet_cnt);
 		ps2_packet_cnt = 0;
 		ps2_last_second = jiffies_msec;
 	}
@@ -820,9 +821,9 @@ int fsp_init(struct psmouse *psmouse)
 		return -ENODEV;
 	}
 
-	printk(KERN_INFO
-		"Finger Sensing Pad, hw: %d.%d.%d, sw: %s, buttons: %d\n",
-		ver >> 4, ver & 0x0F, rev, fsp_drv_ver, buttons & 7);
+	psmouse_info(psmouse,
+		     "Finger Sensing Pad, hw: %d.%d.%d, sw: %s, buttons: %d\n",
+		     ver >> 4, ver & 0x0F, rev, fsp_drv_ver, buttons & 7);
 
 	psmouse->private = priv = kzalloc(sizeof(struct fsp_data), GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 30c85a5..9d46c98 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -167,8 +167,8 @@ static int synaptics_capability(struct psmouse *psmouse)
 
 	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 1) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_CAPAB, cap)) {
-			printk(KERN_ERR "Synaptics claims to have extended capabilities,"
-			       " but I'm not able to read them.\n");
+			psmouse_warn(psmouse,
+				     "device claims to have extended capabilities, but I'm not able to read them.\n");
 		} else {
 			priv->ext_cap = (cap[0] << 16) | (cap[1] << 8) | cap[2];
 
@@ -183,8 +183,8 @@ static int synaptics_capability(struct psmouse *psmouse)
 
 	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 4) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_CAPAB_0C, cap)) {
-			printk(KERN_ERR "Synaptics claims to have extended capability 0x0c,"
-			       " but I'm not able to read it.\n");
+			psmouse_warn(psmouse,
+				     "device claims to have extended capability 0x0c, but I'm not able to read it.\n");
 		} else {
 			priv->ext_cap_0c = (cap[0] << 16) | (cap[1] << 8) | cap[2];
 		}
@@ -232,8 +232,8 @@ static int synaptics_resolution(struct psmouse *psmouse)
 	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 5 &&
 	    SYN_CAP_MAX_DIMENSIONS(priv->ext_cap_0c)) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MAX_COORDS, resp)) {
-			printk(KERN_ERR "Synaptics claims to have max coordinates"
-			       " query, but I'm not able to read it.\n");
+			psmouse_warn(psmouse,
+				     "device claims to have max coordinates query, but I'm not able to read it.\n");
 		} else {
 			priv->x_max = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
 			priv->y_max = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
@@ -243,8 +243,8 @@ static int synaptics_resolution(struct psmouse *psmouse)
 	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 &&
 	    SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MIN_COORDS, resp)) {
-			printk(KERN_ERR "Synaptics claims to have min coordinates"
-			       " query, but I'm not able to read it.\n");
+			psmouse_warn(psmouse,
+				     "device claims to have min coordinates query, but I'm not able to read it.\n");
 		} else {
 			priv->x_min = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
 			priv->y_min = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
@@ -388,7 +388,8 @@ static void synaptics_pt_activate(struct psmouse *psmouse)
 			priv->mode &= ~SYN_BIT_FOUR_BYTE_CLIENT;
 
 		if (synaptics_mode_cmd(psmouse, priv->mode))
-			printk(KERN_INFO "synaptics: failed to switch guest protocol\n");
+			psmouse_warn(psmouse,
+				     "failed to switch guest protocol\n");
 	}
 }
 
@@ -398,7 +399,8 @@ static void synaptics_pt_create(struct psmouse *psmouse)
 
 	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!serio) {
-		printk(KERN_ERR "synaptics: not enough memory to allocate pass-through port\n");
+		psmouse_err(psmouse,
+			    "not enough memory for pass-through port\n");
 		return;
 	}
 
@@ -412,7 +414,8 @@ static void synaptics_pt_create(struct psmouse *psmouse)
 
 	psmouse->pt_activate = synaptics_pt_activate;
 
-	printk(KERN_INFO "serio: %s port at %s\n", serio->name, psmouse->phys);
+	psmouse_info(psmouse, "serio: %s port at %s\n",
+		     serio->name, psmouse->phys);
 	serio_register_port(serio);
 }
 
@@ -1049,13 +1052,15 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 	input_sync(dev);
 }
 
-static int synaptics_validate_byte(unsigned char packet[], int idx, unsigned char pkt_type)
+static int synaptics_validate_byte(struct psmouse *psmouse,
+				   int idx, unsigned char pkt_type)
 {
 	static const unsigned char newabs_mask[]	= { 0xC8, 0x00, 0x00, 0xC8, 0x00 };
 	static const unsigned char newabs_rel_mask[]	= { 0xC0, 0x00, 0x00, 0xC0, 0x00 };
 	static const unsigned char newabs_rslt[]	= { 0x80, 0x00, 0x00, 0xC0, 0x00 };
 	static const unsigned char oldabs_mask[]	= { 0xC0, 0x60, 0x00, 0xC0, 0x60 };
 	static const unsigned char oldabs_rslt[]	= { 0xC0, 0x00, 0x00, 0x80, 0x00 };
+	const char *packet = psmouse->packet;
 
 	if (idx < 0 || idx > 4)
 		return 0;
@@ -1073,7 +1078,7 @@ static int synaptics_validate_byte(unsigned char packet[], int idx, unsigned cha
 		return (packet[idx] & oldabs_mask[idx]) == oldabs_rslt[idx];
 
 	default:
-		printk(KERN_ERR "synaptics: unknown packet type %d\n", pkt_type);
+		psmouse_err(psmouse, "unknown packet type %d\n", pkt_type);
 		return 0;
 	}
 }
@@ -1083,8 +1088,8 @@ static unsigned char synaptics_detect_pkt_type(struct psmouse *psmouse)
 	int i;
 
 	for (i = 0; i < 5; i++)
-		if (!synaptics_validate_byte(psmouse->packet, i, SYN_NEWABS_STRICT)) {
-			printk(KERN_INFO "synaptics: using relaxed packet validation\n");
+		if (!synaptics_validate_byte(psmouse, i, SYN_NEWABS_STRICT)) {
+			psmouse_info(psmouse, "using relaxed packet validation\n");
 			return SYN_NEWABS_RELAXED;
 		}
 
@@ -1109,7 +1114,7 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
 		return PSMOUSE_FULL_PACKET;
 	}
 
-	return synaptics_validate_byte(psmouse->packet, psmouse->pktcnt - 1, priv->pkt_type) ?
+	return synaptics_validate_byte(psmouse, psmouse->pktcnt - 1, priv->pkt_type) ?
 		PSMOUSE_GOOD_DATA : PSMOUSE_BAD_DATA;
 }
 
@@ -1222,21 +1227,22 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 		return -1;
 
 	if (retry > 1)
-		printk(KERN_DEBUG "Synaptics reconnected after %d tries\n",
-			retry);
+		psmouse_dbg(psmouse, "reconnected after %d tries\n", retry);
 
 	if (synaptics_query_hardware(psmouse)) {
-		printk(KERN_ERR "Unable to query Synaptics hardware.\n");
+		psmouse_err(psmouse, "Unable to query Synaptics hardware.\n");
 		return -1;
 	}
 
 	if (synaptics_set_absolute_mode(psmouse)) {
-		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
+		psmouse_err(psmouse,
+			    "Unable to initialize Synaptics hardware.\n");
 		return -1;
 	}
 
 	if (synaptics_set_advanced_gesture_mode(psmouse)) {
-		printk(KERN_ERR "Advanced gesture mode reconnect failed.\n");
+		psmouse_err(psmouse,
+			    "Advanced gesture mode reconnect failed.\n");
 		return -1;
 	}
 
@@ -1244,12 +1250,12 @@ static int synaptics_reconnect(struct psmouse *psmouse)
 	    old_priv.model_id != priv->model_id ||
 	    old_priv.capabilities != priv->capabilities ||
 	    old_priv.ext_cap != priv->ext_cap) {
-		printk(KERN_ERR "Synaptics hardware appears to be different: "
-			"id(%ld-%ld), model(%ld-%ld), caps(%lx-%lx), ext(%lx-%lx).\n",
-			old_priv.identity, priv->identity,
-			old_priv.model_id, priv->model_id,
-			old_priv.capabilities, priv->capabilities,
-			old_priv.ext_cap, priv->ext_cap);
+		psmouse_err(psmouse,
+			    "hardware appears to be different: id(%ld-%ld), model(%ld-%ld), caps(%lx-%lx), ext(%lx-%lx).\n",
+			    old_priv.identity, priv->identity,
+			    old_priv.model_id, priv->model_id,
+			    old_priv.capabilities, priv->capabilities,
+			    old_priv.ext_cap, priv->ext_cap);
 		return -1;
 	}
 
@@ -1330,7 +1336,8 @@ int synaptics_init(struct psmouse *psmouse)
 	 * just fine.
 	 */
 	if (broken_olpc_ec) {
-		printk(KERN_INFO "synaptics: OLPC XO detected, not enabling Synaptics protocol.\n");
+		psmouse_info(psmouse,
+			     "OLPC XO detected, not enabling Synaptics protocol.\n");
 		return -ENODEV;
 	}
 
@@ -1341,26 +1348,29 @@ int synaptics_init(struct psmouse *psmouse)
 	psmouse_reset(psmouse);
 
 	if (synaptics_query_hardware(psmouse)) {
-		printk(KERN_ERR "Unable to query Synaptics hardware.\n");
+		psmouse_err(psmouse, "Unable to query Synaptics hardware.\n");
 		goto init_fail;
 	}
 
 	if (synaptics_set_absolute_mode(psmouse)) {
-		printk(KERN_ERR "Unable to initialize Synaptics hardware.\n");
+		psmouse_err(psmouse,
+			    "Unable to initialize Synaptics hardware.\n");
 		goto init_fail;
 	}
 
 	if (synaptics_set_advanced_gesture_mode(psmouse)) {
-		printk(KERN_ERR "Advanced gesture mode init failed.\n");
+		psmouse_err(psmouse, "Advanced gesture mode init failed.\n");
 		goto init_fail;
 	}
 
 	priv->pkt_type = SYN_MODEL_NEWABS(priv->model_id) ? SYN_NEWABS : SYN_OLDABS;
 
-	printk(KERN_INFO "Synaptics Touchpad, model: %ld, fw: %ld.%ld, id: %#lx, caps: %#lx/%#lx/%#lx\n",
-		SYN_ID_MODEL(priv->identity),
-		SYN_ID_MAJOR(priv->identity), SYN_ID_MINOR(priv->identity),
-		priv->model_id, priv->capabilities, priv->ext_cap, priv->ext_cap_0c);
+	psmouse_info(psmouse,
+		     "Touchpad model: %ld, fw: %ld.%ld, id: %#lx, caps: %#lx/%#lx/%#lx\n",
+		     SYN_ID_MODEL(priv->identity),
+		     SYN_ID_MAJOR(priv->identity), SYN_ID_MINOR(priv->identity),
+		     priv->model_id,
+		     priv->capabilities, priv->ext_cap, priv->ext_cap_0c);
 
 	set_input_params(psmouse->dev, priv);
 
@@ -1392,8 +1402,9 @@ int synaptics_init(struct psmouse *psmouse)
 	 * the same rate as a standard PS/2 mouse).
 	 */
 	if (psmouse->rate >= 80 && impaired_toshiba_kbc) {
-		printk(KERN_INFO "synaptics: Toshiba %s detected, limiting rate to 40pps.\n",
-			dmi_get_system_info(DMI_PRODUCT_NAME));
+		psmouse_info(psmouse,
+			     "Toshiba %s detected, limiting rate to 40pps.\n",
+			     dmi_get_system_info(DMI_PRODUCT_NAME));
 		psmouse->rate = 40;
 	}
 
