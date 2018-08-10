From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH RESEND 1/4] HID: multitouch: add
 MT_QUIRK_NOT_SEEN_MEANS_UP to MT_CLS_WIN_8 quirks
Date: Thu, 9 Aug 2018 17:54:02 -1000
Message-ID: <20180810035402.eb4ljwfdw45jwj5t@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
 <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dmdg6ru22etdixj3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org


--dmdg6ru22etdixj3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 01:39:16PM -1000, Joey Pabalinas wrote:
> The firmware found in the touch screen of the Surface Pro 3 is slightly
> buggy and occasionally doesn't send lift off reports for contacts; add
> MT_QUIRK_NOT_SEEN_MEANS_UP to .quirks to compensate for the missed
> reports.
>=20
> Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

Sorry, my mail filters are in need of some adjusting; I completely missed
the review of the first send of this patchset :(

Please disregard this resend, as I am going to revise it and submit a
v2, thanks.

--=20
Cheers,
Joey Pabalinas

--dmdg6ru22etdixj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlttDFkACgkQruvLfWhy
VBmmOBAAh1q4iN7U17bzBTD0s9+oSqAWnHacb3BHggUCmCLQEB/eCalXvRB+69YX
phzqynXD7Ti3A6mrD3KPgJrTVeMqOv5bHarTL4AUvfsYocQIJ5MDgoJfLQpm6j90
FQfiOIor2V8j4UixPRwfbGV3ArDT5dmwsJB5U2CC7TCg71alYuC2g19FYL+lc+1J
XkJTYUUuJBClVK9ufe/C/wRBGv0HkqX91g+yafB1S9Wsst+WbwItWPb+1k3JWNV4
MkFC89MlbwrvIejNpCR73gm3zfjsoTz8sshJWY/jA0jz+Cn+l46o6bKraWSsjD8S
Wg05WX5uYXEZndMlcdwjvWql0ttCaRlwFxAVIvM/fYt6tq4aiJ8bvqPlx3aKD5bl
GElpQ+iGSMKG1yYyukjthKWI1N4rLTeKz+88oqLNZfwtFuoZousoEc92i+rikpXc
AbDNCjf4xYsPMrDAyoqkROD+Rv+inJ956sbebT2eyuHbhZEdOlvplcpEjlnDa1T4
SDRYiLQ8rXJSmecIL+Z76InOzox35OBa052mjsRQ3oyt/fJ6JBJ95kAp6UmIGhnG
62HQrVL9nlUpEKz5T3tQas4pFz21TEfgPk07pxM3v0Y8K2WNWNJlQWlMCMkcxv6R
lfppJG7jc/HkDXNwEid3euQsBZrhrr0DQayCYxu9t86PKjfTq+k=
=/rvP
-----END PGP SIGNATURE-----

--dmdg6ru22etdixj3--
