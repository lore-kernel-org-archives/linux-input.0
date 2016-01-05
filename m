From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Tue, 5 Jan 2016 17:44:21 +0100
Message-ID: <20160105164421.GP22661@pali>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33264 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbcAEQoY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jan 2016 11:44:24 -0500
Content-Disposition: inline
In-Reply-To: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Santiago Gala <sgala@apache.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Hung <alex.hung@canonical.com>

On Sunday 22 March 2015 14:46:11 Pali Roh=C3=A1r wrote:
> This patch adds detection of trackstick for v7 protocol devices. Code=
 in this
> patch is used in official Dell touchpad linux drivers for Dell models=
:
> Dell Latitude E5250/5250, E5450/5450, E5550/5550
>=20
> Detection code and base reg for alps v3 rushmore and v7 devices is ex=
acly same.
>=20
> Also user in bug https://bugzilla.kernel.org/show_bug.cgi?id=3D94801 =
reported
> that Toshiba Sattellite Z30-A-1DG has only alps v7 touchpad device wi=
thout
> trackstick and kernel reports to userspace also redundant trackstick =
device.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---

Hello!

Alex now tested this patch on two Dell machines with ALPS: E5450 (with
TrackStick) and E5250 (without TrackStick).

With patch nothing was changed for E5450. And E5250 with patch does not
show trackstick input device anymore.

Tested-by: Alex Hung <alex.hung@canonical.com>

>  drivers/input/mouse/alps.c |   12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 33198b9..c9cd27a 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -30,6 +30,7 @@
>  #define ALPS_CMD_NIBBLE_10	0x01f2
> =20
>  #define ALPS_REG_BASE_RUSHMORE	0xc2c0
> +#define ALPS_REG_BASE_V7	0xc2c0
>  #define ALPS_REG_BASE_PINNACLE	0x0000
> =20
>  static const struct alps_nibble_commands alps_v3_nibble_commands[] =3D=
 {
> @@ -1795,7 +1796,7 @@ static int alps_absolute_mode_v3(struct psmouse=
 *psmouse)
>  	return 0;
>  }
> =20
> -static int alps_probe_trackstick_v3(struct psmouse *psmouse, int reg=
_base)
> +static int alps_probe_trackstick_v3_v7(struct psmouse *psmouse, int =
reg_base)
>  {
>  	int ret =3D -EIO, reg_val;
> =20
> @@ -1880,7 +1881,7 @@ static int alps_hw_init_v3(struct psmouse *psmo=
use)
>  	int reg_val;
>  	unsigned char param[4];
> =20
> -	reg_val =3D alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACL=
E);
> +	reg_val =3D alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_PINN=
ACLE);
>  	if (reg_val =3D=3D -EIO)
>  		goto error;
> =20
> @@ -2260,8 +2261,8 @@ static int alps_set_protocol(struct psmouse *ps=
mouse,
>  		priv->x_bits =3D 16;
>  		priv->y_bits =3D 12;
> =20
> -		if (alps_probe_trackstick_v3(psmouse,
> -					     ALPS_REG_BASE_RUSHMORE) < 0)
> +		if (alps_probe_trackstick_v3_v7(psmouse,
> +						ALPS_REG_BASE_RUSHMORE) < 0)
>  			priv->flags &=3D ~ALPS_DUALPOINT;
> =20
>  		break;
> @@ -2311,6 +2312,9 @@ static int alps_set_protocol(struct psmouse *ps=
mouse,
>  		if (priv->fw_ver[1] !=3D 0xba)
>  			priv->flags |=3D ALPS_BUTTONPAD;
> =20
> +		if (alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_V7) < 0)
> +			priv->flags &=3D ~ALPS_DUALPOINT;
> +
>  		break;
>  	}
> =20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
