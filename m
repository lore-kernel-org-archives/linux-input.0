From: Ivan Shapovalov <intelfx@intelfx.name>
Subject: Re: HID: input: support for misbehaving mice having logical_minimum
 != 0
Date: Sun, 21 Jan 2018 09:01:39 +0300
Message-ID: <1516514499.14165.1.camel@intelfx.name>
References: <1496529275.7616.7.camel@intelfx.name>
Reply-To: intelfx@intelfx.name
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OuxEZPA75V+I8GnuwZUK"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38571 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeAUGBo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Jan 2018 01:01:44 -0500
Received: by mail-lf0-f67.google.com with SMTP id g72so6764637lfg.5
        for <linux-input@vger.kernel.org>; Sat, 20 Jan 2018 22:01:43 -0800 (PST)
In-Reply-To: <1496529275.7616.7.camel@intelfx.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>


--=-OuxEZPA75V+I8GnuwZUK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2017-06-04 at 01:34 +0300, Ivan Shapovalov wrote:
> Hello folks,
>=20
> (this is not an actual patch submission; also, this is my first
> submission to mainline kernel, so bear with me...)
>=20
> This is an attempt to fix touchpad handling on Sony Vaio Tap 11.
> On that hardware, touchpad is visible as a generic hid-input mouse.
> The problem is that kernel does not register mouse button release
> events because the hardware reports bogus logical minimum (1) in the
> respective field of the HID descriptor. (Sorry for probably wrong
> terminology.)
>=20
> Moreover, the reported logical maximum (5) also disagrees with what
> I've seen in other generic USB mice (it's 1 everywhere else), but I
> do
> not see the logic by which it is determined -- blindly forcing it to
> 1
> system-wide locks me out of the keyboard.
>=20
> A PoC patch is below that makes touchpad work on that system.
> However,
> the keyboard/mouse on that system are connected via a WUSB dongle
> with
> a generic USB VID/PID, so matching via these (as in the rest of
> usbhid
> quirks) seems inappropriate.
>=20
> So, I'd appreciate a hint on how to match that hardware for a proper
> quirk and what to do with the odd reported logical maximum.
>=20
> I'm also attaching the output of various debug tools ran before and
> after patching.
>=20
> ---
>  drivers/hid/hid-input.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index d05f903c7614..f8e780185c8a 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1069,6 +1069,16 @@ static void hidinput_configure_usage(struct
> hid_input *hidinput, struct hid_fiel
>  	if (usage->type =3D=3D EV_KEY) {
>  		set_bit(EV_MSC, input->evbit);
>  		set_bit(MSC_SCAN, input->mscbit);
> +
> +		if (field->logical_minimum > 0) {
> +			hid_err(device, "XXX: EV_KEY logical_minimum
> =3D %d !=3D 0 - updating\n", field->logical_minimum);
> +			field->logical_minimum =3D 0;
> +			if (field->logical_maximum !=3D 1) {
> +				hid_err(device, "XXX: EV_KEY
> logical_maximum =3D %d !=3D 1 - updating\n", field->logical_maximum);
> +				field->logical_maximum =3D 1;
> +			}
> +		}
> +
>  	}
> =20
>  ignore:
> --=20
> 2.13.0
>=20
> Thanks,

Ping?
Anyone?

Cc'ing maintainers of HID core layer as per MAINTAINERS.

Cheers,
--=20
Ivan Shapovalov / intelfx /
--=-OuxEZPA75V+I8GnuwZUK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAlpkLMMACgkQe94XyOTj
Dp0O5xAAtJeHkZDhBc8FUiUMiadVI53HH6V+9tUtBpvfidPVsiHUGU9zLfNxhUIv
nxJHXexuSZXdmZ2MXrV+tCaCwg4oATrjJ0d8ji01FvmcTNQgK75y/abTfjpk3XtU
JreFJ9TE965HSNY6LWPur2Mt+KF7ESgFegdv86xKbKdIEIiXnq4wjh9c9NcZHlbp
3/PDU2xPGAVqFVvd4w0o/zqzaxYuucLPWnNgkDvysb+zdsMCsJZi7+El1I6n+Yh3
vyDIdCuEZH4g9Jjc56HUQ1D9rTpQa7k3gXzj9qUfZ8+rmTTqB0moCBP7pe8rdwuS
daFq5nnnULUtf/SERpb6JzjNLVjT1RdKbPSefuar1MKKDTyU13scpdG22WEGykcA
rBg5gu7hSGTxpB3c2n9e6fOaiy5IfKWQc9EjhQ2D3RuUyMoaUEFf4r7Zkhgczafo
TpXSYm6azQaW37Xzn5EyORNY3kIPPddvy6P9XIR7M4u7s6U2tmCU9m05lqtmS1DG
bM928ZppT4roN9o57/qUpseM8eHzOnRUym5oAA5V0a718fSA5j9zky0Drsan7/ls
qhuaR8Bh6jBXSBBTmamT2ILqOirVmbOkCGjmb6UCZcBWI+BKZH2wqnzAl9Roq2aX
AxmmlnZzAUAt3ZfMGZXN3njQELQIrZXPxh90I56vIE3qop+dOIc=
=+i8/
-----END PGP SIGNATURE-----

--=-OuxEZPA75V+I8GnuwZUK--

