From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 6/7] input: alps: Add sanity checks for non DualPoint
 devices
Date: Sun, 11 Jan 2015 16:31:00 -0800
Message-ID: <20150112003100.GC31862@dtor-ws>
References: <1415993906-13307-1-git-send-email-pali.rohar@gmail.com>
 <1415993906-13307-7-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:59858 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbALAbG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jan 2015 19:31:06 -0500
Content-Disposition: inline
In-Reply-To: <1415993906-13307-7-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Vadim Klishko <vadim@cirque.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 14, 2014 at 08:38:25PM +0100, Pali Roh=E1r wrote:
> This patch adds sanity checks and reject trackstick packets from ALPS=
 devices
> which do not have trackstick present (those without ALPS_DUALPOINT fl=
ag).
>=20
> Make sure that driver does not process some bogus packets as tracksti=
ck data
> when there is no trackstick packet. Patch also write warning do dmesg=
 so
> possible problems with driver (e.g received invalid data) will be vis=
ible
> for debugging.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/alps.c |   22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 2b7b74d..770bec5 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -475,6 +475,13 @@ static void alps_process_trackstick_packet_v3(st=
ruct psmouse *psmouse)
>  	struct input_dev *dev =3D priv->dev2;
>  	int x, y, z, left, right, middle;
> =20
> +	/* It should be a DualPoint when received trackstick packet */
> +	if (!(priv->flags & ALPS_DUALPOINT)) {
> +		psmouse_warn(psmouse,
> +			"Rejected trackstick packet from non DualPoint device");
> +		return;
> +	}
> +
>  	/* Sanity check packet */
>  	if (!(packet[0] & 0x40)) {
>  		psmouse_dbg(psmouse, "Bad trackstick packet, discarding\n");
> @@ -699,7 +706,8 @@ static void alps_process_touchpad_packet_v3_v5(st=
ruct psmouse *psmouse)
> =20
>  	alps_report_semi_mt_data(psmouse, fingers);
> =20
> -	if (!(priv->quirks & ALPS_QUIRK_TRACKSTICK_BUTTONS)) {
> +	if ((priv->flags & ALPS_DUALPOINT) &&
> +	    !(priv->quirks & ALPS_QUIRK_TRACKSTICK_BUTTONS)) {
>  		input_report_key(dev2, BTN_LEFT, f->ts_left);
>  		input_report_key(dev2, BTN_RIGHT, f->ts_right);
>  		input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
> @@ -743,8 +751,11 @@ static void alps_process_packet_v6(struct psmous=
e *psmouse)
>  	 */
>  	if (packet[5] =3D=3D 0x7F) {
>  		/* It should be a DualPoint when received Trackpoint packet */
> -		if (!(priv->flags & ALPS_DUALPOINT))
> +		if (!(priv->flags & ALPS_DUALPOINT)) {
> +			psmouse_warn(psmouse,
> +			"Rejected trackstick packet from non DualPoint device");
>  			return;
> +		}
> =20
>  		/* Trackpoint packet */
>  		x =3D packet[1] | ((packet[3] & 0x20) << 2);
> @@ -962,6 +973,13 @@ static void alps_process_trackstick_packet_v7(st=
ruct psmouse *psmouse)
>  	struct input_dev *dev2 =3D priv->dev2;
>  	int x, y, z, left, right, middle;
> =20
> +	/* It should be a DualPoint when received trackstick packet */
> +	if (!(priv->flags & ALPS_DUALPOINT)) {
> +		psmouse_warn(psmouse,
> +			"Rejected trackstick packet from non DualPoint device");
> +		return;
> +	}
> +
>  	/*
>  	 *        b7 b6 b5 b4 b3 b2 b1 b0
>  	 * Byte0   0  1  0  0  1  0  0  0
> --=20
> 1.7.9.5
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
