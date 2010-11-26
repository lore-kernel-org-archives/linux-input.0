From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Input event for blocking touchpad
Date: Fri, 26 Nov 2010 19:10:57 -0200
Message-ID: <20101126211056.GD3819@barata.holoscopio.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade2.minaslivre.org ([74.50.53.203]:42657 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab0KZVTX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Nov 2010 16:19:23 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I have a notebook with an ACPI system that notifies about the pressing
of the key for blocking touchpad. However, it does not notify it by
itself. I was considering sending the event to userspace and let it does
the blocking.

Since other keys are also notified by this same ACPI object, it's even
more natural that I use an input device to send this to userspace.

The problem is: there seems to be no event to represent this. Any
suggestions?

Best regards,
Cascardo.

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJM8CJfAAoJEEWxSg7udFZInIMP+gORojV1mq1gWdCIwVXxVyxv
Vhrw2gdQkXrQc2y2Calx9EN8YWwp9RrshbFeBgpgk4UJFF3yorJywGNSwBMwCiwd
8Qj90MPT3/MrGjPfieYKuULcbyw5fafpbHbQ8XeToq7wvG+Ekp5Dep8EWByAOqwn
sIxWZwrC34Ae9O5CKaY9X6pBGS1VENnlvvTePqjQExwapOUUHDBA6FsOKmwpgdvn
4YirdD2IYop+fyQoTA6t9K7neKyX9d/keyE0hB3mYXFN2sKNRHtDGuYBl/Oa1841
MJYzm9xWLc2LUV6QNMs87ZLC1TDIvo5w+aAw6Mp1k5HHyl2O61VQ/6JzcxflAi0I
QDTZMJMXrS6XBcDHB9mGMOHXu3ZK/QagpDTShCRhmRGs7tro8HOrfdSgn0Lze7bt
63AnoW4h0Wmao4u0csZL/YP8WdISRMIuImdiZjCWETJ/S3EGYWcMUibVuH+Y+UC8
oiNB4b4K/uYmuvo+1G24jmP1eGvL6Uv7Z5RAXS6XchGRpr+FT9PXHZ8YGtUsbXVG
3H+LO5MszI5xBIJFfmrUxx+OS/l6It24zlQ1mEJdCSewCy4fFx2Ofr8maR2VnL5g
pzu+LOnB5ZKOa0OrjTI8amPC5egJ+6vyC0jiyyqiJomzsIW9UObi4s8uNPGyJGiS
ghMKDxRn7g+NQr5uODDg
=KSZ+
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
