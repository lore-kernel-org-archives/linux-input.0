From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 5/7] Input: synaptics - remove TOPBUTTONPAD property for Lenovos 2015
Date: Fri,  6 Feb 2015 15:04:33 -0500
Message-ID: <1423253075-23469-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The 2015 series of the Lenovo thinkpads added back the hardware buttons
on top of the touchpad for the trackstick.

Unfortunately, Lenovo used the PNPIDs that are supposed to be
"5 buttons" touchpads, so the new laptops also have the
INPUT_PROP_TOPBUTTONPAD. Yay!

Instead of manually removing each of the new ones, or hoping that we
know all the current ones, we can consider that the PNPIDs list that
were given contains touchpads that have the trackstick buttons, either
physically wired to them, or emulated with the top software button
property.

Thanks to the extra buttons capability in query $10, we can reliably
detect the physical buttons from the software ones, and so we can
remove the TOPBUTTONPAD property even if it was declared as such.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

v2:
- rely on SYN_CAP_EXT_BUTTONS_STICK to remove INPUT_PROP_TOPBUTTONPAD, not on
  the BTN_0 heuristic

 drivers/input/mouse/synaptics.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 40e79b0..79c4a87 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1209,7 +1209,8 @@ static void set_input_params(struct psmouse *psmouse,
 
 	if (SYN_CAP_CLICKPAD(priv->ext_cap_0c)) {
 		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
-		if (psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids))
+		if (psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
+		    !SYN_CAP_EXT_BUTTONS_STICK(priv->ext_cap_10))
 			__set_bit(INPUT_PROP_TOPBUTTONPAD, dev->propbit);
 		/* Clickpads report only left button */
 		__clear_bit(BTN_RIGHT, dev->keybit);
-- 
2.1.0
