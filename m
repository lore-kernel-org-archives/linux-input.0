From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Reported key not released
Date: Mon, 24 Nov 2014 23:04:48 +0100
Message-ID: <201411242304.49047@pali>
References: <201411231413.30076@pali> <201411242158.33119@pali> <20141124215147.GB14361@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6110518.8nCAdYk1rl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20141124215147.GB14361@srcf.ucam.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Alex Hung <alex.hung@canonical.com>
List-Id: linux-input@vger.kernel.org

--nextPart6110518.8nCAdYk1rl
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 24 November 2014 22:51:47 Matthew Garrett wrote:
> On Mon, Nov 24, 2014 at 09:58:32PM +0100, Pali Roh=C3=A1r wrote:
> > So kernel should filter i8042 atk key press events which
> > represent HW switch?
>=20
> Yeah - the firmware is sending an "Update rfkill state"
> message, not a real keypress. If you're already listening for
> those events through a filter then you should just drop them
> once you've done the state update.

Now I wanted to do not use i8042 hook function in dell-laptop.c=20
which was used only for receiving key event (hw switch) and=20
propagating it to dell-laptop rfkill device. See my patch:

dell-laptop: Use dell-rbtn instead i8042 filter when possible

But if we really should drop these atk key press, then another=20
patch for it will be needed.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6110518.8nCAdYk1rl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRzq4EACgkQi/DJPQPkQ1J38gCcDStNe3BJsFgtIsS8qdgfujRE
pXQAn0Eve+ho2ZpVlMW9J+GCAEPvZLYu
=WwoN
-----END PGP SIGNATURE-----

--nextPart6110518.8nCAdYk1rl--
