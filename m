From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Subject: Re: [PATCH] Input: zforce - make the interrupt GPIO optional
Date: Wed, 29 Jul 2015 20:17:10 +0200
Message-ID: <143822119.SjJP6yKATN@diego>
References: <1438072008-11769-1-git-send-email-dirk.behme@de.bosch.com> <2117458.kiOQbe0u2g@diego> <20150729175304.GD23178@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:35122 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbbG2SRO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 14:17:14 -0400
In-Reply-To: <20150729175304.GD23178@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-input@vger.kernel.org

Hi Dmitry,

Am Mittwoch, 29. Juli 2015, 10:53:04 schrieb Dmitry Torokhov:
> On Tue, Jul 28, 2015 at 11:43:20PM +0200, Heiko St=FCbner wrote:

[snip]

> > > > @@ -510,7 +511,18 @@ static irqreturn_t zforce_irq_thread(int i=
rq,
> > > > void
> > > > *dev_id)>
> > > >=20
> > > >  	if (!ts->suspending && device_may_wakeup(&client->dev))
> > > >  =09
> > > >  		pm_stay_awake(&client->dev);
> > > >=20
> > > > -	while (gpiod_get_value_cansleep(ts->gpio_int)) {
> > > > +	while (run) {
> > > > +		/*
> > > > +		 * Exit the loop if either
> > > > +		 * - the optional interrupt GPIO isn't specified
> > > > +		 *   (there is only one packet read per ISR invocation,=20
then)
> > > > +		 * or
> > > > +		 * - the GPIO isn't active any more
> > > > +		 *   (packet read until the level GPIO indicates that there=20
is
> > > > +		 *    no IRQ any more)
> > > > +		 */
> > > > +		run =3D gpiod_get_value_cansleep(ts->gpio_int);
> > > > +
> >=20
> > alteratively you could simply convert to a
> >=20
> > 	/* Run at least once, or as long as the interrupt gpio is active. =
*/
> > 	do {
> > =09
> > 		...
> > =09
> > 	} while(gpiod_get_value_cansleep(ts->gpio_int));
> >=20
> > saving the additional variable run and a lot of lines, while still =
running
> > at least once.
>=20
> But I think that means that we'll try to read even if gpio is not act=
ive
> anymore on the first iteration.

I don't think this is a possible scenario :-)

The interrupt is only used for transmission of touch-data and is pulled=
 low as=20
long as the host hasn't fetched all touch-packages. So if nothing else =
except=20
the zforce-driver talks to the chip, the gpio will stay on.

And when we're entering the interrupt handler, there is at least one to=
uch-
data package waiting.


> So maybe we need to factor out the body
> and do:
>=20
> 	if (!ts->gpio_int)
> 		zforce_report_data(...)
> 	else
> 		while (gpiod_get_value_cansleep(ts->gpio_int))
> 			zforce_report_data(...);
>=20
> Or we could install 2 different interrupt handlers, depending on the
> presence of interrupt gpio.


Heiko
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
