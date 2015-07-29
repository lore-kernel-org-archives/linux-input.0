From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: zforce - make the interrupt GPIO optional
Date: Wed, 29 Jul 2015 11:35:50 -0700
Message-ID: <20150729183550.GF23178@dtor-ws>
References: <1438072008-11769-1-git-send-email-dirk.behme@de.bosch.com>
 <2117458.kiOQbe0u2g@diego>
 <20150729175304.GD23178@dtor-ws>
 <143822119.SjJP6yKATN@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34237 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbG2Sfy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 14:35:54 -0400
Received: by pdbbh15 with SMTP id bh15so10072517pdb.1
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2015 11:35:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <143822119.SjJP6yKATN@diego>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-input@vger.kernel.org

On Wed, Jul 29, 2015 at 08:17:10PM +0200, Heiko St=FCbner wrote:
> Hi Dmitry,
>=20
> Am Mittwoch, 29. Juli 2015, 10:53:04 schrieb Dmitry Torokhov:
> > On Tue, Jul 28, 2015 at 11:43:20PM +0200, Heiko St=FCbner wrote:
>=20
> [snip]
>=20
> > > > > @@ -510,7 +511,18 @@ static irqreturn_t zforce_irq_thread(int=
 irq,
> > > > > void
> > > > > *dev_id)>
> > > > >=20
> > > > >  	if (!ts->suspending && device_may_wakeup(&client->dev))
> > > > >  =09
> > > > >  		pm_stay_awake(&client->dev);
> > > > >=20
> > > > > -	while (gpiod_get_value_cansleep(ts->gpio_int)) {
> > > > > +	while (run) {
> > > > > +		/*
> > > > > +		 * Exit the loop if either
> > > > > +		 * - the optional interrupt GPIO isn't specified
> > > > > +		 *   (there is only one packet read per ISR invocation,=20
> then)
> > > > > +		 * or
> > > > > +		 * - the GPIO isn't active any more
> > > > > +		 *   (packet read until the level GPIO indicates that ther=
e=20
> is
> > > > > +		 *    no IRQ any more)
> > > > > +		 */
> > > > > +		run =3D gpiod_get_value_cansleep(ts->gpio_int);
> > > > > +
> > >=20
> > > alteratively you could simply convert to a
> > >=20
> > > 	/* Run at least once, or as long as the interrupt gpio is active=
=2E */
> > > 	do {
> > > =09
> > > 		...
> > > =09
> > > 	} while(gpiod_get_value_cansleep(ts->gpio_int));
> > >=20
> > > saving the additional variable run and a lot of lines, while stil=
l running
> > > at least once.
> >=20
> > But I think that means that we'll try to read even if gpio is not a=
ctive
> > anymore on the first iteration.
>=20
> I don't think this is a possible scenario :-)
>=20
> The interrupt is only used for transmission of touch-data and is pull=
ed low as=20
> long as the host hasn't fetched all touch-packages. So if nothing els=
e except=20
> the zforce-driver talks to the chip, the gpio will stay on.
>=20
> And when we're entering the interrupt handler, there is at least one =
touch-
> data package waiting.

I see. Then please ignore me ;)

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
