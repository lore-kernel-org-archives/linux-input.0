From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 2/2] Input: pm8941-pwrkey: Introduce reboot mode support
Date: Thu, 15 Jun 2017 18:26:57 +0200
Message-ID: <20170615162657.dgjsriesdzlqwzux@earth>
References: <20170527065130.3456-1-bjorn.andersson@linaro.org>
 <20170527065130.3456-2-bjorn.andersson@linaro.org>
 <20170530025324.GD32841@dtor-ws>
 <20170530044711.GP12920@tuxbook>
 <20170608163243.j4dfpa6swoz27ofd@earth>
 <20170612233203.GT12920@tuxbook>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dfpgadujqsipv3o2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170612233203.GT12920@tuxbook>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--dfpgadujqsipv3o2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 12, 2017 at 04:32:03PM -0700, Bjorn Andersson wrote:
> On Thu 08 Jun 09:32 PDT 2017, Sebastian Reichel wrote:
>=20
> > Hi,
> >=20
> > On Mon, May 29, 2017 at 09:47:11PM -0700, Bjorn Andersson wrote:
> > > On Mon 29 May 19:53 PDT 2017, Dmitry Torokhov wrote:
> > >=20
> > > > On Fri, May 26, 2017 at 11:51:30PM -0700, Bjorn Andersson wrote:
> > > > > In some Qualcomm platforms the magic for informing LK which mode =
to
> > > > > reboot into is stored in the PON_SOFT_RB_SPARE register. Register=
 with
> > > > > the reboot mode helpers to expose this to the user.
> > > >=20
> > > > Hmm, is the power key driver the best place to have this? WHy isn't=
 this
> > > > a driver in its own right?
> > > >=20
> > >=20
> > > The functionality is part of the "PON" block in the Qualcomm PMICs,
> > > other functionality from this block relates to configuration and
> > > handling related to power-key and reset-key.
> > >=20
> > > Several of these properties are intermingled, so I do believe it's be=
st
> > > to handle them in a single driver; that said, it might no longer be
> > > correct to name the driver "pwrkey" or that it is a "misc input" driv=
er.
> >=20
> > I merged patch 1 and provided an immutable branch, so
> > that this could go through the input subsystem.
> >=20
>=20
> Thanks
>=20
> > To me it doesn't look that intermingled, though. I think
> > the reboot and reboot-mode parts could go into their own
> > driver in drivers/power/reset.
> >=20
>=20
> I did reach out to Rob regarding this and the single hardware block
> should be described by a single node in DeviceTree.
>=20
> As such if we split the non-input related handling into another driver
> we would need to make the input driver create a subdevice during probe -
> or create a new pon-driver with a new compatible that internally spawns
> the pwrkey driver. Neither seems desirable to me...

The pon-driver would have been the proper solution, but with the
binding already being defined that's no longer a nice option :(

> The features of the PON block not yet shown on LKML are status registers
> to indicate the reason for powering up the PMIC and a watchdog (which I
> don't believe is used or exposed today).

So we have a block, which has watchdog, powerdown, reboot, boot-reason,
reboot-mode and power key. To me that does not look like it should be
one driver.

-- Sebastian

--dfpgadujqsipv3o2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllCtU4ACgkQ2O7X88g7
+po9LBAApPph4fv1HqwrniB4snq+4+2PRBOBO1jSLN68aVxp7F5UDACkYmFHKfiW
MaMiWTp2Z/caA1zrPdPiF/EcWiXa+9p5UxMaSDR914sC0AIaVet6YKaFWmMuiuC8
ImlzSXXSJVJFgg0fo5/eZXbLINq92qzhKr1x9noQXFtdrpmxb8re/ebD5TnDpFWn
ElNqg4rfiZhWaQxC30QDM0OJlaPfjAyJ+HXmr+cq2JmyYNvkVWXoTVwgCELuDy65
NcllWnAskiPM1V/BjWos+KJvTVkQF5bGGIHQtGbIOy8RoANnylkysoo1WAHXvO1j
RIc9GBbfIOKsZBannADsGUIPxqkzQR5C2xGQJjFRJDZjDujEOJD2b0UGULD4T6w9
popvdysVwncsd+US6cRduwGGh5CPMR/gYE78QmYNUcHxR9YsLOSIOt6GDKhBLOWm
rsmCn4YZRuVJo5wabEMyraHRjY55ty0rKsTDal05G3217AgxZNic1mD9rAxQmf4C
n0xbdOSFSBeF/wSmZj+5I5+5d+uFVAmjyRe2FQAGX58/ZANlKOw9XwbYBGbLmgpR
BKHIuNwI4JJEs6bQMce8+ZzUM8cgk2GPLf/a/8c4QyJikC/+yHQe4CrX3tyeVOPy
9V0aOnT4ojDAvS9Du1VL3o/Bt74Dybz4Y87O9WFG4BkPz4XAsZU=
=dfUz
-----END PGP SIGNATURE-----

--dfpgadujqsipv3o2--
