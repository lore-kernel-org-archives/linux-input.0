From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 2/8] mfd: wm97xx-core: core support for wm97xx Codec
Date: Tue, 19 Sep 2017 17:08:56 +0100
Message-ID: <20170919160856.756pwipflx4jt42y@sirena.co.uk>
References: <20170913193723.16234-1-robert.jarzmik@free.fr>
 <20170913193723.16234-3-robert.jarzmik@free.fr>
 <20170914074146.dnibkvom4yuzejf3@dell>
 <20170914074300.iobuwn2hrmnf6sen@dell>
 <20170914160453.gys3imt4eobckcrq@sirena.org.uk>
 <20170918085236.z6gmgrwvsjvvc4cd@dell>
 <20170919121539.mz2mettkefxf3oer@sirena.co.uk>
 <20170919152253.tvj3hheggrx4lgig@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a7bdzbmda6laqtbi"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57062 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdISQJe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Sep 2017 12:09:34 -0400
Content-Disposition: inline
In-Reply-To: <20170919152253.tvj3hheggrx4lgig@dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org


--a7bdzbmda6laqtbi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 19, 2017 at 04:22:53PM +0100, Lee Jones wrote:

> However, since this is a new driver, you can just take it with my:

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/wm97xx-mfd

for you to fetch changes up to ae9d1b5fbd7b7ee1c2d2f62a7cee3c0455e06f94:

  Input: wm97xx: add new AC97 bus support (2017-09-19 17:07:28 +0100)

----------------------------------------------------------------
mfd/Input: Changes for the new wm97xx MFD

The newly added proper driver model support for ac97 means we can now
have a real MFD for the wm97xx devices rather than the hacks that have
been used.  Since they're mainly audio devices they're going via ASoC,
these are the other changes for cross tree merging.

----------------------------------------------------------------
Robert Jarzmik (3):
      Input: wm97xx: split out touchscreen registering
      mfd: wm97xx-core: core support for wm97xx Codec
      Input: wm97xx: add new AC97 bus support

 drivers/input/touchscreen/Kconfig       |   2 +-
 drivers/input/touchscreen/wm97xx-core.c | 252 +++++++++++++++-------
 drivers/mfd/Kconfig                     |  14 ++
 drivers/mfd/Makefile                    |   1 +
 drivers/mfd/wm97xx-core.c               | 366 ++++++++++++++++++++++++++++++++
 include/linux/mfd/wm97xx.h              |  25 +++
 6 files changed, 577 insertions(+), 83 deletions(-)
 create mode 100644 drivers/mfd/wm97xx-core.c
 create mode 100644 include/linux/mfd/wm97xx.h

--a7bdzbmda6laqtbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnBQRcACgkQJNaLcl1U
h9DKNQf5AY04xI4UhK+PTMKgueqp9P1iiWNnPoRc+jgXWo6afxRg5A2gOh4nyJm2
miRAjNbgmWNO8+TizS8dtPgH3ZlzuMzHD7m1WBYAyKjozqxKBRh1AG1JghJ4jetC
lWHuyaxDCjUx/4PMYRIOf5n9zw/ORTS7gac2Tpl7PsVCU7yy3jXysPiT0jlAA9xI
PcX1bkFXTh/pZWgX+VPkWRtN9YekxArvwnKCZ640XWHFnq4wbLSKqlzBfZ0lyH8D
gyqha1+UGt93jQYv1IxhqDALleZL2dNosNmcx6G80W+ufuncNFK/JsYgn4TtIQDz
u6/Ipd5yxN+gQse5RyudJ7+HpksNUw==
=mhyV
-----END PGP SIGNATURE-----

--a7bdzbmda6laqtbi--
