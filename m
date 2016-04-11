From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] Input: rotary_encoder - support binary encoding of
 states
Date: Mon, 11 Apr 2016 10:32:48 -0500
Message-ID: <20160411153248.GA20044@rob-hp-laptop>
References: <1460055528-13814-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAL_JsqLfQQu69LcsFuJkKmjppp047vW5Ga+y5XiDAAG-Weh6ug@mail.gmail.com>
 <20160408064058.GC10108@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160408064058.GC10108-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 08, 2016 at 08:40:58AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Rob,
>=20
> On Thu, Apr 07, 2016 at 05:45:00PM -0500, Rob Herring wrote:
> > On Thu, Apr 7, 2016 at 1:58 PM, Uwe Kleine-K=F6nig
> > <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > > It's not advisable to use this encoding, but to support existing =
devices
> > > add support for this to the driver.
> > >
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org=
>
> > > ---
> >=20
> > Ack for the binding, but...
>=20
> Thanks. Actually I already had your ack for v2 and only dropped it to
> make you look over the patch again :-)
> =20
> > > @@ -213,6 +222,17 @@ static int rotary_encoder_probe(struct platf=
orm_device *pdev)
> > >         encoder->rollover =3D
> > >                 device_property_read_bool(dev, "rotary-encoder,ro=
llover");
> > >
> > > +       err =3D device_property_read_string(dev, "rotary-encoder,=
encoding",
> > > +                                         &encoding);
> > > +       if (!err && !strcmp(encoding, "binary")) {
> > > +               encoder->encoding =3D ROTENC_BINARY;
> > > +       } else if (err || !strcmp(encoding, "gray")) {
> > > +               encoder->encoding =3D ROTENC_GRAY;
> > > +       } else {
> > > +               dev_err(dev, "unknown encoding setting");
> > > +               return -EINVAL;
> >=20
> > device_property_match_string() here instead.
>=20
> With the added downside that the property is parsed at least twice fr=
om
> dt, right? This is not a hot path, but still I wonder if it simplyfie=
s
> the driver code enough to be worth the effort?

IMO, yes.
=20
> Also this seems to have a different semantic and allows the property =
to
> be an array.

It is not really the kernel's job to validate crap in bindings. If you=20
put '"binary", "gray"' in your DT, then the kernel may or may not handl=
e=20
that.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
