From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Wed, 25 Feb 2015 21:45:22 +0100
Message-ID: <201502252145.22577@pali>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201502202141.16017@pali> <54EE1917.4020805@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2211052.m6BLW1Q3dA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EE1917.4020805@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>
List-Id: linux-input@vger.kernel.org

--nextPart2211052.m6BLW1Q3dA
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 25 February 2015 19:48:55 Mario Limonciello wrote:
> On 02/20/2015 02:41 PM, Pali Roh=C3=A1r wrote:
> > On Friday 20 February 2015 20:56:23 Mario Limonciello wrote:
> >=20
> > resetafter=3D0 means to never reset (even if driver receive
> > e.g thousand invalid packets). I think this is very
> > dangerous if there will be other bugs either in linux
> > driver or some other HW problems.
> >=20
> > For ALPS issue I added resetafter =3D pktsize * 2 (Allow 2
> > invalid packets without resetting device). Cannot you find
> > something similar for synaptics touchpads on XPS? (pktsize
> > for ALPS is 6, no idea how big are synaptics packets).
>=20
> Pali,
>=20
> I've done some experimentation with increasing the size to
> resetafter to up to pktsize * 4.  It will decrease the number
> of occurrences of this problem, but the problem still occurs
> eventually.  pktsize for synaptics is 6 as well.  Would you
> recommend to continue to go higher than that?  Since
> out_of_sync_cnt is reset when a full packet gets received,
> some arbitrarily high number should likely fix it to.
>=20
> That being said, if you try to more closely follow what
> Windows does for the mouse, it's not issuing a reconnect no
> matter how much bad data is received.

I believe problem is similar to one as with ALPS devices. Driver=20
always receive 6 bytes packet of data (no new byte is inserted=20
and no byte is never lost), just one byte in packet is incorrect=20
(does not match specification).

Setting resetafter to > 0 prevent problems when driver enters=20
into undefined state (either by bug in driver of other SW/HW=20
problem). So I think setting resetafter to 0 is not good idea.

But if we know that setting resetafter to 4*pktsize is not enough=20
(e.g. with experimenting you saw that driver received more then 4=20
invalid packets consecutively), set it to higher value.

I think it is still good idea to ignore maximally as many packets=20
which can be received in time which is equal to resetting device.

E.g. when period of time in which we are dropping all packets is=20
higher then time needed to reset touchpad, we should stop=20
dropping packets and immediately reset touchpad. In this case we=20
could hit maybe problem in driver (there can be bugs) or touchpad=20
is in some bad state and out-of-sync...

So if your tests show that there are never invalid 10 packets=20
consecutively, then set resetafter to 10 packets. Value 10 is=20
still not high and if it fix problem with touchpad I think it is=20
acceptable. But rather ask Dmitry what he thinks about it. This=20
is just my opinion.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2211052.m6BLW1Q3dA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTuNGIACgkQi/DJPQPkQ1JeeQCguEdNBsag3wj3293x5UBTzvWx
S7EAoJD6wu8tYUnz+u2+Qw3HmajK19Xz
=CM43
-----END PGP SIGNATURE-----

--nextPart2211052.m6BLW1Q3dA--
