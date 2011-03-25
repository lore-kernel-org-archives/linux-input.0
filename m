From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2 0/3] Another try for the Sixaxis plugin
Date: Fri, 25 Mar 2011 17:27:10 +0100
Message-ID: <20110325172710.b87db045.ospite@studenti.unina.it>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
	<1298637244.10364.19.camel@novo.hadess.net>
	<20110324183247.3291e59e.ospite@studenti.unina.it>
	<20110325153105.GA26039@psychosis.jim.sh>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__25_Mar_2011_17_27_10_+0100_wSS6YIkiiayen._2"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:49172 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820Ab1CYQ1c (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 12:27:32 -0400
In-Reply-To: <20110325153105.GA26039@psychosis.jim.sh>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>

--Signature=_Fri__25_Mar_2011_17_27_10_+0100_wSS6YIkiiayen._2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Mar 2011 11:31:05 -0400
Jim Paris <jim@jtan.com> wrote:

> Antonio Ospite wrote:
> > With regard to that, I'd like to see some USB dumps of a Sixaxis
> > talking with GameOS to check if the PS3 can turn off BT on the
> > controller explicitly, can anyone help here? (Pascal? Do you have
> > access to a USB analyzer?):
> >=20
> > The scenarios I am interested in are:
> >  1. Connect a non-paired Sixaxis to the PS3 via USB
> >  2. Connect an already paired Sixaxis to the PS3 via USB
> >  3. Connect a Sixaxis already associated via BT to a PS3 via USB
>=20
> Hi Antonio,
>=20
> You asked me for this a while ago, sorry it took so long.  I ran some
> tests and put the log files here:
>   http://ps3.jim.sh/sixaxis/dumps/
>

Thanks a lot Jim, now I know what to do if I got bored this weekend.

[...]
> I also did some quick captures of pairing the keypad (CECHZK1UC) and
> original headset (CECHYA-0075).  They are being paired with 00:13:a9:74:f=
e:57.
>   http://ps3.jim.sh/sixaxis/dumps/
>=20
> -jim
>

If I get to taking a look at those I could ask Bastien to test some
stuff too :)

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__25_Mar_2011_17_27_10_+0100_wSS6YIkiiayen._2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2Mwl4ACgkQ5xr2akVTsAGZ+QCdExcN5jNtO1Yb+pF4So6vO+Ze
0IkAn30h7DxIIoC5I568+N/KtC31IECz
=cV/N
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Mar_2011_17_27_10_+0100_wSS6YIkiiayen._2--
