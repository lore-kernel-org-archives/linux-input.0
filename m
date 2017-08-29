From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [GIT PULL] Immutable branch between MFD and HWMON due for the
 v4.14 merge window
Date: Tue, 29 Aug 2017 16:19:13 +0200
Message-ID: <20170829141913.ieujukwf4xxed3ez@earth>
References: <20170821145404.18902-1-sebastian.reichel@collabora.co.uk>
 <20170822074741.jjynyudbfgzsl7ju@dell>
 <20170829125113.g74twfnahomtdr2x@earth>
 <a61ad063-07a2-c24c-45b8-c3bdfe630a0c@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f2pl5gxxjo7ah37z"
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a61ad063-07a2-c24c-45b8-c3bdfe630a0c@roeck-us.net>
Sender: linux-hwmon-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lee Jones <lee.jones@linaro.org>, Support Opensource <support.opensource@diasemi.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--f2pl5gxxjo7ah37z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Tue, Aug 29, 2017 at 06:34:39AM -0700, Guenter Roeck wrote:
> On 08/29/2017 05:51 AM, Sebastian Reichel wrote:
> > Hi Lee,
> >=20
> > I noticed, that you did not yet push out your for-mfd-next branch,
> > so the patches did not yet appear in linux-next. Was this
> > intentional?
> >=20
> The immutable branch referenced below doesn't exist either.

The immutable branch looks ok for me:

https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=3Dib-mfd=
-hwmon-v4.14

> Guenter
>=20
> > -- Sebastian
> >=20
> > On Tue, Aug 22, 2017 at 08:47:41AM +0100, Lee Jones wrote:
> > > Enjoy!
> > >=20
> > > The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bb=
a20877:
> > >=20
> > >    Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
> > >=20
> > > are available in the git repository at:
> > >=20
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-h=
wmon-v4.14
> > >=20
> > > for you to fetch changes up to 4f16cab19a3d57638dd5d962ff6e87c154a6ca=
b2:
> > >=20
> > >    hwmon: da9052: Add support for TSI channel (2017-08-22 08:45:02 +0=
100)
> > >=20
> > > ----------------------------------------------------------------
> > > Immutable branch between MFD and HWMON due for the v4.14 merge window
> > >=20
> > > ----------------------------------------------------------------
> > > Sebastian Reichel (4):
> > >        mfd: da9052: Add register details for TSI
> > >        hwmon: da9052: Replace S_IRUGO with 0444
> > >        mfd: da9052: Make touchscreen registration optional
> > >        hwmon: da9052: Add support for TSI channel
> > >=20
> > >   drivers/hwmon/da9052-hwmon.c      | 285 +++++++++++++++++++++++++++=
++++++++---
> > >   drivers/mfd/da9052-core.c         |  26 +++-
> > >   include/linux/mfd/da9052/da9052.h |   6 +
> > >   include/linux/mfd/da9052/reg.h    |  11 +-
> > >   4 files changed, 302 insertions(+), 26 deletions(-)
> > > --=20
> > > Lee Jones
> > > Linaro STMicroelectronics Landing Team Lead
> > > Linaro.org =E2=94=82 Open source software for ARM SoCs
> > > Follow Linaro: Facebook | Twitter | Blog
>=20

--f2pl5gxxjo7ah37z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmld98ACgkQ2O7X88g7
+prsiA//SxVMCTss5Z5/F7cMOJviDNpepvVqu0K+lL5N0B3AtpoWeIRdnL2w91+f
VCO1AD7Y9xqiY/IBuxoFMVssOxXw0DWlIVvu4PRglxjDttFGFozXVuUdkLEO8emQ
fxJ/iw0X9MrkQb7oak1ShO0IxOWT7q+JDb7ExdOCCqVe0E2POQYJvvqiGmO718k/
yfWZMkZcTVnxXsjGrOyT1vTIwSRtTOI8e0DVu1xvxch9WUTStOMBHy2qjGdobWlH
jVNvtXmJWdFFntkD0Azr2CXCbVzAcM7lKnO+56Jz/pkPv1NUhV7pniWjYVcHx/Mx
ZT9HIyBv4ETywDWZXbI3lp9RbFl4gKeSdWb1DIgJVndvf+5dcRsvzBYjIIeP+GSP
zDqlpumiQyTuPBIjXXE8nmt9QizYdXQ4hUSCKBbYXBrwc+CqdE9TH0IRfsUGkvsC
rQo+dc0NINmqgNMKH9LND+2/QG081A+eVAswglpE8k5kiUlkxempGSKiizFzgBS/
Y2zqGemYK+WW9j3SQt61Z2wNmZWLndfEGfeeFIfD8FcT4GcgoGFL3rhWn94YXRUx
+fE/uq+NxFcVZTQTLkOkRTWFX81S4z/qtpS8NqBucWMQMNyXm7bQ72KVuzdMhgiH
7jBwvfLXdCsZCgY46j84tFh8I/Tyn3UbqQFXfoZF8n/4S1w1Zvc=
=2uB7
-----END PGP SIGNATURE-----

--f2pl5gxxjo7ah37z--
