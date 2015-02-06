From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 2/7] Input: synaptics - handle spurious release of trackstick buttons
Date: Fri,  6 Feb 2015 15:04:30 -0500
Message-ID: <1423253075-23469-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Fimware 8.1 has a bug in which the extra buttons are only sent
when the ExtBit is 1.
This should be fixed in a future FW update which should have a bump
of the minor version.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

v2:
- break out extra buttons reporting in its own function
- use firmware version to remove the spurious releases

 drivers/input/mouse/synaptics.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 3bd7032..a033fc7 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -815,14 +815,36 @@ static void synaptics_report_semi_mt_data(struct input_dev *dev,
 	}
 }
 
-static void synaptics_report_buttons(struct psmouse *psmouse,
-				     const struct synaptics_hw_state *hw)
+static void synaptics_report_ext_buttons(struct psmouse *psmouse,
+					 const struct synaptics_hw_state *hw)
 {
 	struct input_dev *dev = psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
 	int ext_bits = (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) + 1) >> 1;
 	int i;
 
+	if (!SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
+		return;
+
+	/* bug in FW 8.1, buttons are reported only when ExtBit is 1 */
+	if ((SYN_ID_FULL(priv->identity) == 0x801) &&
+	    !((psmouse->packet[0] ^ psmouse->packet[3]) & 0x02))
+		return;
+
+	for (i = 0; i < ext_bits; i++) {
+		input_report_key(dev, BTN_0 + 2 * i,
+			hw->ext_buttons & (1 << i));
+		input_report_key(dev, BTN_1 + 2 * i,
+			hw->ext_buttons & (1 << (i + ext_bits)));
+	}
+}
+
+static void synaptics_report_buttons(struct psmouse *psmouse,
+				     const struct synaptics_hw_state *hw)
+{
+	struct input_dev *dev = psmouse->dev;
+	struct synaptics_data *priv = psmouse->private;
+
 	input_report_key(dev, BTN_LEFT, hw->left);
 	input_report_key(dev, BTN_RIGHT, hw->right);
 
@@ -834,12 +856,7 @@ static void synaptics_report_buttons(struct psmouse *psmouse,
 		input_report_key(dev, BTN_BACK, hw->down);
 	}
 
-	for (i = 0; i < ext_bits; i++) {
-		input_report_key(dev, BTN_0 + 2 * i,
-				 hw->ext_buttons & (1 << i));
-		input_report_key(dev, BTN_1 + 2 * i,
-				 hw->ext_buttons & (1 << (i + ext_bits)));
-	}
+	synaptics_report_ext_buttons(psmouse, hw);
 }
 
 static void synaptics_report_mt_data(struct psmouse *psmouse,
-- 
2.1.0
