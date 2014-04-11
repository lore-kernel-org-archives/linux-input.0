From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Fri, 11 Apr 2014 17:18:13 +0100
Message-ID: <20140411161813.GF28800@sirena.org.uk>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140411122901.GE28800@sirena.org.uk>
 <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBB4VLUCNAKGQEEVY4RJA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--aZoGpuMECXJckB41
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2014 at 03:04:32PM +0200, Carlo Caione wrote:
> On Fri, Apr 11, 2014 at 2:29 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> >> +                             regulators {
> >> +                                     compatible = "x-powers,axp20x-reg";

> > This compatible isn't part of the driver.

> Yes I know. The problem here is that in v4 I had to fill in the field
> .of_compatible of the mfd_cell with "x-powers,axp20x-reg". This
> because the regulator_dev_lookup() checks for dev->of_node when
> looking for the supply so I needed the compatible string in the DT to
> have the dev->of_node filled in by mfd_add_device().
> What do you suggest? Modify the regulator driver?

You're looking for regulator_bulk_register_supply_alias() in the MFD
driver (via parent_supplies in the MFD cell probably).

--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTSBXCAAoJELSic+t+oim9z3IP/39nshXt+p3gX9hjp78V4FYB
xmky6PjRARPFEhqxG5xfbowi3OhP1ur4XdvdzAhyjsZM/Ydb5O/l7cUQ8VTCMcTB
vfZKGdQ1sb9y5NzLVtsi54Kt8zGBL3sCsV8tDSmV2VmLalMDnZezfImK+Sit8klR
flVGTviRT1xrSrqCHsDww2IjtaSgy57M8ML/eCDlNZpECeevsMzmhermMCNNpm9Z
g1EsZjYJviZaT/C+VS3ApC9yx9aXNZ1/LSB1LOct7Q2ACf2xHMgL7RY5Wd/N2Juf
gl9bMRCENYpnR2TepuyadO50XldhRqEroyhftO1XxwKQuLBM9nDervbpnAQAidUo
H/d1r2+EOZHdFc/Y+VurPQHuBKNsxvXlgeAW5bmpHCh2SLqa4EPaj7wsovpA3iEs
b+GAENE84t3Gw9mKEnsM1GKBhJKXJwGlwRmU+txkuwgkTlNvI97FvXJrzg8E1uWb
VaUmnCrQyN25a5ImKRke2adAlKFbumN7avUnsHUIQF45iOSeALbWzAt2rroJE6zs
DXVF0tBpZx4ubh0cpYpfWhbuYMC1oiKWPpbnhhEKMxZq3OnwBXXOPrlrJCIltJcl
czQlNpWMoPxodCie68M/tBNMjkaDvfwi9OWd4Ej0BSrUyK296m1I/2uu4LutWabp
n0eD5xQCeaYaGp7M+zlx
=Lzol
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--
