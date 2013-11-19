From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv9][ 1/3] Input: tsc2007: Add device tree support.
Date: Tue, 19 Nov 2013 13:11:02 -0800
Message-ID: <20131119211102.GA14888@core.coreip.homeip.net>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:53202 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab3KTOhY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Nov 2013 09:37:24 -0500
Content-Disposition: inline
In-Reply-To: <1383916659-9988-1-git-send-email-denis@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Denis Carikli <denis@eukrea.com>
Cc: linux-input@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, linux-arm-kernel@lists.infradead.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>

Hi Denis,

On Fri, Nov 08, 2013 at 02:17:37PM +0100, Denis Carikli wrote:
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: devicetree@vger.kernel.org
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Lothar Wa=DFmann <LW@KARO-electronics.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric B=E9nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v8->v9:
> - Added Grant Likely in the Cc list.
> - Removed the mention of the pinctrl properties in the documentation.
>=20
> ChangeLog v7->v8:
> - Fixed the lack of x and z fuzz properties.
> - The pendown gpio is better documented.
> - Added Shawn Guo in the cc list.

Does the device still work if you drop the patch below on top of yours?

Thanks!

--=20
Dmitry

Input: tsc2007 misc fixes

=46rom: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-imx/mach-cpuimx35.c    |    2 -
 arch/arm/mach-imx/mach-cpuimx51sd.c  |    2 -
 arch/sh/boards/mach-ecovec24/setup.c |    2 -
 drivers/input/touchscreen/tsc2007.c  |  126 +++++++++++++-------------=
--------
 include/linux/i2c/tsc2007.h          |    6 +-
 5 files changed, 55 insertions(+), 83 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach=
-cpuimx35.c
index 771362d..65e4c53 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -53,7 +53,7 @@ static const struct imxi2c_platform_data
 };
=20
 #define TSC2007_IRQGPIO		IMX_GPIO_NR(3, 2)
-static int tsc2007_get_pendown_state(void)
+static int tsc2007_get_pendown_state(struct device *dev)
 {
 	return !gpio_get_value(TSC2007_IRQGPIO);
 }
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/ma=
ch-cpuimx51sd.c
index 9b5ddf5..1fba2b8 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -121,7 +121,7 @@ static const struct imxuart_platform_data uart_pdat=
a __initconst =3D {
 	.flags =3D IMXUART_HAVE_RTSCTS,
 };
=20
-static int tsc2007_get_pendown_state(void)
+static int tsc2007_get_pendown_state(struct device *dev)
 {
 	if (mx51_revision() < IMX_CHIP_REVISION_3_0)
 		return !gpio_get_value(TSC2007_IRQGPIO_REV2);
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach=
-ecovec24/setup.c
index 1fa8be4..23d7e45 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -501,7 +501,7 @@ static struct platform_device keysc_device =3D {
 /* TouchScreen */
 #define IRQ0 evt2irq(0x600)
=20
-static int ts_get_pendown_state(void)
+static int ts_get_pendown_state(struct device *dev)
 {
 	int val =3D 0;
 	gpio_free(GPIO_FN_INTC_IRQ0);
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchs=
creen/tsc2007.c
index 3168a99..390148c 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -88,15 +88,10 @@ struct tsc2007 {
 	wait_queue_head_t	wait;
 	bool			stopped;
=20
-	int			(*get_pendown_state)(void);
+	int			(*get_pendown_state)(struct device *);
 	void			(*clear_penirq)(void);
 };
=20
-static int tsc2007_get_pendown_state_dt(struct tsc2007 *ts)
-{
-	return !gpio_get_value(ts->gpio);
-}
-
 static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
 {
 	s32 data;
@@ -155,14 +150,6 @@ static u32 tsc2007_calculate_pressure(struct tsc20=
07 *tsc, struct ts_event *tc)
 	return rt;
 }
=20
-static bool tsc2007_is_pen_down_valid(struct tsc2007 *ts)
-{
-	if (ts->of)
-		return gpio_is_valid(ts->gpio);
-	else
-		return ts->get_pendown_state ? true : false;
-}
-
 static bool tsc2007_is_pen_down(struct tsc2007 *ts)
 {
 	/*
@@ -179,13 +166,10 @@ static bool tsc2007_is_pen_down(struct tsc2007 *t=
s)
 	 * to fall back on the pressure reading.
 	 */
=20
-	if (!tsc2007_is_pen_down_valid(ts))
+	if (!ts->get_pendown_state)
 		return true;
=20
-	if (ts->of)
-		return tsc2007_get_pendown_state_dt(ts);
-	else
-		return ts->get_pendown_state();
+	return ts->get_pendown_state(&ts->client->dev);
 }
=20
 static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
@@ -202,7 +186,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *=
handle)
=20
 		rt =3D tsc2007_calculate_pressure(ts, &tc);
=20
-		if (!rt && !tsc2007_is_pen_down_valid(ts)) {
+		if (!rt && !ts->get_pendown_state) {
 			/*
 			 * If pressure reported is 0 and we don't have
 			 * callback to check pendown state, we have to
@@ -298,13 +282,25 @@ static void tsc2007_close(struct input_dev *input=
_dev)
 }
=20
 #ifdef CONFIG_OF
-static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 =
*ts,
-			    struct device_node *np)
+static int tsc2007_get_pendown_state_gpio(struct device *dev)
+{
+	struct i2c_client *client =3D to_i2c_client(dev);
+	struct tsc2007 *ts =3D i2c_get_clientdata(client);
+
+	return !gpio_get_value(ts->gpio);
+}
+
+static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 =
*ts)
 {
-	int err =3D 0;
+	struct device_node *np =3D client->dev.of_node;
 	u32 val32;
 	u64 val64;
=20
+	if (!np) {
+		dev_err(&client->dev, "missing device tree data\n");
+		return -EINVAL;
+	}
+
 	if (!of_property_read_u32(np, "ti,max-rt", &val32))
 		ts->max_rt =3D val32;
 	else
@@ -327,42 +323,32 @@ static int tsc2007_probe_dt(struct i2c_client *cl=
ient, struct tsc2007 *ts,
 	if (!of_property_read_u32(np, "ti,x-plate-ohms", &val32)) {
 		ts->x_plate_ohms =3D val32;
 	} else {
-		dev_err(&client->dev,
-			"Error: lacking ti,x-plate-ohms devicetree property. (err %d).",
-			err);
+		dev_err(&client->dev, "missing ti,x-plate-ohms devicetree property."=
);
 		return -EINVAL;
 	}
=20
 	ts->gpio =3D of_get_gpio(np, 0);
-	if (!gpio_is_valid(ts->gpio))
-		dev_err(&client->dev,
-			"GPIO not found (of_get_gpio returned %d)\n",
-			ts->gpio);
-
-	/* Used to detect if it is probed trough the device tree,
-	 * in order to be able to use that information in the IRQ handler.
-	 */
-	ts->of =3D 1;
+	if (gpio_is_valid(ts->gpio))
+		ts->get_pendown_state =3D tsc2007_get_pendown_state_gpio;
+	else
+		dev_warn(&client->dev,
+			 "GPIO not specified in DT (of_get_gpio returned %d)\n",
+			 ts->gpio);
=20
 	return 0;
 }
 #else
-static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 =
*ts,
-			    struct device_node *np)
+static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 =
*ts)
 {
-	return -ENODEV;
+	dev_err(&client->dev, "platform data is required!\n");
+	return -EINVAL;
 }
 #endif
=20
 static int tsc2007_probe_pdev(struct i2c_client *client, struct tsc200=
7 *ts,
-			      struct tsc2007_platform_data *pdata,
+			      const struct tsc2007_platform_data *pdata,
 			      const struct i2c_device_id *id)
 {
-	if (!pdata) {
-		dev_err(&client->dev, "platform data is required!\n");
-		return -EINVAL;
-	}
-
 	ts->model             =3D pdata->model;
 	ts->x_plate_ohms      =3D pdata->x_plate_ohms;
 	ts->max_rt            =3D pdata->max_rt ? : MAX_12BIT;
@@ -379,45 +365,40 @@ static int tsc2007_probe_pdev(struct i2c_client *=
client, struct tsc2007 *ts,
 		return -EINVAL;
 	}
=20
-	/* Used to detect if it is probed trough the device tree,
-	 * in order to be able to use that information in the IRQ handler.
-	 */
-	ts->of =3D 0;
-
 	return 0;
 }
=20
 static int tsc2007_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-	struct device_node *np =3D client->dev.of_node;
-	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;
+	const struct tsc2007_platform_data *pdata =3D dev_get_platdata(&clien=
t->dev);
 	struct tsc2007 *ts;
 	struct input_dev *input_dev;
-	int err =3D 0;
+	int err;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -EIO;
=20
 	ts =3D devm_kzalloc(&client->dev, sizeof(struct tsc2007), GFP_KERNEL)=
;
 	if (!ts)
 		return -ENOMEM;
=20
-	if (np)
-		err =3D tsc2007_probe_dt(client, ts, np);
-	else
+	if (pdata)
 		err =3D tsc2007_probe_pdev(client, ts, pdata, id);
-
+	else
+		err =3D tsc2007_probe_dt(client, ts);
 	if (err)
 		return err;
=20
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_READ_WORD_DATA))
-		return -EIO;
-
 	input_dev =3D input_allocate_device();
 	if (!input_dev) {
 		err =3D -ENOMEM;
 		goto err_free_input;
 	};
=20
+	i2c_set_clientdata(client, ts);
+
 	ts->client =3D client;
 	ts->irq =3D client->irq;
 	ts->input =3D input_dev;
@@ -443,10 +424,8 @@ static int tsc2007_probe(struct i2c_client *client=
,
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT,
 			     ts->fuzzz, 0);
=20
-	if (!np) {
-		if (pdata->init_platform_hw)
-			pdata->init_platform_hw();
-	}
+	if (pdata && pdata->init_platform_hw)
+		pdata->init_platform_hw();
=20
 	err =3D request_threaded_irq(ts->irq, tsc2007_hard_irq, tsc2007_soft_=
irq,
 				   IRQF_ONESHOT, client->dev.driver->name, ts);
@@ -461,16 +440,12 @@ static int tsc2007_probe(struct i2c_client *clien=
t,
 	if (err)
 		goto err_free_irq;
=20
-	i2c_set_clientdata(client, ts);
-
 	return 0;
=20
  err_free_irq:
 	free_irq(ts->irq, ts);
-	if (!np) {
-		if (pdata->exit_platform_hw)
-			pdata->exit_platform_hw();
-	}
+	if (pdata && pdata->exit_platform_hw)
+		pdata->exit_platform_hw();
  err_free_input:
 	input_free_device(input_dev);
 	return err;
@@ -478,16 +453,13 @@ static int tsc2007_probe(struct i2c_client *clien=
t,
=20
 static int tsc2007_remove(struct i2c_client *client)
 {
-	struct device_node *np =3D client->dev.of_node;
-	struct tsc2007	*ts =3D i2c_get_clientdata(client);
-	struct tsc2007_platform_data *pdata =3D client->dev.platform_data;
+	const struct tsc2007_platform_data *pdata =3D dev_get_platdata(&clien=
t->dev);
+	struct tsc2007 *ts =3D i2c_get_clientdata(client);
=20
 	free_irq(ts->irq, ts);
=20
-	if (!np) {
-		if (pdata->exit_platform_hw)
-			pdata->exit_platform_hw();
-	}
+	if (pdata && pdata->exit_platform_hw)
+		pdata->exit_platform_hw();
=20
 	input_unregister_device(ts->input);
 	kfree(ts);
diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007.h
index 506a9f7..041c8e8 100644
--- a/include/linux/i2c/tsc2007.h
+++ b/include/linux/i2c/tsc2007.h
@@ -14,9 +14,9 @@ struct tsc2007_platform_data {
 	int	fuzzy;
 	int	fuzzz;
=20
-	int	(*get_pendown_state)(void);
-	void	(*clear_penirq)(void);		/* If needed, clear 2nd level
-						   interrupt source */
+	int	(*get_pendown_state)(struct device *);
+	/* If needed, clear 2nd level interrupt source */
+	void	(*clear_penirq)(void);
 	int	(*init_platform_hw)(void);
 	void	(*exit_platform_hw)(void);
 };
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
