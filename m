From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH v4 6/8] Input: elantech - clean up elantech_init
Date: Mon, 29 Aug 2011 16:28:57 +0800
Message-ID: <1314606539-24722-7-git-send-email-jj_ding@emc.com.tw>
References: <1314606539-24722-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314606539-24722-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>, JJ Ding <jj_ding@emc.com.tw>
List-Id: linux-input@vger.kernel.org

Group property setting code into elantech_set_properties.

Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
Acked-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/mouse/elantech.c |   69 ++++++++++++++++++++++-----------------
 1 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 008e8c2..2ae7c49 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -791,6 +791,42 @@ static int elantech_reconnect(struct psmouse *psmouse)
 }
 
 /*
+ * determine hardware version and set some properties according to it.
+ */
+static void elantech_set_properties(struct elantech_data *etd)
+{
+	/*
+	 * Assume every version greater than 0x020030 is new EeePC style
+	 * hardware with 6 byte packets, except 0x020600
+	 */
+	if (etd->fw_version < 0x020030 || etd->fw_version == 0x020600)
+		etd->hw_version = 1;
+	else
+		etd->hw_version = 2;
+
+	/*
+	 * Turn on packet checking by default.
+	 */
+	etd->paritycheck = 1;
+
+	/*
+	 * This firmware suffers from misreporting coordinates when
+	 * a touch action starts causing the mouse cursor or scrolled page
+	 * to jump. Enable a workaround.
+	 */
+	etd->jumpy_cursor =
+		(etd->fw_version == 0x020022 || etd->fw_version == 0x020600);
+
+	if (etd->hw_version == 2) {
+		/* For now show extra debug information */
+		etd->debug = 1;
+
+		if (etd->fw_version >= 0x020800)
+			etd->reports_pressure = true;
+	}
+}
+
+/*
  * Initialize the touchpad and create sysfs entries
  */
 int elantech_init(struct psmouse *psmouse)
@@ -816,26 +852,9 @@ int elantech_init(struct psmouse *psmouse)
 	}
 
 	etd->fw_version = (param[0] << 16) | (param[1] << 8) | param[2];
-
-	/*
-	 * Assume every version greater than this is new EeePC style
-	 * hardware with 6 byte packets
-	 */
-	if (etd->fw_version >= 0x020030) {
-		etd->hw_version = 2;
-		/* For now show extra debug information */
-		etd->debug = 1;
-		etd->paritycheck = 1;
-
-		if (etd->fw_version >= 0x020800)
-			etd->reports_pressure = true;
-
-	} else {
-		etd->hw_version = 1;
-		etd->paritycheck = 1;
-	}
-
-	pr_info("assuming hardware version %d, firmware version %d.%d.%d\n",
+	elantech_set_properties(etd);
+	pr_info("assuming hardware version %d "
+		"(with firmware version 0x%02x%02x%02x)\n",
 		etd->hw_version, param[0], param[1], param[2]);
 
 	if (synaptics_send_cmd(psmouse, ETP_CAPABILITIES_QUERY,
@@ -847,16 +866,6 @@ int elantech_init(struct psmouse *psmouse)
 		etd->capabilities[0], etd->capabilities[1],
 		etd->capabilities[2]);
 
-	/*
-	 * This firmware suffers from misreporting coordinates when
-	 * a touch action starts causing the mouse cursor or scrolled page
-	 * to jump. Enable a workaround.
-	 */
-	if (etd->fw_version == 0x020022 || etd->fw_version == 0x020600) {
-		pr_info("firmware version 2.0.34/2.6.0 detected, enabling jumpy cursor workaround\n");
-		etd->jumpy_cursor = true;
-	}
-
 	if (elantech_set_absolute_mode(psmouse)) {
 		pr_err("failed to put touchpad into absolute mode.\n");
 		goto init_fail;
-- 
1.7.4.1
