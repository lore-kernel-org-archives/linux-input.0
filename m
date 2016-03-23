From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Input: rotary_encoder - support binary encoding of states
Date: Wed, 23 Mar 2016 07:49:30 +0100
Message-ID: <20160323064930.GJ6191@pengutronix.de>
References: <1458680914-4533-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAAEAJfDAg9aW62O8zNG3cGf207_azZYFja8jUgf+5xDAtzfbyg@mail.gmail.com>
 <CAL_Jsq++0hPVuqZERsfGRM20F+2rzFUz2CDOR1Kioj0uOaskDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34051 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751234AbcCWGtg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Mar 2016 02:49:36 -0400
Content-Disposition: inline
In-Reply-To: <CAL_Jsq++0hPVuqZERsfGRM20F+2rzFUz2CDOR1Kioj0uOaskDQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Daniel Mack <daniel@zonque.org>, Rojhalat Ibrahim <imr@rtschenk.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

Hello Ezequiel,

On Tue, Mar 22, 2016 at 07:47:06PM -0500, Rob Herring wrote:
> On Tue, Mar 22, 2016 at 5:50 PM, Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> > (Adding DT people)

Thanks. (I thought addressing the list was enough.)

> > On 22 March 2016 at 18:08, Uwe Kleine-K=F6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> >> A plain binary encoding has some downsides compared to the usual G=
ray
> >> encoding, but that doesn't stop hardware engineers to eventually u=
se it.
> >> So implement support for this encoding in the rotary encoder drive=
r.
> >>
> >> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >> ---
> >> Hello,
> >>
> >> an alternative to define this difference in the device tree is to =
use
> >> something like:
> >>
> >>         rotary-encoder,encoding =3D "binary";
> >>
> >> or
> >>
> >>         rotary-encoder,encoding =3D <ROTARY_ENCODER_ENCODING_BINAR=
Y>;
> >>
> >> instead of a property
> >>
> >>         rotary-encoder,encoding-binary;
> >>
> >> . While the two first solutions make it obvious that there can onl=
y be
> >> one encoding, they IMHO look ugly, so I went for the property with=
out
> >> value. What do you think?
> >>
> >
> > Yes, picking something like:
> >
> >   rotary-encoder,encoding =3D "binary";
> >
> > emphasizing the fact that only one encoding will be used,
> > will work better, scaling well if we need to introduce some
> > "foobar" encoding.

OK, then I stick to strings to not have to introduce magic constants or
cpp symbols?

> Fine, but "rotary-encoder" is not a vendor I've ever heard of. Just
> "encoding" is sufficient.

I picked that to be consistent with rotary-encoder,steps and other
already existing properties documented in
Documentation/devicetree/bindings/input/rotary-encoder.txt.

Should the prefix be dropped for these, too (with compat code)?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
