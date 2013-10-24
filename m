From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/8] input: Remove OOM message after input_allocate_device
Date: Thu, 24 Oct 2013 20:26:11 +0200
Message-ID: <20131024182611.GA3512@pengutronix.de>
References: <cover.1382555436.git.joe@perches.com>
 <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Ferruh Yigit <fery@cypress.com>, Wan ZongShun <mcuos.com@gmail.com>, Andrey Moiseev <o2g.org.ru@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Josh Wu <josh.wu@atmel.com>, linux-samsung-soc@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, Pau Oliva Fora <pof@eslack.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hello Joe,

On Wed, Oct 23, 2013 at 12:14:50PM -0700, Joe Perches wrote:
> Emitting an OOM message isn't necessary after input_allocate_device
> as there's a generic OOM and a dump_stack already done.
>=20
> [...]
> Signed-off-by: Joe Perches <joe@perches.com>
> diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick=
/as5011.c
> index 005d852..3b9c709 100644
> --- a/drivers/input/joystick/as5011.c
> +++ b/drivers/input/joystick/as5011.c
> @@ -254,8 +254,6 @@ static int as5011_probe(struct i2c_client *client=
,
>  	as5011 =3D kmalloc(sizeof(struct as5011_device), GFP_KERNEL);
>  	input_dev =3D input_allocate_device();
>  	if (!as5011 || !input_dev) {
> -		dev_err(&client->dev,
> -			"Can't allocate memory for device structure\n");
Don't know if that can happen, but if as5011 is NULL but input_dev isn'=
t
the message would still be sensible, wouldn't it? There are several mor=
e
that suffer the same "problem".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
