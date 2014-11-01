From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v3 4/4] input: alps: Fix trackstick detection
Date: Sun,  2 Nov 2014 00:25:10 +0100
Message-ID: <1414884310-19842-5-git-send-email-pali.rohar@gmail.com>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com>
 <1414884310-19842-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:51635 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbaKAX0K (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Nov 2014 19:26:10 -0400
In-Reply-To: <1414884310-19842-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

On some laptops after starting them from off state (not after reboot), =
function
alps_probe_trackstick_v3() (called from function alps_identify()) does =
not
detect trackstick. To fix this problem we need to reset device. But fun=
ction
alps_identify() is called also from alps_detect() and we do not want to=
 reset
device in detect function because it will slow down initialization of a=
ll other
non alps devices.

Current alps device init sequence is:
alps_detect() --> alps_identify() (trackstick not detected)
alps_init() --> psmouse_reset() --> alps_identify() (trackstick detecte=
d)

This patch moves initialization code between driver functions so we can=
 remove
alps_identify() call from alps_detect(). Which means that trackstick fu=
nction
alps_probe_trackstick_v3() will be called only from alps_init() and onl=
y after
device reset so it will always return correct information about trackst=
ick
presence. Code for identifying protocol version is moved to alps_init()=
 and
because psmouse-base.c calling alps_detect() and alps_init() consecutiv=
ely then
detection of both alps and also other non alps devices will not be brok=
en.

=46irst this patch moves code between functions:

 * Move calling function alps_probe_trackstick_v3() (for rushmore devic=
es) from
   alps_identify() to alps_hw_init_rushmore_v3()

 * Move code for checking "E6 report" from alps_identify() to alps_dete=
ct()

 * Move code for setting correct device name string and model/protocol =
version
   from alps_detect() to alps_init(). To not break psmouse-base.c in fu=
nction
   alps_detect() set only generic name "DualPoint TouchPad".

Next it removes alps_identify() from alps_detect() because it is not ne=
eded
anymore (code which use it was moved to alps_init()).

And last this patch fix another code for trackstick detection of protoc=
ol V3
devices. In function alps_hw_init_v3() is removed ALPS_DUALPOINT flag f=
rom
device if alps_setup_trackstick_v3() or alps_setup_trackstick_v3() retu=
rns
-ENODEV (which means trackstick is not present).

Now trackstick detection should work and in function alps_init() is set
correct name and other properties for both input devices.

Side effect of this patch is also faster alps devices initialization be=
cause
function alps_identify() is called only once (from alps_init()).

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/input/mouse/alps.c |   96 +++++++++++++++++++++++++++++-------=
--------
 1 file changed, 64 insertions(+), 32 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index e802d28..04161b6 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1732,6 +1732,7 @@ error:
=20
 static int alps_hw_init_v3(struct psmouse *psmouse)
 {
+	struct alps_data *priv =3D psmouse->private;
 	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
 	int reg_val;
 	unsigned char param[4];
@@ -1740,9 +1741,15 @@ static int alps_hw_init_v3(struct psmouse *psmou=
se)
 	if (reg_val =3D=3D -EIO)
 		goto error;
=20
-	if (reg_val =3D=3D 0 &&
-	    alps_setup_trackstick_v3(psmouse, ALPS_REG_BASE_PINNACLE) =3D=3D =
-EIO)
-		goto error;
+	if (reg_val =3D=3D 0) {
+		reg_val =3D alps_setup_trackstick_v3(psmouse,
+						   ALPS_REG_BASE_PINNACLE);
+		if (reg_val =3D=3D -EIO)
+			goto error;
+	}
+
+	if (reg_val =3D=3D -ENODEV)
+		priv->flags &=3D ~ALPS_DUALPOINT;
=20
 	if (alps_enter_command_mode(psmouse) ||
 	    alps_absolute_mode_v3(psmouse)) {
@@ -1849,15 +1856,20 @@ static int alps_hw_init_rushmore_v3(struct psmo=
use *psmouse)
 	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
 	int reg_val, ret =3D -1;
=20
-	if (priv->flags & ALPS_DUALPOINT) {
+	reg_val =3D alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_RUSHMORE)=
;
+	if (reg_val =3D=3D -EIO)
+		goto error;
+
+	if (reg_val =3D=3D 0) {
 		reg_val =3D alps_setup_trackstick_v3(psmouse,
 						   ALPS_REG_BASE_RUSHMORE);
 		if (reg_val =3D=3D -EIO)
 			goto error;
-		if (reg_val =3D=3D -ENODEV)
-			priv->flags &=3D ~ALPS_DUALPOINT;
 	}
=20
+	if (reg_val =3D=3D -ENODEV)
+		priv->flags &=3D ~ALPS_DUALPOINT;
+
 	if (alps_enter_command_mode(psmouse) ||
 	    alps_command_mode_read_reg(psmouse, 0xc2d9) =3D=3D -1 ||
 	    alps_command_mode_write_reg(psmouse, 0xc2cb, 0x00))
@@ -2176,20 +2188,15 @@ static int alps_match_table(struct psmouse *psm=
ouse, struct alps_data *priv,
=20
 static int alps_identify(struct psmouse *psmouse, struct alps_data *pr=
iv)
 {
-	unsigned char e6[4], e7[4], ec[4];
+	unsigned char e7[4], ec[4];
+	int ret;
=20
 	/*
 	 * First try "E6 report".
-	 * ALPS should return 0,0,10 or 0,0,100 if no buttons are pressed.
-	 * The bits 0-2 of the first byte will be 1s if some buttons are
-	 * pressed.
 	 */
-	if (alps_rpt_cmd(psmouse, PSMOUSE_CMD_SETRES,
-			 PSMOUSE_CMD_SETSCALE11, e6))
-		return -EIO;
-
-	if ((e6[0] & 0xf8) !=3D 0 || e6[1] !=3D 0 || (e6[2] !=3D 10 && e6[2] =
!=3D 100))
-		return -EINVAL;
+	ret =3D alps_detect(psmouse, false);
+	if (ret < 0)
+		return ret;
=20
 	/*
 	 * Now get the "E7" and "EC" reports.  These will uniquely identify
@@ -2231,12 +2238,6 @@ static int alps_identify(struct psmouse *psmouse=
, struct alps_data *priv)
 		priv->y_bits =3D 12;
 		priv->flags |=3D ALPS_IS_RUSHMORE;
=20
-		/* hack to make addr_command, nibble_command available */
-		psmouse->private =3D priv;
-
-		if (alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_RUSHMORE))
-			priv->flags &=3D ~ALPS_DUALPOINT;
-
 		return 0;
 	} else if (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0x07 &&
 		   ec[2] >=3D 0x90 && ec[2] <=3D 0x9d) {
@@ -2370,14 +2371,24 @@ int alps_init(struct psmouse *psmouse)
 		dev1->keybit[BIT_WORD(BTN_MIDDLE)] |=3D BIT_MASK(BTN_MIDDLE);
 	}
=20
+	if (priv->flags & ALPS_DUALPOINT) {
+		/*
+		 * format of device name is: "protocol vendor name"
+		 * see function psmouse_switch_protocol() in psmouse-base.c
+		 */
+		dev2->name =3D "AlpsPS/2 ALPS DualPoint Stick";
+		dev2->id.product =3D PSMOUSE_ALPS;
+		dev2->id.version =3D priv->proto_version;
+	} else {
+		dev2->name =3D "PS/2 ALPS Mouse";
+		dev2->id.product =3D PSMOUSE_PS2;
+		dev2->id.version =3D 0x0000;
+	}
+
 	snprintf(priv->phys, sizeof(priv->phys), "%s/input1", psmouse->ps2dev=
=2Eserio->phys);
 	dev2->phys =3D priv->phys;
-	dev2->name =3D (priv->flags & ALPS_DUALPOINT) ?
-		     "DualPoint Stick" : "ALPS PS/2 Device";
 	dev2->id.bustype =3D BUS_I8042;
 	dev2->id.vendor  =3D 0x0002;
-	dev2->id.product =3D PSMOUSE_ALPS;
-	dev2->id.version =3D 0x0000;
 	dev2->dev.parent =3D &psmouse->ps2dev.serio->dev;
=20
 	dev2->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
@@ -2392,6 +2403,10 @@ int alps_init(struct psmouse *psmouse)
 	if (input_register_device(priv->dev2))
 		goto init_fail;
=20
+	if (!(priv->flags & ALPS_DUALPOINT))
+		psmouse->name =3D "GlidePoint TouchPad";
+	psmouse->model =3D priv->proto_version;
+
 	psmouse->protocol_handler =3D alps_process_byte;
 	psmouse->poll =3D alps_poll;
 	psmouse->disconnect =3D alps_disconnect;
@@ -2416,17 +2431,34 @@ init_fail:
=20
 int alps_detect(struct psmouse *psmouse, bool set_properties)
 {
-	struct alps_data dummy;
+	unsigned char e6[4];
=20
-	if (alps_identify(psmouse, &dummy) < 0)
-		return -1;
+	/*
+	 * Try "E6 report".
+	 * ALPS should return 0,0,10 or 0,0,100 if no buttons are pressed.
+	 * The bits 0-2 of the first byte will be 1s if some buttons are
+	 * pressed.
+	 */
+	if (alps_rpt_cmd(psmouse, PSMOUSE_CMD_SETRES,
+			 PSMOUSE_CMD_SETSCALE11, e6))
+		return -EIO;
+
+	if ((e6[0] & 0xf8) !=3D 0 || e6[1] !=3D 0 || (e6[2] !=3D 10 && e6[2] =
!=3D 100))
+		return -EINVAL;
=20
 	if (set_properties) {
+		/*
+		 * NOTE: To detect model and trackstick presence we need to do
+		 *       full device reset. To speed up detection and prevent
+		 *       calling duplicate initialization sequence (both in
+		 *       alps_detect() and alps_init()) we set model/protocol
+		 *       version and correct name in alps_init() (which will
+		 *       do full device reset). For now set name to DualPoint.
+		 */
 		psmouse->vendor =3D "ALPS";
-		psmouse->name =3D dummy.flags & ALPS_DUALPOINT ?
-				"DualPoint TouchPad" : "GlidePoint";
-		psmouse->model =3D dummy.proto_version << 8;
+		psmouse->name =3D "DualPoint TouchPad";
 	}
+
 	return 0;
 }
=20
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
