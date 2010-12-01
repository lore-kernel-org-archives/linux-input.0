From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Rewriting wheels HID descriptor for complete functionality
Date: Wed, 1 Dec 2010 22:20:22 +0100
Message-ID: <20101201222022.b2e49a1b.ospite@studenti.unina.it>
References: <e0bdb04c6bf793ed464934fd4f8b663e.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__1_Dec_2010_22_20_23_+0100_7VLuNB1Wo1jVg7sl"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:53954 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752Ab0LAVUn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Dec 2010 16:20:43 -0500
In-Reply-To: <e0bdb04c6bf793ed464934fd4f8b663e.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org, Marcin Tolysz <tolysz@gmail.com>

--Signature=_Wed__1_Dec_2010_22_20_23_+0100_7VLuNB1Wo1jVg7sl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Dec 2010 13:23:15 -0500
simon@mungewell.org wrote:

> I am working on a driver for a Logitech gaming wheel where the HID
> descriptor presents a 'joystick' with X and Y axis, the Y is a combined
> acc/brake value even though the wheel has separate paddles for each.
>=20
> There are 'vendor defined' variables for both the acc/brake within the HID
> descriptor, but these are not (by Linux) tied to their function.
>
> On the Windows, the specialised Logitech driver gives the option to use
> either combined or separate acc/brake.
>=20
> I am considering re-writing the HID descriptor to expose these separate
> values as 'proper' axis, as they would provide both better resolution and
> better functionality (ie. left foot braking).
>

Simon,

have you tried Marcin Tolysz's approach of loading the new HID
descriptor from an external file?

Look at:
https://patchwork.kernel.org/patch/69723/

If there is interest maybe Marcin's way could be brought back on the
discussion table (Marcin added to CC).

I'll be needing descriptor patching for Sony Sixaxis too, after I solved
some other issues, so I am also interested on settling on a "standard"
way to achieve that.

> Q1. Is this an acceptable thing to do?
>=20
> Q2. In the case where there is significant change to the HID descriptor,
> is it OK to just re-write the whole block (rather than patch/swap a couple
> of bytes)?
>=20
> Q3. In re-writing descriptor for the combined acc/brake. Is there a
> particular 'variable' I should change it to (X, Y and Z would already be
> used), or should I just make it 'vendor defined'?
>=20
> Thanks in advance,
> Simon
> (aka Mungewell)
>=20

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__1_Dec_2010_22_20_23_+0100_7VLuNB1Wo1jVg7sl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz2vBcACgkQ5xr2akVTsAH8SQCaA9sEzKFleAtPU6ehpjhoCp0Y
/lEAnjFTB+9XICplEci/sIkeBy62s+6/
=aOfh
-----END PGP SIGNATURE-----

--Signature=_Wed__1_Dec_2010_22_20_23_+0100_7VLuNB1Wo1jVg7sl--
