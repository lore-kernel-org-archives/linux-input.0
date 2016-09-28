From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 10/12] Input: synaptics-rmi4 - smbus: call psmouse_deactivate before binding/resume
Date: Wed, 28 Sep 2016 10:35:45 +0200
Message-ID: <1475051747-25988-11-git-send-email-benjamin.tissoires@redhat.com>
References: <1475051747-25988-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475051747-25988-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The SMBus Synaptics devices enumerated as PS/2 devices have
the problem of being deaf to I2C if the touchpad has been
fully initialized over PS/2 (psmouse_activate being called).
A simple PS/2 deactivate command is enough to make it back alive.

To make sure the pass-through device does not interfere, we also
remove it from serio while using InterTouch.

Add a platform_data callback to reset the PS/2 device and
prevent it to be asynchronously re-enabled at resume.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v2:
- fix an oops when synaptics_disconnect() was called, which leaded
  to a null parameter as psmouse in synaptics_intertouch_enable()
---
 drivers/input/mouse/psmouse-base.c |  3 +++
 drivers/input/mouse/psmouse.h      |  1 +
 drivers/input/mouse/synaptics.c    | 34 ++++++++++++++++++++++++++++++++++
 drivers/input/rmi4/rmi_smbus.c     | 30 ++++++++++++++++++++----------
 include/linux/rmi.h                | 13 +++++++++++++
 5 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 59d7c37..0b1f09a 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -1607,6 +1607,9 @@ static int psmouse_reconnect(struct serio *serio)
 	unsigned char type;
 	int rc = -1;
 
+	if (psmouse->ignore_reconnect)
+		return 0;
+
 	mutex_lock(&psmouse_mutex);
 
 	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index e0ca6cd..e9dc1a1 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -81,6 +81,7 @@ struct psmouse {
 
 	void (*pt_activate)(struct psmouse *psmouse);
 	void (*pt_deactivate)(struct psmouse *psmouse);
+	bool ignore_reconnect;
 };
 
 enum psmouse_type {
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index e3c46f9..e10be58 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -245,6 +245,32 @@ static const char * const smbus_pnp_ids[] = {
 
 static int rmi4_id;
 
+static void synaptics_pt_create(struct psmouse *psmouse);
+
+static int synaptics_intertouch_enable(void *data, bool value)
+{
+	struct psmouse *psmouse = data;
+	struct synaptics_data *priv;
+
+	if (!psmouse)
+		return 0;
+
+	priv = psmouse->private;
+
+	psmouse->ignore_reconnect = value;
+
+	if (value) {
+		serio_unregister_child_port(psmouse->ps2dev.serio);
+		psmouse_deactivate(psmouse);
+	} else {
+		psmouse_activate(psmouse);
+		if (SYN_CAP_PASS_THROUGH(priv->capabilities))
+			synaptics_pt_create(psmouse);
+	}
+
+	return 0;
+}
+
 static int synaptics_create_intertouch(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
@@ -262,6 +288,8 @@ static int synaptics_create_intertouch(struct psmouse *psmouse)
 			.trackstick_buttons =
 			  !!SYN_CAP_EXT_BUTTONS_STICK(priv->ext_cap_10),
 		},
+		.transport_enable = synaptics_intertouch_enable,
+		.transport_data = psmouse,
 	};
 
 	if (priv->intertouch)
@@ -1398,6 +1426,12 @@ static void synaptics_disconnect(struct psmouse *psmouse)
 				   &psmouse_attr_disable_gesture.dattr);
 
 	if (priv->intertouch) {
+		struct rmi_device_platform_data *pdata;
+
+		/* reset transport_data as it will get eventually freed */
+		pdata = priv->intertouch->dev.platform_data;
+		pdata->transport_data = NULL;
+
 		platform_device_unregister(priv->intertouch);
 		priv->intertouch = NULL;
 	}
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 4d6f228..023dbd5 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -244,8 +244,15 @@ static void rmi_smb_clear_state(struct rmi_smb_xport *rmi_smb)
 
 static int rmi_smb_enable_smbus_mode(struct rmi_smb_xport *rmi_smb)
 {
+	struct rmi_device_platform_data *pdata;
 	int retval;
 
+	pdata = dev_get_platdata(&rmi_smb->client->dev);
+
+	retval = rmi_transport_enable(pdata, true);
+	if (retval)
+		return retval;
+
 	/* we need to get the smbus version to activate the touchpad */
 	retval = rmi_smb_get_version(rmi_smb);
 	if (retval < 0)
@@ -261,13 +268,6 @@ static int rmi_smb_reset(struct rmi_transport_dev *xport, u16 reset_addr)
 
 	rmi_smb_clear_state(rmi_smb);
 
-	/*
-	 * we do not call the actual reset command, it has to be handled in
-	 * PS/2 or there will be races between PS/2 and SMBus.
-	 * PS/2 should ensure that a psmouse_reset is called before
-	 * intializing the device and after it has been removed to be in a known
-	 * state.
-	 */
 	return rmi_smb_enable_smbus_mode(rmi_smb);
 }
 
@@ -334,9 +334,13 @@ static int rmi_smb_probe(struct i2c_client *client,
 	rmi_smb->xport.proto_name = "smb2";
 	rmi_smb->xport.ops = &rmi_smb_ops;
 
+	retval = rmi_transport_enable(pdata, true);
+	if (retval)
+		return retval;
+
 	retval = rmi_smb_get_version(rmi_smb);
 	if (retval < 0)
-		return retval;
+		goto fail;
 
 	smbus_version = retval;
 	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
@@ -345,7 +349,8 @@ static int rmi_smb_probe(struct i2c_client *client,
 	if (smbus_version != 2) {
 		dev_err(&client->dev, "Unrecognized SMB version %d.\n",
 				smbus_version);
-		return -ENODEV;
+		retval = -ENODEV;
+		goto fail;
 	}
 
 	i2c_set_clientdata(client, rmi_smb);
@@ -355,20 +360,25 @@ static int rmi_smb_probe(struct i2c_client *client,
 		dev_err(&client->dev, "Failed to register transport driver at 0x%.2X.\n",
 			client->addr);
 		i2c_set_clientdata(client, NULL);
-		return retval;
+		goto fail;
 	}
 
 	dev_info(&client->dev, "registered rmi smb driver at %#04x.\n",
 			client->addr);
 	return 0;
 
+fail:
+	rmi_transport_enable(pdata, false);
+	return retval;
 }
 
 static int rmi_smb_remove(struct i2c_client *client)
 {
+	struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct rmi_smb_xport *rmi_smb = i2c_get_clientdata(client);
 
 	rmi_unregister_transport_device(&rmi_smb->xport);
+	rmi_transport_enable(pdata, false);
 
 	return 0;
 }
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 4a071e8..02e1dae 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -214,6 +214,9 @@ struct rmi_device_platform_data {
 	struct rmi_2d_sensor_platform_data sensor_pdata;
 	struct rmi_f01_power_management power_management;
 	struct rmi_f30_data f30_data;
+
+	int (*transport_enable)(void*, bool);
+	void *transport_data;
 };
 
 /**
@@ -350,6 +353,16 @@ struct rmi_driver_data {
 	void *data;
 };
 
+static inline int rmi_transport_enable(struct rmi_device_platform_data *pdata,
+				       bool value)
+{
+	if (!pdata->transport_enable)
+		return 0;
+
+	return pdata->transport_enable(pdata->transport_data, value);
+}
+
+
 int rmi_register_transport_device(struct rmi_transport_dev *xport);
 void rmi_unregister_transport_device(struct rmi_transport_dev *xport);
 int rmi_process_interrupt_requests(struct rmi_device *rmi_dev);
-- 
2.7.4
