From: Daniel Martin <daniel.martin@secunet.com>
Subject: [PATCH 5/5] Input: synaptics - Support min/max board id in min_max_pnpid_table
Date: Fri, 6 Feb 2015 14:25:08 +0100
Message-ID: <1423229108-29268-6-git-send-email-daniel.martin@secunet.com>
References: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
Reply-To: Daniel Martin <consume.noise@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:41601 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754383AbbBFNTf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2015 08:19:35 -0500
In-Reply-To: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Daniel Martin <daniel.martin@secunet.com>

Add a min/max range for board ids to the min/max coordinates quirk. This
makes it possible to restrict quirks to specific models based upon their
board id. The define ANY_BOARD_ID (0) serves as a wildcard.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
Signed-off-by: Daniel Martin <daniel.martin@secunet.com>
---
 drivers/input/mouse/synaptics.c | 44 +++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 0ea36ae..601ed39 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -120,31 +120,40 @@ void synaptics_reset(struct psmouse *psmouse)
 
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
 		(const char * const []){"LEN0034", "LEN0036", "LEN0039",
 					"LEN2002", "LEN2004", NULL},
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
@@ -401,19 +410,28 @@ static int synaptics_quirks(struct psmouse *psmouse)
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
2.2.2

