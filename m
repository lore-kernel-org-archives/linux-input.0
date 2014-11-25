From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/7] Fixes for ALPS trackstick
Date: Tue, 25 Nov 2014 12:08:31 +0100
Message-ID: <201411251208.31658@pali>
References: <1415993906-13307-1-git-send-email-pali.rohar@gmail.com> <201411170839.17504@pali> <201411200029.49547@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5693687.OUhKZolg6b";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201411200029.49547@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Vadim Klishko <vadim@cirque.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart5693687.OUhKZolg6b
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 20 November 2014 00:29:49 Pali Roh=C3=A1r wrote:
> On Monday 17 November 2014 08:39:14 Pali Roh=C3=A1r wrote:
> > On Friday 14 November 2014 21:59:31 Dmitry Torokhov wrote:
> > > Hi Pali,
> > >=20
> > > On Friday, November 14, 2014 08:38:19 PM Pali Roh=C3=A1r wrote:
> > > > This patch series fix detection and identifying
> > > > trackstick on machines with ALPS devices. Last patch
> > > > split trackstick and bare PS/2 mouse packets between
> > > > dev2 and dev3 input devices which make sure that driver
> > > > will send only trackstick data to trackstick input
> > > > device.
> > >=20
> > > Thank you for splitting the change, unfortunately it is
> > > now quite big to apply to 3.18. Any chance you could try
> > > implementing what I suggested in
> > > http://www.spinics.net/lists/linux-input/msg34029.html and
> > > then we can do the more comprehensive solution in 3.19.
> > >=20
> > > Thanks.
> >=20
> > Hello, I think that patches 1/7 and 5/7 could do that job. I
> > did not tested them alone (without other patches), but if
> > you think that two patches are ok for 3.18 & stable I can
> > test them...
>=20
> Dmitry, ping.

Dmitry: ping again.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5693687.OUhKZolg6b
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR0Yy8ACgkQi/DJPQPkQ1LKHwCfaBoDx7SSlzXru6ZLH8MqcA3O
vD4AoMoeMnMrBIn4R6LjxTtzOA9bH3IW
=ZQzK
-----END PGP SIGNATURE-----

--nextPart5693687.OUhKZolg6b--
