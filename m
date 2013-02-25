From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 4/4] Input: auo_pixcir_ts - add devicetree support
Date: Mon, 25 Feb 2013 14:47:17 +0100
Message-ID: <201302251447.18385.heiko@sntech.de>
References: <201302231255.23772.heiko@sntech.de> <201302241058.01412.heiko@sntech.de> <20130225030641.GA18433@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:45675 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab3BYNrY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Feb 2013 08:47:24 -0500
In-Reply-To: <20130225030641.GA18433@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Am Montag, 25. Februar 2013, 04:06:41 schrieb Dmitry Torokhov:
> On Sun, Feb 24, 2013 at 10:58:00AM +0100, Heiko St=FCbner wrote:
> > Hi Dmitry,
> >=20
> > Am Sonntag, 24. Februar 2013, 09:00:15 schrieb Dmitry Torokhov:
> > > Hi Heiko,
> > >=20
> > > On Sat, Feb 23, 2013 at 12:58:16PM +0100, Heiko St=FCbner wrote:
> > > > +static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(stru=
ct
> > > > device *dev) +{
> > > > +	struct auo_pixcir_ts_platdata *pdata =3D NULL;
> > > > +
> > > > +#ifdef CONFIG_OF
> > > > +	struct device_node *np =3D dev->of_node;
> > > > +
> > > > +	if (!np)
> > > > +		return NULL;
> > > > +
> > > > +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > > > +	if (!pdata) {
> > > > +		dev_err(dev, "failed to allocate platform data\n");
> > > > +		return NULL;
> > > > +	}
> > >=20
> > > I disike #ifdefs in the middle of the code, also it would be nice=
 if we
> > > signal the proper error instead of always using -EINVAL when ther=
e are
> > > issues with platform/DT data.
> > >=20
> > > How about the version of the patch below?
> >=20
> > I tested it and everything of course still works :-) .
>=20
> OK, great, then I will queue these for the next merge window.
>=20
> Could you also try this patch (it however needs attached patch enhanc=
ing
> devres to support custom actions).
>=20
> Thanks.

In general looks really nice and also works. I have some small nitpicks=
 (patch=20
desc, reset gpio naming) and it will also need to use=20
devm_request_threaded_irq to get the irq correctly freed on removal. [a=
ll also=20
marked at the corresponding places below]

Otherwise:

Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko

> Input: auo-pixer-ts - switch to using managed resources
>=20
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> This simplifier error unwinding and device teardown.
		^^ simplifies

>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>=20
>  drivers/input/touchscreen/auo-pixcir-ts.c |  162
>  ++++++++++++----------------- 1 file changed, 68 insertions(+), 94
>  deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c
> b/drivers/input/touchscreen/auo-pixcir-ts.c index dfa6d54..f4ba6ffa 1=
00644
> --- a/drivers/input/touchscreen/auo-pixcir-ts.c
> +++ b/drivers/input/touchscreen/auo-pixcir-ts.c
> @@ -533,13 +533,21 @@ static struct auo_pixcir_ts_platdata
> *auo_pixcir_parse_dt(struct device *dev)
>=20
>  }
>  #endif
>=20
> +static void auo_pixcir_reset(void *data)
> +{
> +       struct auo_pixcir_ts *ts =3D data;
> +
> +       gpio_set_value(ts->pdata->gpio_rst, 0);
> +}
> +
>=20
>  static int auo_pixcir_probe(struct i2c_client *client,
>=20
> -                                     const struct i2c_device_id *id)
> +                           const struct i2c_device_id *id)
>=20
>  {
> =20
>         const struct auo_pixcir_ts_platdata *pdata;
>         struct auo_pixcir_ts *ts;
>         struct input_dev *input_dev;
>=20
> -       int ret;
> +       int version;
> +       int error;
>=20
>         pdata =3D dev_get_platdata(&client->dev);
>         if (!pdata) {
>=20
> @@ -548,60 +556,30 @@ static int auo_pixcir_probe(struct i2c_client
> *client,
>=20
>                         return PTR_ERR(pdata);
>        =20
>         }
>=20
> -       ts =3D kzalloc(sizeof(struct auo_pixcir_ts), GFP_KERNEL);
> +       ts =3D devm_kzalloc(&client->dev,
> +                         sizeof(struct auo_pixcir_ts), GFP_KERNEL);
>=20
>         if (!ts)
>        =20
>                 return -ENOMEM;
>=20
> -       ret =3D gpio_request(pdata->gpio_int, "auo_pixcir_ts_int");
> -       if (ret) {
> -               dev_err(&client->dev, "request of gpio %d failed, %d\=
n",
> -                       pdata->gpio_int, ret);
> -               goto err_gpio_int;
> -       }
> -
> -       ret =3D gpio_direction_input(pdata->gpio_int);
> -       if (ret) {
> -               dev_err(&client->dev, "setting direction of gpio %d f=
ailed
> %d\n", -                       pdata->gpio_int, ret);
> -               goto err_gpio_dir;
> -       }
> -
> -       ret =3D gpio_request(pdata->gpio_rst, "auo_pixcir_ts_rst");
> -       if (ret) {
> -               dev_err(&client->dev, "request of gpio %d failed, %d\=
n",
> -                       pdata->gpio_rst, ret);
> -               goto err_gpio_dir;
> -       }
> -
> -       ret =3D gpio_direction_output(pdata->gpio_rst, 1);
> -       if (ret) {
> -               dev_err(&client->dev, "setting direction of gpio %d f=
ailed
> %d\n", -                       pdata->gpio_rst, ret);
> -               goto err_gpio_rst;
> +       input_dev =3D devm_input_allocate_device(&client->dev);
> +       if (!input_dev) {
> +               dev_err(&client->dev, "could not allocate input devic=
e\n");
> +               return -ENOMEM;
>=20
>         }
>=20
> -       msleep(200);
> -
>=20
>         ts->pdata =3D pdata;
>         ts->client =3D client;
>=20
> +       ts->input =3D input_dev;
>=20
>         ts->touch_ind_mode =3D 0;
>=20
> +       ts->stopped =3D true;
>=20
>         init_waitqueue_head(&ts->wait);
>        =20
>         snprintf(ts->phys, sizeof(ts->phys),
>        =20
>                  "%s/input0", dev_name(&client->dev));
>=20
> -       input_dev =3D input_allocate_device();
> -       if (!input_dev) {
> -               dev_err(&client->dev, "could not allocate input devic=
e\n");
> -               goto err_input_alloc;
> -       }
> -
> -       ts->input =3D input_dev;
> -
>=20
>         input_dev->name =3D "AUO-Pixcir touchscreen";
>         input_dev->phys =3D ts->phys;
>         input_dev->id.bustype =3D BUS_I2C;
>=20
> -       input_dev->dev.parent =3D &client->dev;
>=20
>         input_dev->open =3D auo_pixcir_input_open;
>         input_dev->close =3D auo_pixcir_input_close;
>=20
> @@ -626,72 +604,69 @@ static int auo_pixcir_probe(struct i2c_client
> *client,
>=20
>                              AUO_PIXCIR_MAX_AREA, 0, 0);
>        =20
>         input_set_abs_params(input_dev, ABS_MT_ORIENTATION, 0, 1, 0, =
0);
>=20
> -       ret =3D i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_VERSI=
ON);
> -       if (ret < 0)
> -               goto err_fw_vers;
> -       dev_info(&client->dev, "firmware version 0x%X\n", ret);
> -
> -       ret =3D auo_pixcir_int_config(ts, pdata->int_setting);
> -       if (ret)
> -               goto err_fw_vers;
> -
>=20
>         input_set_drvdata(ts->input, ts);
>=20
> -       ts->stopped =3D true;
>=20
> -       ret =3D request_threaded_irq(client->irq, NULL, auo_pixcir_in=
terrupt,
> -                                  IRQF_TRIGGER_RISING | IRQF_ONESHOT=
,
> -                                  input_dev->name, ts);
> -       if (ret) {
> -               dev_err(&client->dev, "irq %d requested failed\n",
> client->irq); -               goto err_fw_vers;
> +       error =3D devm_gpio_request_one(&client->dev, pdata->gpio_int=
,
> +                                     GPIOF_DIR_IN, "auo_pixcir_ts_in=
t");
> +       if (error) {
> +               dev_err(&client->dev, "request of gpio %d failed, %d\=
n",
> +                       pdata->gpio_int, error);
> +               return error;
>=20
>         }
>=20
> -       /* stop device and put it into deep sleep until it is opened =
*/
> -       ret =3D auo_pixcir_stop(ts);
> -       if (ret < 0)
> -               goto err_input_register;
> -
> -       ret =3D input_register_device(input_dev);
> -       if (ret) {
> -               dev_err(&client->dev, "could not register input devic=
e\n");
> -               goto err_input_register;
> +       error =3D devm_gpio_request_one(&client->dev, pdata->gpio_rst=
,
> +                                     GPIOF_DIR_OUT | GPIOF_INIT_HIGH=
,
> +                                     "auo_pixcir_ts_int");

									  ^^ auo_pixcir_ts_rst


> +       if (error) {
> +               dev_err(&client->dev, "request of gpio %d failed, %d\=
n",
> +                       pdata->gpio_rst, error);
> +               return error;
>=20
>         }
>=20
> -       i2c_set_clientdata(client, ts);
> -
> -       return 0;
> -
> -err_input_register:
> -       free_irq(client->irq, ts);
> -err_fw_vers:
> -       input_free_device(input_dev);
> -err_input_alloc:
> -       gpio_set_value(pdata->gpio_rst, 0);
> -err_gpio_rst:
> -       gpio_free(pdata->gpio_rst);
> -err_gpio_dir:
> -       gpio_free(pdata->gpio_int);
> -err_gpio_int:
> -       kfree(ts);
> +       error =3D devm_add_action(&client->dev, auo_pixcir_reset, ts)=
;
> +       if (error) {
> +               auo_pixcir_reset(ts);
> +               dev_err(&client->dev, "failed to register xxx action,
> %d\n", +                       error);
> +               return error;
> +       }
>=20
> -       return ret;
> -}
> +       msleep(200);
>=20
> -static int auo_pixcir_remove(struct i2c_client *client)
> -{
> -       struct auo_pixcir_ts *ts =3D i2c_get_clientdata(client);
> -       const struct auo_pixcir_ts_platdata *pdata =3D ts->pdata;
> +       version =3D i2c_smbus_read_byte_data(client, AUO_PIXCIR_REG_V=
ERSION);
> +       if (version < 0) {
> +               error =3D version;
> +               return error;
> +       }
>=20
> -       free_irq(client->irq, ts);
> +       dev_info(&client->dev, "firmware version 0x%X\n", version);
>=20
> -       input_unregister_device(ts->input);
> +       error =3D auo_pixcir_int_config(ts, pdata->int_setting);
> +       if (error)
> +               return error;
>=20
> -       gpio_set_value(pdata->gpio_rst, 0);
> -       gpio_free(pdata->gpio_rst);
> +       error =3D request_threaded_irq(client->irq, NULL,

+       error =3D devm_request_threaded_irq(&client->dev, client->irq, =
NULL,


> auo_pixcir_interrupt, +                                  =20
> IRQF_TRIGGER_RISING | IRQF_ONESHOT, +                                =
  =20
> input_dev->name, ts);
> +       if (error) {
> +               dev_err(&client->dev, "irq %d requested failed, %d\n"=
,
> +                       client->irq, error);
> +               return error;
> +       }
>=20
> -       gpio_free(pdata->gpio_int);
> +       /* stop device and put it into deep sleep until it is opened =
*/
> +       error =3D auo_pixcir_stop(ts);
> +       if (error)
> +               return error;
> +
> +       error =3D input_register_device(input_dev);
> +       if (error) {
> +               dev_err(&client->dev, "could not register input devic=
e,
> %d\n", +                       error);
> +               return error;
> +       }
>=20
> -       kfree(ts);
> +       i2c_set_clientdata(client, ts);
>=20
>         return 0;
> =20
>  }
>=20
> @@ -718,7 +693,6 @@ static struct i2c_driver auo_pixcir_driver =3D {
>=20
>                 .of_match_table =3D of_match_ptr(auo_pixcir_ts_dt_idt=
able),
>        =20
>         },
>         .probe          =3D auo_pixcir_probe,
>=20
> -       .remove         =3D auo_pixcir_remove,
>=20
>         .id_table       =3D auo_pixcir_idtable,
> =20
>  };
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
