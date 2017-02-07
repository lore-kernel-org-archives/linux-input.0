From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 1/2] Input: psmouse - add a custom serio protocol to send extra information
Date: Tue,  7 Feb 2017 17:25:38 +0100
Message-ID: <20170207162539.5577-2-benjamin.tissoires@redhat.com>
References: <20170206192327.GA17441@dtor-ws>
 <20170207162539.5577-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170207162539.5577-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>
Cc: Adrian Alves <aalves@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The tracksticks on the Lenovo thinkpads have their buttons connected
through the touchpad device. We already fixed that in synaptics.c, but
when we switch the device into RMI4 mode to have proper support, the
pass-through functionality can't deal with them easily.

We add a new PS/2 flag and protocol designed for psmouse.
The RMI4 F03 pass-through can then emit a special set of commands
to notify psmouse the state of the buttons.

This patch implements the protocol in psmouse, while an other will
do the same for rmi4-f03.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/psmouse-base.c | 39 +++++++++++++++++++++++++++++++++++---
 drivers/input/mouse/psmouse.h      |  5 +++++
 include/uapi/linux/serio.h         |  7 ++++---
 3 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index bee2674..d37b04a 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -199,9 +199,12 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 	}
 
 	/* Generic PS/2 Mouse */
-	input_report_key(dev, BTN_LEFT,    packet[0]       & 1);
-	input_report_key(dev, BTN_MIDDLE, (packet[0] >> 2) & 1);
-	input_report_key(dev, BTN_RIGHT,  (packet[0] >> 1) & 1);
+	input_report_key(dev, BTN_LEFT,
+			 (packet[0] | psmouse->extra_buttons)       & 1);
+	input_report_key(dev, BTN_MIDDLE,
+			 ((packet[0] | psmouse->extra_buttons) >> 2) & 1);
+	input_report_key(dev, BTN_RIGHT,
+			 ((packet[0] | psmouse->extra_buttons) >> 1) & 1);
 
 	input_report_rel(dev, REL_X, packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0);
 	input_report_rel(dev, REL_Y, packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);
@@ -282,6 +285,19 @@ static int psmouse_handle_byte(struct psmouse *psmouse)
 	return 0;
 }
 
+static void psmouse_handle_extra_buttons(struct psmouse *psmouse,
+					 unsigned char data)
+{
+	struct input_dev *dev = psmouse->dev;
+
+	input_report_key(dev, BTN_LEFT,    data       & 1);
+	input_report_key(dev, BTN_MIDDLE, (data >> 2) & 1);
+	input_report_key(dev, BTN_RIGHT,  (data >> 1) & 1);
+	input_sync(dev);
+
+	psmouse->extra_buttons = data;
+}
+
 /*
  * psmouse_interrupt() handles incoming characters, either passing them
  * for normal processing or gathering them as command response.
@@ -306,6 +322,23 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 		goto out;
 	}
 
+	if (unlikely(flags & SERIO_OOB_DATA)) {
+		switch (psmouse->oob_data_type) {
+		case PSMOUSE_OOB_NONE:
+			psmouse->oob_data_type = data;
+			goto out;
+		case PSMOUSE_OOB_EXTRA_BTNS:
+			psmouse_handle_extra_buttons(psmouse, data);
+			psmouse->oob_data_type = PSMOUSE_OOB_NONE;
+			goto out;
+		default:
+			psmouse_warn(psmouse,
+				     "unknown OOB_DATA type: 0x%02x\n",
+				     psmouse->oob_data_type);
+			psmouse->oob_data_type = PSMOUSE_OOB_NONE;
+		}
+	}
+
 	if (unlikely(psmouse->ps2dev.flags & PS2_FLAG_ACK))
 		if  (ps2_handle_ack(&psmouse->ps2dev, data))
 			goto out;
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index e0ca6cd..8c83b8e 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -1,6 +1,9 @@
 #ifndef _PSMOUSE_H
 #define _PSMOUSE_H
 
+#define PSMOUSE_OOB_NONE	0x00
+#define PSMOUSE_OOB_EXTRA_BTNS	0x01
+
 #define PSMOUSE_CMD_SETSCALE11	0x00e6
 #define PSMOUSE_CMD_SETSCALE21	0x00e7
 #define PSMOUSE_CMD_SETRES	0x10e8
@@ -53,6 +56,8 @@ struct psmouse {
 	unsigned char pktcnt;
 	unsigned char pktsize;
 	unsigned char type;
+	unsigned char oob_data_type;
+	unsigned char extra_buttons;
 	bool ignore_parity;
 	bool acks_disable_command;
 	unsigned int model;
diff --git a/include/uapi/linux/serio.h b/include/uapi/linux/serio.h
index f2447a8..ccd0ccd 100644
--- a/include/uapi/linux/serio.h
+++ b/include/uapi/linux/serio.h
@@ -17,9 +17,10 @@
 /*
  * bit masks for use in "interrupt" flags (3rd argument)
  */
-#define SERIO_TIMEOUT	1
-#define SERIO_PARITY	2
-#define SERIO_FRAME	4
+#define SERIO_TIMEOUT	BIT(0)
+#define SERIO_PARITY	BIT(1)
+#define SERIO_FRAME	BIT(2)
+#define SERIO_OOB_DATA	BIT(3)
 
 /*
  * Serio types
-- 
2.9.3
