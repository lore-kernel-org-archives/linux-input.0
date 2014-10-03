From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/3] input: alps: For protocol V3, do not process data
 when last packet's bit7 is set
Date: Fri, 03 Oct 2014 11:51:22 +0200
Message-ID: <542E719A.8030509@redhat.com>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com> <1412329392-5580-3-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36017 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbaJCJvb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Oct 2014 05:51:31 -0400
In-Reply-To: <1412329392-5580-3-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 10/03/2014 11:43 AM, Pali Roh=C3=A1r wrote:
> Sometimes laptops with closed lid receive invalid ALPS protocol V3 pa=
ckets with
> last bit7 set.
>=20
> This happens on Dell Latitude laptops and it looks like it is BIOS bu=
g. Probably
> EC does not correctly split keyboard and touchpad PS/2 data and when =
laptop lid
> is closed it adds 0xFF packet into touchpad PS/2 data.
>=20
> When last packet's bit7 is set it is invalid ALPS packet. So Do not p=
rocess it
> and drop it with PSMOUSE_FULL_PACKET.
>=20
> After testing it looks like this patch fixed problem with reseting mo=
use (after
> series of invalid packets) when laptop lid is closed on Dell Latitude=
 machines.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> ---
>  drivers/input/mouse/alps.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 1bd5aa1..b1f44d4 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1179,6 +1179,16 @@ static psmouse_ret_t alps_process_byte(struct =
psmouse *psmouse)
>  		return PSMOUSE_BAD_DATA;
>  	}
> =20
> +	if (priv->proto_version =3D=3D ALPS_PROTO_V3 && psmouse->pktcnt =3D=
=3D psmouse->pktsize) {
> +		// For protocol V3, do not process data when last packet's bit7 is=
 set
> +		if (psmouse->packet[psmouse->pktcnt - 1] & 0x80) {
> +			psmouse_dbg(psmouse, "v3 discard packet[%i] =3D %x\n",
> +				    psmouse->pktcnt - 1,
> +				    psmouse->packet[psmouse->pktcnt - 1]);
> +			return PSMOUSE_FULL_PACKET;
> +		}
> +	}
> +

I wonder if this should not be PSMOUSE_BAD_DATA as a return value ? I r=
ealize that
with the 3th patch in place, that will cause an immediate reset, but if=
 your theory is
right that this ff gets inserted from the keyboard ps/2 stream, then we=
 actually want
a full reset as otherwise we will be out of sync then.

>  	/* Bytes 2 - pktsize should have 0 in the highest bit */
>  	if ((priv->proto_version < ALPS_PROTO_V5) &&
>  	    psmouse->pktcnt >=3D 2 && psmouse->pktcnt <=3D psmouse->pktsize=
 &&
>=20

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
