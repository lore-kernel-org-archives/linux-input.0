From: Ulrik De Bie <ulrik_opensource-kernel@yahoo.com>
Subject: [PATCH] drivers/input/mouse/elantech elantech driver for Lenovo L530 trackpoint
Date: Tue, 30 Jul 2013 14:44:10 -0700 (PDT)
Message-ID: <1375220650.66420.YahooMailNeo@web120605.mail.ne1.yahoo.com>
Reply-To: Ulrik De Bie <ulrik_opensource-kernel@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm3-vm6.bullet.mail.ne1.yahoo.com ([98.138.91.96]:26056 "EHLO
	nm3-vm6.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755571Ab3G3Vu0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jul 2013 17:50:26 -0400
References: 
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Hi,

I've a new work laptop Lenovo L530. For 3.2 and 3.9 kernel, the trackpo=
int
does not work out of the box. It gives sync errors as shown below when =
the trackpoint
or trackpoint mouse buttons are pressed and no input is received by use=
rspace:
[=A0  29.010641] psmouse serio1: Touchpad at isa0060/serio1/input0 lost=
 sync at byte 6
The touchpad does work.

The alternative is to do a downgrade to generic ps/2 mouse (modprobe ps=
mouse proto=3Dbare)
but this has the disadvantage that touchpad can't be disabled (I want t=
rackpoint, not touchpad).

I did some analysis of the psmouse packets generated, and it became app=
arent that the
generated packets are according to a very strict format as described in=
 the elantech_report_trackpoint
function in the patch below.

With this patch, the trackpoint is provided as another input device; cu=
rrently called 'My stick'
The trackpoint now succesfully works and I can disable the touchpad wit=
h synclient TouchPadOff=3D1
The patch will also output messages that do not follow the expected pat=
tern.=20
In the mean time I've seen 2 unknown packets occasionally:
0x04 , 0x00 , 0x00 , 0x00 , 0x00 , 0x00
0x00 , 0x00 , 0x00 , 0x02 , 0x00 , 0x00
I don't know what those are for, but they can be safely ignored.

Currently all packets that are not known to v3 touchpad and where packe=
t[3] (the fourth byte) lowest
nibble is 6 are now recognized as PACKET_TRACKPOINT and processed by th=
e new elantech_report_trackpoint.


The first feedback I would appreciate on the patch:
1a) Do you think that the creation of the extra input device is the cor=
rect way to go ? I saw also a synaptics-pt but I was not able to figure=
 it out and the extra input gave me a desirable result fast.

1b) What would be the requirements for the name and the phys parameter =
of the device ?


2) Is the patch correct with regards to ps/2 protocol semantics ? Shoul=
d it be more restrictive; maybe limited to the 4 patterns used to dump =
unexpected packets ?

3) Would a 'trackpoint' detection be required ? I have no idea how to d=
o this because I have a lack of elantech version/capabilities samples, =
I have just the one on my laptop:
psmouse serio1: elantech: assuming hardware version 3 (with firmware ve=
rsion 0x350f02)
psmouse serio1: elantech: Synaptics capabilities query result 0xb9, 0x1=
5, 0x0c.

4) Is there anyone else with different hardware/firmwareversion/synapti=
cs capabilities where this patch also works ?

The patch below was ported to 3.10.4 kernel (originally made for 3.2 ke=
rnel which is the default kernel on my laptop)

Thanks for all feedback and your time,
Ulrik




diff -uprN -X linux-3.10.4-vanilla/Documentation/dontdiff linux-3.10.4-=
vanilla/drivers/input/mouse/elantech.c linux-3.10.4/drivers/input/mouse=
/elantech.c
--- linux-3.10.4-vanilla/drivers/input/mouse/elantech.c=A0=A0=A0 2013-0=
7-29 01:30:49.000000000 +0200
+++ linux-3.10.4/drivers/input/mouse/elantech.c=A0=A0=A0 2013-07-30 23:=
06:12.000000000 +0200
@@ -402,6 +402,54 @@ static void elantech_report_absolute_v2(
=A0=A0=A0 input_sync(dev);
}

+static void elantech_report_trackpoint(struct psmouse *psmouse,
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0  int packet_type)
+{
+=A0=A0=A0 /* byte 0:=A0 0=A0  0 ~sx ~sy=A0  0=A0  M=A0  R=A0  L */
+=A0=A0=A0 /* byte 1: sx=A0  0=A0  0=A0  0=A0  0=A0  0=A0  0=A0  0 */
+=A0=A0=A0 /* byte 2: sy=A0  0=A0  0=A0  0=A0  0=A0  0=A0  0=A0  0 */
+=A0=A0=A0 /* byte 3:=A0 0=A0  0=A0 sy=A0 sx=A0  0=A0  1=A0  1=A0  0 */
+=A0=A0=A0 /* byte 4: x7=A0 x6=A0 x5=A0 x4=A0 x3=A0 x2=A0 x1=A0 x0 */
+=A0=A0=A0 /* byte 5: y7=A0 y6=A0 y5=A0 y4=A0 y3=A0 y2=A0 y1=A0 y0 */
+
+=A0=A0=A0 /*
+=A0=A0=A0  * x and y are written in two's complement spread
+=A0=A0=A0  * over 9 bits with sx/sy the relative top bit and
+=A0=A0=A0  * x7..x0 and y7..y0 the lower bits.
+=A0=A0=A0  * The sign of y is opposite to what the input driver
+=A0=A0=A0  * expects for a relative movement
+=A0=A0=A0  */
+
+=A0=A0=A0 struct elantech_data *etd =3D psmouse->private;
+=A0=A0=A0 struct input_dev *dev2 =3D etd->dev2;
+=A0=A0=A0 unsigned char *packet =3D psmouse->packet;
+=A0=A0=A0 int x, y;
+=A0=A0=A0 input_report_key(dev2, BTN_LEFT, packet[0] & 0x01);
+=A0=A0=A0 input_report_key(dev2, BTN_RIGHT, packet[0] & 0x02);
+=A0=A0=A0 input_report_key(dev2, BTN_MIDDLE, packet[0] & 0x04);
+=A0=A0=A0 x =3D (s32) ((u32) ((packet[1] & 0x80) ? 0UL : 0xFFFFFF00UL)=
 | (u32)
+=A0=A0=A0 =A0=A0=A0 =A0  packet[4]);
+=A0=A0=A0 y =3D -(s32) ((u32) ((packet[2] & 0x80) ? 0UL : 0xFFFFFF00UL=
) | (u32)
+=A0=A0=A0 =A0=A0=A0 =A0 =A0 packet[5]);
+=A0=A0=A0 input_report_rel(dev2, REL_X, x);
+=A0=A0=A0 input_report_rel(dev2, REL_Y, y);
+=A0=A0=A0 switch ((((u32) packet[0] & 0xF8) << 24) | ((u32) packet[1] =
<< 16)
+=A0=A0=A0 =A0=A0=A0 | (u32) packet[2] << 8 | (u32) packet[3]) {
+=A0=A0=A0 case 0x00808036UL:
+=A0=A0=A0 case 0x10008026UL:
+=A0=A0=A0 case 0x20800016UL:
+=A0=A0=A0 case 0x30000006UL:
+=A0=A0=A0 =A0=A0=A0 break;
+=A0=A0=A0 default:
+=A0=A0=A0 =A0=A0=A0 /* Dump unexpected packet sequences if debug=3D1 (=
default) */
+=A0=A0=A0 =A0=A0=A0 if (etd->debug =3D=3D 1)
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 elantech_packet_dump(psmouse);
+=A0=A0=A0 =A0=A0=A0 break;
+=A0=A0=A0 }
+
+=A0=A0=A0 input_sync(dev2);
+}
+
/*
=A0 * Interpret complete data packets and report absolute mode input ev=
ents for
=A0 * hardware version 3. (12 byte packets for two fingers)
@@ -688,6 +736,8 @@ static int elantech_packet_check_v3(stru
=A0=A0=A0 if ((packet[0] & 0x0c) =3D=3D 0x0c && (packet[3] & 0xce) =3D=3D=
 0x0c)
=A0=A0=A0 =A0=A0=A0 return PACKET_V3_TAIL;

+=A0=A0=A0 if ((packet[3]&0x0f) =3D=3D 0x06)
+=A0=A0=A0 =A0=A0=A0 return PACKET_TRACKPOINT;
=A0=A0=A0 return PACKET_UNKNOWN;
}

@@ -752,7 +802,10 @@ static psmouse_ret_t elantech_process_by
=A0=A0=A0 =A0=A0=A0 if (packet_type =3D=3D PACKET_UNKNOWN)
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return PSMOUSE_BAD_DATA;

-=A0=A0=A0 =A0=A0=A0 elantech_report_absolute_v3(psmouse, packet_type);
+=A0=A0=A0 =A0=A0=A0 if (packet_type =3D=3D PACKET_TRACKPOINT)
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 elantech_report_trackpoint(psmouse, pack=
et_type);
+=A0=A0=A0 =A0=A0=A0 else
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 elantech_report_absolute_v3(psmouse, pac=
ket_type);
=A0=A0=A0 =A0=A0=A0 break;

=A0=A0=A0 case 4:
@@ -1236,8 +1289,10 @@ int elantech_detect(struct psmouse *psmo
=A0 */
static void elantech_disconnect(struct psmouse *psmouse)
{
+=A0=A0=A0 struct elantech_data *etd =3D psmouse->private;
=A0=A0=A0 sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0  &elantech_attr_group);
+=A0=A0=A0 input_unregister_device(etd->dev2);
=A0=A0=A0 kfree(psmouse->private);
=A0=A0=A0 psmouse->private =3D NULL;
}
@@ -1323,10 +1378,15 @@ int elantech_init(struct psmouse *psmous
=A0=A0=A0 struct elantech_data *etd;
=A0=A0=A0 int i, error;
=A0=A0=A0 unsigned char param[3];
+=A0=A0=A0 struct input_dev *dev2;

=A0=A0=A0 psmouse->private =3D etd =3D kzalloc(sizeof(struct elantech_d=
ata), GFP_KERNEL);
=A0=A0=A0 if (!etd)
=A0=A0=A0 =A0=A0=A0 return -ENOMEM;
+=A0=A0=A0 dev2 =3D input_allocate_device();
+=A0=A0=A0 if (!dev2)
+=A0=A0=A0 =A0=A0=A0 goto init_fail;
+=A0=A0=A0 etd->dev2 =3D dev2;

=A0=A0=A0 psmouse_reset(psmouse);

@@ -1386,9 +1446,26 @@ int elantech_init(struct psmouse *psmous
=A0=A0=A0 psmouse->reconnect =3D elantech_reconnect;
=A0=A0=A0 psmouse->pktsize =3D etd->hw_version > 1 ? 6 : 4;

+=A0=A0=A0 snprintf(etd->phys, sizeof(etd->phys), "%s/input1",
+=A0=A0=A0 =A0=A0=A0 psmouse->ps2dev.serio->phys);
+=A0=A0=A0 dev2->phys =3D etd->phys;
+=A0=A0=A0 dev2->name =3D "My stick";
+=A0=A0=A0 dev2->id.bustype =3D BUS_I8042;
+=A0=A0=A0 dev2->id.vendor=A0 =3D 0x0002;
+=A0=A0=A0 dev2->id.product =3D PSMOUSE_ELANTECH;
+=A0=A0=A0 dev2->id.version =3D 0x0000;
+=A0=A0=A0 dev2->dev.parent =3D &psmouse->ps2dev.serio->dev;
+=A0=A0=A0 dev2->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
+=A0=A0=A0 dev2->relbit[BIT_WORD(REL_X)] =3D BIT_MASK(REL_X) | BIT_MASK=
(REL_Y);
+=A0=A0=A0 dev2->keybit[BIT_WORD(BTN_LEFT)] =3D
+=A0=A0=A0 =A0=A0=A0 BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) | BIT_MA=
SK(BTN_RIGHT);
+
+=A0=A0=A0 if (input_register_device(etd->dev2))
+=A0=A0=A0 =A0=A0=A0 goto init_fail;
=A0=A0=A0 return 0;

=A0 init_fail:
+=A0=A0=A0 input_free_device(dev2);
=A0=A0=A0 kfree(etd);
=A0=A0=A0 return -1;
}
diff -uprN -X linux-3.10.4-vanilla/Documentation/dontdiff linux-3.10.4-=
vanilla/drivers/input/mouse/elantech.h linux-3.10.4/drivers/input/mouse=
/elantech.h
--- linux-3.10.4-vanilla/drivers/input/mouse/elantech.h=A0=A0=A0 2013-0=
7-29 01:30:49.000000000 +0200
+++ linux-3.10.4/drivers/input/mouse/elantech.h=A0=A0=A0 2013-07-30 21:=
14:09.000000000 +0200
@@ -94,6 +94,7 @@
#define PACKET_V4_HEAD=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 0x05
#define PACKET_V4_MOTION=A0=A0=A0 =A0=A0=A0 0x06
#define PACKET_V4_STATUS=A0=A0=A0 =A0=A0=A0 0x07
+#define PACKET_TRACKPOINT=A0=A0=A0 =A0=A0=A0 0x08

/*
=A0 * track up to 5 fingers for v4 hardware
@@ -114,6 +115,8 @@ struct finger_pos {
};

struct elantech_data {
+=A0=A0=A0 struct input_dev *dev2;=A0=A0=A0 =A0=A0=A0 /* Relative devic=
e */
+=A0=A0=A0 char=A0=A0=A0 phys[32];
=A0=A0=A0 unsigned char reg_07;
=A0=A0=A0 unsigned char reg_10;
=A0=A0=A0 unsigned char reg_11;

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
