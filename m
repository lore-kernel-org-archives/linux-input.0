From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] synaptices: Report INPUT_PROP_TOPBUTTONPAD property for touchpads with top buttonareas
Date: Wed,  9 Apr 2014 16:03:01 +0200
Message-ID: <1397052181-22768-4-git-send-email-hdegoede@redhat.com>
References: <1397052181-22768-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12079 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932847AbaDIODM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Apr 2014 10:03:12 -0400
In-Reply-To: <1397052181-22768-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/synaptics.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index d8d49d1..4637cc7 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -118,6 +118,16 @@ void synaptics_reset(struct psmouse *psmouse)
 
 #ifdef CONFIG_MOUSE_PS2_SYNAPTICS
 
+static const char *topbuttonpad_pnp_ids[] = {
+	"LEN0033", /* Helix */
+	"LEN0034", /* T540, X1 Carbon 2nd */
+	"LEN0035", /* X240 */
+	"LEN0036", /* T440 */
+	"LEN0042", /* Yoga */
+	"LEN2004", /* L440 */
+	NULL
+};
+
 /*****************************************************************************
  *	Synaptics communications functions
  ****************************************************************************/
@@ -1255,8 +1265,10 @@ static void set_abs_position_params(struct input_dev *dev,
 	input_abs_set_res(dev, y_code, priv->y_res);
 }
 
-static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
+static void set_input_params(struct psmouse *psmouse,
+			     struct synaptics_data *priv)
 {
+	struct input_dev *dev = psmouse->dev;
 	int i;
 
 	/* Things that apply to both modes */
@@ -1325,6 +1337,15 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 
 	if (SYN_CAP_CLICKPAD(priv->ext_cap_0c)) {
 		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
+		/* See if this buttonpad has a top button area */
+		for (i = 0; topbuttonpad_pnp_ids[i]; i++) {
+			if (compare_pnp_id(psmouse->ps2dev.serio->pnp_id,
+					   topbuttonpad_pnp_ids[i])) {
+				__set_bit(INPUT_PROP_TOPBUTTONPAD,
+					  dev->propbit);
+				break;
+			}
+		}
 		/* Clickpads report only left button */
 		__clear_bit(BTN_RIGHT, dev->keybit);
 		__clear_bit(BTN_MIDDLE, dev->keybit);
@@ -1593,7 +1614,7 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 		     priv->capabilities, priv->ext_cap, priv->ext_cap_0c,
 		     priv->board_id, priv->firmware_id);
 
-	set_input_params(psmouse->dev, priv);
+	set_input_params(psmouse, priv);
 
 	/*
 	 * Encode touchpad model so that it can be used to set
-- 
1.9.0

