From: Masaki Ota <masaki.ota@jp.alps.com>
Subject: RE: [PATCH] Support TrackStick of Thinkpad L570
Date: Wed, 29 Nov 2017 00:28:51 +0000
Message-ID: <TYXPR01MB0719138F86E0F9B366CEEAF9C73B0@TYXPR01MB0719.jpnprd01.prod.outlook.com>
References: <20171120075530.4880-1-masaki.ota@jp.alps.com>
 <20171126001559.uqeud7wxgjhkldgd@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ty1jpn01on0070.outbound.protection.outlook.com ([104.47.93.70]:20704
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751722AbdK2A24 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Nov 2017 19:28:56 -0500
In-Reply-To: <20171126001559.uqeud7wxgjhkldgd@dtor-ws>
Content-Language: ja-JP
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Masaki Ota <012nexus@gmail.com>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "pali.rohar@gmail.com" <pali.rohar@gmail.com>, "aaron.ma@canonical.com" <aaron.ma@canonical.com>, "jaak@ristioja.ee" <jaak@ristioja.ee>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Domitry,

I think we can add the code to HID for this device, but we will not use SMB=
us interface for Touchpad in the future.
We should not do it.

Best Regards,
Masaki Ota
-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]=20
Sent: Sunday, November 26, 2017 9:16 AM
To: Masaki Ota <012nexus@gmail.com>
Cc: benjamin.tissoires@redhat.com; pali.rohar@gmail.com; aaron.ma@canonical=
.com; jaak@ristioja.ee; =1B$BB@ED=1B(B =1B$B??4n=1B(B Masaki Ota <masaki.ot=
a@jp.alps.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support TrackStick of Thinkpad L570

Hi,

On Mon, Nov 20, 2017 at 04:55:30PM +0900, Masaki Ota wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> - The issue is that Thinkpad L570 TrackStick does not work. Because the m=
ain interface of Thinkpad L570 device is SMBus, so ALPS overlooked PS2 inte=
rface Firmware setting of TrackStick. The detail is that TrackStick otp bit=
 is disabled.

Is it custom protocol over SMBus/I2C or HID (via i2c-hid)? If it is custom =
protocol, can we add the proper driver to the kernel for it so we can get a=
way from the PS/2 emulation in firmware?

Thanks!

> - Add the code that checks 0xD7 address value. This value is device numbe=
r information, so we can identify the device by checking this value.
> - If we check 0xD7 value, we need to enable Command mode and after check =
the value we need to disable Command mode, then we have to enable the devic=
e(0xF4 command).
> - Thinkpad L570 device number is 0x0C or 0x1D. If it is TRUE, enable ALPS=
_DUALPOINT flag.
>=20
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> ---
>  drivers/input/mouse/alps.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c=20
> index 850b00e3ad8e..cce52104ed5a 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2541,13 +2541,28 @@ static int=20
> alps_update_btn_info_ss4_v2(unsigned char otp[][4],  }
> =20
>  static int alps_update_dual_info_ss4_v2(unsigned char otp[][4],
> -				       struct alps_data *priv)
> +				       struct alps_data *priv,
> +					struct psmouse *psmouse)
>  {
>  	bool is_dual =3D false;
> +	int reg_val =3D 0;
> +	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> =20
> -	if (IS_SS4PLUS_DEV(priv->dev_id))
> +	if (IS_SS4PLUS_DEV(priv->dev_id)) {
>  		is_dual =3D (otp[0][0] >> 4) & 0x01;
> =20
> +		/* For support TrackStick of Thinkpad L570 device */
> +		if (alps_exit_command_mode(psmouse) =3D=3D 0 &&
> +			alps_enter_command_mode(psmouse) =3D=3D 0) {
> +			reg_val =3D alps_command_mode_read_reg(psmouse, 0xD7);
> +		}
> +		alps_exit_command_mode(psmouse);
> +		ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> +
> +		if (reg_val =3D=3D 0x0C || reg_val =3D=3D 0x1D)
> +			is_dual =3D true;
> +	}
> +
>  	if (is_dual)
>  		priv->flags |=3D ALPS_DUALPOINT |
>  					ALPS_DUALPOINT_WITH_PRESSURE;
> @@ -2570,7 +2585,7 @@ static int alps_set_defaults_ss4_v2(struct=20
> psmouse *psmouse,
> =20
>  	alps_update_btn_info_ss4_v2(otp, priv);
> =20
> -	alps_update_dual_info_ss4_v2(otp, priv);
> +	alps_update_dual_info_ss4_v2(otp, priv, psmouse);
> =20
>  	return 0;
>  }
> --
> 2.14.1
>=20

--=20
Dmitry
