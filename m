From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH 1/2] input: egalax_ts: add system wakeup support
Date: Thu, 6 Sep 2018 03:30:53 +0000
Message-ID: <AM0PR0402MB3905F7737816174202D634CAF5010@AM0PR0402MB3905.eurprd04.prod.outlook.com>
References: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
 <20180905172700.GA257188@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905172700.GA257188@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Marco Antonio Franchi <marco.franchi@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

Hi, Dmitry

Anson Huang
Best Regards!


> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Thursday, September 6, 2018 1:27 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: robh+dt@kernel.org; mark.rutland@arm.com; Marco Antonio Franchi
> <marco.franchi@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> linux-input@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH 1/2] input: egalax_ts: add system wakeup support
>=20
> Hi Anson,
>=20
> On Wed, Sep 05, 2018 at 05:26:46PM +0800, Anson Huang wrote:
> > This patch adds wakeup function support for egalax touch screen, if
> > "wakeup-source" is added to device tree's egalax touch screen node,
> > the wakeup function will be enabled, and egalax touch screen will be
> > able to wakeup system from suspend.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  drivers/input/touchscreen/egalax_ts.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/input/touchscreen/egalax_ts.c
> > b/drivers/input/touchscreen/egalax_ts.c
> > index 80e69bb..74984ed 100644
> > --- a/drivers/input/touchscreen/egalax_ts.c
> > +++ b/drivers/input/touchscreen/egalax_ts.c
> > @@ -164,6 +164,7 @@ static int egalax_firmware_version(struct
> > i2c_client *client)  static int egalax_ts_probe(struct i2c_client *clie=
nt,
> >  			   const struct i2c_device_id *id)  {
> > +	struct device_node *np =3D client->dev.of_node;
> >  	struct egalax_ts *ts;
> >  	struct input_dev *input_dev;
> >  	int error;
> > @@ -224,6 +225,9 @@ static int egalax_ts_probe(struct i2c_client *clien=
t,
> >  	if (error)
> >  		return error;
> >
> > +	if (of_property_read_bool(np, "wakeup-source"))
> > +		device_init_wakeup(&client->dev, true);
>=20
> This is done in i2c core, there is no need to do it in the driver.
=20
Correct, I removed it in V2 patch.


>=20
> > +
> >  	return 0;
> >  }
> >
> > @@ -241,6 +245,9 @@ static int __maybe_unused
> egalax_ts_suspend(struct device *dev)
> >  	struct i2c_client *client =3D to_i2c_client(dev);
> >  	int ret;
> >
> > +	if (device_may_wakeup(dev))
> > +		return enable_irq_wake(client->irq);
> > +
> >  	ret =3D i2c_master_send(client, suspend_cmd, MAX_I2C_DATA_LEN);
> >  	return ret > 0 ? 0 : ret;
> >  }
> > @@ -249,6 +256,9 @@ static int __maybe_unused egalax_ts_resume(struct
> > device *dev)  {
> >  	struct i2c_client *client =3D to_i2c_client(dev);
> >
> > +	if (device_may_wakeup(dev))
> > +		return 0;
>=20
> This will end up with unbalanced enable_irq_wake() from suspend.

Ah, it is a mistake, I fix it in V2 patch, please help review it.

And for the other patch about adding "wakeup-source" into dt-binding, I thi=
nk it may
be no need now, since it is already included in i2c's dt-binding, right?

Thanks.

Anson.

>=20
> > +
> >  	return egalax_wake_up_device(client);  }
> >
> > --
> > 2.7.4
> >
>=20
> Thanks.
>=20
> --
> Dmitry
