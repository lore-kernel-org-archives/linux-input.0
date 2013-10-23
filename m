From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv4][ 1/4] Input: tsc2007: Add device tree support.
Date: Wed, 23 Oct 2013 10:21:23 +0200
Message-ID: <20131023082123.GC7404@ulmo.nvidia.com>
References: <1382363667-10341-1-git-send-email-denis@eukrea.com>
 <20131021155927.GB4255@core.coreip.homeip.net>
 <20131022114947.30dc9c07@ipc1.ka-ro>
 <20131022223504.GA19819@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:56830 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab3JWIX6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Oct 2013 04:23:58 -0400
Content-Disposition: inline
In-Reply-To: <20131022223504.GA19819@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <rob.herring@calxeda.com>, Denis Carikli <denis@eukrea.com>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--rz+pwK2yUstbofK6
Content-Type: multipart/mixed; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2013 at 03:35:05PM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 22, 2013 at 11:49:47AM +0200, Lothar Wa=C3=9Fmann wrote:
> > Hi,
> >=20
> > > On Mon, Oct 21, 2013 at 03:54:24PM +0200, Denis Carikli wrote:
> > > > =20
> > > > +	if (ts->of)
> > > > +		return tsc2007_get_pendown_state_dt(ts);
> > > > +
> > > >  	if (!ts->get_pendown_state)
> > > >  		return true;
> > >=20
> > > Instead of special casing "if (ts->of)" all over the place why don't =
you
> > > set up the device structure as:
> > >=20
> > > 	if (<configuring_tsc2007_form_dt>)
> > > 		ts->get_pendown_state =3D tsc2007_get_pendown_state_dt;
> > >=20
> > > and be done with it?
> > >
> > I also thought about that, but the existing function does not have any
> > parameters, while the DT version of get_pendown_state() requires to get
> > the GPIO passed to it somehow.
>=20
> You can always have tsc2007_get_pendown_state_platform() wrapping the
> call. Or we just go and fix board code.

I used to have a patch which did exactly that but never got around to
submitting it. Essentially what it did was add a void * parameter to the
=2Eget_pendown_state() and .clear_penirq() callbacks, along with a new
=2Ecallback_data field that the driver could set. At the same time there
was some code to unify code for boards that merely use a simple GPIO as
pendown.

I'm attaching what I think is the latest version. I no longer have
access to the hardware so I can't test this, but perhaps it can serve as
an example of how this could work. Sorry this isn't in the form of a
proper patch.

Thierry

--LwW0XdcUbUexiWVK
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="tsc2007.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpu=
imx35.c
index d49b0ec..0dd8381 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -62,6 +62,7 @@ static int tsc2007_get_pendown_state(void)
 static struct tsc2007_platform_data tsc2007_info =3D {
 	.model			=3D 2007,
 	.x_plate_ohms		=3D 180,
+	.pendown_gpio		=3D -1,
 	.get_pendown_state =3D tsc2007_get_pendown_state,
 };
=20
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-c=
puimx51sd.c
index b87cc49..ef2a7e6 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -134,6 +134,7 @@ static int tsc2007_get_pendown_state(void)
 static struct tsc2007_platform_data tsc2007_info =3D {
 	.model			=3D 2007,
 	.x_plate_ohms		=3D 180,
+	.pendown_gpio		=3D -1,
 	.get_pendown_state	=3D tsc2007_get_pendown_state,
 };
=20
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile=
/board-ap4evb.c
index b85957a..69abf30 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1199,6 +1199,7 @@ static int ts_init(void)
 static struct tsc2007_platform_data tsc2007_info =3D {
 	.model			=3D 2007,
 	.x_plate_ohms		=3D 180,
+	.pendown_gpio		=3D -1,
 	.get_pendown_state	=3D ts_get_pendown_state,
 	.init_platform_hw	=3D ts_init,
 };
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-eco=
vec24/setup.c
index 64559e8a..6cfd0ef 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -517,6 +517,7 @@ static int ts_init(void)
 static struct tsc2007_platform_data tsc2007_info =3D {
 	.model			=3D 2007,
 	.x_plate_ohms		=3D 180,
+	.pendown_gpio		=3D -1,
 	.get_pendown_state	=3D ts_get_pendown_state,
 	.init_platform_hw	=3D ts_init,
 };
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscree=
n/tsc2007.c
index 1473d23..c87fdac 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -20,10 +20,15 @@
  *  published by the Free Software Foundation.
  */
=20
+#define pr_fmt(fmt) "tsc2007: " fmt
+
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
=20
@@ -75,13 +80,16 @@ struct tsc2007 {
 	unsigned long		poll_delay;
 	unsigned long		poll_period;
=20
+	int			pendown_gpio;
+	int			active_low;
 	int			irq;
=20
 	wait_queue_head_t	wait;
 	bool			stopped;
=20
-	int			(*get_pendown_state)(void);
-	void			(*clear_penirq)(void);
+	void			*callback_data;
+	int			(*get_pendown_state)(void *data);
+	void			(*clear_penirq)(void *data);
 };
=20
 static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
@@ -161,7 +169,7 @@ static bool tsc2007_is_pen_down(struct tsc2007 *ts)
 	if (!ts->get_pendown_state)
 		return true;
=20
-	return ts->get_pendown_state();
+	return ts->get_pendown_state(ts->callback_data);
 }
=20
 static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
@@ -171,6 +179,13 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *han=
dle)
 	struct ts_event tc;
 	u32 rt;
=20
+	/*
+	 * With some panels we need to wait a bit otherwise the first value
+	 * is often wrong.
+	 */
+	if (ts->poll_delay > 0)
+		msleep(ts->poll_delay);
+
 	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
=20
 		/* pen is down, continue with the measurement */
@@ -219,7 +234,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *hand=
le)
 	input_sync(input);
=20
 	if (ts->clear_penirq)
-		ts->clear_penirq();
+		ts->clear_penirq(ts->callback_data);
=20
 	return IRQ_HANDLED;
 }
@@ -228,11 +243,11 @@ static irqreturn_t tsc2007_hard_irq(int irq, void *ha=
ndle)
 {
 	struct tsc2007 *ts =3D handle;
=20
-	if (!ts->get_pendown_state || likely(ts->get_pendown_state()))
+	if (!ts->get_pendown_state || likely(ts->get_pendown_state(ts->callback_d=
ata)))
 		return IRQ_WAKE_THREAD;
=20
 	if (ts->clear_penirq)
-		ts->clear_penirq();
+		ts->clear_penirq(ts->callback_data);
=20
 	return IRQ_HANDLED;
 }
@@ -273,6 +288,75 @@ static void tsc2007_close(struct input_dev *input_dev)
 	tsc2007_stop(ts);
 }
=20
+static int tsc2007_get_pendown_state(void *data)
+{
+	struct tsc2007 *ts =3D data;
+	int ret =3D 0;
+
+	ret =3D !!gpio_get_value(ts->pendown_gpio);
+	if (ts->active_low)
+		ret =3D !ret;
+
+	return ret;
+}
+
+static struct tsc2007_platform_data *tsc2007_parse_dt(struct device *dev)
+{
+	struct tsc2007_platform_data *pdata;
+	enum of_gpio_flags flags;
+	u32 value, values[3];
+	int err;
+
+	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	err =3D of_get_named_gpio_flags(dev->of_node, "pendown-gpios", 0,
+				      &flags);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	pdata->pendown_gpio =3D err;
+
+	if (flags & OF_GPIO_ACTIVE_LOW)
+		pdata->active_low =3D true;
+
+	err =3D of_property_read_u32(dev->of_node, "x-plate-ohms", &value);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	pdata->x_plate_ohms =3D value;
+
+	err =3D of_property_read_u32(dev->of_node, "max-rt", &value);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	pdata->max_rt =3D value;
+
+	err =3D of_property_read_u32(dev->of_node, "poll-delay", &value);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	pdata->poll_delay =3D value;
+
+	err =3D of_property_read_u32(dev->of_node, "poll-period", &value);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	pdata->poll_period =3D value;
+
+	err =3D of_property_read_u32_array(dev->of_node, "fuzz", values,
+					 ARRAY_SIZE(values));
+	if (err < 0)
+		return ERR_PTR(err);
+
+	pdata->fuzzx =3D values[0];
+	pdata->fuzzy =3D values[1];
+	pdata->fuzzz =3D values[2];
+
+	return pdata;
+}
+
 static int __devinit tsc2007_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
@@ -281,18 +365,42 @@ static int __devinit tsc2007_probe(struct i2c_client =
*client,
 	struct input_dev *input_dev;
 	int err;
=20
+	ts =3D kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	if (IS_ENABLED(CONFIG_OF) && client->dev.of_node) {
+		client->irq =3D irq_of_parse_and_map(client->dev.of_node, 0);
+		if (!client->irq) {
+			err =3D -EPROBE_DEFER;
+			goto err_free_mem;
+		}
+	}
+
 	if (!pdata) {
-		dev_err(&client->dev, "platform data is required!\n");
-		return -EINVAL;
+		if (IS_ENABLED(CONFIG_OF) && client->dev.of_node) {
+			pdata =3D tsc2007_parse_dt(&client->dev);
+			if (IS_ERR(pdata)) {
+				err =3D PTR_ERR(pdata);
+				goto err_free_mem;
+			}
+
+			pdata->callback_data =3D ts;
+		} else {
+			dev_err(&client->dev, "platform data is required!\n");
+			err =3D -EINVAL;
+			goto err_free_mem;
+		}
 	}
=20
 	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_READ_WORD_DATA))
-		return -EIO;
+				     I2C_FUNC_SMBUS_READ_WORD_DATA)) {
+		err =3D -EIO;
+		goto err_free_mem;
+	}
=20
-	ts =3D kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
 	input_dev =3D input_allocate_device();
-	if (!ts || !input_dev) {
+	if (!input_dev) {
 		err =3D -ENOMEM;
 		goto err_free_mem;
 	}
@@ -307,13 +415,27 @@ static int __devinit tsc2007_probe(struct i2c_client =
*client,
 	ts->max_rt            =3D pdata->max_rt ? : MAX_12BIT;
 	ts->poll_delay        =3D pdata->poll_delay ? : 1;
 	ts->poll_period       =3D pdata->poll_period ? : 1;
+	ts->callback_data     =3D pdata->callback_data;
 	ts->get_pendown_state =3D pdata->get_pendown_state;
 	ts->clear_penirq      =3D pdata->clear_penirq;
=20
 	if (pdata->x_plate_ohms =3D=3D 0) {
 		dev_err(&client->dev, "x_plate_ohms is not set up in platform data");
 		err =3D -EINVAL;
-		goto err_free_mem;
+		goto err_free_dev;
+	}
+
+	if (gpio_is_valid(pdata->pendown_gpio)) {
+		err =3D gpio_request_one(pdata->pendown_gpio, GPIOF_IN,
+				       "tsc2007");
+		if (err < 0)
+			goto err_free_dev;
+
+		ts->get_pendown_state =3D tsc2007_get_pendown_state;
+		ts->pendown_gpio =3D pdata->pendown_gpio;
+		ts->active_low =3D pdata->active_low;
+	} else {
+		ts->pendown_gpio =3D -EINVAL;
 	}
=20
 	snprintf(ts->phys, sizeof(ts->phys),
@@ -343,7 +465,7 @@ static int __devinit tsc2007_probe(struct i2c_client *c=
lient,
 				   IRQF_ONESHOT, client->dev.driver->name, ts);
 	if (err < 0) {
 		dev_err(&client->dev, "irq %d busy?\n", ts->irq);
-		goto err_free_mem;
+		goto err_free_gpio;
 	}
=20
 	tsc2007_stop(ts);
@@ -360,8 +482,12 @@ static int __devinit tsc2007_probe(struct i2c_client *=
client,
 	free_irq(ts->irq, ts);
 	if (pdata->exit_platform_hw)
 		pdata->exit_platform_hw();
- err_free_mem:
+ err_free_gpio:
+	if (gpio_is_valid(pdata->pendown_gpio))
+		gpio_free(pdata->pendown_gpio);
+ err_free_dev:
 	input_free_device(input_dev);
+ err_free_mem:
 	kfree(ts);
 	return err;
 }
@@ -373,6 +499,9 @@ static int __devexit tsc2007_remove(struct i2c_client *=
client)
=20
 	free_irq(ts->irq, ts);
=20
+	if (gpio_is_valid(ts->pendown_gpio))
+		gpio_free(ts->pendown_gpio);
+
 	if (pdata->exit_platform_hw)
 		pdata->exit_platform_hw();
=20
diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index a447f4e..249d307 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -64,7 +64,8 @@ struct timberdale_device {
=20
 static struct tsc2007_platform_data timberdale_tsc2007_platform_data =3D {
 	.model =3D 2003,
-	.x_plate_ohms =3D 100
+	.x_plate_ohms =3D 100,
+	.pendown_gpio =3D -1,
 };
=20
 static struct i2c_board_info timberdale_i2c_board_info[] =3D {
diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007.h
index 506a9f7..8d72771 100644
--- a/include/linux/i2c/tsc2007.h
+++ b/include/linux/i2c/tsc2007.h
@@ -14,8 +14,12 @@ struct tsc2007_platform_data {
 	int	fuzzy;
 	int	fuzzz;
=20
-	int	(*get_pendown_state)(void);
-	void	(*clear_penirq)(void);		/* If needed, clear 2nd level
+	int	pendown_gpio;
+	bool	active_low;
+
+	void	*callback_data;
+	int	(*get_pendown_state)(void *data);
+	void	(*clear_penirq)(void *data);	/* If needed, clear 2nd level
 						   interrupt source */
 	int	(*init_platform_hw)(void);
 	void	(*exit_platform_hw)(void);

--LwW0XdcUbUexiWVK--

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZ4cDAAoJEN0jrNd/PrOhkTsP/1oWovDOS6cgGeKdEPYc3byt
FD/V88qxw/6nnzjFdVGT0Qbcwa306HiYi96j7wD46apyLsIflU3K89TmkfRwWd5I
6/AqoiFtAKlEjZ9RTVHhrX0AhZldHqXeA2XaAttTGLlz2dQJayMagcc1+Xa1USfU
dhydtfnInq+YguYHa8eIAmoQKCr0iGwZwbL6k1r7P4WDb4SWpyVixu2f+CD+dBss
Pk22AHKqVt8BniU3XrdZIh5lEgoqilX5bizJA8B3EdsT1C6v+JL4gvbuYtipv9FP
fb0GkDu0AbsnC8nYWTl5IfqS+wCsWqQ3TK2Mrd0kTNdEd35oPiLp2mtmzC9um1LE
AH0Y/SHbWFe8gRed1PXrxmgHBf4fsxfE+QHfOU45KnJ+WZgLAjZhyfNqM08F02si
WxIk8T9CdVAHSSZ9G3ztkBU5YwLJTMn3ShXeGU7M+oxp1cVaExr9UnNdIYg/wWnV
O0c5xlUpc2/q8kHK837WPTHMHyq2audWdm6cYMYScLgTRzEVqYCfC9ewvJIvQnnV
j3hw13dKJCmhYpjn39Di01TwB4TyH6YCi5jI2dJEB8qZyRa/AnmT14coWnsmlc6d
0I2FF3crF1SlxoFCinudj4nu59lM50CT5n6AT7Oeah/qcHr1PRcLnGDEMbfHVXQY
ExlLrMhOfo3yA+wUe+xF
=n0pj
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
