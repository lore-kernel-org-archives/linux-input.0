From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: KASAN: use-after-free Read in add_uevent_var
Date: Mon, 6 May 2019 14:39:50 +0200
Message-ID: <20190506123950.GA18177@kunai>
References: <000000000000559435058813dc8d@google.com>
 <20190506081525.GD17751@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190506081525.GD17751@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+6da9575ba2db4da91831@syzkaller.appspotmail.com>, airlied@linux.ie, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, hpa@zytor.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, patrik.r.jakobsson@gmail.com, rydberg@bitmath.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
List-Id: linux-input@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The bug was bisected to:
> >=20
> > commit 0a1c7959acd9674a0e4e59f911f3e5fbf25fd693
> > Author: Wolfram Sang <wsa@the-dreams.de>
> > Date:   Wed May 17 15:22:18 2017 +0000
> >=20
> >     gpu: drm: tc35876x: move header file out of I2C realm
>=20
> Bisect seems to have gone off the rails. No idea where or why.

Yes, luckily it was obvious here, saving us from chasing ghosts.


--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlzQKxIACgkQFA3kzBSg
KbYGlA/+IRmumqdM8Lj+ELaaAGYdWD5XIpHr2MBZBYifi/kUl3ZIlPtdAUcuE7qH
GAZDCVKFU1bcvI/00L584DRCnWEIkXWGlh5S2yPzPPND3qAJjIy75L0JkdVLxG1k
bjy6/ALj/GHSP6ry9FqdOCtyL6NMkbimjKjd5q/hoSLTcGCp5z4SWs3K4J3FiuQy
JCsZbsm6pl7ZVhnF214HWaTss2fmfFfPSPIN0bkdbUup5NguCKGDVHLQBiALz8uI
NucdPf/ElZrpylRz079UNaQ3HnE3Pu9aVET02qefVwtPVO4sJ+BIZLuw0vNvBAv9
ari8b2DByEXXA8CBk0mjm/xaSGbqiVR90L4FsC0UZdGB5MXWkWofXCW1JPNYvc8a
4wVjX63Y6EuccAezuLbS7m2plfPftdOR3CvP4HX15A5ax4yjbBEEKqpoDJDwqifk
ANnvUTa/X4ts+Ld5yFlC3rfACUPj23VY8zR6HswWis5LKjnGUhNdDlzmILFLYmuM
oPHN6BzMIRiMbKFrKbUHzuNLTMR607d4I/dKpnqr6oUjYFFo1pdKHgbrjgxF8y1p
cH+mDe/8N0thkS27Chss8yvzVdtmFoZHSDaeY7QfOG41hqMINNVOLFOkYT9NyoTM
Tdo8ZXHM3+m7SvR0T0AqZ/HTxf4yYziNEuwXTtf0Odih/aGcti4=
=tKNJ
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
