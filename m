From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH 2/2] hid/hid-sony: get and set Sixaxis bdaddr via sysfs
Date: Wed, 1 Sep 2010 19:28:54 +0200
Message-ID: <20100901192854.9370c605.ospite@studenti.unina.it>
References: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it>
	<1272917756-31098-3-git-send-email-ospite@studenti.unina.it>
	<1283357874.2361.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__1_Sep_2010_19_28_54_+0200_P8r0ehtD8Ti8nFg1"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:34634 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844Ab0IAR3B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Sep 2010 13:29:01 -0400
In-Reply-To: <1283357874.2361.24.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org, cbe-oss-dev@lists.ozlabs.org, Jiri Kosina <jkosina@suse.cz>

--Signature=_Wed__1_Sep_2010_19_28_54_+0200_P8r0ehtD8Ti8nFg1
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 01 Sep 2010 17:17:54 +0100
Bastien Nocera <hadess@hadess.net> wrote:

> On Mon, 2010-05-03 at 22:15 +0200, Antonio Ospite wrote:
> > Expose to userspace a simple way to get device bdaddr, and get/set mast=
er
> > bdaddr on Sixaxis controller.
> >=20
> > Right now userspace softwares which manage pairing the controller with a
> > bluetooth adapter, rely on libusb and hence have to detach and reattach
> > usbhid, which is not very nice.
> >=20
> > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> > ---
> >=20
> > As said, ideally this should be done with an interface such as hidraw, =
but its
> > limitations prevent us from doing it the right way; and I am not going =
to
> > touch hidraw myself anytime soon.
>=20
> Rest looks alright to me. Thanks!

Bastien, Jiri, this patch can be DISCARDED. The hidraw work from Alan
Ott (waiting for Marcel to ACK the bluetooth part) will make this kernel
approach overkill.

I already have some bluez patches based on Alan's work, but I am waiting
for the needed changes to land into linus tree before submitting them.

Sorry for making you wasting some time reviewing this one, I told you on
IRC it could be discarded, but we know: "IRCs volant, emails manent".

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__1_Sep_2010_19_28_54_+0200_P8r0ehtD8Ti8nFg1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkx+jVYACgkQ5xr2akVTsAEe5QCgqCNMtl+q23sRq/xn6ZZaVSZi
Jb0An3VwpH5oWvlYC2WhQ6jYPbmBBAMC
=+cWu
-----END PGP SIGNATURE-----

--Signature=_Wed__1_Sep_2010_19_28_54_+0200_P8r0ehtD8Ti8nFg1--
