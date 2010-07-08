From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: cy8ctmg110: capacitive touchscreen support
Date: Thu, 8 Jul 2010 20:44:01 +0300
Message-ID: <20100708174401.GJ10135@sci.fi>
References: <20100708161040.23957.36738.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:55836 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab0GHRyU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jul 2010 13:54:20 -0400
Content-Disposition: inline
In-Reply-To: <20100708161040.23957.36738.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Thu, Jul 08, 2010 at 04:11:38PM -0000, Alan Cox wrote:
> From: Samuli Konttila <samuli.konttila@aavamobile.com>
>=20
> Add support for the cy8ctmg110 capacitive touchscreen used on some em=
bedded
> devices.
>=20
> (Some clean up by Alan Cox)
>=20
> Signed-off-by: Alan Cox <alan@linux.intel.com>
>=20
> ---
> drivers/input/touchscreen/Kconfig         |   14 +
>  drivers/input/touchscreen/Makefile        |    1=20
>  drivers/input/touchscreen/cy8ctmg110_ts.c |  470 +++++++++++++++++++=
++++++++++
>  3 files changed, 485 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/cy8ctmg110_ts.c
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
<snip>
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> +/*
> + * cy8ctmg110_write_req write regs to the i2c devices
> + */
> +static int cy8ctmg110_write_req(struct cy8ctmg110 *tsc, unsigned cha=
r reg,
                                 ^

s/req/reg

> +		unsigned char len, unsigned char *value)
> +{
> +	struct i2c_client *client =3D tsc->client;
> +	unsigned int ret;
> +	unsigned char i2c_data[6];
> +
> +	BUG_ON(len > 5);
> +
> +	i2c_data[0] =3D reg;
> +	memcpy(i2c_data + 1, value, len);
> +
> +	ret =3D i2c_master_send(client, i2c_data, len + 1);
> +	if (ret !=3D 1) {
> +		dev_err(&client->dev,
> +			"cy8ctmg110 touch : i2c write data cmd failed\n");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * cy8ctmg110_read_req read regs from i2c devise
> + */
> +
> +static int cy8ctmg110_read_req(struct cy8ctmg110 *tsc,

ditto

> +		unsigned char *i2c_data, unsigned char len, unsigned char cmd)
> +{
> +	struct i2c_client *client =3D tsc->client;
> +	unsigned int ret;
> +
> +	/* first write slave position to i2c devices */
> +	ret =3D i2c_master_send(client, &cmd, 1);
> +	if (ret !=3D 1)
> +		return ret;
> +
> +	/* Second read data from position */
> +	ret =3D i2c_master_recv(client, i2c_data, 1);
> +	if (ret !=3D 1)
> +		return ret;
> +	return 0;
> +}
> +
<snip>
> +/*
> + * cy8ctmg110_irq_handler irq handling function
> + */
> +
> +static irqreturn_t cy8ctmg110_irq_handler(int irq, void *dev_id)
> +{
> +	struct cy8ctmg110 *tsc =3D (struct cy8ctmg110 *) dev_id;
> +	cy8ctmg110_touch_pos(tsc);

i2c from an interrupt handler? Is there some problem with using a
threaded irq handler?

I see this stuff ends up in i2c_transfer() which will fail with
-EAGAIN if it can't get the bus lock while irqs are disabled. But
-EAGAIN apparently isn't handled by the driver. So what happens
in that case? The event is lost?

> +	return IRQ_HANDLED;
> +}
> +

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
