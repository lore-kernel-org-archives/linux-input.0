From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2 0/3] Another try for the Sixaxis plugin
Date: Thu, 24 Mar 2011 18:32:47 +0100
Message-ID: <20110324183247.3291e59e.ospite@studenti.unina.it>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
	<1298637244.10364.19.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__24_Mar_2011_18_32_48_+0100_cWkTovzvAH6CRF4M"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:60904 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198Ab1CXRdY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2011 13:33:24 -0400
In-Reply-To: <1298637244.10364.19.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>

--Signature=_Thu__24_Mar_2011_18_32_48_+0100_cWkTovzvAH6CRF4M
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Feb 2011 12:34:02 +0000
Bastien Nocera <hadess@hadess.net> wrote:

> On Fri, 2011-02-25 at 11:04 +0100, Antonio Ospite wrote:
[...]
> >=20
> > TODO before merging:
> >   - Check the routine about bluetooth association. Also, is it strictly
> >     necessary to grant manually the first connection?
>=20
> The line setting the device trust should be enough to not have to
> manually grant the first connection. You might want to double-check what
> changes between the state of /var/lib/bluetooth after cable pairing and
> before connecting for the first time.
>

Calling write_trust() before adapter_get_device() fixes the prompt on
the first association, AFAICS adapter_get_device() reads the trust file.

> >   - When the controller is connected via USB after it is working over BT
> >     it is seen as a second controller and the second LED is turned on,
> >     should we force BT disconnection on USB connection?
>=20
> If we can assert that the device is the same one, yes, I think we
> should.
>

With regard to that, I'd like to see some USB dumps of a Sixaxis
talking with GameOS to check if the PS3 can turn off BT on the
controller explicitly, can anyone help here? (Pascal? Do you have
access to a USB analyzer?):

The scenarios I am interested in are:
 1. Connect a non-paired Sixaxis to the PS3 via USB
 2. Connect an already paired Sixaxis to the PS3 via USB
 3. Connect a Sixaxis already associated via BT to a PS3 via USB

> >   - Test with multiple controllers, and/or multiple BT adapters, which I
> >     can't do right now.
> >   - Remove the XXX comment about the lowercase hex bdaddr format.
> >

Another TODO item: avoid setting the led before the controller sends
input events (this is the GameOS behavior as well): I am planning to add
a blocking read() in order to wait for the user to press the PS button
before setting the led, I'll emphasize that in the next review round.

> >=20
> > FUTURE plans:
> >  - Add support for battery status report
>=20
> Where is the battery level exported currently?
>

It is exported in the input report.

> >  - Add support for Playstation Move (I don't have the hardware, tho),
> >    Pascal?
>=20
> The PS3 add-on keyboard, and the PS3 headset both use cable pairing. I
> have them around, but was unable to get them to pair.
>

I don't have the hardware so I never searched to see what the
differences with the Sixaxis are.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__24_Mar_2011_18_32_48_+0100_cWkTovzvAH6CRF4M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2LgEAACgkQ5xr2akVTsAEG4QCdHTJui2WaEhDa13GKrytKtCan
R2MAn1fvtdOmYpssTXKGAcL+39R2nVfF
=w3nf
-----END PGP SIGNATURE-----

--Signature=_Thu__24_Mar_2011_18_32_48_+0100_cWkTovzvAH6CRF4M--
