From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH] hid: ignore digitizer usage Undefined (0x00)
Date: Sat, 12 Jun 2010 18:43:01 -0400
Message-ID: <20100612224301.GF22467@alittletooquiet.net>
References: <20100527151808.GA484@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:55227 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab0FLWnD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Jun 2010 18:43:03 -0400
Content-Disposition: inline
In-Reply-To: <20100527151808.GA484@alittletooquiet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Bjorn Behrendt <bbehrendt@msjvermont.org>


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm not sure if anyone noticed this patch.  Did I send it to the right plac=
e?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

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

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFMFA11RO4fQQdv5AwRAl9pAJ9P3+bMO8Q8redDQ9vpkZGrp16BhQCgoERB
zZABF2iJidsme2AtFy62SRs=
=GEIo
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
