From: Florian Echtler <floe@butterbrot.org>
Subject: Behaviour of input-polldev?
Date: Tue, 03 Sep 2013 13:39:17 +0200
Message-ID: <5225CA65.7030104@butterbrot.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3GQ0qINcP1eNh4piK8kVhRn0Ikv9WPEJN"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:33969 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932597Ab3ICLrQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Sep 2013 07:47:16 -0400
Received: from [192.168.178.30] (ppp-188-174-14-6.dynamic.mnet-online.de [188.174.14.6])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by butterbrot.org (Postfix) with ESMTPSA id B44BDC00214
	for <linux-input@vger.kernel.org>; Tue,  3 Sep 2013 13:39:18 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3GQ0qINcP1eNh4piK8kVhRn0Ikv9WPEJN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I'm in the process of writing an input driver for the Microsoft
Pixelsense (formerly Surface 2.0). The device only has bulk endpoints
and consequently needs to be polled regularly. My beta driver uses
input-polldev for this, and it appears to work nicely, however, I
couldn't find out how input-polldev behaves if one polling cycle takes
longer than expected and a new poll would already be triggered while the
first one is still running?

Thanks & BR, Florian
--=20
SENT FROM MY DEC VT50 TERMINAL


--3GQ0qINcP1eNh4piK8kVhRn0Ikv9WPEJN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlIlymUACgkQ7CzyshGvath5RwCg2gTC9e3TAfX/6d8QNANecTtr
3yoAoOKz0R2bSJzl7laTZ9pxeueRxPtc
=wYIA
-----END PGP SIGNATURE-----

--3GQ0qINcP1eNh4piK8kVhRn0Ikv9WPEJN--
