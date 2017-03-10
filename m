From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 5/9] Input: psmouse - introduce notion of SMBus companions
Date: Fri, 10 Mar 2017 15:01:10 -0800
Message-ID: <20170310230114.788-6-dmitry.torokhov@gmail.com>
References: <20170310230114.788-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170310230114.788-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Prepare PS/2 mouse drivers to work with devices that are accessible both
via PS/2 and SMBus, which provides higher bandwidth, and thus suits better
for modern multi-touch devices.

We expect that SMBus drivers will take control over the device, so when
we detect SMBus "protocol" we forego registering input device, or enabling
PS/2 device reports (as it usually makes device unresponsive to access over
SMBus).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/psmouse-base.c | 100 +++++++++++++++++++++++++------------
 drivers/input/mouse/psmouse.h      |   1 +
 2 files changed, 68 insertions(+), 33 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index bb5d164849ea..40f09ce84f14 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1424,9 +1424,8 @@ static void psmouse_cleanup(struct serio *serio)
  */
 static void psmouse_disconnect(struct serio *serio)
 {
-	struct psmouse *psmouse, *parent = NULL;
-
-	psmouse = serio_get_drvdata(serio);
+	struct psmouse *psmouse = serio_get_drvdata(serio);
+	struct psmouse *parent = NULL;
 
 	sysfs_remove_group(&serio->dev.kobj, &psmouse_attribute_group);
 
@@ -1454,7 +1453,10 @@ static void psmouse_disconnect(struct serio *serio)
 
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
-	input_unregister_device(psmouse->dev);
+
+	if (psmouse->dev)
+		input_unregister_device(psmouse->dev);
+
 	kfree(psmouse);
 
 	if (parent)
@@ -1575,12 +1577,18 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 
 	psmouse_switch_protocol(psmouse, NULL);
 
-	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
-	psmouse_initialize(psmouse);
+	if (!psmouse->protocol->smbus_companion) {
+		psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+		psmouse_initialize(psmouse);
 
-	error = input_register_device(psmouse->dev);
-	if (error)
-		goto err_protocol_disconnect;
+		error = input_register_device(input_dev);
+		if (error)
+			goto err_protocol_disconnect;
+	} else {
+		/* Smbus companion will be reporting events, not us. */
+		input_free_device(input_dev);
+		psmouse->dev = input_dev = NULL;
+	}
 
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
@@ -1589,7 +1597,12 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
 	if (error)
 		goto err_pt_deactivate;
 
-	psmouse_activate(psmouse);
+	/*
+	 * PS/2 devices having SMBus companions should stay disabled
+	 * on PS/2 side, in order to have SMBus part operable.
+	 */
+	if (!psmouse->protocol->smbus_companion)
+		psmouse_activate(psmouse);
 
  out:
 	/* If this is a pass-through port the parent needs to be re-activated */
@@ -1602,8 +1615,10 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
  err_pt_deactivate:
 	if (parent && parent->pt_deactivate)
 		parent->pt_deactivate(parent);
-	input_unregister_device(psmouse->dev);
-	input_dev = NULL; /* so we don't try to free it below */
+	if (input_dev) {
+		input_unregister_device(input_dev);
+		input_dev = NULL; /* so we don't try to free it below */
+	}
  err_protocol_disconnect:
 	if (psmouse->disconnect)
 		psmouse->disconnect(psmouse);
@@ -1665,14 +1680,21 @@ static int __psmouse_reconnect(struct serio *serio, bool fast_reconnect)
 	 * OK, the device type (and capabilities) match the old one,
 	 * we can continue using it, complete initialization
 	 */
-	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
-
-	psmouse_initialize(psmouse);
+	if (!psmouse->protocol->smbus_companion) {
+		psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+		psmouse_initialize(psmouse);
+	}
 
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
 
-	psmouse_activate(psmouse);
+	/*
+	 * PS/2 devices having SMBus companions should stay disabled
+	 * on PS/2 side, in order to have SMBus part operable.
+	 */
+	if (!psmouse->protocol->smbus_companion)
+		psmouse_activate(psmouse);
+
 	rc = 0;
 
 out:
@@ -1732,9 +1754,11 @@ ssize_t psmouse_attr_show_helper(struct device *dev, struct device_attribute *de
 {
 	struct serio *serio = to_serio_port(dev);
 	struct psmouse_attribute *attr = to_psmouse_attr(devattr);
-	struct psmouse *psmouse;
+	struct psmouse *psmouse = serio_get_drvdata(serio);
 
-	psmouse = serio_get_drvdata(serio);
+	if (psmouse->protocol->smbus_companion &&
+			devattr != &psmouse_attr_protocol.dattr)
+		return -ENOENT;
 
 	return attr->show(psmouse, attr->data, buf);
 }
@@ -1753,6 +1777,12 @@ ssize_t psmouse_attr_set_helper(struct device *dev, struct device_attribute *dev
 
 	psmouse = serio_get_drvdata(serio);
 
+	if (psmouse->protocol->smbus_companion &&
+			devattr != &psmouse_attr_protocol.dattr) {
+		retval = -ENOENT;
+		goto out_unlock;
+	}
+
 	if (attr->protect) {
 		if (psmouse->state == PSMOUSE_IGNORE) {
 			retval = -ENODEV;
@@ -1764,13 +1794,14 @@ ssize_t psmouse_attr_set_helper(struct device *dev, struct device_attribute *dev
 			psmouse_deactivate(parent);
 		}
 
-		psmouse_deactivate(psmouse);
+		if (!psmouse->protocol->smbus_companion)
+			psmouse_deactivate(psmouse);
 	}
 
 	retval = attr->set(psmouse, attr->data, buf, count);
 
 	if (attr->protect) {
-		if (retval != -ENODEV)
+		if (retval != -ENODEV && !psmouse->protocol->smbus_companion)
 			psmouse_activate(psmouse);
 
 		if (parent)
@@ -1879,23 +1910,26 @@ static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, void *data, co
 	psmouse_initialize(psmouse);
 	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
-	error = input_register_device(psmouse->dev);
-	if (error) {
-		if (psmouse->disconnect)
-			psmouse->disconnect(psmouse);
+	if (!psmouse->protocol->smbus_companion) {
+		error = input_register_device(psmouse->dev);
+		if (error) {
+			if (psmouse->disconnect)
+				psmouse->disconnect(psmouse);
 
-		psmouse_set_state(psmouse, PSMOUSE_IGNORE);
-		input_free_device(new_dev);
-		psmouse->dev = old_dev;
-		psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
-		psmouse_switch_protocol(psmouse, old_proto);
-		psmouse_initialize(psmouse);
-		psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
+			psmouse_set_state(psmouse, PSMOUSE_IGNORE);
+			input_free_device(new_dev);
+			psmouse->dev = old_dev;
+			psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
+			psmouse_switch_protocol(psmouse, old_proto);
+			psmouse_initialize(psmouse);
+			psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
 
-		return error;
+			return error;
+		}
 	}
 
-	input_unregister_device(old_dev);
+	if (old_dev)
+		input_unregister_device(old_dev);
 
 	if (parent && parent->pt_activate)
 		parent->pt_activate(parent);
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 36bd42179456..e853dee05e79 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -76,6 +76,7 @@ struct psmouse_protocol {
 	bool maxproto;
 	bool ignore_parity; /* Protocol should ignore parity errors from KBC */
 	bool try_passthru; /* Try protocol also on passthrough ports */
+	bool smbus_companion; /* "Protocol" is a stub, device is on SMBus */
 	const char *name;
 	const char *alias;
 	int (*detect)(struct psmouse *, bool);
-- 
2.12.0.246.ga2ecc84866-goog
