From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/6] Input: psmouse - use switch statement in psmouse_process_byte()
Date: Sat, 28 Nov 2015 21:13:51 -0800
Message-ID: <1448774036-39040-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, pali.rohar@gmail.com, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of a series mostly exclusive "if" statements testing protocol type
of the mouse let's use "switch" statement.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 65 ++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index ad18dab..4e43e7e 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -138,22 +138,16 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 	if (psmouse->pktcnt < psmouse->pktsize)
 		return PSMOUSE_GOOD_DATA;
 
-/*
- * Full packet accumulated, process it
- */
-
-/*
- * Scroll wheel on IntelliMice, scroll buttons on NetMice
- */
+	/* Full packet accumulated, process it */
 
-	if (psmouse->type == PSMOUSE_IMPS || psmouse->type == PSMOUSE_GENPS)
+	switch (psmouse->type) {
+	case PSMOUSE_IMPS:
+		/* IntelliMouse has scroll wheel */
 		input_report_rel(dev, REL_WHEEL, -(signed char) packet[3]);
+		break;
 
-/*
- * Scroll wheel and buttons on IntelliMouse Explorer
- */
-
-	if (psmouse->type == PSMOUSE_IMEX) {
+	case PSMOUSE_IMEX:
+		/* Scroll wheel and buttons on IntelliMouse Explorer */
 		switch (packet[3] & 0xC0) {
 		case 0x80: /* vertical scroll on IntelliMouse Explorer 4.0 */
 			input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 32) - (int) (packet[3] & 31));
@@ -168,39 +162,42 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 			input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
 			break;
 		}
-	}
+		break;
 
-/*
- * Extra buttons on Genius NewNet 3D
- */
+	case PSMOUSE_GENPS:
+		/* Report scroll buttons on NetMice */
+		input_report_rel(dev, REL_WHEEL, -(signed char) packet[3]);
 
-	if (psmouse->type == PSMOUSE_GENPS) {
+		/* Extra buttons on Genius NewNet 3D */
 		input_report_key(dev, BTN_SIDE, (packet[0] >> 6) & 1);
 		input_report_key(dev, BTN_EXTRA, (packet[0] >> 7) & 1);
-	}
+		break;
 
-/*
- * Extra button on ThinkingMouse
- */
-	if (psmouse->type == PSMOUSE_THINKPS) {
+	case PSMOUSE_THINKPS:
+		/* Extra button on ThinkingMouse */
 		input_report_key(dev, BTN_EXTRA, (packet[0] >> 3) & 1);
-		/* Without this bit of weirdness moving up gives wildly high Y changes. */
+
+		/*
+		 * Without this bit of weirdness moving up gives wildly
+		 * high Y changes.
+		 */
 		packet[1] |= (packet[0] & 0x40) << 1;
-	}
+		break;
 
-/*
- * Cortron PS2 Trackball reports SIDE button on the 4th bit of the first
- * byte.
- */
-	if (psmouse->type == PSMOUSE_CORTRON) {
+	case PSMOUSE_CORTRON:
+		/*
+		 * Cortron PS2 Trackball reports SIDE button in the
+		 * 4th bit of the first byte.
+		 */
 		input_report_key(dev, BTN_SIDE, (packet[0] >> 3) & 1);
 		packet[0] |= 0x08;
-	}
+		break;
 
-/*
- * Generic PS/2 Mouse
- */
+	default:
+		break;
+	}
 
+	/* Generic PS/2 Mouse */
 	input_report_key(dev, BTN_LEFT,    packet[0]       & 1);
 	input_report_key(dev, BTN_MIDDLE, (packet[0] >> 2) & 1);
 	input_report_key(dev, BTN_RIGHT,  (packet[0] >> 1) & 1);
-- 
2.6.0.rc2.230.g3dd15c0
