From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: drivers/joystick: use parallel port device model
Date: Tue, 4 Aug 2015 20:37:36 +0200
Message-ID: <201508042037.37061@pali>
References: <1438265194-20366-1-git-send-email-sudipm.mukherjee@gmail.com> <20150803123626.GA4726@sudip-pc> <20150803124127.GF20682@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1524238.cfvOXsAPiy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150803124127.GF20682@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart1524238.cfvOXsAPiy
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 03 August 2015 14:41:27 Pali Roh=C3=A1r wrote:
> On Monday 03 August 2015 18:06:26 Sudip Mukherjee wrote:
> > On Mon, Aug 03, 2015 at 02:26:48PM +0200, Pali Roh=C3=A1r wrote:
> > > On Saturday 01 August 2015 18:13:48 Sudip Mukherjee wrote:
> > <snip>
> >=20
> > > Hey! I believe you are not going to break my Atari joystick
> > > connected to my desktop PC via special homemade reduction for
> > > parallel port... :-) That Atari joystick uses db9.ko linux
> > > kernel driver and so any untested changes to db9.c could break
> > > functionality!
> >=20
> > Can you please test the patch I am going to post in an hour or so?
> > The changes which I am making should not break any functionality.
> >=20
> > regards
> > sudip
>=20
> I can test db9.c patches, but not right now... Desktop PC with
> joystick is thousands of miles from me. It will take some time,
> maybe weeks...

Ok, so please send patches and I will try to test them via SSH and=20
remote cooperation :-)

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1524238.cfvOXsAPiy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlXBBnEACgkQi/DJPQPkQ1IuawCgoJ6am4urjmJ3CS+r/juckuiQ
HqwAn2QnQH2HeSrdXi+w1dSyhpe3RhKX
=Tu5k
-----END PGP SIGNATURE-----

--nextPart1524238.cfvOXsAPiy--
