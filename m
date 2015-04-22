From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] HID: bug fixes in hid-cp2112 driver
Date: Wed, 22 Apr 2015 10:03:27 +0200
Message-ID: <20150422080327.GG1511@katana>
References: <1429143746-16967-1-git-send-email-ellen@cumulusnetworks.com>
 <20150416074158.GA913@katana>
 <552F73A8.5060605@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BzCohdixPhurzSK4"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35084 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965547AbbDVIDg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2015 04:03:36 -0400
Content-Disposition: inline
In-Reply-To: <552F73A8.5060605@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: dbarksdale@uplogix.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org


--BzCohdixPhurzSK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >Well, at24 detects how many bytes it got and continues from there.
>=20
> That's true, but instead of returning short, the old
> cp2112_i2c_xfer() fails out (with EIO) when the first USB operation
> doesn't return all the bytes.  Look for "short read: %d < %d" in
> the original version.  That's just broken.

Yes.

> >This shows the drawback of having I2C master drivers not in the
> >i2c-directory: It easily misses updates to the i2c-core.
> >We now have the i2c-quirk infrastructure (2187f03a9576c4) which this
> >driver should make use of. It can describe this...
> >
> >>+    for (m =3D msgs; m < msgs + num; m++) {
> >>+        /*
> >>+         * If the top two messages are a write followed by a read,
> >>+         * then we do them together as CP2112_DATA_WRITE_READ_REQUEST.
> >>+         * Otherwise, process one message.
> >>+         */
> >>+
> >
> >and this and the core will check the messages for you. It should
> >simplify your code, too.
>=20
> I didn't know about that.  Cumulus Linux is based on 3.2.something
> (debian wheezy) and i2c-quirk came in after that.

Well, actually, it came with this merge window :)

> I can update the driver to use the quirk mechanism, but I would
> prefer to do that as a separate checkin, so Cumulus can use
> a version of hid-cp2112.c that exists somewhere in mainline
> even if it's not the latest.

Fine with me if you do the i2c-quirk update as a seperate patch.


--BzCohdixPhurzSK4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVN1XPAAoJEBQN5MwUoCm20/wP/3C7CFMCEVUO6wudoFGft8pb
NRMeDq8YRSWmF1I/RNRYaQvy6WrvrgtucJyn0dn36TCsn9eQsfYs2KQaUIjzMeGY
DKFDE4tsjuxkMQPd1FcHYwzOelXAoP3Wu4iolB7WKcgwbxpypmGym9s/p5Gt9Umf
temhtQULtN7TtOJx7BaFvyUxnCUxKDm7/x8hKQqcWSkVIRJf2IwJuVJthHaH2AnI
5xn66fq+AVgip9XcbKfVpu17pUK2SbhTo6/Cw29W/+JE5ucHuqvgWmggaZmdqssU
6KhIpjLFlaYjyyvWzHdBh/AtfRrpEAEQVzEUg0OyMxnRqeKN4423qI6jp1qVnAQq
QpizgJviyUxPa6Tv8vNJSBiU93V+rlukHVfPGEeOOhJSwRx6UV82HzxavvY/TNJ7
KZrNUPuVXDAiKtrEqmhgL+lYbRuTZfSw/c/rUqxyKbeEYS92rZw1p4KdDX/0OHDO
zEDzm4cuTPObQuNUbKdKep31uSjmN92LlseRHrZDvAnGB/IXfQT8lejiHT08M4wN
cTn//a7sPyicXRdohwY3w62PxyLVv5PTEBCh9TduDHtd1UgbkJ96lECrg3XpUdR2
Gy9XXx3UEbdQGxlhrp0GZZm3coDLO8pXn9yRHUzPOz4P1spbE10vd8VOgLSqlU95
b5gLAmDfAO0RKLUowPSQ
=JycJ
-----END PGP SIGNATURE-----

--BzCohdixPhurzSK4--
