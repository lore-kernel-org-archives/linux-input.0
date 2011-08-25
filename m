From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [RFC/RFT][PATCH] Input: tsc2007 - convert to threaded IRQ
Date: Thu, 25 Aug 2011 10:25:17 +0200
Message-ID: <20110825082517.GA28511@avionic-0098.adnet.avionic-design.de>
References: <20110823061738.GA25272@core.coreip.homeip.net>
 <20110825062159.GB25708@avionic-0098.mockup.avionic-design.de>
 <20110825064333.GA15655@core.coreip.homeip.net>
 <20110825070657.GA29512@avionic-0098.adnet.avionic-design.de>
 <20110825073427.GB24739@core.coreip.homeip.net>
 <20110825075253.GA10702@avionic-0098.adnet.avionic-design.de>
 <20110825075624.GC24739@core.coreip.homeip.net>
 <20110825080551.GD24739@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51838 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699Ab1HYIZS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Aug 2011 04:25:18 -0400
Content-Disposition: inline
In-Reply-To: <20110825080551.GD24739@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors.ext@mocean-labs.com>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Dmitry Torokhov wrote:
> On Thu, Aug 25, 2011 at 12:56:25AM -0700, Dmitry Torokhov wrote:
> > On Thu, Aug 25, 2011 at 09:52:54AM +0200, Thierry Reding wrote:
> > > * Dmitry Torokhov wrote:
> > > > On Thu, Aug 25, 2011 at 09:06:57AM +0200, Thierry Reding wrote:
> > > > > * Dmitry Torokhov wrote:
> > > > > > On Thu, Aug 25, 2011 at 08:21:59AM +0200, Thierry Reding wrote:
> > > > > > > * Dmitry Torokhov wrote:
> > > > > > > > This is completely untested but I believe it should work be=
tter than original
> > > > > > > > workqueue solution, especially when we do not have get_pend=
own_state method
> > > > > > > > available. I wonder if it will help Richard's issue with IR=
Q getting re-raised
> > > > > > > > after pen up event.
> > > > > > > >=20
> > > > > > > > Anyone who has hardware - please give it a spin.
> > > > > > >=20
> > > > > > > I can see no noticeable changes with this patch.
> > > > > > >=20
> > > > > >=20
> > > > > > That's the result I was aiming for ;) Thanks for testing.
> > > > > >=20
> > > > > > Oh, crap... Does it still work if you change IRQ flags in
> > > > > > request_threaded_irq() from 0 to IRQF_ONESHOT?=20
> > > > > >=20
> > > > > > Also, while we are at it would you ming trying out another patch
> > > > > > (below)?
> > > > >=20
> > > > > With both your patch applied and the change from 0 to IRQF_ONESHO=
T the driver
> > > > > oopses when loaded. I didn't have time to investigate further, bu=
t I think I
> > > > > could perhaps test a couple more patches if you provide them.
> > > >=20
> > > > Hmm, can't spot the problem... Where does it die?
> > >=20
> > > I'll see if I can track it down, but I have very limited time.
> >=20
> > Don't worry, there is no rush whatsoever... I'll try to ponder the code
> > some more.
>=20
> I think we fail in tsc2007_open(), instead of "if (err) {" it should say
> "if (err < 0) {"... but I still wonder why this causes oops...

It was indeed the open() call that was failing and changing "if (err) {" to
"if (err < 0) {" does indeed fix the issue.

Again, no negative nor positive changes in the touchscreen behaviour. So
again,

Tested-by: Thierry Reding <thierry.reding@avionic-design.de>

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5WBuwACgkQZ+BJyKLjJp9jPACcDf/hsx6czNushBBxjNSbIhcx
UzwAoK2zGq4hOLaSphC2nwcUYWmTBhL8
=qLea
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
