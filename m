From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Driver for AUO In-Cell touchscreens using pixcir ICs
Date: Mon, 05 Dec 2011 11:13:14 +0100
Message-ID: <1323079994.2989.54.camel@mars>
References: <201112031509.12408.heiko@sntech.de>
	 <1323005501.3023.32.camel@mars>  <201112050920.44611.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62617 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430Ab1LEKNS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Dec 2011 05:13:18 -0500
Received: by bkbzv3 with SMTP id zv3so1619420bkb.19
        for <linux-input@vger.kernel.org>; Mon, 05 Dec 2011 02:13:17 -0800 (PST)
In-Reply-To: <201112050920.44611.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, 2011-12-05 at 09:20 +0100, Heiko St=FCbner wrote:
> Hi Christoph,
>=20
> thanks for taking the time to look it over.
>=20
> comments below
>=20
> Heiko
> Am Sonntag, 4. Dezember 2011, 14:31:41 schrieb Christoph Fritz:
> > Hi Heiko,
> >=20
> >  you can find some annotations below.
> >=20
> > Thanks,
> >  -- chf
> >=20
> > On Sat, 2011-12-03 at 15:09 +0100, Heiko St=FCbner wrote:
> > > Some displays from AUO have a so called in-cell touchscreen, mean=
ing it
> > > is built directly into the display unit.
> > >=20
> > > Touchdata is gathered through PIXCIR Tango-ICs and processed in a=
n
> > > Atmel ATmega168P with custom firmware. Communication between the =
host
> > > system and ATmega is done via I2C.
> > >=20
> > > Devices using this touch solution include the Dell Streak5 and th=
e family
> > > of Qisda ebook readers.
> > >=20
> > > The driver reports single- and multi-touch events including touch=
 area
> > > values.
> > >=20
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >=20
> > >  drivers/input/touchscreen/Kconfig         |   14 +
> > >  drivers/input/touchscreen/Makefile        |    1 +
> > >  drivers/input/touchscreen/auo-pixcir-ts.c |  657
> > >  +++++++++++++++++++++++++++++ include/linux/input/auo-pixcir-ts.=
h     =20
> > >  |   57 +++
> > >  4 files changed, 729 insertions(+), 0 deletions(-)
> > >  create mode 100644 drivers/input/touchscreen/auo-pixcir-ts.c
> > >  create mode 100644 include/linux/input/auo-pixcir-ts.h
>=20
> [...]
>=20
> > > +
> > > +static int auo_pixcir_int_config(struct auo_pixcir_ts *ts, int
> > > int_setting) +{
> > > +	struct i2c_client *client =3D ts->client;
> > > +	struct auo_pixcir_ts_platdata *pdata =3D client->dev.platform_d=
ata;
> > > +	uint8_t value;
> > > +
> > > +	value =3D i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_INT_S=
ETTING);
> > > +	if (value < 0) {
> >=20
> > value is an unsigned int and can't be less than zero. An int value =
would
> > be more appropriate.
> you're right of course and I will fix the type
>=20
> > > +		dev_err(&client->dev, "unable to read reg %Xh, %d\n",
> > > +			AUO_PIXCIR_REG_INT_SETTING, value);
> > > +		return value;
> > > +	}
> > > +
> > > +	value &=3D (~AUO_PIXCIR_INT_MODE_MASK);
> > > +	value |=3D int_setting;
> > > +	value |=3D AUO_PIXCIR_INT_POL_HIGH; /* always use high for inte=
rrupts=20
> */
> > > +
> > > +	value =3D i2c_smbus_write_byte_data(client, AUO_PIXCIR_REG_INT_=
SETTING,
> > > +					  value);
> > > +	if (value < 0) {
> >=20
> > the same here
> here too
>=20
> [...]
>=20
> > > +static int __devinit auo_pixcir_probe(struct i2c_client *client,
> > > +				      const struct i2c_device_id *id)
> > > +{
> > > +	struct auo_pixcir_ts *ts;
> > > +	struct auo_pixcir_ts_platdata *pdata =3D client->dev.platform_d=
ata;
> > > +	struct input_dev *input_dev;
> > > +	int ret;
> > > +
> > > +	if (!pdata)
> > > +		return -EINVAL;
> > > +
> > > +	ts =3D kzalloc(sizeof(struct auo_pixcir_ts), GFP_KERNEL);
> > > +	if (!ts)
> > > +		return -ENOMEM;
> > > +
> > > +	ret =3D gpio_request(pdata->gpio_int, "auo_pixcir_ts_int");
> > > +	if (ret) {
> > > +		dev_err(&client->dev, "request of gpio %d failed, %d\n",
> > > +			pdata->gpio_int, ret);
> > > +		goto err_gpio_int;
> > > +	}
> > > +
> > > +	ret =3D gpio_request(pdata->gpio_rst, "auo_pixcir_ts_rst");
> > > +	if (ret) {
> > > +		dev_err(&client->dev, "request of gpio %d failed, %d\n",
> > > +			pdata->gpio_int, ret);
> > > +		goto err_gpio_rst;
> > > +	}
> > > +
> > > +	if (pdata->init_hw)
> > > +		pdata->init_hw();
> > > +
> > > +	ts->client =3D client;
> > > +	ts->touch_ind_mode =3D 0;
> > > +	init_waitqueue_head(&ts->wait);
> > > +
> > > +	snprintf(ts->phys, sizeof(ts->phys),
> > > +		 "%s/input0", dev_name(&client->dev));
> > > +
> > > +	input_dev =3D input_allocate_device();
> > > +	if (!input_dev) {
> > > +		dev_err(&client->dev, "could not allocate input device\n");
> > > +		goto err_input_alloc;
> > > +	}
> > > +
> > > +	ts->input =3D input_dev;
> > > +
> > > +	input_dev->name =3D "auo_pixcir_ts";
> > > +	input_dev->phys =3D ts->phys;
> > > +	input_dev->id.bustype =3D BUS_I2C;
> > > +	input_dev->dev.parent =3D &client->dev;
> > > +
> > > +	input_dev->open =3D auo_pixcir_input_open;
> > > +	input_dev->close =3D auo_pixcir_input_close;
> > > +
> > > +	__set_bit(EV_ABS, input_dev->evbit);
> > > +	__set_bit(EV_KEY, input_dev->evbit);
> > > +
> > > +	__set_bit(BTN_TOUCH, input_dev->keybit);
> > > +
> > > +	/* For single touch */
> > > +	input_set_abs_params(input_dev, ABS_X, 0, pdata->x_max, 0, 0);
> > > +	input_set_abs_params(input_dev, ABS_Y, 0, pdata->y_max, 0, 0);
> > > +
> > > +	/* For multi touch */
> > > +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
> > > +			     pdata->x_max, 0, 0);
> > > +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
> > > +			     pdata->y_max, 0, 0);
> > > +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
> > > +			     AUO_PIXCIR_MAX_AREA, 0, 0);
> > > +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR, 0,
> > > +			     AUO_PIXCIR_MAX_AREA, 0, 0);
> > > +	input_set_abs_params(input_dev, ABS_MT_ORIENTATION, 0, 1, 0, 0)=
;
> > > +
> > > +	ret =3D i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_VERSION=
);
> > > +	if (ret < 0)
> > > +		goto err_fw_vers;
> > > +	dev_info(&client->dev, "firmware version 0x%X\n", ret);
> > > +
> > > +	ret =3D auo_pixcir_int_config(ts, pdata->int_setting);
> > > +	if (ret)
> > > +		goto err_fw_vers;
> > > +
> > > +	/* disable irqs on the device side before irq-request */
> > > +	auo_pixcir_int_enable(ts, 0);
> > > +	ts->stopped =3D true;
> > > +	ts->is_open =3D false;
> > > +
> > > +	ret =3D request_threaded_irq(client->irq, NULL, auo_pixcir_inte=
rrupt,
> > > +				   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > > +				   input_dev->name, ts);
> > > +	if (ret) {
> > > +		dev_err(&client->dev, "irq %d requested failed\n", client->irq=
);
> > > +		goto err_fw_vers;
> > > +	}
> > > +
> > > +	/* stop device and put it into deep sleep until it is opened */
> > > +	ret =3D auo_pixcir_stop(ts);
> > > +	if (ret < 0)
> > > +		goto err_input_register;
> > > +
> > > +	ret =3D input_register_device(input_dev);
> > > +	if (ret) {
> > > +		dev_err(&client->dev, "could not register input device\n");
> > > +		goto err_input_register;
> > > +	}
> > > +
> > > +	input_set_drvdata(ts->input, ts);
> > > +
> > > +	i2c_set_clientdata(client, ts);
> > > +
> > > +	return 0;
> > > +
> > > +err_input_register:
> > > +	free_irq(client->irq, ts);
> > > +err_fw_vers:
> > > +	input_free_device(input_dev);
> > > +err_input_alloc:
> > > +	if (pdata->exit_hw)
> > > +		pdata->exit_hw();
> > > +	gpio_free(pdata->gpio_rst);
> > > +err_gpio_rst:
> > > +	gpio_free(pdata->gpio_int);
> > > +err_gpio_int:
> > > +	kfree(ts);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int __devexit auo_pixcir_remove(struct i2c_client *client=
)
> > > +{
> > > +	struct auo_pixcir_ts *ts =3D (struct auo_pixcir_ts *)
> > > +						i2c_get_clientdata(client);
> > > +	struct auo_pixcir_ts_platdata *pdata =3D client->dev.platform_d=
ata;
> > > +
> > > +	auo_pixcir_stop(ts);
> > > +
> > > +	free_irq(client->irq, ts);
> > > +
> > > +	input_unregister_device(ts->input);
> > > +	input_free_device(ts->input);
> >=20
> > to quote input.c:
> >=20
> > /**
> >  * input_free_device - free memory occupied by input_dev structure
> >  * @dev: input device to free
> >  *
> >  * This function should only be used if input_register_device()
> >  * was not called yet or if it failed. Once device was registered
> >  * use input_unregister_device() and memory will be freed once last
> >  * reference to the device is dropped.
> >  *
> >  * Device should be allocated by input_allocate_device().
> >  *
> >  * NOTE: If there are references to the input device then memory
> >  * will not be freed until last reference is dropped.
> >  */
> thanks for this quote and I will remove the input_free_device call.
>=20
>=20
> > the same applies to the error path in auo_pixcir_probe()
> according to the docs your quoted this wouldn't be the same, as=20
> input_free_device is called in _probe either before the input_registe=
r_device=20
> call or if the call to it failed.

Yes, it's done right.

 Thanks,
   -- chf


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
