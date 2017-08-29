From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Do not bind to CHPN0001 touchscreen
Date: Tue, 29 Aug 2017 10:51:03 +0200
Message-ID: <20170829085103.yqgyphzcd4sihkca@ninjato>
References: <20170722185537.12696-1-hdegoede@redhat.com>
 <20170722185537.12696-2-hdegoede@redhat.com>
 <20170817193912.hccxyjwstrtr5oiv@ninjato>
 <0c72f919-eab2-2f3f-a760-1aacc25d2550@redhat.com>
 <c8a3428a-4279-dce6-7bce-d6785e0b9960@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pjvk3c6tcx4oualm"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43596 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750779AbdH2IvF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Aug 2017 04:51:05 -0400
Content-Disposition: inline
In-Reply-To: <c8a3428a-4279-dce6-7bce-d6785e0b9960@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org


--pjvk3c6tcx4oualm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> So thinking more about this it might be cleaner to add a blacklist
> of _CID / _HID ACPI-ids for which power-management should be disabled
> to drivers/acpi/device_pm.c : acpi_bus_init_power().
>=20
> When I've some time to look into this I will write a patch following
> that approach.
>=20
> So lets forget about the approach to add an i2c_driver match callback
> for now.

Thanks for the update! That sounds better to me from the high level view
that I have. Thanks to you and Dmitry for discussing the details
throughly. Very much appreciated!


--pjvk3c6tcx4oualm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmlKvcACgkQFA3kzBSg
KbaFaA/+O895rXmveUAMHUOsOpFETX6jf3d+vGugPs/sW+id7EK24aB2H9JuDJh+
9dzwm/CWcXzCwXjO2SX+IwHX4xnDN0/HD8J+rNNY/Q6pHobfbVlKOwlT9dUZzHpR
B3pd0ermKULN1oFehXmVA2NrekXQgt4M+WQyDAgO/PVQU8iuBX6hMa2IjVQZPPB4
3DhbejYzQpfVDx0JzYHhmX76c72qdIukWcozsbH46HbwUF7Rsn+0yKtluv8vPFbT
r0efR4mtVwXODz3HwBcho/jAFUlcGhY8zjdKOw4eEStW7zTsPJp0arumv+KaRm08
OHt1ERaH4DmH1mRE00BxdvD8EtR8H+B3WI75lLGsIVQm6ciIKhkFNtfTx4mt5h/K
fEcShlWEfkcCdyXGJwZHSCV/cjME8TlQkpTrWOxq8q916Wm4nrVwqucwtQGAjMLk
CkXVumbNnddDRVAGKgf5ABk3vn8tFh9I1PwZ5EqMwhzStC6FWFgBg/iARFUnXhUR
sQs3Q6yMcz5vuAcIX/KXOCBh/rlyNho7dLHc712VIcrtjZvDYpTncZcNrMryQaVA
v6Pw7jvxp/G3hdKz1nr1w/mQiyuHOBrsU6WAp+qOAYPGYGfUAYaJrw0Al3X2fSYB
wJ3TlaSdig5Ztk2aI3SJT2e4spbRHZpmmJHnIgozTCoVypatHJE=
=9JVB
-----END PGP SIGNATURE-----

--pjvk3c6tcx4oualm--
