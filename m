From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 06/13] Input: mouse  Use local variables consistently
Date: Sat, 21 Jan 2017 10:45:58 -0800
Message-ID: <1485024365-3368-7-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49924 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbdAUSro (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 13:47:44 -0500
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

If a function declares a variable to access a structure element,
use it conssistently.

The conversion was done automatically with coccinelle using
the following semantic patch.

// Catch function parameters.
// Handle those first to trigger reformatting.

@@
identifier d;
identifier fn;
identifier svar;
identifier elem;
type T;
identifier i;
expression e;
identifier fn;
expression list es;
@@

fn(...) {
  ...
  T d = &svar->elem;
<... when != d = e;
- fn(&svar->elem, es)
+ fn(d, es)
...> }

// Now address non-functions and multiple transformations in function
// parameters.

@@
identifier d;
identifier fn;
identifier svar;
identifier elem;
type T;
identifier i;
expression e;
@@

fn(...) {
  ...
  T d = &svar->elem;
<... when != d = e;
(
- &svar->elem
+ d
|
- svar->elem.i
+ d->i
)
...> }

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/mouse/alps.c          |  2 +-
 drivers/input/mouse/bcm5974.c       |  2 +-
 drivers/input/mouse/cyapa.c         |  6 ++---
 drivers/input/mouse/cypress_ps2.c   |  4 ++--
 drivers/input/mouse/elan_i2c_core.c | 46 +++++++++++++++----------------------
 drivers/input/mouse/elantech.c      |  2 +-
 drivers/input/mouse/hgpk.c          |  5 ++--
 drivers/input/mouse/logips2pp.c     |  2 +-
 drivers/input/mouse/trackpoint.c    |  4 ++--
 9 files changed, 31 insertions(+), 42 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 328edc8c8786..72b28ebfe360 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1855,7 +1855,7 @@ static int alps_absolute_mode_v1_v2(struct psmouse *psmouse)
 	 * Switch mouse to poll (remote) mode so motion data will not
 	 * get in our way
 	 */
-	return ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETPOLL);
+	return ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL);
 }
 
 static int alps_monitor_mode_send_word(struct psmouse *psmouse, u16 word)
diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 30e3442518f8..d0122134f320 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -665,7 +665,7 @@ static int bcm5974_wellspring_mode(struct bcm5974 *dev, bool on)
 	char *data;
 
 	/* Type 3 does not require a mode switch */
-	if (dev->cfg.tp_type == TYPE3)
+	if (c->tp_type == TYPE3)
 		return 0;
 
 	data = kmalloc(c->um_size, GFP_KERNEL);
diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index dc2394292088..fd8865c65caf 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -832,8 +832,8 @@ static int cyapa_prepare_wakeup_controls(struct cyapa *cyapa)
 	int error;
 
 	if (device_can_wakeup(dev)) {
-		error = sysfs_merge_group(&client->dev.kobj,
-					&cyapa_power_wakeup_group);
+		error = sysfs_merge_group(&dev->kobj,
+					  &cyapa_power_wakeup_group);
 		if (error) {
 			dev_err(dev, "failed to add power wakeup group: %d\n",
 				error);
@@ -1312,7 +1312,7 @@ static int cyapa_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = sysfs_create_group(&client->dev.kobj, &cyapa_sysfs_group);
+	error = sysfs_create_group(&dev->kobj, &cyapa_sysfs_group);
 	if (error) {
 		dev_err(dev, "failed to create sysfs entries: %d\n", error);
 		return error;
diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
index 28dcfc822bf6..faa3a980d4f5 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -107,7 +107,7 @@ static int cypress_ps2_read_cmd_status(struct psmouse *psmouse,
 	enum psmouse_state old_state;
 	int pktsize;
 
-	ps2_begin_command(&psmouse->ps2dev);
+	ps2_begin_command(ps2dev);
 
 	old_state = psmouse->state;
 	psmouse->state = PSMOUSE_CMD_MODE;
@@ -133,7 +133,7 @@ static int cypress_ps2_read_cmd_status(struct psmouse *psmouse,
 	psmouse->state = old_state;
 	psmouse->pktcnt = 0;
 
-	ps2_end_command(&psmouse->ps2dev);
+	ps2_end_command(ps2dev);
 
 	return rc;
 }
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fa598f7f4372..2c7d2872636c 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1041,8 +1041,7 @@ static int elan_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	data = devm_kzalloc(&client->dev, sizeof(struct elan_tp_data),
-			    GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct elan_tp_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -1053,29 +1052,25 @@ static int elan_probe(struct i2c_client *client,
 	init_completion(&data->fw_completion);
 	mutex_init(&data->sysfs_mutex);
 
-	data->vcc = devm_regulator_get(&client->dev, "vcc");
+	data->vcc = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(data->vcc)) {
 		error = PTR_ERR(data->vcc);
 		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get 'vcc' regulator: %d\n",
+			dev_err(dev, "Failed to get 'vcc' regulator: %d\n",
 				error);
 		return error;
 	}
 
 	error = regulator_enable(data->vcc);
 	if (error) {
-		dev_err(&client->dev,
-			"Failed to enable regulator: %d\n", error);
+		dev_err(dev, "Failed to enable regulator: %d\n", error);
 		return error;
 	}
 
-	error = devm_add_action(&client->dev,
-				elan_disable_regulator, data);
+	error = devm_add_action(dev, elan_disable_regulator, data);
 	if (error) {
 		regulator_disable(data->vcc);
-		dev_err(&client->dev,
-			"Failed to add disable regulator action: %d\n",
+		dev_err(dev, "Failed to add disable regulator action: %d\n",
 			error);
 		return error;
 	}
@@ -1093,14 +1088,14 @@ static int elan_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
-	dev_info(&client->dev,
+	dev_info(dev,
 		 "Elan Touchpad: Module ID: 0x%04x, Firmware: 0x%04x, Sample: 0x%04x, IAP: 0x%04x\n",
 		 data->product_id,
 		 data->fw_version,
 		 data->sm_version,
 		 data->iap_version);
 
-	dev_dbg(&client->dev,
+	dev_dbg(dev,
 		"Elan Touchpad Extra Information:\n"
 		"    Max ABS X,Y:   %d,%d\n"
 		"    Width X,Y:   %d,%d\n"
@@ -1118,38 +1113,33 @@ static int elan_probe(struct i2c_client *client,
 	 * Systems using device tree should set up interrupt via DTS,
 	 * the rest will use the default falling edge interrupts.
 	 */
-	irqflags = client->dev.of_node ? 0 : IRQF_TRIGGER_FALLING;
+	irqflags = dev->of_node ? 0 : IRQF_TRIGGER_FALLING;
 
-	error = devm_request_threaded_irq(&client->dev, client->irq,
-					  NULL, elan_isr,
+	error = devm_request_threaded_irq(dev, client->irq, NULL, elan_isr,
 					  irqflags | IRQF_ONESHOT,
 					  client->name, data);
 	if (error) {
-		dev_err(&client->dev, "cannot register irq=%d\n", client->irq);
+		dev_err(dev, "cannot register irq=%d\n", client->irq);
 		return error;
 	}
 
-	error = sysfs_create_groups(&client->dev.kobj, elan_sysfs_groups);
+	error = sysfs_create_groups(&dev->kobj, elan_sysfs_groups);
 	if (error) {
-		dev_err(&client->dev, "failed to create sysfs attributes: %d\n",
-			error);
+		dev_err(dev, "failed to create sysfs attributes: %d\n", error);
 		return error;
 	}
 
-	error = devm_add_action(&client->dev,
-				elan_remove_sysfs_groups, data);
+	error = devm_add_action(dev, elan_remove_sysfs_groups, data);
 	if (error) {
 		elan_remove_sysfs_groups(data);
-		dev_err(&client->dev,
-			"Failed to add sysfs cleanup action: %d\n",
+		dev_err(dev, "Failed to add sysfs cleanup action: %d\n",
 			error);
 		return error;
 	}
 
 	error = input_register_device(data->input);
 	if (error) {
-		dev_err(&client->dev, "failed to register input device: %d\n",
-			error);
+		dev_err(dev, "failed to register input device: %d\n", error);
 		return error;
 	}
 
@@ -1157,8 +1147,8 @@ static int elan_probe(struct i2c_client *client,
 	 * Systems using device tree should set up wakeup via DTS,
 	 * the rest will configure device as wakeup source by default.
 	 */
-	if (!client->dev.of_node)
-		device_init_wakeup(&client->dev, true);
+	if (!dev->of_node)
+		device_init_wakeup(dev, true);
 
 	return 0;
 }
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index db7d1d666ac1..efc8ec342351 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1412,7 +1412,7 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	unsigned char param[3];
 
-	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
+	ps2_command(ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
 
 	if (ps2_command(ps2dev,  NULL, PSMOUSE_CMD_DISABLE) ||
 	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE11) ||
diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 62be888e83d0..015509e0b140 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -713,8 +713,7 @@ static int hgpk_toggle_powersave(struct psmouse *psmouse, int enable)
 		 * the upper bound. (in practice, it takes about 3 loops.)
 		 */
 		for (timeo = 20; timeo > 0; timeo--) {
-			if (!ps2_sendbyte(&psmouse->ps2dev,
-					PSMOUSE_CMD_DISABLE, 20))
+			if (!ps2_sendbyte(ps2dev, PSMOUSE_CMD_DISABLE, 20))
 				break;
 			msleep(25);
 		}
@@ -740,7 +739,7 @@ static int hgpk_toggle_powersave(struct psmouse *psmouse, int enable)
 		psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 
 		/* probably won't see an ACK, the touchpad will be off */
-		ps2_sendbyte(&psmouse->ps2dev, 0xec, 20);
+		ps2_sendbyte(ps2dev, 0xec, 20);
 	}
 
 	return 0;
diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index 422da1cd9e76..ef9c97f5e3d7 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -402,7 +402,7 @@ int ps2pp_detect(struct psmouse *psmouse, bool set_properties)
 				psmouse->set_resolution = ps2pp_set_resolution;
 				psmouse->disconnect = ps2pp_disconnect;
 
-				error = device_create_file(&psmouse->ps2dev.serio->dev,
+				error = device_create_file(&ps2dev->serio->dev,
 							   &psmouse_attr_smartscroll.dattr);
 				if (error) {
 					psmouse_err(psmouse,
diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 7331084973e1..922ea02edcc3 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -379,7 +379,7 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
 	if (!set_properties)
 		return 0;
 
-	if (trackpoint_read(&psmouse->ps2dev, TP_EXT_BTN, &button_info)) {
+	if (trackpoint_read(ps2dev, TP_EXT_BTN, &button_info)) {
 		psmouse_warn(psmouse, "failed to get extended button data\n");
 		button_info = 0;
 	}
@@ -402,7 +402,7 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
 
 	trackpoint_defaults(psmouse->private);
 
-	error = trackpoint_power_on_reset(&psmouse->ps2dev);
+	error = trackpoint_power_on_reset(ps2dev);
 
 	/* Write defaults to TP only if reset fails. */
 	if (error)
-- 
2.7.4

