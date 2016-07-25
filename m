From: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Subject: Re: [PATCH 4/5] input: touchscreen: support Allwinner SoCs'
 touchscreen
Date: Mon, 25 Jul 2016 11:45:42 +0200
Message-ID: <20160725094542.GI7419@lukather>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160721062950.GB5993@lukather>
 <20160721064140.GA17658@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U3s59FfKcByyGl+j"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160721064140.GA17658@dtor-ws>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--U3s59FfKcByyGl+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Wed, Jul 20, 2016 at 11:41:40PM -0700, Dmitry Torokhov wrote:
> On Thu, Jul 21, 2016 at 08:29:50AM +0200, Maxime Ripard wrote:
> > On Wed, Jul 20, 2016 at 10:29:10AM +0200, Quentin Schulz wrote:
> > > +	irq =3D regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> > > +	ret =3D devm_request_any_context_irq(&pdev->dev, irq,
> > > +					   sunxi_gpadc_tp_up_irq_handler, 0,
> > > +					   "tp_up", info);
> > > +	if (ret < 0) {
> > > +		dev_err(&pdev->dev,
> > > +			"could not request TP_UP_PENDING interrupt: %d\n", ret);
> > > +		goto err;
> > > +	}
> >=20
> > You enable the interrupts...
> >=20
> > > +	info->tp_up_irq =3D irq;
> > > +	disable_irq(irq);
> > > +
> > > +	ret =3D input_register_device(input);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "failed to register input device\n");
> > > +		goto err;
> > > +	}
> >=20
> > ... but your driver isn't registered yet. How does input_report and
> > input_sync behave in such a case?
>=20
> This is explicitly allowed:
>=20
> "
> ...
>  * NOTE: input_event() may be safely used right after input device was
>  * allocated with input_allocate_device(), even before it is registered
>  * with input_register_device(), but the event will not reach any of the
>  * input handlers. Such early invocation of input_event() may be used
>  * to 'seed' initial state of a switch or initial position of absolute
>  * axis, etc.
>  */
> "

Good to know. Still, it feels like it should be handled explicitly,
instead of relying on the fact that we only call input_event in our
handler and that it works that way.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--U3s59FfKcByyGl+j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXld/GAAoJEBx+YmzsjxAgoDkQAK/0llggCKpX/rro04nf3efp
fQfNUf1Pf2xs2AR7HDDBs6XySakrVZtUR1hgSRg5+MfM/dMFmG40sQ/m+RX9me0I
B76ksA8pNR/FszHQuphOYWCg2uulvDgjv1dSeYP2uvP1ilCb8fBxt/yFrJGEJ5H1
VoGRQtrr/waet5VOaZCCh4rt+w7jCeIvqGO/Ly+OHWPWRIFUXyVoC/Eu9fOKAGu3
erQ81mTW7WbTp6eL6LMZ846AiYeqMWHjHOyBJhDygsIoJWcMD7SaQSfJKo8LZTAY
+ZZscTHKnfnUqk+eKCBA+Gd+5alk9JlRB2LbeLzGFV9E6Uld3HxptADjt2Yb30A+
A6oYdLvK3k2f+eoRXVMRgxE1DyBajijXmw/YFvj43I4HThwbcOwYXMBkkJWCJsFz
TS0EvFm7494jURoUgE9NXbPTVim5nb58tsAYO2iIoJILVuBGscUbfyXgGQt7XldN
h8XO5+Mui/58NJWjkzwg58D6x9vDFy0lifQqfujl7R5qH0mNWU8ZTS87s5CHnRIZ
wc7DWur8YhS7fgieA2Yqc5osx3R2R+vVdk3SIwLW0JLNJitlWKQKvLjxNoh4q/zo
R+T+KUZ9oLhzf2sMNXdx3QxkZMSjq1D9xmVgM4O+rlOOCrItQIPwzgap9qSKzOm/
I3uwwIWB93aq6S6AVyQK
=RIpj
-----END PGP SIGNATURE-----

--U3s59FfKcByyGl+j--
