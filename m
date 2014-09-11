From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] psmouse: Add psmouse_matches_pnp_id helper function
Date: Thu, 11 Sep 2014 10:50:46 +0200
Message-ID: <1410425447-9575-2-git-send-email-hdegoede@redhat.com>
References: <1410425447-9575-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49997 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856AbaIKIuw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Sep 2014 04:50:52 -0400
In-Reply-To: <1410425447-9575-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The matches_pnp_id function from the synaptics driver is useful for other
drivers too. Make it a generic psmouse helper function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/psmouse-base.c | 14 ++++++++++++++
 drivers/input/mouse/psmouse.h      |  1 +
 drivers/input/mouse/synaptics.c    | 17 +++--------------
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index b4e1f01..02e68c3 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -462,6 +462,20 @@ static int psmouse_poll(struct psmouse *psmouse)
 			   PSMOUSE_CMD_POLL | (psmouse->pktsize << 8));
 }
 
+/*
+ * psmouse_matches_pnp_id - check if psmouse matches one of the passed in ids.
+ */
+bool psmouse_matches_pnp_id(struct psmouse *psmouse, const char * const ids[])
+{
+	int i;
+
+	if (!strncmp(psmouse->ps2dev.serio->firmware_id, "PNP:", 4))
+		for (i = 0; ids[i]; i++)
+			if (strstr(psmouse->ps2dev.serio->firmware_id, ids[i]))
+				return true;
+
+	return false;
+}
 
 /*
  * Genius NetMouse magic init.
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 2f0b39d..f4cf664 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -108,6 +108,7 @@ void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
 psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse);
 int psmouse_activate(struct psmouse *psmouse);
 int psmouse_deactivate(struct psmouse *psmouse);
+bool psmouse_matches_pnp_id(struct psmouse *psmouse, const char * const ids[]);
 
 struct psmouse_attribute {
 	struct device_attribute dattr;
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index e8573c6..854caca 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -185,18 +185,6 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	NULL
 };
 
-static bool matches_pnp_id(struct psmouse *psmouse, const char * const ids[])
-{
-	int i;
-
-	if (!strncmp(psmouse->ps2dev.serio->firmware_id, "PNP:", 4))
-		for (i = 0; ids[i]; i++)
-			if (strstr(psmouse->ps2dev.serio->firmware_id, ids[i]))
-				return true;
-
-	return false;
-}
-
 /*****************************************************************************
  *	Synaptics communications functions
  ****************************************************************************/
@@ -362,7 +350,8 @@ static int synaptics_resolution(struct psmouse *psmouse)
 	}
 
 	for (i = 0; min_max_pnpid_table[i].pnp_ids; i++) {
-		if (matches_pnp_id(psmouse, min_max_pnpid_table[i].pnp_ids)) {
+		if (psmouse_matches_pnp_id(psmouse,
+					   min_max_pnpid_table[i].pnp_ids)) {
 			priv->x_min = min_max_pnpid_table[i].x_min;
 			priv->x_max = min_max_pnpid_table[i].x_max;
 			priv->y_min = min_max_pnpid_table[i].y_min;
@@ -1456,7 +1445,7 @@ static void set_input_params(struct psmouse *psmouse,
 
 	if (SYN_CAP_CLICKPAD(priv->ext_cap_0c)) {
 		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
-		if (matches_pnp_id(psmouse, topbuttonpad_pnp_ids))
+		if (psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids))
 			__set_bit(INPUT_PROP_TOPBUTTONPAD, dev->propbit);
 		/* Clickpads report only left button */
 		__clear_bit(BTN_RIGHT, dev->keybit);
-- 
2.1.0

