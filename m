From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [RFC 09/18] input: add input driver for polled GPIO buttons
Date: Fri, 12 Nov 2010 20:14:59 -0500
Message-ID: <201011122015.01709.vapier@gentoo.org>
References: <1289591445-28842-1-git-send-email-juhosg@openwrt.org> <1289591445-28842-10-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1723291.lDtgBNty8G";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:49127 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753699Ab0KMBPn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 20:15:43 -0500
In-Reply-To: <1289591445-28842-10-git-send-email-juhosg@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, kaloz@openwrt.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, michael.hennerich@analog.com, vapier.adi@gmail.com

--nextPart1723291.lDtgBNty8G
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday, November 12, 2010 14:50:36 Gabor Juhos wrote:
> The existing gpio-keys driver can be usable only for GPIO lines with
> interrupt support. Several devices have buttons connected to a GPIO
> line which is not capable to generate interrupts. This patch adds a
> new input driver using the generic GPIO layer and the input-polldev
> to support such buttons.

i havent looked at the two drivers to compare, but my gut reaction is "do w=
e=20
really need two drivers" ?  cant the existing one be extended to support bo=
th=20
types ?  conceivably, you could have a device with both sources and a sep=20
driver would mean user space needs to watch two different devices.  and it=
=20
implicitly means userspace needs to be aware of interrupt vs polled=20
limitations of the hardware instead of it simply caring about GPIOs.
=2Dmike

--nextPart1723291.lDtgBNty8G
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJM3eaVAAoJEEFjO5/oN/WBF4AQAM4sIxRyrlAqtJcbydB16m9O
v4TSAACiirTB92vnxEcZLDuXUfUrm1bqXoDToP3dYxxGbdf8LcB1VDj9XRJOOj8c
tKJC+ByHSGFXReiDJjKRyLti4mWZ6wap7mUB6v146ZrBCKCZtybGp/zg+5n/3AP2
RJfb62MM7B3cSV92OQrc30OddkQHmE30hN2SDVdEOU4uN3hlegDNRL9YzvefOm8w
7rarfF7AnOaiwDQDHp0tJzZxGGVj3gOHdj9r6Z6PV+q2oHLhJav3sdS5ehGaZSmK
ILSeIFZ3FDjR0kP9Apl9/3eoEiXkGrOPXnFp3pedPJZ8XZA/ycZH4+iofqcFztzR
QUgR4l0/r8nOIB0HBKlBrsqcd4ObOu70iB+rAvlcinUGksVjXgqhSP0xQf6nndl7
ErCiwAXLEY4NnVUO6BKgqdNjO3VK3+Fox8phXIW9K5luJNBv6oziOtc2X71A2AMP
VczBdQpn6O4geZn2zRsZoAp7BZB3BlIhqarGs1r5yTkIvZjxfZb6oD9ALTgKxdzT
Gubi4PO0OhrXI/BYbAnEQQeo+s6Uj2LI/epsXua5NptAmFPqwXhXpYfNOJtSTmxe
6zztbjsS+5nmAHSftAYVfEU2ojGrUAyVXcYrftENOm87HojA7qU+3zJQsmqy7A7q
EveRk2cobEafiSu8hlIO
=xJx8
-----END PGP SIGNATURE-----

--nextPart1723291.lDtgBNty8G--
