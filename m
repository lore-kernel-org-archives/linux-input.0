From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: ALPS - Report v3 pinnacle trackstick device only
 if is present
Date: Mon, 23 Mar 2015 12:42:25 +0100
Message-ID: <550FFC21.1000503@redhat.com>
References: <1427032068-13066-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57679 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752145AbbCWLma (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 07:42:30 -0400
In-Reply-To: <1427032068-13066-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 22-03-15 14:47, Pali Roh=C3=A1r wrote:
> This patch move v3 pinnacle code for trackstick detection from alps_h=
w_init_v3()
> to alps_set_protocol() so ALPS_DUALPOINT flag can be cleared before r=
egistering
> trackstick input device in kernel.
>
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Looks good:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/input/mouse/alps.c |   12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index c9cd27a..d24e98d 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1877,15 +1877,12 @@ error:
>
>   static int alps_hw_init_v3(struct psmouse *psmouse)
>   {
> +	struct alps_data *priv =3D psmouse->private;
>   	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
>   	int reg_val;
>   	unsigned char param[4];
>
> -	reg_val =3D alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_PINN=
ACLE);
> -	if (reg_val =3D=3D -EIO)
> -		goto error;
> -
> -	if (reg_val =3D=3D 0 &&
> +	if ((priv->flags & ALPS_DUALPOINT) &&
>   	    alps_setup_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACLE) =3D=3D=
 -EIO)
>   		goto error;
>
> @@ -2249,6 +2246,11 @@ static int alps_set_protocol(struct psmouse *p=
smouse,
>   		priv->decode_fields =3D alps_decode_pinnacle;
>   		priv->nibble_commands =3D alps_v3_nibble_commands;
>   		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> +
> +		if (alps_probe_trackstick_v3_v7(psmouse,
> +						ALPS_REG_BASE_PINNACLE) < 0)
> +			priv->flags &=3D ~ALPS_DUALPOINT;
> +
>   		break;
>
>   	case ALPS_PROTO_V3_RUSHMORE:
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
