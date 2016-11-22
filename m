From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 2/9] ALSA: ac97: add an ac97 bus
Date: Tue, 22 Nov 2016 18:08:17 +0000
Message-ID: <20161122180817.2gqkjal76smnyp63@sirena.org.uk>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-3-git-send-email-robert.jarzmik@free.fr>
 <d57cdfba-da22-652d-3d75-6d1b754cf1d5@metafoo.de>
 <87eg2ly8k6.fsf@belgarion.home>
 <5ae15e01-eaaf-4996-27ec-1179041c0268@metafoo.de>
 <87mvh8uywm.fsf@belgarion.home>
 <6b97a129-bd10-b9be-616d-a3ea3b91b103@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7wx2z723wtuxaqym"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6b97a129-bd10-b9be-616d-a3ea3b91b103@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org


--7wx2z723wtuxaqym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 10, 2016 at 12:38:40PM +0100, Lars-Peter Clausen wrote:
> On 11/09/2016 10:27 PM, Robert Jarzmik wrote:

> > here, ie. that the rescan is a bug, or if it's more an "Occam's razor"
> > discussion ?

> Maybe we can just leave the rescanning out for now and think about how to
> best handle it when the need arises.

Yes, I think that's best - I suspect it'd be something that'd need to be
triggered by a driver for an AC'97 CODEC doing power management but I
imagine that if we were going to have such a system we'd have run into
it already anyway.

--7wx2z723wtuxaqym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYNImQAAoJECTWi3JdVIfQZ14H/30yBSAmxlXCbogpUNM79jxX
3ScUP+q7Ea4Jdgd8sOHVTegLRmdAXHoncxnERXrE2E71n77qU+t0MHb7aiuQfhQW
ze+EHDH91a4qNQitqMT9EY353ya9lyIPhnbaPrumRHL4SjUQvwo99JrhrbVEWX2l
u6FdvW7lKi5ZojNR0C+G8VrQr7go2d2HIt37J0mIxtpH7uZaden8JyLZeOZEaixP
AEEc0zhGjVrZ/JsCtr7umD7Jrh5rqxrdE9pNCW5MgoQFL/7Ar6MDe5k7wXmfyeuG
Ev1mxu/4YCfi/1vsUO94hniFmcOJwxoiUbvufffba7CyJx+vMIvcUWRWdEKn6pM=
=IihL
-----END PGP SIGNATURE-----

--7wx2z723wtuxaqym--
