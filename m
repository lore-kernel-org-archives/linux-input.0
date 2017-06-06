From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator
 driver
Date: Tue, 6 Jun 2017 20:02:31 +0100
Message-ID: <20170606190231.abhgfavfg6cvmkfy@sirena.org.uk>
References: <cover.1495546845.git.stwiss.opensource@diasemi.com>
 <ac0c9c0edf9a3a48d8de7a5c07b16b771871796e.1495546845.git.stwiss.opensource@diasemi.com>
 <20170523171721.lpqjhakaawnz4prz@sirena.org.uk>
 <20170524083243.5rhritb2tvmycfc6@dell>
 <20170524101057.v2fqwki4fopx5k7y@sirena.org.uk>
 <20170530091759.tkajnmlyel6h3djw@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qdheveixqstjem2l"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170530091759.tkajnmlyel6h3djw@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--qdheveixqstjem2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2017 at 10:17:59AM +0100, Lee Jones wrote:
> On Wed, 24 May 2017, Mark Brown wrote:

> > On Wed, May 24, 2017 at 09:32:43AM +0100, Lee Jones wrote:

> > > Plan is to push this through the MFD tree.

> > Great, thanks.

> Just taking a look at this now.  It looks like the dependency:

>   656211b1dfb9 mfd: Add support for DA9061

> ... is now in Mainline.  Therefore it should be okay to take this
> directly through the Regulator repo.

OK, can you resend please Steve?

--qdheveixqstjem2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk2/EYACgkQJNaLcl1U
h9A03Af/Roh0PLgP0x8PVW2nb/wQPKt46BrQkVeMMZpI1ZkTynNtL2cnXC6+tUi2
hkGqWxM6inmjOlIlCjTJSsNBt7qORcJfZHy8x381n2nGowpirNJ7W6EaIJpXAkCI
rXMnYbRo4Wqi+UDbKKS/d6QBMZTLBCKyMKXcEaOznNNLFDTHY6hq7AuVwJn7zAMt
6DMWCi23nwY1NVl6Z6kym5eEn6x4Ye4OT7zHjjm0xRfMKW4HBVgIDbCK2RYephYj
tKcmEmWQ7FEmw+jAEzyg+4B2nG3/vokmBgsNDuX6HLmfq3kvn/UL2KossPCti8Sv
iuUFsKSCjCmGSbu3qBt6fk7ZzA+3JQ==
=09LB
-----END PGP SIGNATURE-----

--qdheveixqstjem2l--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
