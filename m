From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [RFC/RFT][PATCH] Input: tsc2007 - convert to threaded IRQ
Date: Thu, 25 Aug 2011 09:06:57 +0200
Message-ID: <20110825070657.GA29512@avionic-0098.adnet.avionic-design.de>
References: <20110823061738.GA25272@core.coreip.homeip.net>
 <20110825062159.GB25708@avionic-0098.mockup.avionic-design.de>
 <20110825064333.GA15655@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58370 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab1HYHHB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Aug 2011 03:07:01 -0400
Content-Disposition: inline
In-Reply-To: <20110825064333.GA15655@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors.ext@mocean-labs.com>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Dmitry Torokhov wrote:
> On Thu, Aug 25, 2011 at 08:21:59AM +0200, Thierry Reding wrote:
> > * Dmitry Torokhov wrote:
> > > This is completely untested but I believe it should work better than =
original
> > > workqueue solution, especially when we do not have get_pendown_state =
method
> > > available. I wonder if it will help Richard's issue with IRQ getting =
re-raised
> > > after pen up event.
> > >=20
> > > Anyone who has hardware - please give it a spin.
> >=20
> > I can see no noticeable changes with this patch.
> >=20
>=20
> That's the result I was aiming for ;) Thanks for testing.
>=20
> Oh, crap... Does it still work if you change IRQ flags in
> request_threaded_irq() from 0 to IRQF_ONESHOT?=20
>=20
> Also, while we are at it would you ming trying out another patch
> (below)?

With both your patch applied and the change from 0 to IRQF_ONESHOT the driv=
er
oopses when loaded. I didn't have time to investigate further, but I think I
could perhaps test a couple more patches if you provide them.

Thierry

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5V9JAACgkQZ+BJyKLjJp/eZACgrVYH0yrA81O2tMrPgmxFP3bI
qpQAoJQtRBMpN9Jg7SsOComYcKmV3QkB
=gHgP
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
