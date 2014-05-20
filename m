From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 0/7] mfd: AXP20x: Add support for AXP202
 and AXP209
Date: Tue, 20 May 2014 23:23:07 +0100
Message-ID: <20140520222307.GK12304@sirena.org.uk>
References: <1400528868-5971-1-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fq8WU8gPn+p6mCab"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBYNL56NQKGQEYTTAV2Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1400528868-5971-1-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--fq8WU8gPn+p6mCab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2014 at 09:47:41PM +0200, Carlo Caione wrote:

> This set of patches introduces the core driver and support for two different
> subsystems:
> 	- Regulators

>  .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
>  Documentation/devicetree/bindings/mfd/axp20x.txt   |  93 +++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/configs/multi_v7_defconfig                |   3 +
>  arch/arm/configs/sunxi_defconfig                   |   4 +
>  drivers/input/misc/Kconfig                         |  11 +
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/axp20x-pek.c                    | 281 +++++++++++++++++++++
>  drivers/mfd/Kconfig                                |  12 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/axp20x.c                               | 258 +++++++++++++++++++
>  include/linux/mfd/axp20x.h                         | 180 +++++++++++++
>  12 files changed, 856 insertions(+)

The regulator changes don't appear to be showing up in the diffstat or
obviously in the series?

--fq8WU8gPn+p6mCab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe9XIAAoJELSic+t+oim98AUP/jhi3uvP5Dyqacdq+ba0bpgo
F6fX6WVE2jFtVUgI1IlFy3vRRyl3QzEnJtRIrp8ONcy10F8imEOSPugDW66Fnx6r
2wfTAZrtfPbyjGcLF6nSjOkDFsyJZdGAk0T824z7CSD38C6E2pa7IeSsLQmOSkZi
p0OqghEJuWjrkSvanyeRi5JcwOPnOWyWw3qss143L016lo+iubuZRHBfQDtGknaO
gp2/cpNi78O2+eShC9CpHA+geNbo/eO1oJ4AFIa2Jk7C0xWB4xB99RgCENFdCkAk
OZkgz1zVzYgz/h5A4HXKvYCl7lgeaM6wUVY4gKEKRXdwCw0ELe/rXp8c/zD/eg5t
UPTu7b0ibCzY9RtracOe/JTOmpUv3+fuDcU4kWB0kkVgfWgmbh5s6yAtTJWArK47
OKimiaoYJfqB76Nfa+FH7sliNMea2SmNsjUDZ26OLD9fMd3Sgja0q0Nfiwf5eBA5
xf87kXvQUFHIFT3xkWbCI55BB8wBUAt10uTI9w1dOqLpofxj46CMSeItdN4msCw4
KHOXyDIOPlQ5u4Jw9NWQvkpqh/4qWR/VgPsMCDQy94uoOsm3KpRB6lERja3DTGO4
U3RwN3pp9eRY8WDo3uSc/rl2U5snHSSzJmxpCYjrkZlvLmcDagNZ9WOzeZ0xWwam
6oDGGznhA73OpSMhnBal
=fhLr
-----END PGP SIGNATURE-----

--fq8WU8gPn+p6mCab--
