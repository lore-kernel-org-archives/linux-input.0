From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH 1/4] HID: multitouch: add MT_QUIRK_NOT_SEEN_MEANS_UP to
 MT_CLS_WIN_8 quirks
Date: Thu, 9 Aug 2018 13:57:33 -1000
Message-ID: <20180809235732.oecx4jfyzerjgsvu@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
 <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
 <CAO-hwJ+1PEH7VJjQThoihqBUK0yVNvak78GEiAZ7VpDEQ5EFiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yhxhrwftljtjapwv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJ+1PEH7VJjQThoihqBUK0yVNvak78GEiAZ7VpDEQ5EFiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Joey Pabalinas <joeypabalinas@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org


--yhxhrwftljtjapwv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 09:53:19AM +0200, Benjamin Tissoires wrote:
> NACK on this.
> If the Surface has a buggy firmware, we should handle it as a special
> case, not as a common failure.
> Also, I am not sure this quirk is compatible with Win 8 specification.
> Last, we now have a timeout for unreleased touches, so I really don't
> think you need that in recent kernels.
>=20
> Cheers,
> Benjamin
>=20
> >         { .name =3D MT_CLS_EXPORT_ALL_INPUTS,
> >                 .quirks =3D MT_QUIRK_ALWAYS_VALID |
> >                         MT_QUIRK_CONTACT_CNT_ACCURATE,
> >                 .export_all_inputs =3D true },
> >         { .name =3D MT_CLS_WIN_8_DUAL,
> > --
> > 2.18.0
> >
Ah shoot, I had completely missed this reply to my earlier patchset, I
apologize. Now that you mention it, I think handling it as a special
case would be a better way to handle it, so I'll do a bit more research
on the quirk thing and then revise my patches (assuming they end up
as something still worth sending). Appreciate the comments, thanks.

--=20
Cheers,
Joey Pabalinas

--yhxhrwftljtjapwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlts1OoACgkQruvLfWhy
VBmoMQ//ZIPrFEFUd828MQXkNcaoq89nPWA2T8BYlTs6MHI0wcPoiCGUrXEp5Goi
FUpbPb9hB1Emq4sdhNbcKRf/g5S2uGcaHfIeJESCX/VWumODzf6pIKIjFyZTly/Z
loKL83bFWC+k3b/gnf0mShRGVmlbWzQsL/A4l0UaUuCkVDbMkKW7l45iUMOCGU4W
so9BkC2L3+1KRqjDUmizsvz/bUC6uGzL+LO0YFDtlHwxHCV9bp+9XfVhXbpOum1P
nepAkRYK41240P8Dtbg0GJ1RrHIdKdEkApkwjeqlUIZ4uAoDyiEGb2+NCpKKQ5Pp
OrE/OKkHgYbtw0FVK+y03koLP/Q+xWE5MrRnfgYHgnynOJRDEN3beknetf9MbcCP
OAigw5ufbWsn5MW5yjJ7CeAO9nnpMj0FbTMV+NZ1xyJRNBbBYMoG1vGKak8Z5D7c
h21Z115DW/Z1GwK3sJc7Zwllm4an+V6pKCmNz4W7JZCyxNt7NSUf1MbWy4T5sQhn
YNSKYI9jPbywXlOfvoE5USHOKRdQEep5oQKb7rXA6lxKCye60Em916U3AXpsH6bC
hfFeisrlM2l+Eg1yFCsX/CzxpChP1nF1OUk/wVG4lIlYYDLIQW/RAkHRJrMtXov/
Uq7dNSBK9CCS9H3pRn7eqq9abeAVxskRO+TFn3pupUkUm4ps9xI=
=g4uC
-----END PGP SIGNATURE-----

--yhxhrwftljtjapwv--
