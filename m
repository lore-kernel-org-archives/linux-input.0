From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Do not bind to CHPN0001 touchscreen
Date: Thu, 17 Aug 2017 21:39:12 +0200
Message-ID: <20170817193912.hccxyjwstrtr5oiv@ninjato>
References: <20170722185537.12696-1-hdegoede@redhat.com>
 <20170722185537.12696-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tzsrhrz7gahwvwmv"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60920 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752632AbdHQTjO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 15:39:14 -0400
Content-Disposition: inline
In-Reply-To: <20170722185537.12696-2-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org


--tzsrhrz7gahwvwmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey guys,

Sorry, I don't understand some of the stuff here. But I'd like to
understand it before I add something to the I2C core. Especially as it
feels a bit a the edge of the driver model to me.

On Sat, Jul 22, 2017 at 08:55:37PM +0200, Hans de Goede wrote:
> The CHPN0001 ACPI device has a _CID of PNP0C50 but is not HID compatible,
> it uses its own protocol which is handled by the chipone_icn8318 driver.
>=20
> If the i2c_hid_driver's probe functon gets called it will fail with a
> "hid_descr_cmd failed" error.

That sounds like it fails pretty late. I'd assume we could check the
blacklist right at the beginning of probe and bail out immediately?

> Worse, after the probe failure the i2c / ACPI core code will put the ACPI
> device in D3 state

Where does that happen? Sorry, I can't find it. Would it be an idea to
add a flag somewhere telling the device should not be put into D3? That
would be way more generic in case this happens outside I2C world, or?
Disclaimer: I am brainstorming here, don't know super much about ACPI.

> This commit adds a match callback and returns -ENODEV for i2c_client-s
> with a CHPN0001 ACPI device id, so that the probe function never gets
> called, fixing the controller losing its firmware.

Do you know if something like a match-callback exists somewhere else in
the kernel?

Regards,

   Wolfram


--tzsrhrz7gahwvwmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmV8NwACgkQFA3kzBSg
KbZY5xAAokA05IRMLnYvBKNL8lQZJgmHZre0jVS8174gb6ps/geS3bDVZLjPwyu+
sHJbZ8Aba5d+AvrY2RQ/3jebAQ/pG9kwOuQQGVyk00z+3eTx3/68PWaYIW187vCb
qCi9e2/qoXWbh+WUDQO2/AkEqK/E2cTmLds0WCG0Hx8vaQx9Z+mXBChQSz686oxS
BVbvf3zoE9ljQwzcoDLae3TPc9MFz1qB6MU77v9UO+oeDJ+ppY1ULLtz4YavFPcN
GQFp0hYBBOJKsjvtgUyUe4tH5EDluHvX1QOvVMtSE/Z9Btqv55Qn/u+FT2OmTfMt
MUot9oYe/SRKBkoWT3choJ50TM25Z6tf7n3IOiIRFTbw783kkD5PZUxL1BrcpIoG
AVAobQ7m0PigLnEmgBV6esKhVTL2a9cSqSAbx2zOpV0Lql5JiBDQPqseS5m9vvWP
aJP9YE7oSyt3HovcFnA1epStT9+nf65WPAeZEJWhJ2wUrBLAD9fxg65TH2bpdJmm
+zO2C4GDRiKijvnF66Pc08KICc19mHrcCmhVC6mcZldODbsJ1ahcnpoT9CUVoJvJ
5VimrYX/i25GTsBnqX7FqFHMf29mbMzwW8uGGtG1pjW7ytugPak1SyEPLVz/G9gS
waKzXEzei1TCL6AlSav+1/5PnjS7pvv4c5JMb58tGrwlgJ6KXDU=
=QOO4
-----END PGP SIGNATURE-----

--tzsrhrz7gahwvwmv--
