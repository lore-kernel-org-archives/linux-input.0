From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ALPS - fix max coordinates for v5 and v7 protocols
Date: Sat, 21 Mar 2015 20:36:56 -0700
Message-ID: <20150322033656.GA35352@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33896 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbCVDhB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Mar 2015 23:37:01 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Santiago Gala <sgala@apache.org>, Yunkang Tang <yunkang.tang@cn.alps.com>, linux-kernel@vger.kernel.org

Commit 3296f71cd2fde7a2ad52e66a27eae419f6328066 ("Input: ALPS - consoli=
date
setting protocol parameters") inadvertently moved call to
alps_dolphin_get_device_area() from v5 to v7 protocol, causing both
protocols report incorrect maximum values for X and Y axes which result=
ed
in crash in Synaptics X driver.

Reported-by: Santiago Gala <sgala@apache.org>
Reported-by: Pali Roh=E1r <pali.rohar@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/alps.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 1bd15eb..33198b9 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2281,10 +2281,12 @@ static int alps_set_protocol(struct psmouse *ps=
mouse,
 		priv->set_abs_params =3D alps_set_abs_params_mt;
 		priv->nibble_commands =3D alps_v3_nibble_commands;
 		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
-		priv->x_max =3D 1360;
-		priv->y_max =3D 660;
 		priv->x_bits =3D 23;
 		priv->y_bits =3D 12;
+
+		if (alps_dolphin_get_device_area(psmouse, priv))
+			return -EIO;
+
 		break;
=20
 	case ALPS_PROTO_V6:
@@ -2303,9 +2305,8 @@ static int alps_set_protocol(struct psmouse *psmo=
use,
 		priv->set_abs_params =3D alps_set_abs_params_mt;
 		priv->nibble_commands =3D alps_v3_nibble_commands;
 		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
-
-		if (alps_dolphin_get_device_area(psmouse, priv))
-			return -EIO;
+		priv->x_max =3D 0xfff;
+		priv->y_max =3D 0x7ff;
=20
 		if (priv->fw_ver[1] !=3D 0xba)
 			priv->flags |=3D ALPS_BUTTONPAD;
--=20
2.2.0.rc0.207.ga3a616c


--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
