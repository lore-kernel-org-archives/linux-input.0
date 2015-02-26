From: Mathias Gottschlag <mgottschlag@gmail.com>
Subject: [PATCHv2 3/4] psmouse: Disable resolution/rate/scale changes for FocalTech touchpads.
Date: Fri, 27 Feb 2015 00:20:07 +0100
Message-ID: <1424992808-29891-4-git-send-email-mgottschlag@gmail.com>
References: <1423940502-12353-1-git-send-email-mgottschlag@gmail.com>
 <1424992808-29891-1-git-send-email-mgottschlag@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424992808-29891-1-git-send-email-mgottschlag@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>
List-Id: linux-input@vger.kernel.org

These PS/2 commands make some touchpads stop responding, so this commit
adds some dummy functions to replace the generic implementation. Because
scale changes were not encapsulated in a method of struct psmouse yet, this
commit adds a method set_scale to psmouse.

Signed-off-by: Mathias Gottschlag <mgottschlag@gmail.com>
---
 drivers/input/mouse/focaltech.c    | 24 ++++++++++++++++++++++++
 drivers/input/mouse/psmouse-base.c | 18 +++++++++++++++++-
 drivers/input/mouse/psmouse.h      |  7 +++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 0cfc646..d96a847 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -386,6 +386,23 @@ static int focaltech_read_size(struct psmouse *psmouse)
 
 	return 0;
 }
+
+void focaltech_set_resolution(struct psmouse *psmouse, unsigned int resolution)
+{
+	/* not supported yet */
+}
+
+static void focaltech_set_rate(struct psmouse *psmouse, unsigned int rate)
+{
+	/* not supported yet */
+}
+
+static void focaltech_set_scale(struct psmouse *psmouse,
+				enum psmouse_scale scale)
+{
+	/* not supported yet */
+}
+
 int focaltech_init(struct psmouse *psmouse)
 {
 	struct focaltech_data *priv;
@@ -420,6 +437,13 @@ int focaltech_init(struct psmouse *psmouse)
 	psmouse->cleanup = focaltech_reset;
 	/* resync is not supported yet */
 	psmouse->resync_time = 0;
+	/*
+	 * rate/resolution/scale changes are not supported yet, and the generic
+	 * implementations of these functions seem to confuse some touchpads
+	 */
+	psmouse->set_resolution = focaltech_set_resolution;
+	psmouse->set_rate = focaltech_set_rate;
+	psmouse->set_scale = focaltech_set_scale;
 
 	return 0;
 
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 68469fe..58537eb 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -454,6 +454,20 @@ static void psmouse_set_rate(struct psmouse *psmouse, unsigned int rate)
 }
 
 /*
+ * Here we set the mouse scaling.
+ */
+
+static void psmouse_set_scale(struct psmouse *psmouse, enum psmouse_scale scale)
+{
+	if (scale == PSMOUSE_SCALE21) {
+		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE21);
+	} else {
+		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
+	}
+	psmouse->scale = scale;
+}
+
+/*
  * psmouse_poll() - default poll handler. Everyone except for ALPS uses it.
  */
 
@@ -689,6 +703,7 @@ static void psmouse_apply_defaults(struct psmouse *psmouse)
 
 	psmouse->set_rate = psmouse_set_rate;
 	psmouse->set_resolution = psmouse_set_resolution;
+	psmouse->set_scale = psmouse_set_scale;
 	psmouse->poll = psmouse_poll;
 	psmouse->protocol_handler = psmouse_process_byte;
 	psmouse->pktsize = 3;
@@ -1160,7 +1175,7 @@ static void psmouse_initialize(struct psmouse *psmouse)
 	if (psmouse_max_proto != PSMOUSE_PS2) {
 		psmouse->set_rate(psmouse, psmouse->rate);
 		psmouse->set_resolution(psmouse, psmouse->resolution);
-		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
+		psmouse->set_scale(psmouse, PSMOUSE_SCALE11);
 	}
 }
 
@@ -1492,6 +1507,7 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 
 	psmouse->rate = psmouse_rate;
 	psmouse->resolution = psmouse_resolution;
+	psmouse->scale = PSMOUSE_SCALE11;
 	psmouse->resetafter = psmouse_resetafter;
 	psmouse->resync_time = parent ? 0 : psmouse_resync_time;
 	psmouse->smartscroll = psmouse_smartscroll;
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index c2ff137..80fc62c 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -36,6 +36,11 @@ typedef enum {
 	PSMOUSE_FULL_PACKET
 } psmouse_ret_t;
 
+enum psmouse_scale {
+	PSMOUSE_SCALE11,
+	PSMOUSE_SCALE21
+};
+
 struct psmouse {
 	void *private;
 	struct input_dev *dev;
@@ -60,6 +65,7 @@ struct psmouse {
 
 	unsigned int rate;
 	unsigned int resolution;
+	enum psmouse_scale scale;
 	unsigned int resetafter;
 	unsigned int resync_time;
 	bool smartscroll;	/* Logitech only */
@@ -67,6 +73,7 @@ struct psmouse {
 	psmouse_ret_t (*protocol_handler)(struct psmouse *psmouse);
 	void (*set_rate)(struct psmouse *psmouse, unsigned int rate);
 	void (*set_resolution)(struct psmouse *psmouse, unsigned int resolution);
+	void (*set_scale)(struct psmouse *psmouse, enum psmouse_scale scale);
 
 	int (*reconnect)(struct psmouse *psmouse);
 	void (*disconnect)(struct psmouse *psmouse);
-- 
2.1.0
