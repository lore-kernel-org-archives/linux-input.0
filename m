From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 2/2] synaptics: Report INPUT_PROP_TOPBUTTONPAD property for touchpads with top buttonareas
Date: Tue, 15 Apr 2014 09:24:23 +0200
Message-ID: <1397546663-4447-3-git-send-email-hdegoede@redhat.com>
References: <1397546663-4447-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15073 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852AbaDOHYc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2014 03:24:32 -0400
In-Reply-To: <1397546663-4447-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/synaptics.c | 55 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 02132cd..66bd239 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -117,6 +117,44 @@ void synaptics_reset(struct psmouse *psmouse)
 }
 
 #ifdef CONFIG_MOUSE_PS2_SYNAPTICS
+/* This list has been kindly provided by synaptics */
+static const char * const topbuttonpad_pnp_ids[] = {
+	"LEN0017",
+	"LEN0018",
+	"LEN0019",
+	"LEN0023",
+	"LEN002A",
+	"LEN002B",
+	"LEN002C",
+	"LEN002D",
+	"LEN002E",
+	"LEN0033", /* Helix */
+	"LEN0034", /* T431s, T540, X1 Carbon 2nd */
+	"LEN0035", /* X240 */
+	"LEN0036", /* T440 */
+	"LEN0037",
+	"LEN0038",
+	"LEN0041",
+	"LEN0042", /* Yoga */
+	"LEN0045",
+	"LEN0046",
+	"LEN0047",
+	"LEN0048",
+	"LEN0049",
+	"LEN2000",
+	"LEN2001",
+	"LEN2002",
+	"LEN2003",
+	"LEN2004", /* L440 */
+	"LEN2005",
+	"LEN2006",
+	"LEN2007",
+	"LEN2008",
+	"LEN2009",
+	"LEN200A",
+	"LEN200B",
+	NULL
+};
 
 /*****************************************************************************
  *	Synaptics communications functions
@@ -1255,8 +1293,10 @@ static void set_abs_position_params(struct input_dev *dev,
 	input_abs_set_res(dev, y_code, priv->y_res);
 }
 
-static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
+static void set_input_params(struct psmouse *psmouse,
+			     struct synaptics_data *priv)
 {
+	struct input_dev *dev = psmouse->dev;
 	int i;
 
 	/* Things that apply to both modes */
@@ -1325,6 +1365,17 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 
 	if (SYN_CAP_CLICKPAD(priv->ext_cap_0c)) {
 		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
+		/* See if this buttonpad has a top button area */
+		if (!strncmp(psmouse->ps2dev.serio->firmware_id, "PNP:", 4)) {
+			for (i = 0; topbuttonpad_pnp_ids[i]; i++) {
+				if (strstr(psmouse->ps2dev.serio->firmware_id,
+					   topbuttonpad_pnp_ids[i])) {
+					__set_bit(INPUT_PROP_TOPBUTTONPAD,
+						  dev->propbit);
+					break;
+				}
+			}
+		}
 		/* Clickpads report only left button */
 		__clear_bit(BTN_RIGHT, dev->keybit);
 		__clear_bit(BTN_MIDDLE, dev->keybit);
@@ -1627,7 +1678,7 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 		     priv->capabilities, priv->ext_cap, priv->ext_cap_0c,
 		     priv->board_id, priv->firmware_id);
 
-	set_input_params(psmouse->dev, priv);
+	set_input_params(psmouse, priv);
 
 	/*
 	 * Encode touchpad model so that it can be used to set
-- 
1.9.0

