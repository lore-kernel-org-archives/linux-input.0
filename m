From: Tai-hwa Liang <avatar@sentelic.com>
Subject: [PATCH 2/2] Input: sentelic - filtering out jumpy scrolling
Date: Thu, 26 Jul 2012 12:11:07 +0800
Message-ID: <1343275867-5179-2-git-send-email-avatar@sentelic.com>
References: <1343275867-5179-1-git-send-email-avatar@sentelic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:47354 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab2GZELS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Jul 2012 00:11:18 -0400
In-Reply-To: <1343275867-5179-1-git-send-email-avatar@sentelic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

- Accumlating both fingers' coordinates before reporting to the input-mt
  layer such that scrolling in X11 won't keep jumping back and forth;
- Turning a few common operations into utility macros;
- Bumping driver revision to reflect these changes.

Bugzilla:	https://bugzilla.kernel.org/show_bug.cgi?id=43197
Reported-and-tested-by:	Aleksey Spiridonov <leks13@leks13.ru>
Tested-by:	Eddie Dunn <eddie.dunn@gmail.com>
Tested-by:	Jakub Luzny <limoto94@gmail.com>
Tested-by:	Olivier Goffart <olivier@woboq.com>
Signed-off-by: Tai-hwa Liang <avatar@sentelic.com>
---
 drivers/input/mouse/sentelic.c |  108 +++++++++++++++++++++++++---------------
 drivers/input/mouse/sentelic.h |   35 +++++++++++++
 2 files changed, 103 insertions(+), 40 deletions(-)

diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index 060edef..3f6b39c 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -41,7 +41,7 @@
 #define	GET_ABS_Y(packet)	((packet[2] << 2) | (packet[3] & 0x03))
 
 /** Driver version. */
-static const char fsp_drv_ver[] = "1.1.0-K";
+static const char fsp_drv_ver[] = "1.1.1-K";
 
 /*
  * Make sure that the value being sent to FSP will not conflict with
@@ -707,7 +707,7 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
 	struct fsp_data *ad = psmouse->private;
 	unsigned char *packet = psmouse->packet;
 	unsigned char button_status = 0, lscroll = 0, rscroll = 0;
-	unsigned short abs_x, abs_y, fgrs = 0;
+	unsigned short abs_x, abs_y, fgrs;
 	int rel_x, rel_y;
 
 	if (psmouse->pktcnt < 4)
@@ -732,61 +732,89 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
 		abs_x = GET_ABS_X(packet);
 		abs_y = GET_ABS_Y(packet);
 
-		if (packet[0] & FSP_PB0_MFMC) {
+		if (!IS_MFMC(packet[0]) && (packet[0] & (FSP_PB0_LBTN |
+		    FSP_PB0_PHY_BTN)) == FSP_PB0_LBTN) {
 			/*
-			 * MFMC packet: assume that there are two fingers on
-			 * pad
+			 * On-pad click in SFAC mode should be handled
+			 * by userspace.  On-pad clicks in MFMC mode
+			 * are real clickpad clicks, and not ignored.
 			 */
-			fgrs = 2;
+			packet[0] &= ~FSP_PB0_LBTN;
+		}
+		if (abs_x == 0 || abs_y == 0) {
+			/*
+			 * workaround for buggy firmware which sends zero
+			 * coordinates even if there is finger on pad
+			 */
+			if (!IS_MFMC(packet[0])) {
+				/* don't report bad movement */
+				fgrs = 0;
+			} else {
+				/*
+				 * ignore finger up event for multiple finger
+				 * scenario
+				 */
+				return PSMOUSE_FULL_PACKET;
+			}
+		} else {
+			/* finger(s) down */
+			if (!IS_MFMC(packet[0])) {
+				/* SFAC, MFMC CPB packet */
+				fgrs = 1;
 
-			/* MFMC packet */
-			if (packet[0] & FSP_PB0_MFMC_FGR2) {
-				/* 2nd finger */
-				if (ad->last_mt_fgr == 2) {
+				/* no multi-finger information */
+				ad->last_mt_fgr = 0;
+
+				fsp_set_slot(dev, 0, true, abs_x, abs_y);
+				fsp_set_slot(dev, 1, false, 0, 0);
+			} else if (IS_MFMC_FGR1(packet[0])) {
+				/* MFMC 1st finger */
+				if (ad->last_mt_fgr == 1) {
 					/*
 					 * workaround for buggy firmware
 					 * which doesn't clear MFMC bit if
-					 * the 1st finger is up
+					 * the 2nd finger is up
 					 */
 					fgrs = 1;
-					fsp_set_slot(dev, 0, false, 0, 0);
-				}
-				ad->last_mt_fgr = 2;
+					fsp_set_slot(dev, 0, true,
+						     abs_x, abs_y);
+					fsp_set_slot(dev, 1, false, 0, 0);
+				} else {
+					fgrs = 2;
+					ad->last_mt_fgr = 1;
 
-				fsp_set_slot(dev, 1, fgrs == 2, abs_x, abs_y);
+					/*
+					 * accumulate the coordaintes and
+					 * proceed to the next run
+					 */
+					ad->mfmc_x1 = abs_x;
+					ad->mfmc_y1 = abs_y;
+				}
 			} else {
-				/* 1st finger */
-				if (ad->last_mt_fgr == 1) {
+				/* MFMC 2nd finger */
+				if (ad->last_mt_fgr == 2) {
 					/*
 					 * workaround for buggy firmware
 					 * which doesn't clear MFMC bit if
-					 * the 2nd finger is up
+					 * the 1st finger is up
 					 */
 					fgrs = 1;
-					fsp_set_slot(dev, 1, false, 0, 0);
+					fsp_set_slot(dev, 0, false, 0, 0);
+					fsp_set_slot(dev, 1, true,
+						     abs_x, abs_y);
+				} else {
+					fgrs = 2;
+					ad->last_mt_fgr = 2;
+
+					/* report both fingers' coordinate */
+					fsp_set_slot(dev, 1, true,
+						     abs_x, abs_y);
+					abs_x = ad->mfmc_x1;
+					abs_y = ad->mfmc_y1;
+					fsp_set_slot(dev, 0, true,
+						     abs_x, abs_y);
 				}
-				ad->last_mt_fgr = 1;
-				fsp_set_slot(dev, 0, fgrs != 0, abs_x, abs_y);
-			}
-		} else {
-			/* SFAC packet */
-			if ((packet[0] & (FSP_PB0_LBTN|FSP_PB0_PHY_BTN)) ==
-				FSP_PB0_LBTN) {
-				/* On-pad click in SFAC mode should be handled
-				 * by userspace.  On-pad clicks in MFMC mode
-				 * are real clickpad clicks, and not ignored.
-				 */
-				packet[0] &= ~FSP_PB0_LBTN;
 			}
-
-			/* no multi-finger information */
-			ad->last_mt_fgr = 0;
-
-			if (abs_x != 0 && abs_y != 0)
-				fgrs = 1;
-
-			fsp_set_slot(dev, 0, fgrs > 0, abs_x, abs_y);
-			fsp_set_slot(dev, 1, false, 0, 0);
 		}
 		if (fgrs > 0) {
 			input_report_abs(dev, ABS_X, abs_x);
diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
index aa697ec..0173fc5 100644
--- a/drivers/input/mouse/sentelic.h
+++ b/drivers/input/mouse/sentelic.h
@@ -90,6 +90,39 @@
 #define	FSP_PB0_MUST_SET	BIT(3)
 #define	FSP_PB0_PHY_BTN		BIT(4)
 #define	FSP_PB0_MFMC		BIT(5)
+/* packet type. See FSP_PKT_TYPE_XXX */
+#define	FSP_PB0_TYPE		(BIT(7) | BIT(6))
+#define	FSP_PB0_TYPE_REL	(0)
+#define	FSP_PB0_TYPE_ABS	BIT(6)
+#define	FSP_PB0_TYPE_NOTIFY	BIT(7)
+#define	FSP_PB0_TYPE_CUSTOM	(BIT(7) | BIT(6))
+
+/*
+ * physical clickpad button = MFMC packet without physical button.
+ */
+#define	IS_PHY_CPB(_pb0_)	\
+	(((_pb0_) & (FSP_PB0_TYPE | FSP_PB0_MFMC | FSP_PB0_PHY_BTN)) == \
+	(FSP_PB0_TYPE_ABS | FSP_PB0_MFMC))
+/*
+ * single-finger absolute coordinate
+ */
+#define	IS_SFAC(_pb0_)		\
+	(((_pb0_) & (FSP_PB0_TYPE | FSP_PB0_MFMC)) == FSP_PB0_TYPE_ABS)
+/*
+ * multi-finger multi-coordinate (physical clickpad button is excluded)
+ */
+#define	IS_MFMC(_pb0_)		\
+	(((_pb0_) & (FSP_PB0_TYPE | FSP_PB0_MFMC | FSP_PB0_PHY_BTN)) == \
+	(FSP_PB0_TYPE_ABS | FSP_PB0_MFMC | FSP_PB0_PHY_BTN))
+#define	IS_MFMC_FGR1(_pb0_)	\
+	(((_pb0_) & (FSP_PB0_TYPE | FSP_PB0_MFMC | FSP_PB0_PHY_BTN | \
+		FSP_PB0_MFMC_FGR2)) == (FSP_PB0_TYPE_ABS | \
+		FSP_PB0_MFMC | FSP_PB0_PHY_BTN))
+#define	IS_MFMC_FGR2(_pb0_)	\
+	(((_pb0_) & (FSP_PB0_TYPE | FSP_PB0_MFMC | FSP_PB0_PHY_BTN | \
+		FSP_PB0_MFMC_FGR2)) == (FSP_PB0_TYPE_ABS | \
+		FSP_PB0_MFMC | FSP_PB0_PHY_BTN | FSP_PB0_MFMC_FGR2))
+
 
 /* hardware revisions */
 #define	FSP_VER_STL3888_A4	(0xC1)
@@ -117,6 +150,8 @@ struct fsp_data {
 	unsigned char	last_reg;	/* Last register we requested read from */
 	unsigned char	last_val;
 	unsigned int	last_mt_fgr;	/* Last seen finger(multitouch) */
+	unsigned short	mfmc_x1;	/* X coordinate for the 1st finger */
+	unsigned short	mfmc_y1;	/* Y coordinate for the 1st finger */
 };
 
 #ifdef CONFIG_MOUSE_PS2_SENTELIC
-- 
1.7.9.5

