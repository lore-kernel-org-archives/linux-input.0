From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH] Input: add bu21029 touch driver
Date: Tue, 27 Mar 2018 06:57:42 +0000
Message-ID: <7ab56efbafd34c11968d8cef2369c6a5@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hs@denx.de" <hs@denx.de>, "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

> > +++ b/drivers/input/touchscreen/bu21029_ts.c
> > @@ -0,0 +1,456 @@
>=20
> Please add SPDX tag for the driver.

We will do.

> Please use GPIOD API (and include linux/gpio/consumer.h instead of
> of_gpio.h).

We will do the change.

> > +/* HW_ID1 Register (PAGE=3D0, ADDR=3D0x0E, Reset value=3D0x02, Read on=
ly)
>=20
> Multi-line comments start with empty comment line:
>=20
> /*
>  * Multi
>  * line.
>  */

Will be fixed.

> > +	/* calculate Rz (pressure resistance value) by equation:
> > +	 * Rz =3D Rx * (x/Q) * ((z2/z1) - 1), where
> > +	 * Rx is x-plate resistance,
> > +	 * Q  is the touch screen resolution (8bit =3D 256, 12bit =3D 4096)
> > +	 * x, z1, z2 are the measured positions.
> > +	 */
> > +	rz  =3D z2 - z1;
> > +	rz *=3D x;
> > +	rz *=3D bu21029->x_plate_ohms;
> > +	rz /=3D z1;
> > +	rz  =3D DIV_ROUND_CLOSEST(rz, SCALE_12BIT);
> > +	if (rz <=3D bu21029->max_pressure) {
> > +		input_report_abs(bu21029->in_dev, ABS_X, x);
> > +		input_report_abs(bu21029->in_dev, ABS_Y, y);
> > +		input_report_abs(bu21029->in_dev, ABS_PRESSURE, rz);
>=20
> What is the values of pressure reported when finger is touching the
> surface? IOW is 'rz' pressure or resistance?

Rz is pressure measured in Ohms. That is, it is a resistance which
correlates with finger pressure.

I fear that I do not understand your question. Does ABS_PRESSURE have
to be reported in a specific unit, e.g. milli Newton? We thought that
it is a device specific scale and that it will be converted into a
calibrated value (just like the coordinates) in user space.

> > +	if (of_property_read_u32(np, "touchscreen-max-pressure", &val32))
> > +		bu21029->max_pressure =3D MAX_12BIT;
> > +	else
> > +		bu21029->max_pressure =3D val32;
>=20
> Please use infrastructure form include/linux/input/touchscreen.h
> so that you handle different sizes and orientations.

Thank you for this recommendation. We will check it out and send a new
proposal.

> > +	in_dev->name       =3D DRIVER_NAME;
> > +	in_dev->id.bustype =3D BUS_I2C;
> > +	in_dev->dev.parent =3D &client->dev;
>=20
> Not needed with devm_input_allocate_device().

We will have a look at the other drivers.

> > +static int bu21029_remove(struct i2c_client *client)
> > +{
> > +	struct bu21029_ts_data *bu21029 =3D i2c_get_clientdata(client);
> > +
> > +	del_timer_sync(&bu21029->timer);
>=20
> If interrupt comes here kernel will be unhappy. You need to either work
> canceling timer into devm unwid stream (devm_add_action_or_reset()) or
> somehow make sure that you shut off interrupts before canceling the
> timer.

We will work on a solution. Thank you for spotting this.

>=20
> > +
> > +	return 0;
> > +}

> > +static struct i2c_driver bu21029_driver =3D {
> > +	.driver =3D {
> > +		.name  =3D DRIVER_NAME,
> > +		.owner =3D THIS_MODULE,
>=20
> Not needed.

OK, we will remove the .owner assignment.

Greetings,
Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster
