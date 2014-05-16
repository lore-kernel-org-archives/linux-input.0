From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] synaptics: Add a matches_pnp_id helper function
Date: Fri, 16 May 2014 20:46:48 +0200
Message-ID: <1400266009-5436-3-git-send-email-hdegoede@redhat.com>
References: <1400266009-5436-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1400266009-5436-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-input@vger.kernel.org

This is a preparation patch for simplifying the min/max quirk table.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/synaptics.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 898e8bb..395ec9c 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -156,6 +156,18 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	NULL
 };
 
+static bool matches_pnp_id(struct psmouse *psmouse, const char * const ids[])
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
+
 /*****************************************************************************
  *	Synaptics communications functions
  ****************************************************************************/
@@ -1365,17 +1377,8 @@ static void set_input_params(struct psmouse *psmouse,
 
 	if (SYN_CAP_CLICKPAD(priv->ext_cap_0c)) {
 		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
-		/* See if this buttonpad has a top button area */
-		if (!strncmp(psmouse->ps2dev.serio->firmware_id, "PNP:", 4)) {
-			for (i = 0; topbuttonpad_pnp_ids[i]; i++) {
-				if (strstr(psmouse->ps2dev.serio->firmware_id,
-					   topbuttonpad_pnp_ids[i])) {
-					__set_bit(INPUT_PROP_TOPBUTTONPAD,
-						  dev->propbit);
-					break;
-				}
-			}
-		}
+		if (matches_pnp_id(psmouse, topbuttonpad_pnp_ids))
+			__set_bit(INPUT_PROP_TOPBUTTONPAD, dev->propbit);
 		/* Clickpads report only left button */
 		__clear_bit(BTN_RIGHT, dev->keybit);
 		__clear_bit(BTN_MIDDLE, dev->keybit);
-- 
1.9.0
