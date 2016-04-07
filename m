From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] Input: rotary_encoder - support binary encoding of
 states
Date: Thu, 7 Apr 2016 20:45:30 +0200
Message-ID: <20160407184530.GA10108@pengutronix.de>
References: <1458806232-22403-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160407181513.GA7283@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160407181513.GA7283@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rojhalat Ibrahim <imr-yYm5e5rpIQsb1SvskN2V4Q@public.gmane.org>, Sylvain Rochet <sylvain.rochet-ETtyaVkrhkNWk0Htik3J/w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hello Dmitry,

On Thu, Apr 07, 2016 at 11:15:13AM -0700, Dmitry Torokhov wrote:
> On Thu, Mar 24, 2016 at 08:57:12AM +0100, Uwe Kleine-K=F6nig wrote:
> > diff --git a/Documentation/devicetree/bindings/input/rotary-encoder=
=2Etxt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > index 6c9f0c8a846c..e85ce3dea480 100644
> > --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > @@ -20,6 +20,8 @@ Optional properties:
> >    2: Half-period mode
> >    4: Quarter-period mode
> >  - wakeup-source: Boolean, rotary encoder can wake up the system.
> > +- rotary-encoder,encoding: String, the method used to encode steps=
=2E
> > +  Supported are "gray" (the default and more common) and "binary".
> > =20
> >  Deprecated properties:
> >  - rotary-encoder,half-period: Makes the driver work on half-period=
 mode.
> > [...]
> > +	err =3D device_property_read_string(dev, "rotary-encoder,encoding=
",
> > +					  &encoding);
> > +	if (!err && encoding[0] =3D=3D 'b')
>=20
> Why do we only match on first letter? I'd prefer we did better parsin=
g
> (i.e. only accepted valid encodings or no encoding property.

IMHO it's not a problem that

	rotary-encoder,encoding =3D "blablubfasel";

isn't rejected by interpretet as "binary" instead. That's a bit like
compilers that are free to do whatever they want if the source code
contains something non-standard or undefined.

But I admit this might become a problem when the set of allowed
encodings is expanded in the future. So I will resend a more stricter
version.

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
