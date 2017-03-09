From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/8] Input: psmouse - store pointer to current protocol
Date: Thu,  9 Mar 2017 14:16:40 -0800
Message-ID: <20170309221644.17035-5-dmitry.torokhov@gmail.com>
References: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of storing only protocol "type" in pmsouse structure, store pointer
to the protocol structure, so that we have access to more data without
having to copy it over to psmouse structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 43 +++++++++--------------
 drivers/input/mouse/psmouse.h      | 70 ++++++++++++++++++++++----------------
 2 files changed, 58 insertions(+), 55 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 47fd2976da7f..bb5d164849ea 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -116,17 +116,6 @@ static DEFINE_MUTEX(psmouse_mutex);
 
 static struct workqueue_struct *kpsmoused_wq;
 
-struct psmouse_protocol {
-	enum psmouse_type type;
-	bool maxproto;
-	bool ignore_parity; /* Protocol should ignore parity errors from KBC */
-	bool try_passthru; /* Try protocol also on passthrough ports */
-	const char *name;
-	const char *alias;
-	int (*detect)(struct psmouse *, bool);
-	int (*init)(struct psmouse *);
-};
-
 static void psmouse_report_standard_buttons(struct input_dev *dev, u8 buttons)
 {
 	input_report_key(dev, BTN_LEFT,   buttons & BIT(0));
@@ -148,7 +137,7 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 
 	/* Full packet accumulated, process it */
 
-	switch (psmouse->type) {
+	switch (psmouse->protocol->type) {
 	case PSMOUSE_IMPS:
 		/* IntelliMouse has scroll wheel */
 		input_report_rel(dev, REL_WHEEL, -(signed char) packet[3]);
@@ -325,7 +314,8 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 		goto out;
 
 	if (unlikely((flags & SERIO_TIMEOUT) ||
-		     ((flags & SERIO_PARITY) && !psmouse->ignore_parity))) {
+		     ((flags & SERIO_PARITY) &&
+		      !psmouse->protocol->ignore_parity))) {
 
 		if (psmouse->state == PSMOUSE_ACTIVATED)
 			psmouse_warn(psmouse,
@@ -372,7 +362,7 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 		}
 
 		if (psmouse->packet[1] == PSMOUSE_RET_ID ||
-		    (psmouse->type == PSMOUSE_HGPK &&
+		    (psmouse->protocol->type == PSMOUSE_HGPK &&
 		     psmouse->packet[1] == PSMOUSE_RET_BAT)) {
 			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 			serio_reconnect(serio);
@@ -959,6 +949,8 @@ static void psmouse_apply_defaults(struct psmouse *psmouse)
 
 	__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
+	psmouse->protocol = &psmouse_protocols[0];
+
 	psmouse->set_rate = psmouse_set_rate;
 	psmouse->set_resolution = psmouse_set_resolution;
 	psmouse->set_scale = psmouse_set_scale;
@@ -1476,6 +1468,7 @@ static int psmouse_switch_protocol(struct psmouse *psmouse,
 {
 	const struct psmouse_protocol *selected_proto;
 	struct input_dev *input_dev = psmouse->dev;
+	enum psmouse_type type;
 
 	input_dev->dev.parent = &psmouse->ps2dev.serio->dev;
 
@@ -1488,15 +1481,13 @@ static int psmouse_switch_protocol(struct psmouse *psmouse,
 		if (proto->init && proto->init(psmouse) < 0)
 			return -1;
 
-		psmouse->type = proto->type;
 		selected_proto = proto;
 	} else {
-		psmouse->type = psmouse_extensions(psmouse,
-						   psmouse_max_proto, true);
-		selected_proto = psmouse_protocol_by_type(psmouse->type);
+		type = psmouse_extensions(psmouse, psmouse_max_proto, true);
+		selected_proto = psmouse_protocol_by_type(type);
 	}
 
-	psmouse->ignore_parity = selected_proto->ignore_parity;
+	psmouse->protocol = selected_proto;
 
 	/*
 	 * If mouse's packet size is 3 there is no point in polling the
@@ -1522,7 +1513,7 @@ static int psmouse_switch_protocol(struct psmouse *psmouse,
 	input_dev->phys = psmouse->phys;
 	input_dev->id.bustype = BUS_I8042;
 	input_dev->id.vendor = 0x0002;
-	input_dev->id.product = psmouse->type;
+	input_dev->id.product = psmouse->protocol->type;
 	input_dev->id.version = psmouse->model;
 
 	return 0;
@@ -1634,7 +1625,7 @@ static int __psmouse_reconnect(struct serio *serio, bool fast_reconnect)
 	struct psmouse *psmouse = serio_get_drvdata(serio);
 	struct psmouse *parent = NULL;
 	int (*reconnect_handler)(struct psmouse *);
-	unsigned char type;
+	enum psmouse_type type;
 	int rc = -1;
 
 	mutex_lock(&psmouse_mutex);
@@ -1666,7 +1657,7 @@ static int __psmouse_reconnect(struct serio *serio, bool fast_reconnect)
 			goto out;
 
 		type = psmouse_extensions(psmouse, psmouse_max_proto, false);
-		if (psmouse->type != type)
+		if (psmouse->protocol->type != type)
 			goto out;
 	}
 
@@ -1816,7 +1807,7 @@ static ssize_t psmouse_set_int_attr(struct psmouse *psmouse, void *offset, const
 
 static ssize_t psmouse_attr_show_protocol(struct psmouse *psmouse, void *data, char *buf)
 {
-	return sprintf(buf, "%s\n", psmouse_protocol_by_type(psmouse->type)->name);
+	return sprintf(buf, "%s\n", psmouse->protocol->name);
 }
 
 static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, void *data, const char *buf, size_t count)
@@ -1832,7 +1823,7 @@ static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, void *data, co
 	if (!proto)
 		return -EINVAL;
 
-	if (psmouse->type == proto->type)
+	if (psmouse->protocol == proto)
 		return count;
 
 	new_dev = input_allocate_device();
@@ -1856,7 +1847,7 @@ static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, void *data, co
 			return -ENODEV;
 		}
 
-		if (psmouse->type == proto->type) {
+		if (psmouse->protocol == proto) {
 			input_free_device(new_dev);
 			return count; /* switched by other thread */
 		}
@@ -1869,7 +1860,7 @@ static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, void *data, co
 	}
 
 	old_dev = psmouse->dev;
-	old_proto = psmouse_protocol_by_type(psmouse->type);
+	old_proto = psmouse->protocol;
 
 	if (psmouse->disconnect)
 		psmouse->disconnect(psmouse);
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index bc76e771812b..36bd42179456 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -44,21 +44,58 @@ enum psmouse_scale {
 	PSMOUSE_SCALE21
 };
 
+enum psmouse_type {
+	PSMOUSE_NONE,
+	PSMOUSE_PS2,
+	PSMOUSE_PS2PP,
+	PSMOUSE_THINKPS,
+	PSMOUSE_GENPS,
+	PSMOUSE_IMPS,
+	PSMOUSE_IMEX,
+	PSMOUSE_SYNAPTICS,
+	PSMOUSE_ALPS,
+	PSMOUSE_LIFEBOOK,
+	PSMOUSE_TRACKPOINT,
+	PSMOUSE_TOUCHKIT_PS2,
+	PSMOUSE_CORTRON,
+	PSMOUSE_HGPK,
+	PSMOUSE_ELANTECH,
+	PSMOUSE_FSP,
+	PSMOUSE_SYNAPTICS_RELATIVE,
+	PSMOUSE_CYPRESS,
+	PSMOUSE_FOCALTECH,
+	PSMOUSE_VMMOUSE,
+	PSMOUSE_BYD,
+	PSMOUSE_AUTO		/* This one should always be last */
+};
+
+struct psmouse;
+
+struct psmouse_protocol {
+	enum psmouse_type type;
+	bool maxproto;
+	bool ignore_parity; /* Protocol should ignore parity errors from KBC */
+	bool try_passthru; /* Try protocol also on passthrough ports */
+	const char *name;
+	const char *alias;
+	int (*detect)(struct psmouse *, bool);
+	int (*init)(struct psmouse *);
+};
+
 struct psmouse {
 	void *private;
 	struct input_dev *dev;
 	struct ps2dev ps2dev;
 	struct delayed_work resync_work;
-	char *vendor;
-	char *name;
+	const char *vendor;
+	const char *name;
+	const struct psmouse_protocol *protocol;
 	unsigned char packet[8];
 	unsigned char badbyte;
 	unsigned char pktcnt;
 	unsigned char pktsize;
-	unsigned char type;
 	unsigned char oob_data_type;
 	unsigned char extra_buttons;
-	bool ignore_parity;
 	bool acks_disable_command;
 	unsigned int model;
 	unsigned long last;
@@ -89,31 +126,6 @@ struct psmouse {
 	void (*pt_deactivate)(struct psmouse *psmouse);
 };
 
-enum psmouse_type {
-	PSMOUSE_NONE,
-	PSMOUSE_PS2,
-	PSMOUSE_PS2PP,
-	PSMOUSE_THINKPS,
-	PSMOUSE_GENPS,
-	PSMOUSE_IMPS,
-	PSMOUSE_IMEX,
-	PSMOUSE_SYNAPTICS,
-	PSMOUSE_ALPS,
-	PSMOUSE_LIFEBOOK,
-	PSMOUSE_TRACKPOINT,
-	PSMOUSE_TOUCHKIT_PS2,
-	PSMOUSE_CORTRON,
-	PSMOUSE_HGPK,
-	PSMOUSE_ELANTECH,
-	PSMOUSE_FSP,
-	PSMOUSE_SYNAPTICS_RELATIVE,
-	PSMOUSE_CYPRESS,
-	PSMOUSE_FOCALTECH,
-	PSMOUSE_VMMOUSE,
-	PSMOUSE_BYD,
-	PSMOUSE_AUTO		/* This one should always be last */
-};
-
 void psmouse_queue_work(struct psmouse *psmouse, struct delayed_work *work,
 		unsigned long delay);
 int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
-- 
2.12.0.246.ga2ecc84866-goog
