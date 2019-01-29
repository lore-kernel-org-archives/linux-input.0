From: Matthias Fend <Matthias.Fend@wolfvision.net>
Subject: AW: [PATCH 2/3] Input: st1232 - add support for st1633
Date: Tue, 29 Jan 2019 07:07:41 +0000
Message-ID: <VI1PR08MB37588C9F91E99390591E5DCB85970@VI1PR08MB3758.eurprd08.prod.outlook.com>
References: <20190128084449.16070-1-martink@posteo.de>
 <20190128084449.16070-2-martink@posteo.de> <20190128190334.GA34692@dtor-ws>
 <894cb7d4749835325c4e0f9c65d31a63@posteo.de>
 <419160a7-edf5-48cf-85ea-d6d5e9cd6e59.95bf7d06-047e-438c-8c7b-895af195351a.4c28554a-ad2d-4f90-8e2b-982cefd223a5@emailsignatures365.codetwo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <894cb7d4749835325c4e0f9c65d31a63@posteo.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

Hi Martin,


Matthias Fend=0A=
R&D Electronics =0A=
=0A=
Wolfvision GmbH=0A=
Oberes Ried 14 | 6833 Klaus | Austria =0A=
Tel: +43 5523 52250 | Mail: Matthias.Fend@wolfvision.net =0A=
=0A=
Webpage: www.wolfvision.com | www.wolfvision.com/green=0A=
Firmenbuch / Commercial Register: FN283521v Feldkirch/Austria=0A=
=0A=
> -----Urspr=FCngliche Nachricht-----
> Von: linux-input-owner@vger.kernel.org <linux-input-
> owner@vger.kernel.org> Im Auftrag von Martin Kepplinger
> Gesendet: Montag, 28. J=E4nner 2019 20:10
> An: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: devicetree@vger.kernel.org; linux-input@vger.kernel.org;
> robh+dt@kernel.org; mark.rutland@arm.com; linux-kernel@vger.kernel.org;
> Martin Kepplinger <martin.kepplinger@ginzinger.com>
> Betreff: Re: [PATCH 2/3] Input: st1232 - add support for st1633
>=20
> Am 28.01.2019 20:03 schrieb Dmitry Torokhov:
> > Hi Martin,
> >
> > On Mon, Jan 28, 2019 at 09:44:48AM +0100, Martin Kepplinger wrote:
> >> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> >>
> >> Add support for the Sitronix ST1633 touchscreen controller to the
> >> st1232
> >> driver. A protocol spec can be found here:
> >>
> https://emea01.safelinks.protection.outlook.com/?url=3Dwww.ampdisplay.co
> m%2Fdocuments%2Fpdf%2FAM-320480B6TZQW-
> TC0H.pdf&amp;data=3D01%7C01%7CMatthias.Fend%40wolfvision.net%7C4f9d
> 56475f674b1e3b4008d685543b35%7Ce94ec9da9183471e83b351baa8eb804f%
> 7C0&amp;sdata=3DYTw33BPKKpdN%2BBFrufVk8e4YqXOzR6VQKuzRMOjcwWk
> %3D&amp;reserved=3D0
> >>
> >> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> >> ---
> >>  drivers/input/touchscreen/Kconfig  |   6 +-
> >>  drivers/input/touchscreen/st1232.c | 122
> >> +++++++++++++++++++++--------
> >>  2 files changed, 94 insertions(+), 34 deletions(-)
> >>
> >> diff --git a/drivers/input/touchscreen/Kconfig
> >> b/drivers/input/touchscreen/Kconfig
> >> index 068dbbc610fc..7c597a49c265 100644
> >> --- a/drivers/input/touchscreen/Kconfig
> >> +++ b/drivers/input/touchscreen/Kconfig
> >> @@ -1168,11 +1168,11 @@ config TOUCHSCREEN_SIS_I2C
> >>  	  module will be called sis_i2c.
> >>
> >>  config TOUCHSCREEN_ST1232
> >> -	tristate "Sitronix ST1232 touchscreen controllers"
> >> +	tristate "Sitronix ST1232 or ST1633 touchscreen controllers"
> >>  	depends on I2C
> >>  	help
> >> -	  Say Y here if you want to support Sitronix ST1232
> >> -	  touchscreen controller.
> >> +	  Say Y here if you want to support the Sitronix ST1232
> >> +	  or ST1633 touchscreen controller.
> >>
> >>  	  If unsure, say N.
> >>
> >> diff --git a/drivers/input/touchscreen/st1232.c
> >> b/drivers/input/touchscreen/st1232.c
> >> index 11ff32c68025..19a665d48dad 100644
> >> --- a/drivers/input/touchscreen/st1232.c
> >> +++ b/drivers/input/touchscreen/st1232.c
> >> @@ -23,13 +23,15 @@
> >>  #include <linux/types.h>
> >>
> >>  #define ST1232_TS_NAME	"st1232-ts"
> >> +#define ST1633_TS_NAME	"st1633-ts"
> >> +
> >> +enum {
> >> +	st1232,
> >> +	st1633,
> >> +};
> >
> > This enum seems no longer needed, I dropped it.
> >
> >>
> >>  #define MIN_X		0x00
> >>  #define MIN_Y		0x00
> >
> > Given we no longer have constant MAX_X/Y I simply used 0 in
> > input_set_abs_params() and dropped MIN-X/Y.
> >
> >> -#define MAX_X		0x31f	/* (800 - 1) */
> >> -#define MAX_Y		0x1df	/* (480 - 1) */
> >> -#define MAX_AREA	0xff
> >> -#define MAX_FINGERS	2
> >>
> >>  struct st1232_ts_finger {
> >>  	u16 x;
> >> @@ -38,12 +40,24 @@ struct st1232_ts_finger {
> >>  	bool is_valid;
> >>  };
> >>
> >> +struct st_chip_info {
> >> +	bool	have_z;
> >> +	u16	max_x;
> >> +	u16	max_y;
> >> +	u16	max_area;
> >> +	u16	max_fingers;
> >> +	u8	start_reg;
> >> +};
> >> +
> >>  struct st1232_ts_data {
> >>  	struct i2c_client *client;
> >>  	struct input_dev *input_dev;
> >> -	struct st1232_ts_finger finger[MAX_FINGERS];
> >>  	struct dev_pm_qos_request low_latency_req;
> >>  	int reset_gpio;
> >
> > Could you please create an additional patch converting this to gpiod?
> > Instead of doing of_get_gpio()/gpio_is_valid()/devm_gpio_request()
> > smply
> > do
> >
> > 	ts->reset_gpio =3D devm_gpiod_get_optional();
> > 	if (IS_ERR(ts->reset_gpio)) {
> > 		...
> > 	}
> >
> > and later
> >
> > 	if (ts->reset_gpio)
> > 		...
> >
> > Looking at the code it looks like reset is as usual active low, so you
> > will need to invert the logic as gpiod takes care of convertion logical
> > value to proper level (active low or high).
>=20
> I'll test your applied changes and get back to this tomorrow.
>=20
> thanks.
>=20
> >
> >> +	const struct st_chip_info *chip_info;
> >> +	int read_buf_len;
> >> +	u8 *read_buf;
> >> +	struct st1232_ts_finger *finger;
> >>  };
> >>
> >>  static int st1232_ts_read_data(struct st1232_ts_data *ts)
> >> @@ -52,40 +66,35 @@ static int st1232_ts_read_data(struct
> >> st1232_ts_data *ts)
> >>  	struct i2c_client *client =3D ts->client;
> >>  	struct i2c_msg msg[2];
> >>  	int error;
> >> -	u8 start_reg;
> >> -	u8 buf[10];
> >> +	int i, y;
> >> +	u8 start_reg =3D ts->chip_info->start_reg;
> >> +	u8 *buf =3D ts->read_buf;
> >>
> >> -	/* read touchscreen data from ST1232 */
> >> +	/* read touchscreen data */
> >>  	msg[0].addr =3D client->addr;
> >>  	msg[0].flags =3D 0;
> >>  	msg[0].len =3D 1;
> >>  	msg[0].buf =3D &start_reg;
> >> -	start_reg =3D 0x10;
> >>
> >>  	msg[1].addr =3D ts->client->addr;
> >>  	msg[1].flags =3D I2C_M_RD;
> >> -	msg[1].len =3D sizeof(buf);
> >> +	msg[1].len =3D ts->read_buf_len;
> >>  	msg[1].buf =3D buf;
> >>
> >>  	error =3D i2c_transfer(client->adapter, msg, 2);
> >>  	if (error < 0)
> >>  		return error;
> >>
> >> -	/* get "valid" bits */
> >> -	finger[0].is_valid =3D buf[2] >> 7;
> >> -	finger[1].is_valid =3D buf[5] >> 7;
> >> +	for (i =3D 0, y =3D 0; i < ts->chip_info->max_fingers; i++, y +=3D 3=
) {
> >> +		finger[i].is_valid =3D buf[i + y] >> 7;
> >> +		if (finger[i].is_valid) {
> >> +			finger[i].x =3D ((buf[i + y] & 0x0070) << 4) | buf[i + 1];
> >> +			finger[i].y =3D ((buf[i + y] & 0x0007) << 8) | buf[i + 2];
> >>
> >> -	/* get xy coordinate */
> >> -	if (finger[0].is_valid) {
> >> -		finger[0].x =3D ((buf[2] & 0x0070) << 4) | buf[3];
> >> -		finger[0].y =3D ((buf[2] & 0x0007) << 8) | buf[4];
> >> -		finger[0].t =3D buf[8];
> >> -	}
> >> -
> >> -	if (finger[1].is_valid) {
> >> -		finger[1].x =3D ((buf[5] & 0x0070) << 4) | buf[6];
> >> -		finger[1].y =3D ((buf[5] & 0x0007) << 8) | buf[7];
> >> -		finger[1].t =3D buf[9];
> >> +			/* st1232 includes a z-axis / touch strength */
> >> +			if (ts->chip_info->have_z)
> >> +				finger[i].t =3D buf[i + 6];
> >> +		}
> >>  	}
> >>
> >>  	return 0;
> >> @@ -104,11 +113,14 @@ static irqreturn_t st1232_ts_irq_handler(int
> >> irq, void *dev_id)
> >>  		goto end;
> >>
> >>  	/* multi touch protocol */
> >> -	for (i =3D 0; i < MAX_FINGERS; i++) {
> >> +	for (i =3D 0; i < ts->chip_info->max_fingers; i++) {
> >>  		if (!finger[i].is_valid)
> >>  			continue;
> >>
> >> -		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
> finger[i].t);
> >> +		if (ts->chip_info->have_z)
> >> +			input_report_abs(input_dev,
> ABS_MT_TOUCH_MAJOR,
> >> +					 finger[i].t);
> >> +
> >>  		input_report_abs(input_dev, ABS_MT_POSITION_X,
> finger[i].x);
> >>  		input_report_abs(input_dev, ABS_MT_POSITION_Y,
> finger[i].y);
> >>  		input_mt_sync(input_dev);
> >> @@ -142,12 +154,40 @@ static void st1232_ts_power(struct
> >> st1232_ts_data *ts, bool poweron)
> >>  		gpio_direction_output(ts->reset_gpio, poweron);
> >>  }
> >>
> >> +static const struct st_chip_info st1232_chip_info =3D {
> >> +		.have_z =3D true,
> >> +		.max_x =3D 0x31f, /* 800 - 1 */
> >> +		.max_y =3D 0x1df, /* 480 -1 */
> >> +		.max_area =3D 0xff,
> >> +		.max_fingers =3D 2,
> >> +		.start_reg =3D 0x12,
> >> +};
> >> +
> >> +static const struct st_chip_info st1633_chip_info =3D {
> >> +		.have_z =3D false,
> >> +		.max_x =3D 0x13f, /* 320 - 1 */
> >> +		.max_y =3D 0x1df, /* 480 -1 */

I guess these values are the dimensions of the referenced TFT display and n=
ot any limits of the touch controller. I wonder which values are correct he=
re?
Maybe it would also be easier to just use the decimal representation and dr=
op the comment, what do you think?

Thanks,
 ~Matthias

> >> +		.max_area =3D 0x00,
> >> +		.max_fingers =3D 5,
> >> +		.start_reg =3D 0x12,
> >> +};
> >> +
> >>  static int st1232_ts_probe(struct i2c_client *client,
> >>  			   const struct i2c_device_id *id)
> >>  {
> >>  	struct st1232_ts_data *ts;
> >> +	struct st1232_ts_finger *finger;
> >>  	struct input_dev *input_dev;
> >>  	int error;
> >> +	const struct st_chip_info *match =3D NULL;
> >
> > There is no need to initialize with NULL given that we do unconditional
> > assignment below. I removed initialization.
> >
> >> +
> >> +	match =3D device_get_match_data(&client->dev);
> >> +	if (!match && id)
> >> +		match =3D (const void *)id->driver_data;
> >> +	if (!match) {
> >> +		dev_err(&client->dev, "unknown device model\n");
> >> +		return -ENODEV;
> >> +	}
> >>
> >>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> >>  		dev_err(&client->dev, "need I2C_FUNC_I2C\n");
> >> @@ -163,6 +203,19 @@ static int st1232_ts_probe(struct i2c_client
> >> *client,
> >>  	if (!ts)
> >>  		return -ENOMEM;
> >>
> >> +	ts->chip_info =3D match;
> >> +	ts->finger =3D devm_kzalloc(&client->dev,
> >> +				  sizeof(*finger) * ts->chip_info-
> >max_fingers,
> >> +				  GFP_KERNEL);
> >
> > I replaced it with devm_kcalloc(&client->dev,
> > 				ts->chip_info->max_fingers, sizeof(*finger),
> > 				GFP_KERNEL);
> >
> > and applied.
> >
> >> +	if (!ts->finger)
> >> +		return -ENOMEM;
> >> +
> >> +	/* allocate a buffer according to the number of registers to read */
> >> +	ts->read_buf_len =3D ts->chip_info->max_fingers * 4;
> >> +	ts->read_buf =3D devm_kzalloc(&client->dev, ts->read_buf_len,
> >> GFP_KERNEL);
> >> +	if (!ts->read_buf)
> >> +		return -ENOMEM;
> >> +
> >>  	input_dev =3D devm_input_allocate_device(&client->dev);
> >>  	if (!input_dev)
> >>  		return -ENOMEM;
> >> @@ -192,9 +245,14 @@ static int st1232_ts_probe(struct i2c_client
> >> *client,
> >>  	__set_bit(EV_KEY, input_dev->evbit);
> >>  	__set_bit(EV_ABS, input_dev->evbit);
> >>
> >> -	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
> MAX_AREA, 0,
> >> 0);
> >> -	input_set_abs_params(input_dev, ABS_MT_POSITION_X, MIN_X,
> MAX_X, 0,
> >> 0);
> >> -	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, MIN_Y,
> MAX_Y, 0,
> >> 0);
> >> +	if (ts->chip_info->have_z)
> >> +		input_set_abs_params(input_dev,
> ABS_MT_TOUCH_MAJOR, 0,
> >> +				     ts->chip_info->max_area, 0, 0);
> >> +
> >> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> >> +			     MIN_X, ts->chip_info->max_x, 0, 0);
> >> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> >> +			     MIN_Y, ts->chip_info->max_y, 0, 0);
> >>
> >>  	error =3D devm_request_threaded_irq(&client->dev, client->irq,
> >>  					  NULL, st1232_ts_irq_handler,
> >> @@ -261,13 +319,15 @@ static
> SIMPLE_DEV_PM_OPS(st1232_ts_pm_ops,
> >>  			 st1232_ts_suspend, st1232_ts_resume);
> >>
> >>  static const struct i2c_device_id st1232_ts_id[] =3D {
> >> -	{ ST1232_TS_NAME, 0 },
> >> +	{ ST1232_TS_NAME, (unsigned long)&st1232_chip_info },
> >> +	{ ST1633_TS_NAME, (unsigned long)&st1633_chip_info },
> >>  	{ }
> >>  };
> >>  MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
> >>
> >>  static const struct of_device_id st1232_ts_dt_ids[] =3D {
> >> -	{ .compatible =3D "sitronix,st1232", },
> >> +	{ .compatible =3D "sitronix,st1232", .data =3D &st1232_chip_info },
> >> +	{ .compatible =3D "sitronix,st1633", .data =3D &st1633_chip_info },
> >>  	{ }
> >>  };
> >>  MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
> >> --
> >> 2.20.1
> >>
> >
> > Thanks.
