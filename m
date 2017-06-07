From: Ivan Shapovalov <intelfx@intelfx.name>
Subject: Re: HID: input: support for misbehaving mice having logical_minimum
 != 0
Date: Wed, 07 Jun 2017 03:30:53 +0300
Message-ID: <1496795453.27238.0.camel@intelfx.name>
References: <1496529275.7616.7.camel@intelfx.name>
Reply-To: intelfx@intelfx.name
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-XnR3ZOsB/6meFdBBBFja"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34279 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdFGAbA (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Jun 2017 20:31:00 -0400
Received: by mail-lf0-f47.google.com with SMTP id v20so59782152lfa.1
        for <linux-input@vger.kernel.org>; Tue, 06 Jun 2017 17:30:59 -0700 (PDT)
Received: from intelfx-laptop.local ([93.175.7.30])
        by smtp.gmail.com with ESMTPSA id r38sm10898lfi.4.2017.06.06.17.30.56
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Jun 2017 17:30:56 -0700 (PDT)
In-Reply-To: <1496529275.7616.7.camel@intelfx.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


--=-XnR3ZOsB/6meFdBBBFja
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

Anyone? Or should I resend this with [PATCH] in Subject: to make this
noticed?

--=20
Ivan Shapovalov / intelfx /
--=-XnR3ZOsB/6meFdBBBFja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAlk3ST0ACgkQe94XyOTj
Dp0j3RAAwSMcek/gDnjSyLq5o6pY59oN9rYw6nWN8pQ+r3Z/AD7hJJseFEqSXIS8
Zep18wtdHDzPCTgA4p47bUU6mTJ4jofy4GuaTYL+BIVh5GdvCljbAzTFlWHPbg11
iajZZixpCJCwlDRjLFv0a5SNEKz5eVW08t7RVq0e1xpxc3m+5iVhKs5lAYpalBlV
n5dydgjAOtGuoCNGwwqrr1Mm9m2iXkWJA5fMVRY3XPsu8tCsT2hpX5a3E4aKOYow
yrZJ6JSNtOQiZfyXfG0chwl/Kk1IL/pRC4xi6tS2DE+76NvIMRdqehajVu1zrxfV
tKTjUUxqCQP4LyVuLkOSvGLYe1xCVHmPsadekwC5j+JhyEUyhePpAsLnOPqs+/gO
A/4pruSirtSlAIoWQbNPYMd6f5ilOdtxVtMemtvVcd2bd/VIQ5h/HyeGpl9mKWtl
laql8+njU77rNVUV5M6aK5bB5J/GWL2GE5Rrj03QCP85b5cLkv2caKL86dJaRwMC
emSOhRzm/6Hk06tTXYbhjy1Yr5AXTF6wRM8ZA3WZuJubA0vHIfmX/YBS6I+azDvD
QhW7VS9OBIS2jkzp+9q/1J9qH6NhXunxjJPRfyrZGb9I710hr1lNESAHWqTsoI8Q
Oe2k7ew8UTGKVADpv/GhBg0FoAF/Pw3+E7qECF4Qy8fBm2QlkJg=
=69YL
-----END PGP SIGNATURE-----

--=-XnR3ZOsB/6meFdBBBFja--

