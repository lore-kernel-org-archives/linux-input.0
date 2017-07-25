From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Do not bind to CHPN0001 touchscreen
Date: Tue, 25 Jul 2017 15:46:58 +0200
Message-ID: <20170725134658.GB5777@katana>
References: <20170722185537.12696-1-hdegoede@redhat.com>
 <20170722185537.12696-2-hdegoede@redhat.com>
 <20170724081928.GB18097@mail.corp.redhat.com>
 <alpine.LSU.2.20.1707251457190.4705@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39130 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752117AbdGYNrA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Jul 2017 09:47:00 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1707251457190.4705@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> what do we do with this patchset? I think it makes sense for both patches=
=20
> to go in via one tree.

Yes.

> Either I can take it through hid.git with your Ack for the first patch, o=
r=20
> vice versa. Please let me know what you'd prefer.

I'd like use the i2c tree for it. The changes to i2c core are an API
addition while the changes to the HID driver are basically boilerplate.

Makes sense?


--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll3S9IACgkQFA3kzBSg
KbbRMw//eQoWw+oQgN7HTta94sd7g9nOljJYc04iELvNKk6002LVF6FSR3KjMCvs
itfCyHJ56mxbv/jJIHCD7usObm0MsQhsN84f0bKOgpdrA5iL5d+E8yjUg5ZL4xFT
T3gYmXCaSfJ4I5H4oqcBlhcKaDFB0dKPkXdlMCW7j8+GpfOXyi6B0/HMussp5q/R
mPkVpDa9R0w3xRTxK78vHZms3WwvP7EaZud+c/sOd8feDuupsf79uQcO2uaVCnc1
j6hZvQdVgVipo52QeIJKBEPwiLAn1LyX5dkgKlz8sr4k8RapjLoqwZHzo/cAKI3T
TsyPj8yVo4mzHu5AzWMFIGAJMoOvLZ7lRwGO77BZXb1ZSzkFhrN2SyGkMWA/z7r/
Imx+PDs4Vrc0eTLg1pwckI52Cw0eJNX/pJYhxH46JiF/kX2pTGN164nnZpG9eofM
YeIp+caMq92/H3sj1Y6c9Zoy+hsVke3OyG0aajDDL8kajMTMe0Qpzo8nqS3+qrvc
wzryNU9Mr/apySzmE+CGE+p7w0eeVnlRe5MSB57vIxVrXoDmyjnZRt15JaQdOPtH
5s10cuiKFuq58cxSnGrWbrJGOjULITtwTWbX4WYv1gJ4FFYKuX5s0Lws4Jwj7Hvg
eGye9jo6CWEmtIKCbuzWvCk4z3oykJihOFl2rC2HswLongXjQWg=
=t4si
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
