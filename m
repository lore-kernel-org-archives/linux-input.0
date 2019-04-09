From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH RESEND v4 3/4] ARM: dts: sunxi: Add R_LRADC
 support for A83T
Date: Tue, 9 Apr 2019 09:43:14 +0200
Message-ID: <20190409074314.zd5yqilq7h4tvlzo@flea>
References: <20190327023339.25975-1-megous@megous.com>
 <20190327023339.25975-4-megous@megous.com>
 <20190408080056.lfzjxfkvs65oabuu@flea>
 <20190408120901.v46rdhqvobr5vuks@core.my.home>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tjctminwmf5gzanx"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBGM2WHSQKGQEYGNU6CQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190408120901.v46rdhqvobr5vuks-9v8tmBix7cb9zxVx7UNMDg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: mark.rutland-5wv7dgnIgG8@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org


--tjctminwmf5gzanx
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 02:09:01PM +0200, Ond=C5=99ej Jirman wrote:
> Hello Maxime,
>
> On Mon, Apr 08, 2019 at 10:00:56AM +0200, Maxime Ripard wrote:
> > On Wed, Mar 27, 2019 at 03:33:38AM +0100, megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org wrote:
> > > From: Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > >
> > > Allwinner A83T SoC has a low res adc like the one in Allwinner A10 So=
C.
> > > Now the driver has been modified to support it.
> > >
> > > Add support for it.
> > >
> > > Signed-off-by: Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > It's missing your SoB.
>
> Signed-off-by: Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
>
> Please add it when aplying he patch.

Done, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--tjctminwmf5gzanx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKxNEgAKCRDj7w1vZxhR
xS28AQDOEtO1YFUToVj+PAMD2kE/9JgzxyN3fAy+eJHAl59w7AEAtn2BCB9n11YT
W0a1aY30aL9aqoH+fU8xS2oxS0Ypzg4=
=DGSP
-----END PGP SIGNATURE-----

--tjctminwmf5gzanx--
