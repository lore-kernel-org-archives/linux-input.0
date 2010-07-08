From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH] hid: ignore digitizer usage Undefined (0x00)
Date: Wed, 7 Jul 2010 23:16:15 -0400
Message-ID: <20100708031615.GB20081@alittletooquiet.net>
References: <20100527151808.GA484@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:59351 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab0GHDQQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Jul 2010 23:16:16 -0400
Content-Disposition: inline
In-Reply-To: <20100527151808.GA484@alittletooquiet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bjorn Behrendt <bbehrendt@msjvermont.org>, linux-input@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

This patch has gone ignored on the linux-input mailing list.  Perhaps that =
was
done intentionally, but I wanted to try once more to get it looked at before
giving up.

Can you comment?

Thanks,
Forest

On Thu, May 27, 2010 at 11:18:08AM -0400, Forest Bond wrote:
> SMART Technologies has recommended this change to fix a problem reported
> with SMART Board series interactive whiteboards.
>=20
> A description of the device-specific symptom follows:
>=20
>   When the board is connected my mouse bounces up to the top left corner.
>=20
> Bjorn has tested this fix with model SB680.
>=20
> Tested-by: Bjorn Behrendt <bbehrendt@msjvermont.org>
> Signed-off-by: Forest Bond <forest@alittletooquiet.net>
> ---
>  drivers/hid/hid-input.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 7a0d2e4..6b10e5a 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -301,6 +301,9 @@ static void hidinput_configure_usage(struct hid_input=
 *hidinput, struct hid_fiel
> =20
>  	case HID_UP_DIGITIZER:
>  		switch (usage->hid & 0xff) {
> +		case 0x00: /* Undefined */
> +			goto ignore;
> +
>  		case 0x30: /* TipPressure */
>  			if (!test_bit(BTN_TOUCH, input->keybit)) {
>  				device->quirks |=3D HID_QUIRK_NOTOUCH;
> --=20
> 1.7.0.4

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFMNUL/RO4fQQdv5AwRAtp8AKDZgZ1kV4adni2wK4vnPMVofKNOHACeM3VV
FT21Z7gFH16hCDR8XiCbsNs=
=7iMa
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
