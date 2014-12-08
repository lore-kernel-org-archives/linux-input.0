From: Florian Echtler <floe@butterbrot.org>
Subject: [sur40] videobuf2 and/or DMA?
Date: Mon, 08 Dec 2014 08:50:46 +0100
Message-ID: <54855856.3070207@butterbrot.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4n4TEAQmhDt2rbHHq201twGu3g3gFeEC5"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:40980 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbaLHH5z (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Dec 2014 02:57:55 -0500
Received: from [192.168.178.30] (unknown [95.90.212.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by butterbrot.org (Postfix) with ESMTPSA id 803E95C00CDA
	for <linux-input@vger.kernel.org>; Mon,  8 Dec 2014 08:50:47 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4n4TEAQmhDt2rbHHq201twGu3g3gFeEC5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I'm preparing to finally add support for the raw sensor video stream to
my driver for the SUR40 touchscreen. However, after an extensive amount
of Googling, I'm still not clear on the relationship between DMA
transfers, the USB core and the videobuf2 framework.

Specifically, I'd like to know:

- Can I always use DMA on the USB side (for bulk transfers), or does
this in any way require support from the USB device's hardware? (I'm
guessing no, but a definite answer would be great.)

- Regardless of the USB side of things, can I use the videobuf2
framework without _having_ to use DMA? That way, I could get a basic
driver running without DMA and switch later when it's convenient and/or
the speedup is justified.

Thanks & best regards, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL




--4n4TEAQmhDt2rbHHq201twGu3g3gFeEC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlSFWFYACgkQ7CzyshGvatgPUwCfVtURNd1nI3qKuwp1/IoRT0QX
3e4AoJq3pJ8PxACnOjb9G/Bfv0jzAbKc
=61c9
-----END PGP SIGNATURE-----

--4n4TEAQmhDt2rbHHq201twGu3g3gFeEC5--
