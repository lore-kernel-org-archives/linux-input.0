From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 14/14] alps: Add support for v7 devices
Date: Fri, 25 Jul 2014 22:58:11 -0700
Message-ID: <20140726055811.GA31435@core.coreip.homeip.net>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
 <1404919459-23561-15-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:54058 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaGZF6P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jul 2014 01:58:15 -0400
Received: by mail-pd0-f179.google.com with SMTP id ft15so6591377pdb.24
        for <linux-input@vger.kernel.org>; Fri, 25 Jul 2014 22:58:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1404919459-23561-15-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org

Hi Hans,

On Wed, Jul 09, 2014 at 05:24:19PM +0200, Hans de Goede wrote:
> From: Yunkang Tang <yunkang.tang@cn.alps.com>
>=20
> Such as found on the new Toshiba Port=E9g=E9 Z30-A and Z40-A.
>=20
> Signed-off-by: Yunkang Tang <yunkang.tang@cn.alps.com>
> [hdegoede@redhat.com: Remove softbutton handling, this is done in use=
rspace]
> [hdegoede@redhat.com: Report INPUT_PROP_BUTTONPAD]
> [hdegoede@redhat.com: Do not report fake PRESSURE, reporting BTN_TOUC=
H is
>  enough]
> [hdegoede@redhat.com: Various cleanups / refactoring]
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/mouse/alps.c | 257 +++++++++++++++++++++++++++++++++++=
+++++++++-
>  drivers/input/mouse/alps.h |  18 ++++
>  2 files changed, 272 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index ad3a708..8b9b4b0 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -100,6 +100,7 @@ static const struct alps_nibble_commands alps_v6_=
nibble_commands[] =3D {
>  #define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved =
with
>  					   6-byte ALPS packet */
>  #define ALPS_IS_RUSHMORE	0x100	/* device is a rushmore */
> +#define ALPS_BUTTONPAD		0x200	/* device is a clickpad */
> =20
>  static const struct alps_model_info alps_model_data[] =3D {
>  	{ { 0x32, 0x02, 0x14 },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS =
| ALPS_DUALPOINT },	/* Toshiba Salellite Pro M10 */
> @@ -845,6 +846,177 @@ static void alps_process_packet_v4(struct psmou=
se *psmouse)
>  	alps_report_semi_mt_data(psmouse, f->fingers);
>  }
> =20
> +static bool alps_is_valid_package_v7(struct psmouse *psmouse)
> +{
> +	if ((psmouse->pktcnt =3D=3D 3) && ((psmouse->packet[2] & 0x40) !=3D=
 0x40))
> +		return false;
> +	if ((psmouse->pktcnt =3D=3D 4) && ((psmouse->packet[3] & 0x48) !=3D=
 0x48))
> +		return false;
> +	if ((psmouse->pktcnt =3D=3D 6) && ((psmouse->packet[5] & 0x40) !=3D=
 0x0))
> +		return false;
> +	return true;

Maybe:

	switch (psmouse->pktcnt) {
	case 3:
		return (psmouse->packet[2] & 0x40) =3D=3D 0x40;

	case 4:
		return (psmouse->packet[3] & 0x48) =3D=3D 0x48;

	case 6:
		return (psmouse->packet[5] & 0x40) =3D=3D 0x00;
	}

	return true;

?


> +}
> +
> +static unsigned char alps_get_packet_id_v7(char *byte)
> +{
> +	unsigned char packet_id;
> +
> +	if (byte[4] & 0x40)
> +		packet_id =3D V7_PACKET_ID_TWO;
> +	else if (byte[4] & 0x01)
> +		packet_id =3D V7_PACKET_ID_MULTI;
> +	else if ((byte[0] & 0x10) && !(byte[4] & 0x43))
> +		packet_id =3D V7_PACKET_ID_NEW;
> +	else if (byte[1] =3D=3D 0x00 && byte[4] =3D=3D 0x00)
> +		packet_id =3D V7_PACKET_ID_IDLE;
> +	else
> +		packet_id =3D V7_PACKET_ID_UNKNOWN;
> +
> +	return packet_id;
> +}
> +
> +static void alps_get_finger_coordinate_v7(struct input_mt_pos *mt,
> +					  unsigned char *pkt,
> +					  unsigned char pkt_id)
> +{
> +	mt[0].x =3D ((pkt[2] & 0x80) << 4);
> +	mt[0].x |=3D ((pkt[2] & 0x3F) << 5);
> +	mt[0].x |=3D ((pkt[3] & 0x30) >> 1);
> +	mt[0].x |=3D (pkt[3] & 0x07);
> +	mt[0].y =3D (pkt[1] << 3) | (pkt[0] & 0x07);
> +
> +	mt[1].x =3D ((pkt[3] & 0x80) << 4);
> +	mt[1].x |=3D ((pkt[4] & 0x80) << 3);
> +	mt[1].x |=3D ((pkt[4] & 0x3F) << 4);
> +	mt[1].y =3D ((pkt[5] & 0x80) << 3);
> +	mt[1].y |=3D ((pkt[5] & 0x3F) << 4);
> +
> +	if (pkt_id =3D=3D V7_PACKET_ID_TWO) {
> +		mt[1].x &=3D ~0x000F;
> +		mt[1].y |=3D 0x000F;
> +	} else if (pkt_id =3D=3D V7_PACKET_ID_MULTI) {
> +		mt[1].x &=3D ~0x003F;
> +		mt[1].y &=3D ~0x0020;
> +		mt[1].y |=3D ((pkt[4] & 0x02) << 4);
> +		mt[1].y |=3D 0x001F;
> +	} else if (pkt_id =3D=3D V7_PACKET_ID_NEW) {
> +		mt[1].x &=3D ~0x003F;
> +		mt[1].x |=3D (pkt[0] & 0x20);
> +		mt[1].y |=3D 0x000F;
> +	}
> +
> +	mt[0].y =3D 0x7FF - mt[0].y;
> +	mt[1].y =3D 0x7FF - mt[1].y;
> +}
> +
> +static int alps_get_mt_count(struct input_mt_pos *mt)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < MAX_TOUCHES && mt[i].x !=3D 0 && mt[i].y !=3D 0; =
i++)
> +		;

		/* empty */;

just to make sure...

> +
> +	return i;
> +}
> +
> +static int alps_decode_packet_v7(struct alps_fields *f,
> +				  unsigned char *p,
> +				  struct psmouse *psmouse)
> +{
> +	unsigned char pkt_id;
> +
> +	pkt_id =3D alps_get_packet_id_v7(p);
> +	if (pkt_id =3D=3D V7_PACKET_ID_IDLE)
> +		return 0;
> +	if (pkt_id =3D=3D V7_PACKET_ID_UNKNOWN)
> +		return -1;
> +
> +	alps_get_finger_coordinate_v7(f->mt, p, pkt_id);
> +
> +	if (pkt_id =3D=3D V7_PACKET_ID_TWO || pkt_id =3D=3D V7_PACKET_ID_MU=
LTI) {
> +		f->left =3D (p[0] & 0x80) >> 7;
> +		f->right =3D (p[0] & 0x20) >> 5;
> +		f->middle =3D (p[0] & 0x10) >> 4;
> +	}
> +
> +	if (pkt_id =3D=3D V7_PACKET_ID_TWO)
> +		f->fingers =3D alps_get_mt_count(f->mt);
> +	else if (pkt_id =3D=3D V7_PACKET_ID_MULTI)
> +		f->fingers =3D 3 + (p[5] & 0x03);
> +
> +	return 0;
> +}
> +
> +static void alps_process_trackstick_packet_v7(struct psmouse *psmous=
e)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	unsigned char *packet =3D psmouse->packet;
> +	struct input_dev *dev2 =3D priv->dev2;
> +	int x, y, z, left, right, middle;
> +
> +	/*
> +	 *        b7 b6 b5 b4 b3 b2 b1 b0
> +	 * Byte0   0  1  0  0  1  0  0  0
> +	 * Byte1   1  1  *  *  1  M  R  L
> +	 * Byte2  X7  1 X5 X4 X3 X2 X1 X0
> +	 * Byte3  Z6  1 Y6 X6  1 Y2 Y1 Y0
> +	 * Byte4  Y7  0 Y5 Y4 Y3  1  1  0
> +	 * Byte5 T&P  0 Z5 Z4 Z3 Z2 Z1 Z0
> +	 * M / R / L: Middle / Right / Left button
> +	 */
> +
> +	x =3D ((packet[2] & 0xbf)) | ((packet[3] & 0x10) << 2);
> +	y =3D (packet[3] & 0x07) | (packet[4] & 0xb8) |
> +	    ((packet[3] & 0x20) << 1);
> +	z =3D (packet[5] & 0x3f) | ((packet[3] & 0x80) >> 1);
> +
> +	left =3D (packet[1] & 0x01);
> +	right =3D (packet[1] & 0x02) >> 1;
> +	middle =3D (packet[1] & 0x04) >> 2;
> +
> +	/* Divide 2 since trackpoint's speed is too fast */
> +	input_report_rel(dev2, REL_X, (char)x / 2);
> +	input_report_rel(dev2, REL_Y, -((char)y / 2));
> +
> +	input_report_key(dev2, BTN_LEFT, left);
> +	input_report_key(dev2, BTN_RIGHT, right);
> +	input_report_key(dev2, BTN_MIDDLE, middle);
> +
> +	input_sync(dev2);
> +}
> +
> +static void alps_process_touchpad_packet_v7(struct psmouse *psmouse)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	struct input_dev *dev =3D psmouse->dev;
> +	struct alps_fields *f =3D &priv->f;
> +
> +	memset(f, 0, sizeof(*f));
> +
> +	if (priv->decode_fields(f, psmouse->packet, psmouse))
> +		return;
> +
> +	alps_report_mt_data(psmouse, alps_get_mt_count(f->mt));
> +
> +	input_mt_report_finger_count(dev, f->fingers);
> +
> +	input_report_key(dev, BTN_LEFT, f->left);
> +	input_report_key(dev, BTN_RIGHT, f->right);
> +	input_report_key(dev, BTN_MIDDLE, f->middle);
> +
> +	input_sync(dev);
> +}
> +
> +static void alps_process_packet_v7(struct psmouse *psmouse)
> +{
> +	unsigned char *packet =3D psmouse->packet;
> +
> +	if ((packet[0] =3D=3D 0x48) && ((packet[4] & 0x47) =3D=3D 0x06))
> +		alps_process_trackstick_packet_v7(psmouse);
> +	else
> +		alps_process_touchpad_packet_v7(psmouse);
> +}
> +
>  static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
>  					unsigned char packet[],
>  					bool report_buttons)
> @@ -1009,6 +1181,14 @@ static psmouse_ret_t alps_process_byte(struct =
psmouse *psmouse)
>  		return PSMOUSE_BAD_DATA;
>  	}
> =20
> +	if (priv->proto_version =3D=3D ALPS_PROTO_V7 &&
> +			!alps_is_valid_package_v7(psmouse)) {
> +		psmouse_dbg(psmouse, "refusing packet[%i] =3D %x\n",
> +			    psmouse->pktcnt - 1,
> +			    psmouse->packet[psmouse->pktcnt - 1]);
> +		return PSMOUSE_BAD_DATA;
> +	}
> +
>  	if (psmouse->pktcnt =3D=3D psmouse->pktsize) {
>  		priv->process_packet(psmouse);
>  		return PSMOUSE_FULL_PACKET;
> @@ -1121,6 +1301,22 @@ static int alps_rpt_cmd(struct psmouse *psmous=
e, int init_command,
>  	return 0;
>  }
> =20
> +static int alps_check_valid_firmware_id(unsigned char id[])

bool

> +{
> +	int valid =3D 1;

bool; true

> +
> +	if (id[0] =3D=3D 0x73)
> +		valid =3D 1;

true

> +	else if (id[0] =3D=3D 0x88) {
> +		if ((id[1] =3D=3D 0x07) ||
> +		    (id[1] =3D=3D 0x08) ||
> +		    ((id[1] & 0xf0) =3D=3D 0xB0))
> +			valid =3D 1;

true

> +	}
> +
> +	return valid;

Hmmm, does not make sense - it is never false...

> +}
> +
>  static int alps_enter_command_mode(struct psmouse *psmouse)
>  {
>  	unsigned char param[4];
> @@ -1130,8 +1326,7 @@ static int alps_enter_command_mode(struct psmou=
se *psmouse)
>  		return -1;
>  	}
> =20
> -	if ((param[0] !=3D 0x88 || (param[1] !=3D 0x07 && param[1] !=3D 0x0=
8)) &&
> -	    param[0] !=3D 0x73) {
> +	if (!alps_check_valid_firmware_id(param)) {
>  		psmouse_dbg(psmouse,
>  			    "unknown response while entering command mode\n");
>  		return -1;
> @@ -1785,6 +1980,32 @@ static int alps_hw_init_dolphin_v1(struct psmo=
use *psmouse)
>  	return 0;
>  }
> =20
> +static int alps_hw_init_v7(struct psmouse *psmouse)
> +{
> +	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> +	int reg_val, ret =3D -1;
> +
> +	if (alps_enter_command_mode(psmouse) ||
> +	    alps_command_mode_read_reg(psmouse, 0xc2d9) =3D=3D -1)
> +		goto error;
> +
> +	if (alps_command_mode_write_reg(psmouse, 0xc2c9, 0x64))
> +		goto error;
> +
> +	reg_val =3D alps_command_mode_read_reg(psmouse, 0xc2c4);
> +	if (reg_val =3D=3D -1)
> +		goto error;
> +	if (__alps_command_mode_write_reg(psmouse, reg_val | 0x02))
> +		goto error;
> +
> +	alps_exit_command_mode(psmouse);
> +	return ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> +
> +error:
> +	alps_exit_command_mode(psmouse);
> +	return ret;
> +}
> +
>  static void alps_set_defaults(struct alps_data *priv)
>  {
>  	priv->byte0 =3D 0x8f;
> @@ -1843,6 +2064,21 @@ static void alps_set_defaults(struct alps_data=
 *priv)
>  		priv->x_max =3D 2047;
>  		priv->y_max =3D 1535;
>  		break;
> +	case ALPS_PROTO_V7:
> +		priv->hw_init =3D alps_hw_init_v7;
> +		priv->process_packet =3D alps_process_packet_v7;
> +		priv->decode_fields =3D alps_decode_packet_v7;
> +		priv->set_abs_params =3D alps_set_abs_params_mt;
> +		priv->nibble_commands =3D alps_v3_nibble_commands;
> +		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> +		priv->x_max =3D 0xfff;
> +		priv->y_max =3D 0x7ff;
> +		priv->byte0 =3D 0x48;
> +		priv->mask0 =3D 0x48;
> +
> +		if (priv->fw_ver[1] !=3D 0xba)
> +			priv->flags |=3D ALPS_BUTTONPAD;
> +		break;
>  	}
>  }
> =20
> @@ -1914,6 +2150,12 @@ static int alps_identify(struct psmouse *psmou=
se, struct alps_data *priv)
>  			return -EIO;
>  		else
>  			return 0;
> +	} else if (ec[0] =3D=3D 0x88 &&
> +		   ((ec[1] & 0xf0) =3D=3D 0xb0 || (ec[1] & 0xf0) =3D=3D 0xc0)) {
> +		priv->proto_version =3D ALPS_PROTO_V7;
> +		alps_set_defaults(priv);
> +
> +		return 0;
>  	} else if (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0x08) {
>  		priv->proto_version =3D ALPS_PROTO_V3;
>  		alps_set_defaults(priv);
> @@ -1985,6 +2227,10 @@ static void alps_set_abs_params_mt(struct alps=
_data *priv,
> =20
>  	set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
>  	set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
> +
> +	/* V7 is real multi-touch */
> +	if (priv->proto_version =3D=3D ALPS_PROTO_V7)
> +		clear_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
>  }
> =20
>  int alps_init(struct psmouse *psmouse)
> @@ -2030,7 +2276,9 @@ int alps_init(struct psmouse *psmouse)
>  	dev1->evbit[BIT_WORD(EV_ABS)] |=3D BIT_MASK(EV_ABS);
> =20
>  	priv->set_abs_params(priv, dev1);
> -	input_set_abs_params(dev1, ABS_PRESSURE, 0, 127, 0, 0);
> +	/* No pressure on V7 */
> +	if (priv->proto_version !=3D ALPS_PROTO_V7)
> +		input_set_abs_params(dev1, ABS_PRESSURE, 0, 127, 0, 0);
> =20
>  	if (priv->flags & ALPS_WHEEL) {
>  		dev1->evbit[BIT_WORD(EV_REL)] |=3D BIT_MASK(EV_REL);
> @@ -2047,6 +2295,9 @@ int alps_init(struct psmouse *psmouse)
>  		dev1->keybit[BIT_WORD(BTN_1)] |=3D BIT_MASK(BTN_1);
>  		dev1->keybit[BIT_WORD(BTN_2)] |=3D BIT_MASK(BTN_2);
>  		dev1->keybit[BIT_WORD(BTN_3)] |=3D BIT_MASK(BTN_3);
> +	} else if (priv->flags & ALPS_BUTTONPAD) {
> +		set_bit(INPUT_PROP_BUTTONPAD, dev1->propbit);
> +		clear_bit(BTN_RIGHT, dev1->keybit);
>  	} else {
>  		dev1->keybit[BIT_WORD(BTN_MIDDLE)] |=3D BIT_MASK(BTN_MIDDLE);
>  	}
> diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
> index e3d0f09..a98ac9b 100644
> --- a/drivers/input/mouse/alps.h
> +++ b/drivers/input/mouse/alps.h
> @@ -20,6 +20,7 @@
>  #define ALPS_PROTO_V4	4
>  #define ALPS_PROTO_V5	5
>  #define ALPS_PROTO_V6	6
> +#define ALPS_PROTO_V7	7	/* t3btl t4s */
> =20
>  #define MAX_TOUCHES	2
> =20
> @@ -27,6 +28,23 @@
>  #define DOLPHIN_PROFILE_XOFFSET		8	/* x-electrode offset */
>  #define DOLPHIN_PROFILE_YOFFSET		1	/* y-electrode offset */
> =20
> +/*
> + * enum V7_PACKET_ID - defines the packet type for V7
> + * V7_PACKET_ID_IDLE: There's no finger and no button activity.
> + * V7_PACKET_ID_TWO: There's one or two non-resting fingers on touch=
pad
> + *  or there's button activities.
> + * V7_PACKET_ID_MULTI: There are at least three non-resting fingers.
> + * V7_PACKET_ID_NEW: The finger position in slot is not continues fr=
om
> + *  previous packet.
> +*/
> +enum V7_PACKET_ID {
> +	 V7_PACKET_ID_IDLE,
> +	 V7_PACKET_ID_TWO,
> +	 V7_PACKET_ID_MULTI,
> +	 V7_PACKET_ID_NEW,
> +	 V7_PACKET_ID_UNKNOWN,
> +};
> +
>  /**
>   * struct alps_model_info - touchpad ID table
>   * @signature: E7 response string to match.
> --=20
> 2.0.0
>=20

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
