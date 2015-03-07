From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v7 4/5] Input: add haptic drvier on max77843
Date: Sat, 7 Mar 2015 21:21:02 +0100
Message-ID: <20150307202102.GH5233@earth>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-5-git-send-email-jaewon02.kim@samsung.com>
 <20150302173223.GA17094@dtor-ws>
 <54F50FE5.3060605@samsung.com>
 <20150304224742.GA38298@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150304224742.GA38298@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Beomho Seo <beomho.seo@samsung.com>
List-Id: linux-input@vger.kernel.org


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 04, 2015 at 02:47:42PM -0800, Dmitry Torokhov wrote:
> [...]
> > >Do you want it to go through my or MFD tree?
> > Other drivers merged in each maintainers git.

Actually only Lee took PATCH 1 so far.

> > If you don`t hava a problem, please merge your input git tree.
>=20
> Applied, thank you.

Patches 2-4 depend on linux/mfd/max77843-private.h from Patch 1,
so taking them independently will introduce build problems.

> [...]
> > >>+++ b/drivers/input/misc/max77843-haptic.c
> > >>[...]
> > >>+#include <linux/mfd/max77843-private.h>
> > >>[...]

-- Sebastian

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU+12uAAoJENju1/PIO/qaWYgP/1ntTuxcz6WR9ZejqhmBwxTh
5HOvZzRYXgyX3s46ttkgrki77eDT1dibyJxij1iah/NQlk+NjwFQU/BUMbNLsu8M
WvSonG5y8yk+AsVsKJYPhhuAsKZ8tZ+xmR33J1ETDLdUViHw/umuqvqxp0d11EsL
gGmjkKsrVdk1DGMMtMN0rCUZJpwIgMcHLl4/ubB/hqX1bh4a43VIW3cPYMaTQd/E
jtv0RUN0qJ1GyXpAWfrKdm7rtAnvN5nGynu2E4MLJmgp5ftogSbFoBAZBQtM+mBb
jd3myFVujQHFl2fz5oDsdJMxmSDG3nl5wd7s1FVUnGjREJGBGNUVznI/d+k6LTtC
TY9oh2Rb07jXejifpF11eLAyzYxOvBH9zaZKQGl+z+O5HfghdB8B8fAlq/zald5E
GPMu8KzE9Sw5LiDAGNNEYf/xC5LAMaSbrzx3ppg8iNY8NTa/Itn49L/UpQd/z34l
BfKNDMoaHY5vEM6FKZdtqgL1Y8I0LsAyqw0Dt+B3OEKuDtBWkE6ajEyFTAl977Kq
tFpPYxUfWJJSB/Lj7UhHUizsg7Pe+Rh1ZtpPb2ZLguNRHaZ6tfq7OpiuXnt7qZXU
CEsFIUi+EqpD92a24slTa+VTyc/GcfZjZauHyIw6Nwhf+kNhLyycM0pd4058cBcZ
R2vba3Vaodf/sdRtVG/u
=Mqa+
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
