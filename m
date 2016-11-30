From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 5/5] Input: arizona-haptics - Use SoC component pin
 control functions
Date: Wed, 30 Nov 2016 17:28:23 +0000
Message-ID: <20161130172823.ihmk6jaw2khtyzek@sirena.org.uk>
References: <1480434282-26389-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1480434282-26389-6-git-send-email-rf@opensource.wolfsonmicro.com>
 <20161130014135.GE20680@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrpi5xya2wwh3t34"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35118 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758439AbcK3R3C (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Nov 2016 12:29:02 -0500
Content-Disposition: inline
In-Reply-To: <20161130014135.GE20680@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, myungjoo.ham@samsung.com, linux-input@vger.kernel.org


--lrpi5xya2wwh3t34
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 29, 2016 at 05:41:35PM -0800, Dmitry Torokhov wrote:
> On Tue, Nov 29, 2016 at 03:44:42PM +0000, Richard Fitzgerald wrote:

> > Switch to using the snd_soc_component_x_pin equivalent functions that
> > take a specified SoC component and automatically add the name prefix to
> > the provided pin name.

> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Do you want me to apply this or do you want to apply it in your tree?
I've created a tag:

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-dapm-pin-component

for you to fetch changes up to 1b4d9c22191583ef1fb7433417b2ceb2a608d887:

  ASoC: core: Add component pin control functions (2016-11-30 17:16:09 +0000)

----------------------------------------------------------------
ASoC: Pin enable controls for components

Provide an interface for devices to manipulate their own pins in DAPM
without being affected by the renaming facilities provided by ASoC for
machine drivers.

----------------------------------------------------------------
Richard Fitzgerald (1):
      ASoC: core: Add component pin control functions

 include/sound/soc.h   |  20 +++++
 sound/soc/soc-utils.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 219 insertions(+)

--lrpi5xya2wwh3t34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYPww2AAoJECTWi3JdVIfQTdUH/16awUP++IlpDu5sCdHTc4Qi
6IOpy1c7UmU2NXdi9rRGahIrARSAlSJdC5w6BUligJaKLyOmeOSDYUOokrDsAGEY
QyXvaknK1csWNCqyrXrKbcELwZeDaYifvlesAvELHKIvp6AAbuQ7fmNUa4TYQDSG
sk4Ny4ljDxlLo7N5aFoPeA4VqxS7pZf2xQfaimLqMTjsCOsV8hQ6JAOL2a3uZ2fp
ahAc4os7+m1pwBQoSSWoZcF14MI/Wmts8eLalv/yPMvDZ2nuZDBNGAVUsdXAUvFx
Wr/AuE5m97R+pDnbZMWlV5ZfFu/pyYAZoj9xRGRS1fJuCrIuBWaL9L1Y8vkrSiE=
=lbmb
-----END PGP SIGNATURE-----

--lrpi5xya2wwh3t34--
