From: Denis Carikli <denis@eukrea.com>
Subject: [PATCHv4][ 1/4] Input: tsc2007: Add device tree support.
Date: Mon, 21 Oct 2013 15:54:24 +0200
Message-ID: <1382363667-10341-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:53648 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361Ab3JUNym (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Oct 2013 09:54:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Denis Carikli <denis@eukrea.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Cc: Eric B=C3=A9nard <eric@eukrea.com>
Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v2->v4:
- The x-plate-ohms property was renamed to ti,x-plate-ohms.
- multilines strings were avoided.
- shorten the message related to the lack of ti,x-plate-ohms in the dts=
=2E
- whitespace fix in tsc2007_get_pendown_state_dt(struct tsc2007 *ts)
- (ts->gpio < 0) replaced by !gpio_is_valid(ts->gpio)
- devm_kzalloc is now used instead of kzalloc, and some minor code chan=
ge was
  made because of that.
---
 .../bindings/input/touchscreen/tsc2007.txt         |   44 +++++
 drivers/input/touchscreen/tsc2007.c                |  201 ++++++++++++=
+++-----
 2 files changed, 200 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/tsc2007.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc200=
7.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
new file mode 100644
index 0000000..fadd3f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
@@ -0,0 +1,44 @@
+* Texas Instruments tsc2007 touchscreen controller
+
+Required properties:
+- compatible: must be "ti,tsc2007".
+- reg: I2C address of the chip.
+- pinctrl-0: Should specify pin control groups used for this controlle=
r
+  (see pinctrl bindings[0]).
+- pinctrl-names: Should contain only one value - "default"
+  (see pinctrl bindings[0]).
+- interrupt-parent: the phandle for the interrupt controller
+  (see interrupt binding[1]).
+- interrupts: interrupt to which the chip is connected
+  (see interrupt binding[1]).
+- ti,x-plate-ohms: X-plate resistance in ohms.
+
+Optional properties:
+- gpios: the interrupt gpio the chip is connected to (trough the penir=
q pin)
+  (see GPIO binding[2] for more details).
+- max-rt: maximum pressure.
+- fuzzy: specifies the fuzz value that is used to filter noise from th=
e event
+  stream.
+- poll-period: how much time to wait(in millisecond) before reading ag=
ain the
+  values from the tsc2007.
+
+[0]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+[1]: Documentation/devicetree/bindings/interrupt-controller/interrupts=
=2Etxt
+[2]: Documentation/devicetree/bindings/gpio/gpio.txt
+
+Example:
+	&i2c1 {
+		/* ... */
+		tsc2007@49 {
+			compatible =3D "ti,tsc2007";
+			reg =3D <0x49>;
+			pinctrl-names =3D "default";
+			pinctrl-0 =3D <&pinctrl_tsc2007_1>;
+			interrupt-parent =3D <&gpio4>;
+			interrupts =3D <0x0 0x8>;
+			gpios =3D <&gpio4 0 0>;
+			ti,x-plate-ohms =3D <180>;
+		};
+
+		/* ... */
+	};
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchs=
creen/tsc2007.c
index 0b67ba4..3143ebc 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -26,6 +26,9 @@
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
=20
 #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
 #define TSC2007_MEASURE_AUX		(0x2 << 4)
@@ -74,7 +77,10 @@ struct tsc2007 {
 	u16			max_rt;
 	unsigned long		poll_delay;
 	unsigned long		poll_period;
+	int			fuzzy;
+	char			of;
=20
+	unsigned		gpio;
 	int			irq;
=20
 	wait_queue_head_t	wait;
@@ -84,6 +90,14 @@ struct tsc2007 {
 	void			(*clear_penirq)(void);
 };
=20
+static int tsc2007_get_pendown_state_dt(struct tsc2007 *ts)
+{
+	if (gpio_is_valid(ts->gpio))
+		return !gpio_get_value(ts->gpio);
+	else
+		return true;
+}
+
 static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
 {
 	s32 data;
@@ -158,6 +172,9 @@ static bool tsc2007_is_pen_down(struct tsc2007 *ts)
 	 * to fall back on the pressure reading.
 	 */
=20
+	if (ts->of)
+		return tsc2007_get_pendown_state_dt(ts);
+
 	if (!ts->get_pendown_state)
 		return true;
=20
@@ -175,10 +192,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, void=
 *handle)
=20
 		/* pen is down, continue with the measurement */
 		tsc2007_read_values(ts, &tc);
-
 		rt =3D tsc2007_calculate_pressure(ts, &tc);
=20
-		if (rt =3D=3D 0 && !ts->get_pendown_state) {
+		if ((ts->of && rt =3D=3D 0 && !gpio_is_valid(ts->gpio)) ||
+			(!ts->of && rt =3D=3D 0 && !ts->get_pendown_state)) {
 			/*
 			 * If pressure reported is 0 and we don't have
 			 * callback to check pendown state, we have to
@@ -198,7 +215,6 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *=
handle)
 			input_report_abs(input, ABS_PRESSURE, rt);
=20
 			input_sync(input);
-
 		} else {
 			/*
 			 * Sample found inconsistent by debouncing or pressure is
@@ -217,7 +233,6 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *=
handle)
 	input_report_key(input, BTN_TOUCH, 0);
 	input_report_abs(input, ABS_PRESSURE, 0);
 	input_sync(input);
-
 	if (ts->clear_penirq)
 		ts->clear_penirq();
=20
@@ -228,11 +243,17 @@ static irqreturn_t tsc2007_hard_irq(int irq, void=
 *handle)
 {
 	struct tsc2007 *ts =3D handle;
=20
-	if (!ts->get_pendown_state || likely(ts->get_pendown_state()))
-		return IRQ_WAKE_THREAD;
+	if (!ts->of) {
+		if (!ts->get_pendown_state || likely(ts->get_pendown_state()))
+			return IRQ_WAKE_THREAD;
=20
-	if (ts->clear_penirq)
-		ts->clear_penirq();
+		if (ts->clear_penirq)
+			ts->clear_penirq();
+	} else {
+		if ((!gpio_is_valid(ts->gpio)) ||
+		    likely(tsc2007_get_pendown_state_dt(ts)))
+			return IRQ_WAKE_THREAD;
+	}
=20
 	return IRQ_HANDLED;
 }
@@ -273,34 +294,65 @@ static void tsc2007_close(struct input_dev *input=
_dev)
 	tsc2007_stop(ts);
 }
=20
-static int tsc2007_probe(struct i2c_client *client,
-				   const struct i2c_device_id *id)
+#ifdef CONFIG_OF
+static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 =
*ts,
+			    struct device_node *np)
 {
-	struct tsc2007 *ts;
-	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;
-	struct input_dev *input_dev;
-	int err;
-
-	if (!pdata) {
-		dev_err(&client->dev, "platform data is required!\n");
+	int err =3D 0;
+	u32 val32;
+	u64 val64;
+
+	if (!of_property_read_u32(np, "max-rt", &val32))
+		ts->max_rt =3D val32;
+	else
+		ts->max_rt =3D MAX_12BIT;
+
+	if (!of_property_read_u32(np, "fuzzy", &val32))
+		ts->fuzzy =3D val32;
+
+	if (!of_property_read_u64(np, "poll-period", &val64))
+		ts->poll_period =3D val64;
+	else
+		ts->poll_period =3D 1;
+
+	if (!of_property_read_u32(np, "ti,x-plate-ohms", &val32)) {
+		ts->x_plate_ohms =3D val32;
+	} else {
+		dev_err(&client->dev,
+			"Error: lacking ti,x-plate-ohms devicetree property. (err %d).",
+			err);
 		return -EINVAL;
 	}
=20
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_READ_WORD_DATA))
-		return -EIO;
+	ts->gpio =3D of_get_gpio(np, 0);
+	if (!gpio_is_valid(ts->gpio))
+		dev_err(&client->dev,
+			"GPIO not found (of_get_gpio returned %d)\n",
+			ts->gpio);
=20
-	ts =3D kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
-	input_dev =3D input_allocate_device();
-	if (!ts || !input_dev) {
-		err =3D -ENOMEM;
-		goto err_free_mem;
-	}
+	/* Used to detect if it is probed trough the device tree,
+	 * in order to be able to use that information in the IRQ handler.
+	 */
+	ts->of =3D 1;
=20
-	ts->client =3D client;
-	ts->irq =3D client->irq;
-	ts->input =3D input_dev;
-	init_waitqueue_head(&ts->wait);
+	return 0;
+}
+#else
+static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 =
*ts,
+			    struct device_node *np)
+{
+	return -ENODEV;
+}
+#endif
+
+static int tsc2007_probe_pdev(struct i2c_client *client, struct tsc200=
7 *ts,
+			      struct tsc2007_platform_data *pdata,
+			      const struct i2c_device_id *id)
+{
+	if (!pdata) {
+		dev_err(&client->dev, "platform data is required!\n");
+		return -EINVAL;
+	}
=20
 	ts->model             =3D pdata->model;
 	ts->x_plate_ohms      =3D pdata->x_plate_ohms;
@@ -309,13 +361,57 @@ static int tsc2007_probe(struct i2c_client *clien=
t,
 	ts->poll_period       =3D pdata->poll_period ? : 1;
 	ts->get_pendown_state =3D pdata->get_pendown_state;
 	ts->clear_penirq      =3D pdata->clear_penirq;
+	ts->fuzzy             =3D pdata->fuzzy;
=20
 	if (pdata->x_plate_ohms =3D=3D 0) {
 		dev_err(&client->dev, "x_plate_ohms is not set up in platform data")=
;
-		err =3D -EINVAL;
-		goto err_free_mem;
+		return -EINVAL;
 	}
=20
+	/* Used to detect if it is probed trough the device tree,
+	 * in order to be able to use that information in the IRQ handler.
+	 */
+	ts->of =3D 0;
+
+	return 0;
+}
+
+static int tsc2007_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device_node *np =3D client->dev.of_node;
+	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;
+	struct tsc2007 *ts;
+	struct input_dev *input_dev;
+	int err =3D 0;
+
+	ts =3D devm_kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	if (np)
+		err =3D tsc2007_probe_dt(client, ts, np);
+	else
+		err =3D tsc2007_probe_pdev(client, ts, pdata, id);
+
+	if (err)
+		return err;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -EIO;
+
+	input_dev =3D input_allocate_device();
+	if (!input_dev) {
+		err =3D -ENOMEM;
+		goto err_free_input;
+	};
+
+	ts->client =3D client;
+	ts->irq =3D client->irq;
+	ts->input =3D input_dev;
+	init_waitqueue_head(&ts->wait);
+
 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input0", dev_name(&client->dev));
=20
@@ -331,19 +427,21 @@ static int tsc2007_probe(struct i2c_client *clien=
t,
 	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TOUCH);
=20
-	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, pdata->fuzzx, 0)=
;
-	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, pdata->fuzzy, 0)=
;
+	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, ts->fuzzy, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, ts->fuzzy, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT,
-			pdata->fuzzz, 0);
+			     ts->fuzzy, 0);
=20
-	if (pdata->init_platform_hw)
-		pdata->init_platform_hw();
+	if (!np) {
+		if (pdata->init_platform_hw)
+			pdata->init_platform_hw();
+	}
=20
 	err =3D request_threaded_irq(ts->irq, tsc2007_hard_irq, tsc2007_soft_=
irq,
 				   IRQF_ONESHOT, client->dev.driver->name, ts);
 	if (err < 0) {
 		dev_err(&client->dev, "irq %d busy?\n", ts->irq);
-		goto err_free_mem;
+		goto err_free_input;
 	}
=20
 	tsc2007_stop(ts);
@@ -358,23 +456,27 @@ static int tsc2007_probe(struct i2c_client *clien=
t,
=20
  err_free_irq:
 	free_irq(ts->irq, ts);
-	if (pdata->exit_platform_hw)
-		pdata->exit_platform_hw();
- err_free_mem:
+	if (!np) {
+		if (pdata->exit_platform_hw)
+			pdata->exit_platform_hw();
+	}
+ err_free_input:
 	input_free_device(input_dev);
-	kfree(ts);
 	return err;
 }
=20
 static int tsc2007_remove(struct i2c_client *client)
 {
+	struct device_node *np =3D client->dev.of_node;
 	struct tsc2007	*ts =3D i2c_get_clientdata(client);
 	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;
=20
 	free_irq(ts->irq, ts);
=20
-	if (pdata->exit_platform_hw)
-		pdata->exit_platform_hw();
+	if (!np) {
+		if (pdata->exit_platform_hw)
+			pdata->exit_platform_hw();
+	}
=20
 	input_unregister_device(ts->input);
 	kfree(ts);
@@ -389,10 +491,19 @@ static const struct i2c_device_id tsc2007_idtable=
[] =3D {
=20
 MODULE_DEVICE_TABLE(i2c, tsc2007_idtable);
=20
+#ifdef CONFIG_OF
+static const struct of_device_id tsc2007_of_match[] =3D {
+	{ .compatible =3D "ti,tsc2007" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tsc2007_of_match);
+#endif
+
 static struct i2c_driver tsc2007_driver =3D {
 	.driver =3D {
 		.owner	=3D THIS_MODULE,
-		.name	=3D "tsc2007"
+		.name	=3D "tsc2007",
+		.of_match_table =3D of_match_ptr(tsc2007_of_match),
 	},
 	.id_table	=3D tsc2007_idtable,
 	.probe		=3D tsc2007_probe,
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
