From: Stefan Assmann <sassmann@kpanic.de>
Subject: [PATCH] Input: psmouse - add small delay for IBM trackpoint pass-through mode
Date: Sat, 15 Aug 2015 16:40:18 +0200
Message-ID: <1439649618-3366-1-git-send-email-sassmann@kpanic.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, sassmann@kpanic.de
List-Id: linux-input@vger.kernel.org

There are trackpoint devices that fail to respond to the PS2 command
PSMOUSE_CMD_GETID if immediately queried after the parent device is
deactivated. Add a small delay for the hardware to get in a sane state
before sending any PS2 commands.

One example of such a system is:
Lenovo ThinkPad X120e, model 30515QG
synaptics: Touchpad model: 1, fw: 8.0, id: 0x1e2b1, caps: 0xd001a3/0x940300/0x121c00, board id: 1811, fw id: 797391

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 drivers/input/mouse/psmouse-base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index ec347703..ad18dab 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1540,6 +1540,10 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 	if (error)
 		goto err_clear_drvdata;
 
+	/* give PT device some time to settle down before probing */
+	if (serio->id.type == SERIO_PS_PSTHRU)
+		usleep_range(10000, 15000);
+
 	if (psmouse_probe(psmouse) < 0) {
 		error = -ENODEV;
 		goto err_close_serio;
-- 
2.4.3
