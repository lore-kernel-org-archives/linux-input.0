From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [RFC PATCH] input: Add disable sysfs entry for every input device
Date: Mon, 2 Jan 2017 18:09:58 +0100
Message-ID: <201701021809.58943@pali>
References: <1482660296-8432-1-git-send-email-pali.rohar@gmail.com> <1483370825.2420.8.camel@hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3101963.zXW8HlsloR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483370825.2420.8.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Chuck Ebbert <cebbert.lkml@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart3101963.zXW8HlsloR
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 02 January 2017 16:27:05 Bastien Nocera wrote:
> On Sun, 2016-12-25 at 11:04 +0100, Pali Roh=C3=A1r wrote:
> > This patch allows user to disable events from any input device so
> > events
> > would not be delivered to userspace.
> >=20
> > Currently there is no way to disable particular input device by
> > kernel.
> > User for different reasons would need it for integrated PS/2
> > keyboard or
> > touchpad in notebook or touchscreen on mobile device to prevent
> > sending
> > events. E.g. mobile phone in pocket or broken integrated PS/2
> > keyboard.
> >=20
> > This is just a RFC patch, not tested yet. Original post about
> > motivation
> > about this patch is there: https://lkml.org/lkml/2014/11/29/92
>=20
> Having implemented something of that ilk in user-space (we
> automatically disable touch devices when the associated screen is
> turned off/suspended), I think this might need more thought.

How to implement such thing in userspace? I think you cannot do that=20
without rewriting every one userspace application which uses input.

> What happens when a device is opened and the device disabled through
> sysfs, are the users revoked?

Applications will not receive events. Same as if input device does not=20
generates events.

> Does this put the device in suspend in the same way that closing the
> device's last user does?

Current code not (this is just RFC prototype), but it should be possible=20
to implement.

> Is this not better implemented in user-space at the session level,
> where it knows about which output corresponds to which input device?

How to do that without rewriting existing applications?

> Is this useful enough to disable misbehaving devices on hardware, so
> that the device is not effective on boot? =20

In case integrated device is absolutely unusable and generates always=20
random events, it does not solve problem at boot time.

But more real case is laptop with closed LID press buttons and here it=20
is useful.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3101963.zXW8HlsloR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhqiWYACgkQi/DJPQPkQ1IApQCfT3SZAVpWybyokJtOvZEyeY4Y
dXUAnAy4/xvVaHhTGTES/zRja0oxgJVz
=dxz9
-----END PGP SIGNATURE-----

--nextPart3101963.zXW8HlsloR--
