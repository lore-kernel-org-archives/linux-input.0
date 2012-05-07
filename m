From: Tai-hwa Liang <avatar@sentelic.com>
Subject: [PATCH] Input: sentelic - including production serial number in driver information string
Date: Mon,  7 May 2012 21:49:26 +0800
Message-ID: <1336398566-28669-1-git-send-email-avatar@sentelic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:31647 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab2EGNtc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 May 2012 09:49:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hardware since Cx supports an unique identity(used to identify OEM vendors
and released lot number) which is very helpful for diagnostic purpose.
This revision tries to make it as a part of driver boot up message.

Whilst here, also bumping fsp_drv_ver to acknowledge recent addition of
absolute coordinates output.

Signed-off-by: Tai-hwa Liang <avatar@sentelic.com>
---
 drivers/input/mouse/sentelic.c |   34 ++++++++++++++++++++++++++++++----
 drivers/input/mouse/sentelic.h |    8 ++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index 661a0ca..3f5649f 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -41,7 +41,7 @@
 #define	GET_ABS_Y(packet)	((packet[2] << 2) | (packet[3] & 0x03))
 
 /** Driver version. */
-static const char fsp_drv_ver[] = "1.0.0-K";
+static const char fsp_drv_ver[] = "1.1.0-K";
 
 /*
  * Make sure that the value being sent to FSP will not conflict with
@@ -303,6 +303,27 @@ static int fsp_get_revision(struct psmouse *psmouse, int *rev)
 	return 0;
 }
 
+static int fsp_get_sn(struct psmouse *psmouse, int *sn)
+{
+	int v0, v1, v2;
+	int rc = -EIO;
+
+	/* production number since Cx is available at: 0x0b40 ~ 0x0b42 */
+	if (fsp_page_reg_write(psmouse, FSP_PAGE_0B))
+		goto out;
+	if (fsp_reg_read(psmouse, FSP_REG_SN0, &v0))
+		goto out;
+	if (fsp_reg_read(psmouse, FSP_REG_SN1, &v1))
+		goto out;
+	if (fsp_reg_read(psmouse, FSP_REG_SN2, &v2))
+		goto out;
+	*sn = (v0 << 16) | (v1 << 8) | v2;
+	rc = 0;
+out:
+	fsp_page_reg_write(psmouse, FSP_PAGE_DEFAULT);
+	return rc;
+}
+
 static int fsp_get_buttons(struct psmouse *psmouse, int *btn)
 {
 	static const int buttons[] = {
@@ -1000,16 +1021,21 @@ static int fsp_reconnect(struct psmouse *psmouse)
 int fsp_init(struct psmouse *psmouse)
 {
 	struct fsp_data *priv;
-	int ver, rev;
+	int ver, rev, sn = 0;
 	int error;
 
 	if (fsp_get_version(psmouse, &ver) ||
 	    fsp_get_revision(psmouse, &rev)) {
 		return -ENODEV;
 	}
+	if (ver >= FSP_VER_STL3888_C0) {
+		/* firmware information is only available since C0 */
+		fsp_get_sn(psmouse, &sn);
+	}
 
-	psmouse_info(psmouse, "Finger Sensing Pad, hw: %d.%d.%d, sw: %s\n",
-		     ver >> 4, ver & 0x0F, rev, fsp_drv_ver);
+	psmouse_info(psmouse,
+		     "Finger Sensing Pad, hw: %d.%d.%d, sn: %x, sw: %s\n",
+		     ver >> 4, ver & 0x0F, rev, sn, fsp_drv_ver);
 
 	psmouse->private = priv = kzalloc(sizeof(struct fsp_data), GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
index 334de19..aa697ec 100644
--- a/drivers/input/mouse/sentelic.h
+++ b/drivers/input/mouse/sentelic.h
@@ -65,6 +65,14 @@
 #define	FSP_BIT_SWC1_GST_GRP1	BIT(6)
 #define	FSP_BIT_SWC1_BX_COMPAT	BIT(7)
 
+#define	FSP_PAGE_0B		(0x0b)
+#define	FSP_PAGE_82		(0x82)
+#define	FSP_PAGE_DEFAULT	FSP_PAGE_82
+
+#define	FSP_REG_SN0		(0x40)
+#define	FSP_REG_SN1		(0x41)
+#define	FSP_REG_SN2		(0x42)
+
 /* Finger-sensing Pad packet formating related definitions */
 
 /* absolute packet type */
-- 
1.7.9.5

