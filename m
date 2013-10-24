From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 4/8] input: Remove OOM message after
 input_allocate_device
Date: Thu, 24 Oct 2013 11:43:38 -0700
Message-ID: <1382640218.22433.71.camel@joe-AO722>
References: <cover.1382555436.git.joe@perches.com>
	 <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
	 <20131024182611.GA3512@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:42436 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754747Ab3JXSnn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Oct 2013 14:43:43 -0400
In-Reply-To: <20131024182611.GA3512@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Ferruh Yigit <fery@cypress.com>, Wan ZongShun <mcuos.com@gmail.com>, Andrey Moiseev <o2g.org.ru@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Josh Wu <josh.wu@atmel.com>, linux-samsung-soc@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, Pau Oliva Fora <pof@eslack.org>, linux-arm-kernel@lists.infradead.org

On Thu, 2013-10-24 at 20:26 +0200, Uwe Kleine-K=F6nig wrote:
> Hello Joe,
>=20
> On Wed, Oct 23, 2013 at 12:14:50PM -0700, Joe Perches wrote:
> > Emitting an OOM message isn't necessary after input_allocate_device
> > as there's a generic OOM and a dump_stack already done.
> >=20
> > [...]
> > Signed-off-by: Joe Perches <joe@perches.com>
> > diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joysti=
ck/as5011.c
> > index 005d852..3b9c709 100644
> > --- a/drivers/input/joystick/as5011.c
> > +++ b/drivers/input/joystick/as5011.c
> > @@ -254,8 +254,6 @@ static int as5011_probe(struct i2c_client *clie=
nt,
> >  	as5011 =3D kmalloc(sizeof(struct as5011_device), GFP_KERNEL);
> >  	input_dev =3D input_allocate_device();
> >  	if (!as5011 || !input_dev) {
> > -		dev_err(&client->dev,
> > -			"Can't allocate memory for device structure\n");
> Don't know if that can happen, but if as5011 is NULL but input_dev is=
n't
> the message would still be sensible, wouldn't it? There are several m=
ore
> that suffer the same "problem".

Any k.alloc without __GFP_NOWARN does a generic OOM message
and a dump_stack() so there could already be 2 messages anyway.

cheers, Joe

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
