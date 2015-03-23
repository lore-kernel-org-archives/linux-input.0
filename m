From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: ALPS - Detect trackstick presence for v7 protocol
Date: Mon, 23 Mar 2015 12:39:48 +0100
Message-ID: <550FFB84.6000609@redhat.com>
References: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33637 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbbCWLjv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 07:39:51 -0400
In-Reply-To: <1427031971-13018-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Santiago Gala <sgala@apache.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 22-03-15 14:46, Pali Roh=C3=A1r wrote:
> This patch adds detection of trackstick for v7 protocol devices. Code=
 in this
> patch is used in official Dell touchpad linux drivers for Dell models=
:
> Dell Latitude E5250/5250, E5450/5450, E5550/5550
>
> Detection code and base reg for alps v3 rushmore and v7 devices is ex=
acly same.
>
> Also user in bug https://bugzilla.kernel.org/show_bug.cgi?id=3D94801 =
reported
> that Toshiba Sattellite Z30-A-1DG has only alps v7 touchpad device wi=
thout
> trackstick and kernel reports to userspace also redundant trackstick =
device.
>
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Looks good, but has this been tested on a laptop which actually has a v=
7 pad +
trackstick? I would like to see this actually tested on at least one su=
ch
laptop before it gets merged.

Regards,

Hans



> ---
>   drivers/input/mouse/alps.c |   12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 33198b9..c9cd27a 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -30,6 +30,7 @@
>   #define ALPS_CMD_NIBBLE_10	0x01f2
>
>   #define ALPS_REG_BASE_RUSHMORE	0xc2c0
> +#define ALPS_REG_BASE_V7	0xc2c0
>   #define ALPS_REG_BASE_PINNACLE	0x0000
>
>   static const struct alps_nibble_commands alps_v3_nibble_commands[] =
=3D {
> @@ -1795,7 +1796,7 @@ static int alps_absolute_mode_v3(struct psmouse=
 *psmouse)
>   	return 0;
>   }
>
> -static int alps_probe_trackstick_v3(struct psmouse *psmouse, int reg=
_base)
> +static int alps_probe_trackstick_v3_v7(struct psmouse *psmouse, int =
reg_base)
>   {
>   	int ret =3D -EIO, reg_val;
>
> @@ -1880,7 +1881,7 @@ static int alps_hw_init_v3(struct psmouse *psmo=
use)
>   	int reg_val;
>   	unsigned char param[4];
>
> -	reg_val =3D alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACL=
E);
> +	reg_val =3D alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_PINN=
ACLE);
>   	if (reg_val =3D=3D -EIO)
>   		goto error;
>
> @@ -2260,8 +2261,8 @@ static int alps_set_protocol(struct psmouse *ps=
mouse,
>   		priv->x_bits =3D 16;
>   		priv->y_bits =3D 12;
>
> -		if (alps_probe_trackstick_v3(psmouse,
> -					     ALPS_REG_BASE_RUSHMORE) < 0)
> +		if (alps_probe_trackstick_v3_v7(psmouse,
> +						ALPS_REG_BASE_RUSHMORE) < 0)
>   			priv->flags &=3D ~ALPS_DUALPOINT;
>
>   		break;
> @@ -2311,6 +2312,9 @@ static int alps_set_protocol(struct psmouse *ps=
mouse,
>   		if (priv->fw_ver[1] !=3D 0xba)
>   			priv->flags |=3D ALPS_BUTTONPAD;
>
> +		if (alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_V7) < 0)
> +			priv->flags &=3D ~ALPS_DUALPOINT;
> +
>   		break;
>   	}
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
