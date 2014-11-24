From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Reported key not released
Date: Mon, 24 Nov 2014 21:58:32 +0100
Message-ID: <201411242158.33119@pali>
References: <201411231413.30076@pali> <20141124200433.GA3459@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart236147119.Rxt5re3Wyp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20141124200433.GA3459@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Alex Hung <alex.hung@canonical.com>
List-Id: linux-input@vger.kernel.org

--nextPart236147119.Rxt5re3Wyp
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 24 November 2014 21:04:33 Matthew Garrett wrote:
> On Sun, Nov 23, 2014 at 02:13:30PM +0100, Pali Roh=C3=A1r wrote:
> > When I enable or disable this switch it correctly enable or
> > disable devices (and also hard rfkill status is set
> > correctly).
>=20
> If the switch changes the rfkill state, you shouldn't be
> emitting any presses - the rfkill state change will notify
> userspace. Consume the event in the filter and don't pass it
> through.

So kernel should filter i8042 atk key press events which=20
represent HW switch?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart236147119.Rxt5re3Wyp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRzm/kACgkQi/DJPQPkQ1Li2gCgys+KtohZ3FXSXzMX2gJ+zQ/L
/mgAn0WTgNxAnkjVXzDps8g+AEd2oJuY
=6lxb
-----END PGP SIGNATURE-----

--nextPart236147119.Rxt5re3Wyp--
