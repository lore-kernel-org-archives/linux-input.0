From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Fri, 9 May 2014 19:49:08 +0100
Message-ID: <20140509184908.GX12304@sirena.org.uk>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
 <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com>
 <536963A0.4060506@wwwdotorg.org>
 <536BAA5A.1010809@itdev.co.uk>
 <536BB3C9.8070908@wwwdotorg.org>
 <20140508172635.GD11672@core.coreip.homeip.net>
 <536BE154.2090701@itdev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="syjoJAwOg4MOHaL2"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39567 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbaEIStf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 May 2014 14:49:35 -0400
Content-Disposition: inline
In-Reply-To: <536BE154.2090701@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>


--syjoJAwOg4MOHaL2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2014 at 08:56:04PM +0100, Nick Dyer wrote:

> Thanks! I had wondered why you had left it, you never communicated this to
> me unfortunately. Would it be preferable for me to switch to
> request_firmware_nowait() and complete the probe asynchronously after it
> returns?

Another common option is to defer the firmware request/load until the
device is opened, but that doesn't work for all devices.  That should
mean that userspace is up and running.

--syjoJAwOg4MOHaL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbSMhAAoJELSic+t+oim98YEP/3TkvTbDnoIal5lXvPk7mijb
JcqGHc7XPa+xagdbm9vCpEo/NTeNaq0Mjm9lvIZjMcVFSUNYXA2lFO9qk+4P62oe
GDInpkNq7QdE6yruOOU9PmTX2u3nYpyMsnU4l5Ab4oEJ7wi9H3jAhrzfHA7nPURv
d6CXgQzATOyel6FQna04cNfw6ylAPXO17exBBoY8hlRHipaat3QrfR0gGOYFv0qZ
7qaBReSeVz/u/ae7XMx1/mm2LuQsiUJpatYKVNgPYnOynEvaiCDi0J4ksZvkmwOF
0YkNbD7GhF5VtOBGDP0BIXa+71uL6mUkRlOI1Dz4/crD+sggucfN3tF52N4D1yFz
naEIk8gRT4+pQInKTqbEmzuud6VkOoYDtjOauCQcrHp4PUT/b4bgE2fDFyTGL7Ht
1p4mvBPc1r/VeAtf9z5SKGI2hD2bh5rdqLjMGa9FCbxT7a+RKJ5sLvgFWpBTer0I
WSlXQOpFbpTyaLeQWc1GP5m58UeAx/lSzo8mkpA4ADps6k8JWvGuP5ZZJKgYfpjp
4AoC44FV4zr6Zggi4cbxzhvF2cxP53TmCXDggL32rWQ/b5Uu0kihbIfg/qbQzcNW
l1ohdjUorF8mR5rJoeTBlUMNxzG5/rQUbu4zJjPJHXsjOYpKLtenkuiSwLKPyIxo
IucXjZ578ipuNre96MND
=D3lu
-----END PGP SIGNATURE-----

--syjoJAwOg4MOHaL2--
