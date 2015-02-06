From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 5/6] Input: synaptics - Support min/max board id in min_max_pnpid_table
Date: Fri,  6 Feb 2015 10:44:58 -0500
Message-ID: <1423237499-2930-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Martin <consume.noise@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Daniel Martin <daniel.martin@secunet.com>

Add a min/max range for board ids to the min/max coordinates quirk. This
makes it possible to restrict quirks to specific models based upon their
board id. The define ANY_BOARD_ID (0) serves as a wildcard.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541

Cc: stable@vger.kernel.org
Signed-off-by: Daniel Martin <daniel.martin@secunet.com>
---
 drivers/input/mouse/synaptics.c | 44 +++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 359e26d..b02000f 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -123,32 +123,41 @@ void synaptics_reset(struct psmouse *psmouse)
 
 static bool cr48_profile_sensor;
 
+#define ANY_BOARD_ID 0
 struct min_max_quirk {
 	const char * const *pnp_ids;
+	struct {
+		unsigned long int min, max;
+	} board_id;
 	int x_min, x_max, y_min, y_max;
 };
 
 static const struct min_max_quirk min_max_pnpid_table[] = {
 	{
 		(const char * const []){"LEN0033", NULL},
+		{ANY_BOARD_ID, ANY_BOARD_ID},
 		1024, 5052, 2258, 4832
 	},
 	{
 		(const char * const []){"LEN0042", NULL},
+		{ANY_BOARD_ID, ANY_BOARD_ID},
 		1232, 5710, 1156, 4696
 	},
 	{
 		(const char * const []){"LEN0034", "LEN0036", "LEN0037",
 					"LEN0039", "LEN2002", "LEN2004",
 					NULL},
+		{ANY_BOARD_ID, ANY_BOARD_ID},
 		1024, 5112, 2024, 4832
 	},
 	{
 		(const char * const []){"LEN2001", NULL},
+		{ANY_BOARD_ID, ANY_BOARD_ID},
 		1024, 5022, 2508, 4832
 	},
 	{
 		(const char * const []){"LEN2006", NULL},
+		{ANY_BOARD_ID, ANY_BOARD_ID},
 		1264, 5675, 1171, 4688
 	},
 	{ }
@@ -405,19 +414,28 @@ static int synaptics_quirks(struct psmouse *psmouse)
 	int i;
 
 	for (i = 0; min_max_pnpid_table[i].pnp_ids; i++) {
-		if (psmouse_matches_pnp_id(psmouse,
-					   min_max_pnpid_table[i].pnp_ids)) {
-			priv->x_min = min_max_pnpid_table[i].x_min;
-			priv->x_max = min_max_pnpid_table[i].x_max;
-			priv->y_min = min_max_pnpid_table[i].y_min;
-			priv->y_max = min_max_pnpid_table[i].y_max;
-			psmouse_warn(psmouse,
-				     "quirked min/max coordinates: "
-				     "x [%d..%d], y [%d..%d]\n",
-				     priv->x_min, priv->x_max,
-				     priv->y_min, priv->y_max);
-			break;
-		}
+		if (!psmouse_matches_pnp_id(psmouse,
+					    min_max_pnpid_table[i].pnp_ids))
+			continue;
+
+		if (min_max_pnpid_table[i].board_id.min != ANY_BOARD_ID &&
+		    priv->board_id < min_max_pnpid_table[i].board_id.min)
+			continue;
+
+		if (min_max_pnpid_table[i].board_id.max != ANY_BOARD_ID &&
+		    priv->board_id > min_max_pnpid_table[i].board_id.max)
+			continue;
+
+		priv->x_min = min_max_pnpid_table[i].x_min;
+		priv->x_max = min_max_pnpid_table[i].x_max;
+		priv->y_min = min_max_pnpid_table[i].y_min;
+		priv->y_max = min_max_pnpid_table[i].y_max;
+		psmouse_warn(psmouse,
+			     "quirked min/max coordinates: "
+			     "x [%d..%d], y [%d..%d]\n",
+			     priv->x_min, priv->x_max,
+			     priv->y_min, priv->y_max);
+		break;
 	}
 
 	return 0;
-- 
2.1.0
