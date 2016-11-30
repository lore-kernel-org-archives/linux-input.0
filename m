From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 4/5] extcon: arizona: Use SoC component pin control
 functions
Date: Wed, 30 Nov 2016 17:27:53 +0000
Message-ID: <20161130172753.rua3vb4nly42imxh@sirena.org.uk>
References: <1480434282-26389-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <CGME20161129154455epcas3p2f983a463ce7e9de35e78cb8625dcb200@epcas3p2.samsung.com>
 <1480434282-26389-5-git-send-email-rf@opensource.wolfsonmicro.com>
 <583E1B02.4040000@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wtochakwmh253x7y"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35096 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758281AbcK3R3C (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Nov 2016 12:29:02 -0500
Content-Disposition: inline
In-Reply-To: <583E1B02.4040000@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org


--wtochakwmh253x7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2016 at 09:19:14AM +0900, Chanwoo Choi wrote:

> But, the patch4 is dependent on patch1.
> After finished the review of patch1,
> I'll add acekd-by tag.=20

Or you can just pull in that patch, whichever is easiest - I've created
a tag:

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-dapm-pin-component

for you to fetch changes up to 1b4d9c22191583ef1fb7433417b2ceb2a608d887:

  ASoC: core: Add component pin control functions (2016-11-30 17:16:09 +000=
0)

----------------------------------------------------------------
ASoC: Pin enable controls for components

Provide an interface for devices to manipulate their own pins in DAPM
without being affected by the renaming facilities provided by ASoC for
machine drivers.

----------------------------------------------------------------
Richard Fitzgerald (1):
      ASoC: core: Add component pin control functions

 include/sound/soc.h   |  20 +++++
 sound/soc/soc-utils.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 219 insertions(+)

--wtochakwmh253x7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYPwwYAAoJECTWi3JdVIfQsOMH/iJk1YyTUeYaTWV6DrfvRFFU
qlCeySAbxqvFgRbJayuqERx9HwQYTCFiICbnTy3NdfoCwkQ9vi/A5bPXDd1vg5pD
ej2q+yuMViWdnNpmuR2Lua6p+7uljLyziAsYBW+RErkzifDvQFSreoX+klPGt9FV
+zYbrEFSYZd4WEj4OeHGxLg53QY8OoItutQ+hpkejm8Ajg/afLwK6io98do9Qw6X
AXyUCLwQX3xQ5FT+Kjo2XWw2wGk69N0dfeAjQWxmmP4JIGf0ATgHCX3QEfH+6WSl
s1T9vNDcbkCcP0Lb0yDlHK/+6PP0oZPNq+mSTRJeOkr2DSdO/srABnQxskznzqk=
=W+Zb
-----END PGP SIGNATURE-----

--wtochakwmh253x7y--
