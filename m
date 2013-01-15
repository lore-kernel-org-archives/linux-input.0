From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 2/4] input: keyboard: tegra: use devm_* for resource
 allocation
Date: Tue, 15 Jan 2013 13:32:48 +0100
Message-ID: <20130115123248.GB2625@pengutronix.de>
References: <1357371910-3164-1-git-send-email-ldewangan@nvidia.com>
 <20130114161644.GC14721@kroah.com>
 <20130114221551.GA30020@avionic-0098.adnet.avionic-design.de>
 <201301142224.11243.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201301142224.11243.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 10:24:11PM +0000, Arnd Bergmann wrote:
> On Monday 14 January 2013, Thierry Reding wrote:
> > It certainly sounds like a less complicated way to do it. But it also
> > involves adding a function with a made up name and drop a function with
> > a perfectly good name instead. I wouldn't even know what name to choose
> > for the new API.
> >=20
>=20
> How about devm_ioremap_resource()? Sounds equally fitting, and is shorter.

2 cents, I wrote back then:

* the new function is not named 'devm_ioremap_resource' because it does mor=
e than
  just ioremap, namely request_mem_region. I didn't want to create implicit
  knowledge here.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlD1THAACgkQD27XaX1/VRsbUQCeO3T9fGRUTenwPGNdf2Wfow+S
2yQAnjkdp45Tk8czgujiurdGGiEEMDvr
=LQve
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
