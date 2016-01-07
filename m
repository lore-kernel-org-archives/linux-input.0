From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ALPS - Report v3 pinnacle trackstick device only
 if is present
Date: Wed, 6 Jan 2016 16:00:33 -0800
Message-ID: <20160107000033.GB3129@dtor-ws>
References: <1427032068-13066-1-git-send-email-pali.rohar@gmail.com>
 <550FFC21.1000503@redhat.com>
 <20160105165419.GQ22661@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35464 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbcAGAAg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2016 19:00:36 -0500
Content-Disposition: inline
In-Reply-To: <20160105165419.GQ22661@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 05, 2016 at 05:54:19PM +0100, Pali Roh=E1r wrote:
> On Monday 23 March 2015 12:42:25 Hans de Goede wrote:
> > Hi,
> >=20
> > On 22-03-15 14:47, Pali Roh=E1r wrote:
> > >This patch move v3 pinnacle code for trackstick detection from alp=
s_hw_init_v3()
> > >to alps_set_protocol() so ALPS_DUALPOINT flag can be cleared befor=
e registering
> > >trackstick input device in kernel.
> > >
> > >Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> >=20
> > Looks good:
> >=20
> > Acked-by: Hans de Goede <hdegoede@redhat.com>
> >=20
> > Regards,
> >=20
> > Hans
> >=20
>=20
> Hi Hans! I would like to remind this patch as it stays here on ML.

Applied, thank you.

>=20
> >=20
> > >---
> > >  drivers/input/mouse/alps.c |   12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > >diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps=
=2Ec
> > >index c9cd27a..d24e98d 100644
> > >--- a/drivers/input/mouse/alps.c
> > >+++ b/drivers/input/mouse/alps.c
> > >@@ -1877,15 +1877,12 @@ error:
> > >
> > >  static int alps_hw_init_v3(struct psmouse *psmouse)
> > >  {
> > >+	struct alps_data *priv =3D psmouse->private;
> > >  	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> > >  	int reg_val;
> > >  	unsigned char param[4];
> > >
> > >-	reg_val =3D alps_probe_trackstick_v3_v7(psmouse, ALPS_REG_BASE_P=
INNACLE);
> > >-	if (reg_val =3D=3D -EIO)
> > >-		goto error;
> > >-
> > >-	if (reg_val =3D=3D 0 &&
> > >+	if ((priv->flags & ALPS_DUALPOINT) &&
> > >  	    alps_setup_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACLE) =3D=
=3D -EIO)
> > >  		goto error;
> > >
> > >@@ -2249,6 +2246,11 @@ static int alps_set_protocol(struct psmouse=
 *psmouse,
> > >  		priv->decode_fields =3D alps_decode_pinnacle;
> > >  		priv->nibble_commands =3D alps_v3_nibble_commands;
> > >  		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> > >+
> > >+		if (alps_probe_trackstick_v3_v7(psmouse,
> > >+						ALPS_REG_BASE_PINNACLE) < 0)
> > >+			priv->flags &=3D ~ALPS_DUALPOINT;
> > >+
> > >  		break;
> > >
> > >  	case ALPS_PROTO_V3_RUSHMORE:
> > >
>=20
> --=20
> Pali Roh=E1r
> pali.rohar@gmail.com

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
