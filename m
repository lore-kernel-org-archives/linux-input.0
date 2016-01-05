From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Report v3 pinnacle trackstick device only
 if is present
Date: Tue, 5 Jan 2016 17:54:19 +0100
Message-ID: <20160105165419.GQ22661@pali>
References: <1427032068-13066-1-git-send-email-pali.rohar@gmail.com>
 <550FFC21.1000503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35444 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbcAEQyV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jan 2016 11:54:21 -0500
Content-Disposition: inline
In-Reply-To: <550FFC21.1000503@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 23 March 2015 12:42:25 Hans de Goede wrote:
> Hi,
>=20
> On 22-03-15 14:47, Pali Roh=C3=A1r wrote:
> >This patch move v3 pinnacle code for trackstick detection from alps_=
hw_init_v3()
> >to alps_set_protocol() so ALPS_DUALPOINT flag can be cleared before =
registering
> >trackstick input device in kernel.
> >
> >Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> Looks good:
>=20
> Acked-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Regards,
>=20
> Hans
>=20

Hi Hans! I would like to remind this patch as it stays here on ML.

>=20
> >---
> >  drivers/input/mouse/alps.c |   12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> >diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> >index c9cd27a..d24e98d 100644
> >--- a/drivers/input/mouse/alps.c
> >+++ b/drivers/input/mouse/alps.c
> >@@ -1877,15 +1877,12 @@ error:
> >
> >  static int alps_hw_init_v3(struct psmouse *psmouse)
> >  {
> >+	struct alps_data *priv =3D psmouse->private;
> >  	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> >  	int reg_val;
> >  	unsigned char param[4];
> >
> >-	reg_val =3D alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_PIN=
NACLE);
> >-	if (reg_val =3D=3D -EIO)
> >-		goto error;
> >-
> >-	if (reg_val =3D=3D 0 &&
> >+	if ((priv->flags & ALPS_DUALPOINT) &&
> >  	    alps_setup_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACLE) =3D=
=3D -EIO)
> >  		goto error;
> >
> >@@ -2249,6 +2246,11 @@ static int alps_set_protocol(struct psmouse *=
psmouse,
> >  		priv->decode_fields =3D alps_decode_pinnacle;
> >  		priv->nibble_commands =3D alps_v3_nibble_commands;
> >  		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> >+
> >+		if (alps_probe_trackstick_v3_v7(psmouse,
> >+						ALPS_REG_BASE_PINNACLE) < 0)
> >+			priv->flags &=3D ~ALPS_DUALPOINT;
> >+
> >  		break;
> >
> >  	case ALPS_PROTO_V3_RUSHMORE:
> >

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
