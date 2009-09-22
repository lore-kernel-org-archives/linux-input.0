From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Atmel AT42QT2160 sensor chip input driver
Date: Mon, 21 Sep 2009 22:52:52 -0700
Message-ID: <20090922055252.GA9658@core.coreip.homeip.net>
References: <f20381800908201315s7cd4cfc1g57c8799218415b8d@mail.gmail.com> <20090915042612.GB1132@core.coreip.homeip.net> <f20381800909210835h66d695f2i10d95c3ed040efe7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:57093 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbZIVFwz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 01:52:55 -0400
Received: by an-out-0708.google.com with SMTP id d40so4781107and.1
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2009 22:52:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f20381800909210835h66d695f2i10d95c3ed040efe7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Raphael Derosso Pereira <raphaelpereira@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Raphael,

On Mon, Sep 21, 2009 at 12:35:21PM -0300, Raphael Derosso Pereira wrote=
:
> Hello Dimitry,
>=20
> 2009/9/15 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> >
> > This version is much better, thank you very much for making the cha=
nges
> > I requested.
>=20
> You're very welcomed, let's see this version I'm sending now!
>=20
> >
> >> +
> >> +#define QT2160_CMD_CHIPID =A0 =A0(00)
> >> +#define QT2160_CMD_CODEVER =A0 (01)
> >> +#define QT2160_CMD_GSTAT =A0 =A0 (02)
> >> +#define QT2160_CMD_KEYS3 =A0 =A0 (03)
> >> +#define QT2160_CMD_KEYS4 =A0 =A0 (04)
> >> +#define QT2160_CMD_SLIDE =A0 =A0 (05)
> >> +#define QT2160_CMD_GPIOS =A0 =A0 (06)
> >> +#define QT2160_CMD_SUBVER =A0 =A0(07)
> >> +#define QT2160_CMD_CALIBRATE (10)
> >
> > I am a bit concerned about this chunk. The first 8 commands are wri=
tten
> > as octal while the last (calibrate) as decimal. Is this intentional=
?
>=20
> You are right. There's no need to declare them as octal.
>=20
> >
> > I also made a few more changes. Could you please trythe patch below=
 and
> > if everything is still working I will apply to my tree.
>=20
> As I had already made other modifications, I added your changes into
> my code, correct a bug you inserted (qt2160_read must return the
> variable value and not 0 at the end), and I'm sending a patch against
> 2.6.31. Hope you don't mind.
>=20
> --
>=20
> From: Raphael Derosso Pereira <raphaelpereira@gmail.com>
>=20
> Input: AT42QT2160
>=20
> Inclusion of input->open and input->close plus Dmitry fixups plus oth=
er cleanups
> needed after checking code.
>=20
> Signed-off-by: Raphael Derosso Pereira <raphaelpereira@gmail.com>
> --
> diff -pruN linux-2.6.31_orig/drivers/input/keyboard/Kconfig
> linux-2.6.31_rp/drivers/input/keyboard/Kconfig
> --- linux-2.6.31_orig/drivers/input/keyboard/Kconfig	2009-09-09
> 19:13:59.000000000 -0300
> +++ linux-2.6.31_rp/drivers/input/keyboard/Kconfig	2009-09-21
> 12:09:49.000000000 -0300
> @@ -361,4 +361,22 @@ config KEYBOARD_XTKBD
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called xtkbd.
>=20
> +config QT2160
> +	tristate "Atmel AT42QT2160 Touch Sensor Chip"
> +	depends on EXPERIMENTAL
> +	select I2C
> +	help
> +	  If you say yes here you get support for Atmel AT42QT2160 Touch
> +	  Sensor chip as a keyboard input.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called qt2160.
> +
> +config QT2160_DEBUG
> +	bool "AT42QT2160 Debug Messages"
> +	depends on QT2160
> +	help
> +	  Generates lots of debug from driver to help show what is going
> +	  on under the hoods.

I don't think we need a Kconfig entry for debugging. A person who wants
to debug such driver can easily turn on debugging manually.

> +
> +static int qt2160_open(struct input_dev *dev)
> +{
> +	int error;
> +	struct qt2160_data *qt2160;
> +	struct i2c_client *client;
> +
> +	qt2160 =3D input_get_drvdata(dev);
> +	client =3D qt2160->client;
> +
> +	/* Calibrate device */
> +	error =3D qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
> +	if (error) {
> +		dev_err(&client->dev,
> +			"failed to calibrate device\n");
> +		return error;
> +	}
> +
> +	/* Initialize IRQ structure */
> +	schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTERVAL);
> +
> +	if (client->irq) {
> +		error =3D request_irq(client->irq, qt2160_irq,
> +			(IRQF_TRIGGER_FALLING), "qt2160", qt2160);
> +
> +		if (error) {
> +			dev_err(&client->dev,
> +				"failed to allocate irq %d\n", client->irq);
> +			return error;
> +		}
> +	}
> +

We normally try to allocate all necessary resources in probe() so that
if device is bound to a driver it should work unless it is broken. Sinc=
e
there is no way to shut off IRQs while IRQ handler is registered it doe=
s
not make sense to have open and close if we allocate IRQ in probe().

Please take a look at the latest version that I have in 'for-linus'
branch in my tree on kernel.org and shout if you see something wrong.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
