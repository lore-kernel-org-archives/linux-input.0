From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 1/6] Input: synaptics - Split synaptics_resolution(), query first
Date: Fri,  6 Feb 2015 10:44:54 -0500
Message-ID: <1423237499-2930-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Martin <consume.noise@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Daniel Martin <consume.noise@gmail.com>

Split the function synaptics_resolution() into
    synaptics_resolution() and synaptics_quirks().

synaptics_resolution() will be called before synaptics_quirks() to query
dimensions and resolutions before overwriting them with quirks.

Cc: stable@vger.kernel.org
Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---

v2: Removed SYN_ID_MAJOR() check from synaptics_quirks().

 drivers/input/mouse/synaptics.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7e705ee..8c2b343 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -346,7 +346,6 @@ static int synaptics_resolution(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 	unsigned char resp[3];
-	int i;
 
 	if (SYN_ID_MAJOR(priv->identity) < 4)
 		return 0;
@@ -358,17 +357,6 @@ static int synaptics_resolution(struct psmouse *psmouse)
 		}
 	}
 
-	for (i = 0; min_max_pnpid_table[i].pnp_ids; i++) {
-		if (psmouse_matches_pnp_id(psmouse,
-					   min_max_pnpid_table[i].pnp_ids)) {
-			priv->x_min = min_max_pnpid_table[i].x_min;
-			priv->x_max = min_max_pnpid_table[i].x_max;
-			priv->y_min = min_max_pnpid_table[i].y_min;
-			priv->y_max = min_max_pnpid_table[i].y_max;
-			return 0;
-		}
-	}
-
 	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 5 &&
 	    SYN_CAP_MAX_DIMENSIONS(priv->ext_cap_0c)) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MAX_COORDS, resp)) {
@@ -394,6 +382,29 @@ static int synaptics_resolution(struct psmouse *psmouse)
 	return 0;
 }
 
+/*
+ * Apply quirk(s) if the hardware matches
+ */
+
+static int synaptics_quirks(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	int i;
+
+	for (i = 0; min_max_pnpid_table[i].pnp_ids; i++) {
+		if (psmouse_matches_pnp_id(psmouse,
+					   min_max_pnpid_table[i].pnp_ids)) {
+			priv->x_min = min_max_pnpid_table[i].x_min;
+			priv->x_max = min_max_pnpid_table[i].x_max;
+			priv->y_min = min_max_pnpid_table[i].y_min;
+			priv->y_max = min_max_pnpid_table[i].y_max;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int synaptics_query_hardware(struct psmouse *psmouse)
 {
 	if (synaptics_identify(psmouse))
@@ -408,6 +419,8 @@ static int synaptics_query_hardware(struct psmouse *psmouse)
 		return -1;
 	if (synaptics_resolution(psmouse))
 		return -1;
+	if (synaptics_quirks(psmouse))
+		return -1;
 
 	return 0;
 }
-- 
2.1.0
