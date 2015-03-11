From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v6 13/22] HID: Change power supply ownership from driver
 to core
Date: Wed, 11 Mar 2015 19:46:44 +0100
Message-ID: <20150311184643.GA2380@earth>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
 <1425976046-20973-14-git-send-email-k.kozlowski@samsung.com>
 <20150310141444.GC11992@earth>
 <alpine.LNX.2.00.1503111207450.24876@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43939 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbbCKSrG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Mar 2015 14:47:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1503111207450.24876@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Wed, Mar 11, 2015 at 12:08:09PM -0400, Jiri Kosina wrote:
> On Tue, 10 Mar 2015, Sebastian Reichel wrote:
> > On Tue, Mar 10, 2015 at 09:27:17AM +0100, Krzysztof Kozlowski wrote:
> > > Change the ownership of power_supply structure from each driver
> > > implementing the class to the power supply core.
[...]
> > >  [...]
> > >  drivers/hid/hid-input.c                   |  51 ++++---
> > >  drivers/hid/hid-sony.c                    |  43 +++---
> > >  drivers/hid/hid-wiimote-modules.c         |  41 ++---
> > >  drivers/hid/hid-wiimote.h                 |   3 +-
> > >  drivers/hid/wacom.h                       |   8 +-
> > >  drivers/hid/wacom_sys.c                   |  71 ++++-----
> > >  [...]
> > >  82 files changed, 2296 insertions(+), 1839 deletions(-)
> >=20
> > I would like to merge this patch via power-supply tree. Can you
> > please provide your Acked-By?
>=20
> I don't see the patch neither on linux-input@ nor LKML. Could you please=
=20
> bounce it my way so that I can review it?

Krzysztof, can you take care of resending the patch? It looks like
it got detected as SPAM by most vger.kernel.org mailinglists.

It seems to have been received by LKML, though:

https://lkml.org/lkml/2015/3/10/99 (currently broken?)

Google Cache:
https://webcache.googleusercontent.com/search?q=3Dcache:-FhPl4Qzm4wJ:https:=
//lkml.org/lkml/2015/3/10/99+&cd=3D2&hl=3Dde&ct=3Dclnk

-- Sebastian

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVAI2QAAoJENju1/PIO/qaAFQP/RXvUAHiw8niLsk/gmrsNRp7
xs9O2E+hLjdYKQaFbykwjayPquX+3plJS2gEwjRCEOeyPVeyTk4XOVwNneVTnTAz
yPbhhHv40rSJ/YBw3B/SONQo7jkzN45fRAMhpnhDdD02l6KkIt32Ae5Z5mZ1U4z3
k5ZszJk721DyNVDxoWmq8GGYkV5YxWDR5uHh5B7em1lEPZ/FIRHers3R939lrREg
F0HeHFzqfwpnHamY4b4j4SZezeyg1ztS9rjLs4WXX4zPJcsFAkWN6s0098CNZRWn
N86kB9QmUFdVWBH85yTLoXujaEzxJlp2TcVTKjnj88zBLDqlx5DHz9+2/1Ujf+C+
f5rvHjov0pYdGrHKz5V5bVVtNj3sUvUPbTiRltRMP5qpkuRmoM5+rnrPga4OAdcz
hUAw1mt79U0u/cv+iuSzA0WwAe+xMtECoCkbSKK/I/0Px/zlluKBoVMIY1UGirLv
Iw3vJwpybUdIJ1JX9RVVWogwUCUCn5eC+OA5JSubJRZHZdpx/8ts1OOlJZKGvn9x
kii8QlR7mRg+dTTqx0u9u0UNcpGj0RS8EfkIrWHh96jZCZPXHVit4YKyXRKqb+f9
LVYqh9tqZzdjkXZZjE8oy2CT/53NGfnvVRhbTtb6N1kK+TjXo0SyKx3rgQMku750
0dbwqGHBYrEvAGiqm6rE
=0kpD
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
