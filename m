From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] Input: rotary-encoder - use more than two gpios
Date: Tue, 2 Feb 2016 14:27:03 +0100
Message-ID: <20160202132703.GY13664@pengutronix.de>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <56B09C27.8070009@zonque.org>
 <20160202125602.GW13664@pengutronix.de>
 <56B0ABC9.10107@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56B0ABC9.10107-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sylvain Rochet <sylvain.rochet-ETtyaVkrhkNWk0Htik3J/w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello Daniel,

On Tue, Feb 02, 2016 at 02:14:49PM +0100, Daniel Mack wrote:
> On 02/02/2016 01:56 PM, Uwe Kleine-K=F6nig wrote:
> > Hello Daniel,
> >=20
> > On Tue, Feb 02, 2016 at 01:08:07PM +0100, Daniel Mack wrote:
> >> On 02/02/2016 11:24 AM, Uwe Kleine-K=F6nig wrote:
> >>> Some time ago I sent a v1 of this, now after testing the changes =
more
> >>> deeply patch 3 changed a bit. The old series started with
> >>>
> >>> 	Date: Wed,  2 Dec 2015 11:07:11 +0100
> >>> 	From: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >>> 	Subject: [PATCH RFC 0/3] input: rotary_encoder: use more than tw=
o gpios as input
> >>> 	Message-Id: <1449050834-31779-1-git-send-email-u.kleine-koenig@p=
engutronix.de>
> >>>
> >>> The two first patches are just preparation for the third patch.
> >>>
> >>> There is an obvious improvement that allows detection of quick ch=
anges
> >>> more reliably with >2 gpios, but I didn't implement this yet. (Wi=
th 4
> >>> GPIOs you can distinguish a counter clockwise movement of three s=
tates
> >>> from a clock wise movement of a single state. Still the patch is =
useful
> >>> as it makes these devices work at all.
> >>>
> >>> My test device looks as follows:
> >>>
> >>>         rotary@0 {
> >>>                 compatible =3D "rotary-encoder";
> >>>                 gpios =3D <&gpio4 12 GPIO_ACTIVE_HIGH>, <&gpio4 1=
1 GPIO_ACTIVE_HIGH>, <&gpio4 10 GPIO_ACTIVE_HIGH>, <&gpio4 9 GPIO_ACTIV=
E_HIGH>;
> >>>
> >>>                 rotary-encoder,steps =3D <16>;
> >>> 		rotary-encoder,steps-per-period =3D <16>;
> >>>         };
> >>>
> >>> While Daniel Mack and Rojhalat Ibrahim agreed that this device is=
 an
> >>> absolute encoder and should be supported by a simpler logic, I st=
ill
> >>> consider it worthwhile to get these patches in as a first step. A=
lso the
> >>> binding looks right, so IMHO the comments shouldn't stop this ser=
ies
> >>> from going in.
> >>
> >> I still don't understand why this is implemented that way, rather =
than
> >> going for a much simpler logic of interpretation that also allows =
users
> >> to read out the absolute position.
> >>
> >> The code to read the value would be really just as simple as readi=
ng all
> >> GPIOs and or-ing their values into the result, and skip the state
> >> machine completely. This code would be active if a new attribute
> >> (something like 'rotary-encoder,hardware-absolute') is set, or eve=
n
> >> implicitly, when more than 2 GPIOs are specified.
> >>
> >> Is there any reason for not doing that?
> >=20
> > Currently the reason is lack of time. And when implementing
> > rotary-encoder,hardware-absolute something similar would be the res=
ult
> > for the relative reporting anyhow. So the problem is only that I do=
n't
> > have absolute support yet, but the patches as is would be the base =
for
> > that anyhow.
>=20
> Because you would support relative support for such 4-pin encoders as
> well? I would have thought that absolute encoders would report absolu=
te
> values only, but I guess you have a point here. Just to make sure we'=
re
> on the same page: For more than 2 GPIOs, and an absent
> "rotary-encoder,relative-axis", the driver would switch to a mode in
> which it bypasses the state machine, right?

Not sure about how this will be represented in the device tree, but yes=
,
that's more or less how I imagine to implement this. (And in the end
having support for a 4-line relative device is just a side effect of
having support for relative devices and for 4-line devices.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
