From: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv5][ 1/4] Input: tsc2007: Add device tree support.
Date: Wed, 23 Oct 2013 14:10:17 +0200
Message-ID: <1382530220-27881-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Lothar Wa=C3=9Fmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Eric B=C3=A9nard <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
---
ChangeLog v4->v5:
- Most of the "if (ts->of)" were replaced by wrapping them in the
  tsc2007_is_pen_down_valid and tsc2007_is_pen_down functions.
- Some whitespace cleanups.
- The devm_kzalloc call was fixed to make it compile.
---
 .../bindings/input/touchscreen/tsc2007.txt         |   44 +++++
 drivers/input/touchscreen/tsc2007.c                |  194 ++++++++++++=
+++-----
 2 files changed, 197 insertions(+), 41 deletions(-)
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
index 0b67ba4..0625fe1 100644
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
@@ -84,6 +90,11 @@ struct tsc2007 {
 	void			(*clear_penirq)(void);
 };
=20
+static int tsc2007_get_pendown_state_dt(struct tsc2007 *ts)
+{
+	return !gpio_get_value(ts->gpio);
+}
+
 static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
 {
 	s32 data;
@@ -142,6 +153,14 @@ static u32 tsc2007_calculate_pressure(struct tsc20=
07 *tsc, struct ts_event *tc)
 	return rt;
 }
=20
+static bool tsc2007_is_pen_down_valid(struct tsc2007 *ts)
+{
+	if (ts->of)
+		return gpio_is_valid(ts->gpio);
+	else
+		return ts->get_pendown_state ? true : false;
+}
+
 static bool tsc2007_is_pen_down(struct tsc2007 *ts)
 {
 	/*
@@ -158,10 +177,13 @@ static bool tsc2007_is_pen_down(struct tsc2007 *t=
s)
 	 * to fall back on the pressure reading.
 	 */
=20
-	if (!ts->get_pendown_state)
+	if (!tsc2007_is_pen_down_valid(ts))
 		return true;
=20
-	return ts->get_pendown_state();
+	if (ts->of)
+		return tsc2007_get_pendown_state_dt(ts);
+	else
+		return ts->get_pendown_state();
 }
=20
 static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
@@ -178,7 +200,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *=
handle)
=20
 		rt =3D tsc2007_calculate_pressure(ts, &tc);
=20
-		if (rt =3D=3D 0 && !ts->get_pendown_state) {
+		if(!rt && !tsc2007_is_pen_down_valid(ts)) {
 			/*
 			 * If pressure reported is 0 and we don't have
 			 * callback to check pendown state, we have to
@@ -228,7 +250,7 @@ static irqreturn_t tsc2007_hard_irq(int irq, void *=
handle)
 {
 	struct tsc2007 *ts =3D handle;
=20
-	if (!ts->get_pendown_state || likely(ts->get_pendown_state()))
+	if (tsc2007_is_pen_down(ts))
 		return IRQ_WAKE_THREAD;
=20
 	if (ts->clear_penirq)
@@ -273,34 +295,65 @@ static void tsc2007_close(struct input_dev *input=
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
@@ -309,13 +362,57 @@ static int tsc2007_probe(struct i2c_client *clien=
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
+	ts =3D devm_kzalloc(&client->dev, sizeof(struct tsc2007), GFP_KERNEL)=
;
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
@@ -331,19 +428,21 @@ static int tsc2007_probe(struct i2c_client *clien=
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
@@ -358,23 +457,27 @@ static int tsc2007_probe(struct i2c_client *clien=
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
@@ -389,10 +492,19 @@ static const struct i2c_device_id tsc2007_idtable=
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
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
