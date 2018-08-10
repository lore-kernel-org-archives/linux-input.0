From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH 2/4] HID: multitouch: don't check
 HID_GROUP_MULTITOUCH_WIN_8 for serial protocol
Date: Thu, 9 Aug 2018 17:50:03 -1000
Message-ID: <20180810035003.hga4n72rl5e2c4hg@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
 <0aaacf083be5b68a830f9e174f9abee3b00c5a51.1530402641.git.joeypabalinas@gmail.com>
 <CAO-hwJJpAfvvP+s9Cqmi8v7pHsEw3tKTrySQaEg8TUzPTFcQfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7stbl6j5qdp3x27t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJJpAfvvP+s9Cqmi8v7pHsEw3tKTrySQaEg8TUzPTFcQfA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org


--7stbl6j5qdp3x27t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 10:16:01AM +0200, Benjamin Tissoires wrote:
> There is a tiny difference between the HID group (this device looks
> like it is used as a Win 8 device) and the device class (this is
> effectively a Win8 device)
>=20
> It makes sense to remove this check for Win8 devices, but I don't
> think it should be done for all devices.
>=20
> All in all, it won't change much.

Hm, that sounds sane. I'll do a bit more research on this and see if
restricting it to just Win8 devices is simple enough to be worthwhile.

--=20
Cheers,
Joey Pabalinas

--7stbl6j5qdp3x27t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlttC2oACgkQruvLfWhy
VBkbEBAAqsuBA3i2LN1qeeT8ZvjBOfJVUG+MK/wEOkRrtHas3VVc2LoYQM4MGKY2
/gcFjQQWqRJ4VCQ/YrahVMSV83xmVOTMVmmPQXsstJCZPPjUWNa2TFNF7iiafToa
n6UBzT6un5Y6Bqy2HTXN9v1rzoHGb0nw8f2LfW63hnWY1x5LWrb4AmrFVa+XfzLa
+sqM4x/NBnM7nZ12LEaygoiI7xlCxrFdeeFi3XpI7LZAN3CRFGHqJY7K3CfMle1X
k7YCS1wCigEK6Ep68pVKjY6F5xrIB18kYOBZfoH3ykzG01XZq3iFwRQwl4qrNOAE
7kgozmF76kT96e8i7T7aE/Xpf4KC+d2wmtLbx+yNKrptEWKRZKubTpLv5EtHpbhA
Ij5ODdpO3/Gr4efN/EDh+UgxMR3qbMQnC0Dg93BvUbMW+4I9JXJX/ADPQzvSbout
EfU2H/11UMkW/h0OihBhhHc463tHD075ugGyc46zhTet6LjG4DEWMKXG9bOS9sov
/nqJ8laNdvyY1Thk6zJnlDMfLbPIDSjZed/sJQ8Oi44gAJKUxtFiPQsSbh2C84eb
SL14d04vIgA30+Edj6P6PgjTVRaacwv5kyh82s1VogS5B1MXC/Q3yLD4+k8P/acQ
tDyUls1Y0PCUmRKpcJEDWUZgfAI0IiGVgHgv6CN3sRPFFT6HM7Q=
=TYpt
-----END PGP SIGNATURE-----

--7stbl6j5qdp3x27t--
