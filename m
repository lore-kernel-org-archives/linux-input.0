From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 06/10] Input: synaptics-rmi4 - smbus: call psmouse_deactivate before binding/resume
Date: Tue, 10 Jan 2017 17:11:24 +0100
Message-ID: <20170110161128.7441-7-benjamin.tissoires@redhat.com>
References: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170110161128.7441-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Andrew Duggan <aduggan@synaptics.com>
Cc: Adrian Alves <aalves@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The SMBus Synaptics devices enumerated as PS/2 devices have
the problem of being deaf to I2C if the touchpad has been
fully initialized over PS/2 (psmouse_activate being called).
A simple PS/2 deactivate command is enough to make it back alive.

We forward the serio parent node to rmi_smbus so it can manually
deactivate/reactivate the serio node (so we can fallback on PS/2
if a problem happens on SMBus).

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_smbus.c | 28 ++++++++++++++++++----------
 include/linux/rmi.h            |  2 ++
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 7675255..3ebb2829 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/rmi.h>
+#include <linux/serio.h>
 #include <linux/slab.h>
 #include "rmi_driver.h"
 
@@ -34,6 +35,7 @@ struct mapping_table_entry {
 struct rmi_smb_xport {
 	struct rmi_transport_dev xport;
 	struct i2c_client *client;
+	struct serio *serio_parent;
 
 	struct mutex page_mutex;
 	int page;
@@ -244,8 +246,13 @@ static void rmi_smb_clear_state(struct rmi_smb_xport *rmi_smb)
 
 static int rmi_smb_enable_smbus_mode(struct rmi_smb_xport *rmi_smb)
 {
+	struct rmi_device_platform_data *pdata;
 	int retval;
 
+	pdata = dev_get_platdata(&rmi_smb->client->dev);
+
+	serio_deactivate(rmi_smb->serio_parent);
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
 
@@ -320,10 +320,13 @@ static int rmi_smb_probe(struct i2c_client *client,
 	rmi_smb->xport.pdata.irq = client->irq;
 	rmi_smb->xport.proto_name = "smb2";
 	rmi_smb->xport.ops = &rmi_smb_ops;
+	rmi_smb->serio_parent = pdata->parent;
+
+	serio_deactivate(rmi_smb->serio_parent);
 
 	retval = rmi_smb_get_version(rmi_smb);
 	if (retval < 0)
-		return retval;
+		goto fail;
 
 	smbus_version = retval;
 	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
@@ -332,7 +335,8 @@ static int rmi_smb_probe(struct i2c_client *client,
 	if (smbus_version != 2) {
 		dev_err(&client->dev, "Unrecognized SMB version %d.\n",
 				smbus_version);
-		return -ENODEV;
+		retval = -ENODEV;
+		goto fail;
 	}
 
 	i2c_set_clientdata(client, rmi_smb);
@@ -342,13 +346,16 @@ static int rmi_smb_probe(struct i2c_client *client,
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
+	serio_activate(rmi_smb->serio_parent);
+	return retval;
 }
 
 static int rmi_smb_remove(struct i2c_client *client)
@@ -356,6 +363,7 @@ static int rmi_smb_remove(struct i2c_client *client)
 	struct rmi_smb_xport *rmi_smb = i2c_get_clientdata(client);
 
 	rmi_unregister_transport_device(&rmi_smb->xport);
+	serio_activate(rmi_smb->serio_parent);
 
 	return 0;
 }
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 64125443..c47da15 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -222,6 +222,8 @@ struct rmi_device_platform_data {
 	struct rmi_2d_sensor_platform_data sensor_pdata;
 	struct rmi_f01_power_management power_management;
 	struct rmi_f30_data f30_data;
+
+	struct serio *parent;
 };
 
 /**
-- 
2.9.3
