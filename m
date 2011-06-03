From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: Losing events from USB barcode reader
Date: Fri, 3 Jun 2011 10:54:54 -0300
Message-ID: <20110603135453.GC2379@nautilus.holoscopio.com>
References: <20110523210228.7738801f@surf>
 <20110524095556.GA6805@polaris.bitmath.org>
 <20110525173832.237e7ac7@surf>
 <20110603101511.6b841ce4@surf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade2.minaslivre.org ([74.50.53.203]:37154 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab1FCNzC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jun 2011 09:55:02 -0400
Content-Disposition: inline
In-Reply-To: <20110603101511.6b841ce4@surf>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 03, 2011 at 10:15:11AM +0200, Thomas Petazzoni wrote:
> Hello,
>=20
> On Wed, 25 May 2011 17:38:32 +0200
> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
>=20
> > Agreed. However, I don't know on which criteria should the kernel
> > decide what the size of the internal buffer should be, in this
> > particular case.
>=20
> Any idea on how to adjust the kernel internal events buffer size for
> this particular device ?
>=20

Since v2.6.36, the device may hint the size of the buffer through
input_set_events_per_packet. Perhaps, you could use a QUIRCK or
something like that to indicate that you need a larger buffer and then
use that to set the buffer to a size like 60, which is what is used by
most other uses of this indication. To compare to the minimum default
value, this is 8 input_event's in evdev per event. That is, a hint of 60
will allocate a buffer of 480 entries, instead of 64.

Regards,
Cascardo.

> Thanks!
>=20
> Thomas
> --=20
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJN6OetAAoJEEWxSg7udFZI4YkP/iI5sOeXz3ldJ2LZP1p0cPO2
I2sAIZNmaBx7lrNXyw/kY+kFl9ljTyaX6LAAqvTxMUqz/3p5jPQF8cMLgpueTlX5
gV0iHFf5WSDsM14bdk7FzhDaMjl/q8AVwsiYJteLcO7Q7VI410M3qDGFD+6nWH/R
B+mSIqho9ccwRYsQZ6gzF4VOG+kpci/R42m8fwasFdVq3+LMjJs5FCdFTgDklK2E
rctvNEm/J7pMV+Bj/EPgiVFc9nEQDDcL9XAWyxgZ6H741+deL2RNs4QtLjQoPWZF
PXmypPBgIAqJsGEqkUzGdYLIidebEDv+g6CJ8ijx2dnVoKpYNk4sgliqa7CqzNSF
wTkUoYfzVurRoRU/F80ewxpomVHEqKzMMTffkscda0sKOgb83iZ4wBp7xUxo2zSE
O4r2cgTyZ8Dj9SvqKHS0MclzcahdIG3mgEBmEBEFqTfXSKuSDyvKRYreRp4I15FR
97e1UlSkLT0pdFz6Hna7EpaIDbwa1HsohM7sWA58o8BrZ9lQLUcFAWtjorUjqHFA
wNzEqKOHqzwuP8jEQAq3vWQsyJf0HHrcemUWC+nWDoYJivPMWRzqp6toFPkilqjP
HobDKSxmTzVOmq8afccPYkg4Aa7JPJrwOSZqUU8mXa0FHRXF42hiN2AuLckxHzSl
HOeArEYBGITXnYjL50tn
=O1Cb
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
