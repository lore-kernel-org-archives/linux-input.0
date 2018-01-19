From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/7] Input: psmouse - move sliced command implementation to libps2
Date: Fri, 19 Jan 2018 11:41:08 -0800
Message-ID: <20180119194111.185590-5-dmitry.torokhov@gmail.com>
References: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34610 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756236AbeASTlT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 14:41:19 -0500
In-Reply-To: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

In preparation to adding some debugging statements to PS/2 control
sequences let's move psmouse_sliced_command() into libps2 and rename it
to ps2_sliced_command().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elantech.c     | 12 ++++++------
 drivers/input/mouse/logips2pp.c    |  2 +-
 drivers/input/mouse/psmouse-base.c | 26 --------------------------
 drivers/input/mouse/psmouse.h      |  1 -
 drivers/input/mouse/synaptics.c    |  8 ++++----
 drivers/input/serio/libps2.c       | 32 ++++++++++++++++++++++++++++++++
 include/linux/libps2.h             |  3 +++
 7 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index af7fc17c14d96..db47a5e1d114d 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -35,7 +35,7 @@
 static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c,
 				unsigned char *param)
 {
-	if (psmouse_sliced_command(psmouse, c) ||
+	if (ps2_sliced_command(&psmouse->ps2dev, c) ||
 	    ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETINFO)) {
 		psmouse_err(psmouse, "%s query 0x%02x failed.\n", __func__, c);
 		return -1;
@@ -107,8 +107,8 @@ static int elantech_read_reg(struct psmouse *psmouse, unsigned char reg,
 
 	switch (etd->hw_version) {
 	case 1:
-		if (psmouse_sliced_command(psmouse, ETP_REGISTER_READ) ||
-		    psmouse_sliced_command(psmouse, reg) ||
+		if (ps2_sliced_command(&psmouse->ps2dev, ETP_REGISTER_READ) ||
+		    ps2_sliced_command(&psmouse->ps2dev, reg) ||
 		    ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETINFO)) {
 			rc = -1;
 		}
@@ -162,9 +162,9 @@ static int elantech_write_reg(struct psmouse *psmouse, unsigned char reg,
 
 	switch (etd->hw_version) {
 	case 1:
-		if (psmouse_sliced_command(psmouse, ETP_REGISTER_WRITE) ||
-		    psmouse_sliced_command(psmouse, reg) ||
-		    psmouse_sliced_command(psmouse, val) ||
+		if (ps2_sliced_command(&psmouse->ps2dev, ETP_REGISTER_WRITE) ||
+		    ps2_sliced_command(&psmouse->ps2dev, reg) ||
+		    ps2_sliced_command(&psmouse->ps2dev, val) ||
 		    ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11)) {
 			rc = -1;
 		}
diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index 7f4813fc3c6dd..51a156afa6c21 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -116,7 +116,7 @@ static int ps2pp_cmd(struct psmouse *psmouse, u8 *param, u8 command)
 {
 	int error;
 
-	error = psmouse_sliced_command(psmouse, command);
+	error = ps2_sliced_command(&psmouse->ps2dev, command);
 	if (error)
 		return error;
 
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index e3523143296ad..cbe12671f784c 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -429,32 +429,6 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 	return IRQ_HANDLED;
 }
 
-/*
- * psmouse_sliced_command() sends an extended PS/2 command to the mouse
- * using sliced syntax, understood by advanced devices, such as Logitech
- * or Synaptics touchpads. The command is encoded as:
- * 0xE6 0xE8 rr 0xE8 ss 0xE8 tt 0xE8 uu where (rr*64)+(ss*16)+(tt*4)+uu
- * is the command.
- */
-int psmouse_sliced_command(struct psmouse *psmouse, u8 command)
-{
-	int i;
-	int error;
-
-	error = ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
-	if (error)
-		return error;
-
-	for (i = 6; i >= 0; i -= 2) {
-		u8 d = (command >> i) & 3;
-		error = ps2_command(&psmouse->ps2dev, &d, PSMOUSE_CMD_SETRES);
-		if (error)
-			return error;
-	}
-
-	return 0;
-}
-
 /*
  * psmouse_reset() resets the mouse into power-on state.
  */
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 8bc99691494e9..71ac50082c8b4 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -131,7 +131,6 @@ struct psmouse {
 
 void psmouse_queue_work(struct psmouse *psmouse, struct delayed_work *work,
 		unsigned long delay);
-int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
 int psmouse_reset(struct psmouse *psmouse);
 void psmouse_set_state(struct psmouse *psmouse, enum psmouse_state new_state);
 void psmouse_set_resolution(struct psmouse *psmouse, unsigned int resolution);
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 3d2e23a0ae39d..588408abc17e0 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -84,7 +84,7 @@ static int synaptics_mode_cmd(struct psmouse *psmouse, u8 mode)
 	u8 param[1];
 	int error;
 
-	error = psmouse_sliced_command(psmouse, mode);
+	error = ps2_sliced_command(&psmouse->ps2dev, mode);
 	if (error)
 		return error;
 
@@ -190,7 +190,7 @@ static int synaptics_send_cmd(struct psmouse *psmouse, u8 cmd, u8 *param)
 {
 	int error;
 
-	error = psmouse_sliced_command(psmouse, cmd);
+	error = ps2_sliced_command(&psmouse->ps2dev, cmd);
 	if (error)
 		return error;
 
@@ -547,7 +547,7 @@ static int synaptics_set_advanced_gesture_mode(struct psmouse *psmouse)
 	static u8 param = 0xc8;
 	int error;
 
-	error = psmouse_sliced_command(psmouse, SYN_QUE_MODEL);
+	error = ps2_sliced_command(&psmouse->ps2dev, SYN_QUE_MODEL);
 	if (error)
 		return error;
 
@@ -614,7 +614,7 @@ static int synaptics_pt_write(struct serio *serio, u8 c)
 	u8 rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
 	int error;
 
-	error = psmouse_sliced_command(parent, c);
+	error = ps2_sliced_command(&parent->ps2dev, c);
 	if (error)
 		return error;
 
diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index c3712f0a47b50..e96ae477f0b56 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -269,6 +269,38 @@ int ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 }
 EXPORT_SYMBOL(ps2_command);
 
+/*
+ * ps2_sliced_command() sends an extended PS/2 command to the mouse
+ * using sliced syntax, understood by advanced devices, such as Logitech
+ * or Synaptics touchpads. The command is encoded as:
+ * 0xE6 0xE8 rr 0xE8 ss 0xE8 tt 0xE8 uu where (rr*64)+(ss*16)+(tt*4)+uu
+ * is the command.
+ */
+
+int ps2_sliced_command(struct ps2dev *ps2dev, u8 command)
+{
+	int i;
+	int retval;
+
+	ps2_begin_command(ps2dev);
+
+	retval = __ps2_command(ps2dev, NULL, PS2_CMD_SETSCALE11);
+	if (retval)
+		goto out;
+
+	for (i = 6; i >= 0; i -= 2) {
+		u8 d = (command >> i) & 3;
+		retval = __ps2_command(ps2dev, &d, PS2_CMD_SETRES);
+		if (retval)
+			break;
+	}
+
+out:
+	ps2_end_command(ps2dev);
+	return retval;
+}
+EXPORT_SYMBOL(ps2_sliced_command);
+
 /*
  * ps2_init() initializes ps2dev structure
  */
diff --git a/include/linux/libps2.h b/include/linux/libps2.h
index 649295a5ff47d..cd4454502a042 100644
--- a/include/linux/libps2.h
+++ b/include/linux/libps2.h
@@ -11,6 +11,8 @@
  */
 
 
+#define PS2_CMD_SETSCALE11	0x00e6
+#define PS2_CMD_SETRES		0x10e8
 #define PS2_CMD_GETID		0x02f2
 #define PS2_CMD_RESET_BAT	0x02ff
 
@@ -48,6 +50,7 @@ void ps2_begin_command(struct ps2dev *ps2dev);
 void ps2_end_command(struct ps2dev *ps2dev);
 int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command);
 int ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command);
+int ps2_sliced_command(struct ps2dev *ps2dev, u8 command);
 bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data);
 bool ps2_handle_response(struct ps2dev *ps2dev, u8 data);
 void ps2_cmd_aborted(struct ps2dev *ps2dev);
-- 
2.16.0.rc1.238.g530d649a79-goog

