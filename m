From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: ALPS - fix max coordinates for v5 and v7 protocols
Date: Sun, 22 Mar 2015 11:48:17 +0100
Message-ID: <550E9DF1.60507@redhat.com>
References: <20150322033656.GA35352@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58302 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbbCVKuz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Mar 2015 06:50:55 -0400
In-Reply-To: <20150322033656.GA35352@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Santiago Gala <sgala@apache.org>, Yunkang Tang <yunkang.tang@cn.alps.com>, linux-kernel@vger.kernel.org

Hi,

On 22-03-15 04:36, Dmitry Torokhov wrote:
> Commit 3296f71cd2fde7a2ad52e66a27eae419f6328066 ("Input: ALPS - conso=
lidate
> setting protocol parameters") inadvertently moved call to
> alps_dolphin_get_device_area() from v5 to v7 protocol, causing both
> protocols report incorrect maximum values for X and Y axes which resu=
lted
> in crash in Synaptics X driver.
>
> Reported-by: Santiago Gala <sgala@apache.org>
> Reported-by: Pali Roh=E1r <pali.rohar@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

=46ix looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/input/mouse/alps.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 1bd15eb..33198b9 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2281,10 +2281,12 @@ static int alps_set_protocol(struct psmouse *=
psmouse,
>   		priv->set_abs_params =3D alps_set_abs_params_mt;
>   		priv->nibble_commands =3D alps_v3_nibble_commands;
>   		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> -		priv->x_max =3D 1360;
> -		priv->y_max =3D 660;
>   		priv->x_bits =3D 23;
>   		priv->y_bits =3D 12;
> +
> +		if (alps_dolphin_get_device_area(psmouse, priv))
> +			return -EIO;
> +
>   		break;
>
>   	case ALPS_PROTO_V6:
> @@ -2303,9 +2305,8 @@ static int alps_set_protocol(struct psmouse *ps=
mouse,
>   		priv->set_abs_params =3D alps_set_abs_params_mt;
>   		priv->nibble_commands =3D alps_v3_nibble_commands;
>   		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> -
> -		if (alps_dolphin_get_device_area(psmouse, priv))
> -			return -EIO;
> +		priv->x_max =3D 0xfff;
> +		priv->y_max =3D 0x7ff;
>
>   		if (priv->fw_ver[1] !=3D 0xba)
>   			priv->flags |=3D ALPS_BUTTONPAD;
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
