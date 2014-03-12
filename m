From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH 6/7] regulator: AXP20x: Add support for
 regulators subsystem
Date: Wed, 12 Mar 2014 00:38:58 +0000
Message-ID: <20140312003858.GG28112@sirena.org.uk>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
 <20140303015616.GN2411@sirena.org.uk>
 <20140311192411.GA4193@localhost.fastwebnet.it>
 <20140311192940.GA28112@sirena.org.uk>
 <20140311210659.GA10961@localhost.fastwebnet.it>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I7/wf4ZduhLeleqy"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBOWZ72MAKGQEPTDII4I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140311210659.GA10961-bi+AKbBUZKZeIdyRz4JgOMwOAu8XWILU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--I7/wf4ZduhLeleqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2014 at 10:06:59PM +0100, Carlo Caione wrote:
> On Tue, Mar 11, 2014 at 07:29:40PM +0000, Mark Brown wrote:

> > With the above code the driver will return an error and never get as far
> > as registering the regulator.

> I agree, but if I register the regulators without having the constrains
> defined in the DT, when regulator_init_complete() is
> called, the regulators are disabled powering off the SoC (at least for
> DCDC2 and DCDC3).

Right, but the kernel will say what it's doing before it does so and
then the user can provide the appropriate setup in DT to force things
on.

--I7/wf4ZduhLeleqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTH6yfAAoJELSic+t+oim9bGwP/RcWsZ+pynOuj8i5kn+PX705
HD4gPawCItAK9jqWewKqsuNbGIvo8DEfptcQzJ1Hf3J4s4s/Q+7NCepf4/5TkI1G
wCTp68y2d4nKLlQp7MA1TLS8npxH+Ki7um5OGaiN53BeuoWhpomFsaZDZGMe3/7P
PUHt3rC1WJ2JrSNJ1AiKRcraog3pUYO6TgiSzXa0tqomdvG8L2+tLkJk3gKL0nfj
+xfCLxyHW1tM3vCAXV3BY0XbdBpU1RquavI6NbV8R8h8SSL9d7PHIdrxOuYfIt1v
UH/WshUwAxkcRkztvLw1hg2UpjAAy89QIdhGySKhvX6+1sXRPKR5JzxNckpiRAYD
XqQdXMi8tvZ4OpLMWuoZIJ+tItIzL5TnKAffWaFQ5po8B347lNRmTrwe+czEa+VC
MoOKK17rmHlQvycJIQTxb9C8sYRVUOIKO5gYyiW/W4KlhpghyT/7f83saldqAElH
mas2neQwrNcr7GGCuizRRSLePBW6jLeUkQtqMgEHvzFHXOnvAIDvEZ69wPGNEGic
SBkqZ84OT31+htKFDtx6OgZz9wNlME/hUNNBt3Q6qXBzDGpFujkp3u517gBDFd8W
T9CFq57XXEOLmrV4ffBi9hRgHl6HvKEDjw1MnVfLi+lSSeuvtFpFI4SLg0DYQz5g
ey6KYrxeUvyHpPLuYmqx
=eukY
-----END PGP SIGNATURE-----

--I7/wf4ZduhLeleqy--
