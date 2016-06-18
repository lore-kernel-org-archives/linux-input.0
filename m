From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Canonical has own Ubuntu driver for ALPS 73 03 28 devices
Date: Sun, 19 Jun 2016 01:43:46 +0200
Message-ID: <201606190143.46444@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7376420.ge59iZbc9q";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Ben Morgan <Ben_Morgan@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart7376420.ge59iZbc9q
Content-Type: multipart/mixed;
  boundary="Boundary-01=_yydZXAj2jABGOwU"
Content-Transfer-Encoding: 7bit


--Boundary-01=_yydZXAj2jABGOwU
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I did not know about it since I found:

http://oem.archive.canonical.com/pool/public/o/oem-alps-touchpad-1521052-dk=
ms/oem-alps-touchpad-1521052-dkms_1oem7_all.deb

If you are interested extracted patch is in attachment.

I do not understand it... Why Canonical is hidden and don't communicate
with rest of world? Otherwise touchpads could work out-of-box on non
Ubuntu systems too with mainline kernel.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--Boundary-01=_yydZXAj2jABGOwU
Content-Type: text/x-patch;
  charset="UTF-8";
  name="alps.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="alps.patch"

=2D-- alps.c	2016-06-19 01:26:34.755016680 +0200
+++ alps.c	2016-02-03 07:09:04.000000000 +0100
@@ -159,6 +159,10 @@ static const struct alps_protocol_info a
 	ALPS_PROTO_V8, 0x18, 0x18, 0
 };
=20
+static const struct alps_protocol_info alps_flare_protocol_data =3D {
+	ALPS_PROTO_FLARE, 0x18, 0x18, 0
+};
+
 /*
  * Some v2 models report the stick buttons in separate bits
  */
@@ -509,7 +513,7 @@ static void alps_report_mt_data(struct p
 	struct alps_fields *f =3D &priv->f;
 	int i, slot[MAX_TOUCHES];
=20
=2D	input_mt_assign_slots(dev, slot, f->mt, n, 0);
+	input_mt_assign_slots(dev, slot, f->mt, n);
 	for (i =3D 0; i < n; i++)
 		alps_set_slot(dev, slot[i], f->mt[i].x, f->mt[i].y);
=20
@@ -716,6 +720,84 @@ static int alps_decode_dolphin(struct al
 	return 0;
 }
=20
+static int alps_decode_flare_standard(struct alps_fields *f, unsigned char=
 *p,
+				struct psmouse *psmouse)
+{
+	if (FLARE_IS_1F_PACKET(p)) {
+		f->fingers =3D 1;
+		f->st.x =3D FLARE_1F_X(p);
+		f->st.y =3D FLARE_1F_Y(p);
+		f->pressure =3D FLARE_1F_Z(p);
+		f->mt[0].x =3D f->st.x;
+		f->mt[0].y =3D f->st.y;
+
+		f->middle =3D !!(FLARE_STD_BTN(p) & 0x04);
+		f->right =3D !!(FLARE_STD_BTN(p) & 0x02);
+		f->left =3D !!(FLARE_STD_BTN(p) & 0x01);
+
+		/* Guard */
+		if (f->pressure =3D=3D 0) {
+			f->fingers =3D 0;
+		}
+	} else if (FLARE_IS_2F_PACKET(p)) {
+		f->fingers =3D 2;
+		if (FLARE_MF_Z(p, 0) =3D=3D 1) {
+			f->pressure =3D 64;
+		} else if (FLARE_MF_Z(p, 0) =3D=3D 2) {
+			f->pressure =3D 127;
+		}
+
+		f->mt[0].x =3D FLARE_STD_MF_X(p, 0);
+		f->mt[0].y =3D FLARE_STD_MF_Y(p, 0);
+		f->mt[1].x =3D FLARE_STD_MF_X(p, 1);
+		f->mt[1].y =3D FLARE_STD_MF_Y(p, 1);
+
+		f->st.x =3D f->mt[0].x;
+		f->st.y =3D f->mt[0].y;
+	}
+
+	return 0;
+}
+
+static int alps_decode_flare_buttonless(struct alps_fields *f, unsigned ch=
ar *p,
+				struct psmouse *psmouse)
+{
+	if (FLARE_IS_1F_PACKET(p)) {
+		f->fingers =3D 1;
+		f->st.x =3D FLARE_1F_X(p);
+		f->st.y =3D FLARE_1F_Y(p);
+		f->pressure =3D FLARE_1F_LFB(p) ? 127 : 64;
+		f->mt[0].x =3D f->st.x;
+		f->mt[0].y =3D f->st.y;
+
+		/* Guard.
+		 * How the Z value is calculated is arbitrary. :-) */
+		if (FLARE_1F_Z(p) =3D=3D 0) {
+			f->fingers =3D 0;
+			f->pressure =3D 0;
+		} else if (FLARE_1F_Z(p) < 6) {
+			f->pressure =3D FLARE_1F_Z(p) * 12;
+		}
+	} else if (FLARE_IS_2F_PACKET(p)) {
+		f->fingers =3D 2;
+		if (FLARE_MF_Z(p, 0) =3D=3D 1) {
+			f->pressure =3D 64;
+		} else if (FLARE_MF_Z(p, 0) =3D=3D 2) {
+			f->pressure =3D 127;
+		}
+
+		f->mt[0].x =3D FLARE_BTL_MF_X(p, 0);
+		f->mt[0].y =3D FLARE_BTL_MF_Y(p, 0);
+		f->mt[1].x =3D FLARE_BTL_MF_X(p, 1);
+		f->mt[1].y =3D FLARE_BTL_MF_Y(p, 1);
+
+		f->st.x =3D f->mt[0].x;
+		f->st.y =3D f->mt[0].y;
+	}
+
+	return 0;
+}
+
 static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 {
 	struct alps_data *priv =3D psmouse->private;
@@ -793,6 +875,66 @@ static void alps_process_touchpad_packet
 		input_sync(dev2);
 	}
 }
+static void alps_process_touchpad_packet_flare(struct psmouse *psmouse)
+{
+	struct alps_data *priv =3D psmouse->private;
+	unsigned char *packet =3D psmouse->packet;
+	struct input_dev *dev =3D psmouse->dev;
+	int x1 =3D 0, y1 =3D 0, x2 =3D 0, y2 =3D 0;
+	int fingers =3D 0;
+	struct alps_fields *f =3D &priv->f;
+
+	priv->decode_fields(f, packet, psmouse);
+
+	fingers =3D f->fingers;
+	x1 =3D f->mt[0].x;
+	y1 =3D f->mt[0].y;
+	x2 =3D f->mt[1].x;
+	y2 =3D f->mt[1].y;
+
+	/*
+	 * Sometimes the hardware sends a single packet with z =3D 0
+	 * in the middle of a stream. Real releases generate packets
+	 * with x, y, and z all zero, so these seem to be flukes.
+	 * Ignore them.
+	 */
+	if (f->st.x && f->st.y && !f->pressure)
+		return;
+
+	if (f->pressure > 0)
+		input_report_key(dev, BTN_TOUCH, 1);
+	else
+		input_report_key(dev, BTN_TOUCH, 0);
+
+
+	input_mt_slot(dev, 0);
+	input_mt_report_slot_state(dev, MT_TOOL_FINGER, fingers !=3D 0);
+	if (fingers !=3D 0) {
+		input_report_abs(dev, ABS_MT_POSITION_X, x1);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y1);
+	}
+
+	input_mt_slot(dev, 1);
+	input_mt_report_slot_state(dev, MT_TOOL_FINGER, fingers =3D=3D 2);
+	if (fingers =3D=3D 2) {
+		input_report_abs(dev, ABS_MT_POSITION_X, x2);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y2);
+	}
+
+	input_mt_report_finger_count(dev, fingers);
+
+	input_report_key(dev, BTN_LEFT, f->left);
+	input_report_key(dev, BTN_RIGHT, f->right);
+	input_report_key(dev, BTN_MIDDLE, f->middle);
+
+	if (f->pressure > 0) {
+		input_report_abs(dev, ABS_X, f->st.x);
+		input_report_abs(dev, ABS_Y, f->st.y);
+	}
+	input_report_abs(dev, ABS_PRESSURE, f->pressure);
+
+	input_sync(dev);
+}
=20
 static void alps_process_packet_v3(struct psmouse *psmouse)
 {
@@ -1545,6 +1687,7 @@ static psmouse_ret_t alps_process_byte(s
 	 * Can not distinguish V8's first byte from PS/2 packet's
 	 */
 	if (priv->proto_version !=3D ALPS_PROTO_V8 &&
+	    priv->proto_version !=3D ALPS_PROTO_FLARE && /* Ss5 use absolute mode=
 */
 	    !psmouse->out_of_sync_cnt &&
 	    (psmouse->packet[0] & 0xc8) =3D=3D 0x08) {
=20
@@ -2518,6 +2661,24 @@ static int alps_hw_init_dolphin_v1(struc
 	return 0;
 }
=20
+static int alps_hw_init_flare(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
+	unsigned char param[2];
+
+	/* This is dolphin "v1" as empirically defined by florin9doi */
+	param[0] =3D 0x64;
+	param[1] =3D 0x28;
+
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    ps2_command(ps2dev, &param[0], PSMOUSE_CMD_SETRATE) ||
+	    ps2_command(ps2dev, &param[1], PSMOUSE_CMD_SETRATE))
+		return -1;
+
+	return 0;
+}
+
 static int alps_hw_init_v7(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
@@ -2576,10 +2737,29 @@ error:
 	return ret;
 }
=20
+static void alps_set_abs_params_mt(struct alps_data *priv,
+				   struct input_dev *dev1)
+{
+	set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
+	input_mt_init_slots(dev1, 2, 0);
+	input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
+	input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
+
+	set_bit(BTN_TOOL_DOUBLETAP, dev1->keybit);
+	set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
+	set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
+
+	input_set_abs_params(dev1, ABS_X, 0, priv->x_max, 0, 0);
+	input_set_abs_params(dev1, ABS_Y, 0, priv->y_max, 0, 0);
+}
+
 static int alps_set_protocol(struct psmouse *psmouse,
 			     struct alps_data *priv,
 			     const struct alps_protocol_info *protocol)
 {
+	unsigned char flare_config_page[3];
+	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
+
 	psmouse->private =3D priv;
=20
 	setup_timer(&priv->timer, alps_flush_packet, (unsigned long)psmouse);
@@ -2654,6 +2834,52 @@ static int alps_set_protocol(struct psmo
=20
 		break;
=20
+	case ALPS_PROTO_FLARE:
+		priv->hw_init =3D alps_hw_init_flare;
+		priv->process_packet =3D alps_process_touchpad_packet_flare;
+		priv->set_abs_params =3D alps_set_abs_params_mt;
+		priv->nibble_commands =3D alps_v3_nibble_commands;
+		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
+		priv->x_bits =3D 12;
+		priv->y_bits =3D 12;
+
+		/* Read configure page 0 */
+		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE21) ||
+		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE21) ||
+		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE21) ||
+		    ps2_command(ps2dev, flare_config_page, PSMOUSE_CMD_GETINFO) ||
+		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+		    ps2_command(ps2dev, flare_config_page, PSMOUSE_CMD_GETINFO)) {
+			return -EIO;
+		}
+
+		priv->x_max =3D (flare_config_page[2] & 0x0f) + 16 - 1;
+		priv->y_max =3D ((flare_config_page[2] >> 4) & 0x0f) + 5 - 1;
+
+		/* Read configure page 1 */
+		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL) ||
+		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL) ||
+		    ps2_command(ps2dev, flare_config_page, PSMOUSE_CMD_GETINFO)) {
+			return -EIO;
+		}
+
+		/* b1 of byte0 of configure page 1: Pad Button Emulation
+		 * 	0: No,  standard mode
+		 * 	1: Yes, buttonless(or force) mode */
+		if ((flare_config_page[0] & 0x02)) {
+			priv->decode_fields =3D alps_decode_flare_buttonless;
+			priv->x_max <<=3D 6;
+			priv->y_max <<=3D 6;
+
+		} else {
+			priv->decode_fields =3D alps_decode_flare_standard;
+			priv->x_max <<=3D 7;
+			priv->y_max <<=3D 7;
+		}
+
+		break;
+
 	case ALPS_PROTO_V6:
 		priv->hw_init =3D alps_hw_init_v6;
 		priv->process_packet =3D alps_process_packet_v6;
@@ -2744,7 +2970,6 @@ static int alps_identify(struct psmouse
 			 PSMOUSE_CMD_RESET_WRAP, ec) ||
 	    alps_exit_command_mode(psmouse))
 		return -EIO;
=2D
 	protocol =3D alps_match_table(e7, ec);
 	if (!protocol) {
 		if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D 0x50 &&
@@ -2761,6 +2986,8 @@ static int alps_identify(struct psmouse
 		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
 			   e7[2] =3D=3D 0x14 && ec[1] =3D=3D 0x02) {
 			protocol =3D &alps_v8_protocol_data;
+		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D 0x28) {
+			protocol =3D &alps_flare_protocol_data;
 		} else {
 			psmouse_dbg(psmouse,
 				    "Likely not an ALPS touchpad: E7=3D%3ph, EC=3D%3ph\n", e7, ec);
=2D-- alps.h	2016-06-19 01:34:46.745006525 +0200
+++ alps.h	2016-02-03 07:09:04.000000000 +0100
@@ -20,6 +20,7 @@
 #define ALPS_PROTO_V3_RUSHMORE	0x310
 #define ALPS_PROTO_V4		0x400
 #define ALPS_PROTO_V5		0x500
+#define ALPS_PROTO_FLARE	0x510
 #define ALPS_PROTO_V6		0x600
 #define ALPS_PROTO_V7		0x700	/* t3btl t4s */
 #define ALPS_PROTO_V8		0x800	/* SS4btl SS4s */
@@ -122,6 +123,58 @@ enum V7_PACKET_ID {
 	 V7_PACKET_ID_UNKNOWN,
 };
=20
+/* Packet identification Macros for Flare Version2               */
+/* ------------------------------------------------------------- */
+/* FLARE_IS_1F_PACKET	=3D Recognizes 1-finger packet from others */
+/* FLARE_IS_2F_PACKET	=3D Recognizes 2-finger packet from others */
+#define	FLARE_IS_1F_PACKET(_b) ((((_b[3] >> 4) & 0x01) =3D=3D 0) && (((_b[=
3] >> 5) & 0x01) =3D=3D 0))
+#define	FLARE_IS_2F_PACKET(_b) ((((_b[3] >> 4) & 0x01) =3D=3D 0x01) && (((=
_b[3] >> 5) & 0x01) =3D=3D 0))
+#define	FLARE_1F_Z(_b) (((_b[5]     ) & 0x0F) |		\
+			((_b[5] >> 1) & 0x70) |		\
+			((_b[4]     ) & 0x80)		\
+			)
+
+
+#define	FLARE_1F_X(_b) ((_b[0] & 0x0007) |	  \
+			((_b[1] << 3) & 0x0078) | \
+			((_b[1] << 2) & 0x0380) | \
+			((_b[2] << 5) & 0x0C00)	  \
+			)
+#define	FLARE_1F_Y(_b) (((_b[2]     ) & 0x000F) |		\
+			((_b[3] >> 2) & 0x0030) |		\
+			((_b[4] << 6) & 0x03C0) |		\
+			((_b[4] << 5) & 0x0C00)			\
+			)
+
+#define	FLARE_1F_LFB(_b) (((_b[2] >> 4) & 0x01) =3D=3D 0x01)
+#define	FLARE_MF_Z(_b, _i) (((_b[1 + _i * 3]     ) & 0x0001) |	\
+			    ((_b[1 + _i * 3] >> 1) & 0x0002)	\
+			    )
+#define	FLARE_MF_LF(_b, _i) ((_b[1 + _i * 3] & 0x0004) =3D=3D 0x0004)
+
+/* Packet decoding macros of - Normal HW composition      */
+/* ------------------------------------------------------ */
+/* FLARE_STD_BTN	=3D 3-bit (; ---- ---- ---- -210 )  */
+/* FLARE_STD_MF_X	=3D 8-bit	(; ---- BA98 7654 ---- )  */
+/* FLARE_STD_MF_Y	=3D 8-bit	(; ---- BA98 7654 ---- )  */
+#define	FLARE_STD_BTN(_b) ((_b[0] >> 5 ) & 0x07)
+#define	FLARE_STD_MF_X(_b, _i) (((_b[0 + _i * 3] << 4) & 0x0070) |	\
+				((_b[1 + _i * 3] << 4) & 0x0F80)	\
+				)
+#define	FLARE_STD_MF_Y(_b, _i) (((_b[1 + _i * 3] << 3) & 0x0010) |	\
+				((_b[2 + _i * 3] << 5) & 0x01E0) |	\
+				((_b[2 + _i * 3] << 4) & 0x0E00)	\
+				)
+
+/* Packet decoding macros of  - Buttonless HW composition   */
+/* -------------------------------------------------------- */
+/* FLARE_BTL_MF_X	=3D 9-bit	(; ---- BA98 7654 3--- )    */
+/* FLARE_BTL_MF_Y	=3D 9-bit	(; ---- BA98 7654 3--- )    */
+#define	FLARE_BTL_MF_X(_b, _i) (FLARE_STD_MF_X(_b, _i) | ((_b[0 + _i * 3] =
>> 4) & 0x0008))
+#define	FLARE_BTL_MF_Y(_b, _i) (FLARE_STD_MF_Y(_b, _i) | ((_b[0 + _i * 3] =
>> 3) & 0x0008))
+
+
+
 /**
  * struct alps_protocol_info - information about protocol used by a device
  * @version: Indicates V1/V2/V3/...

--Boundary-01=_yydZXAj2jABGOwU--

--nextPart7376420.ge59iZbc9q
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAldl3LIACgkQi/DJPQPkQ1IQ4ACcCGD53DGlv91PVesQg7+bIIxG
UK8AnA27uL2yQCg3fRqNv09hiPVLpsGX
=qOaw
-----END PGP SIGNATURE-----

--nextPart7376420.ge59iZbc9q--
