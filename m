From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 2/8] mfd: wm97xx-core: core support for wm97xx Codec
Date: Tue, 19 Sep 2017 13:15:39 +0100
Message-ID: <20170919121539.mz2mettkefxf3oer@sirena.co.uk>
References: <20170913193723.16234-1-robert.jarzmik@free.fr>
 <20170913193723.16234-3-robert.jarzmik@free.fr>
 <20170914074146.dnibkvom4yuzejf3@dell>
 <20170914074300.iobuwn2hrmnf6sen@dell>
 <20170914160453.gys3imt4eobckcrq@sirena.org.uk>
 <20170918085236.z6gmgrwvsjvvc4cd@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ykdp4fmwxqckai3n"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60560 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbdISMQ3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Sep 2017 08:16:29 -0400
Content-Disposition: inline
In-Reply-To: <20170918085236.z6gmgrwvsjvvc4cd@dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org


--ykdp4fmwxqckai3n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 18, 2017 at 09:52:36AM +0100, Lee Jones wrote:
> On Thu, 14 Sep 2017, Mark Brown wrote:

> > On Thu, Sep 14, 2017 at 08:43:00AM +0100, Lee Jones wrote:

> > > Change of plan.  It looks like there are deps.

> > > Unapplied.

> > The core stuff went in during the merge window, you should be able to
> > wait for -rc1 or pick up the asoc-v4.14 tag.

> No, I mean patches; 3, 4, 5 and 7 depend on this file.

Right, but I'd have expected a pull request more than the patch being
unapplied?

--ykdp4fmwxqckai3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnBCmoACgkQJNaLcl1U
h9C1YAf/UybwXnI2Dxl5dzHNIwJo65OrgYDeL1+YhUhvyuy7v4hrAvgmmdRUQZ/l
HXIQhN2p+wSJI45Rw2GE2tpHcbJvv1eDsffM5E24WBwFd0Qwv9sriwCyMEdT13iM
QbTW0aAUlvuVHaERGJPRGCgwfrIosD2ziQqaDMRPjQTcr/gfJIC2OB7Lq8xv0tF9
5ys7BE0StzFbEqgVjbpnZR+nz9/4k/3Aw8enB44OFNXm+T2TAWnNzPX6zEKrn2H0
Oa4HF/MOJGkb6RTqK0R9y+gxz7xPkSliYgx2hCbdmJpZV7YmY9xMosUmYjfiY8el
GYAkGm5dWfSQCOG++oUFzMkn7nF0Ew==
=yP6q
-----END PGP SIGNATURE-----

--ykdp4fmwxqckai3n--
