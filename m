From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 14/14] alps: Add support for v7 devices
Date: Sat, 26 Jul 2014 10:22:08 +0200
Message-ID: <53D36530.9020408@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com> <1404919459-23561-15-git-send-email-hdegoede@redhat.com> <20140726055811.GA31435@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64794 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbaGZIWT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jul 2014 04:22:19 -0400
In-Reply-To: <20140726055811.GA31435@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org

Hi,

On 07/26/2014 07:59 AM, Dmitry Torokhov wrote:> Hi Hans,
>
> On Wed, Jul 09, 2014 at 05:24:05PM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> This series started out as a single patch to add support for a new m=
odel
>> of alps touchpad, called PROTO_V7 in this patchset.
>>
>> While working on this I ended up doing some refactoring as preparati=
on, which
>> I tested on a Rushmore alps touchpad, which lead to some bugfixes an=
d more
>> cleanups, etc.
>>
>> The result is a 14 patch patch-set, which:
>>
>> 1) Significantly improves multi-touch support on V3 and V4 models (i=
ncluding
>>    the Rushmore V3 variant)
>> 2) Improves the code quality / readability quite a bit
>> 3) Adds support for PROTO_V7
>
> Excellent series, very easy to read. I have applied everything but v7
> support as I have questions about that patch.

I'm glad you like the series, that shows that my work to split it into
manageable bits was worth the extra effort, so that is good to hear.

On 07/26/2014 07:58 AM, Dmitry Torokhov wrote:
> Hi Hans,
>=20
> On Wed, Jul 09, 2014 at 05:24:19PM +0200, Hans de Goede wrote:
>> From: Yunkang Tang <yunkang.tang@cn.alps.com>
>>
>> Such as found on the new Toshiba Port=E9g=E9 Z30-A and Z40-A.
>>
>> Signed-off-by: Yunkang Tang <yunkang.tang@cn.alps.com>
>> [hdegoede@redhat.com: Remove softbutton handling, this is done in us=
erspace]
>> [hdegoede@redhat.com: Report INPUT_PROP_BUTTONPAD]
>> [hdegoede@redhat.com: Do not report fake PRESSURE, reporting BTN_TOU=
CH is
>>  enough]
>> [hdegoede@redhat.com: Various cleanups / refactoring]
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/input/mouse/alps.c | 257 ++++++++++++++++++++++++++++++++++=
++++++++++-
>>  drivers/input/mouse/alps.h |  18 ++++
>>  2 files changed, 272 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index ad3a708..8b9b4b0 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -100,6 +100,7 @@ static const struct alps_nibble_commands alps_v6=
_nibble_commands[] =3D {
>>  #define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved=
 with
>>  					   6-byte ALPS packet */
>>  #define ALPS_IS_RUSHMORE	0x100	/* device is a rushmore */
>> +#define ALPS_BUTTONPAD		0x200	/* device is a clickpad */
>> =20
>>  static const struct alps_model_info alps_model_data[] =3D {
>>  	{ { 0x32, 0x02, 0x14 },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS=
 | ALPS_DUALPOINT },	/* Toshiba Salellite Pro M10 */
>> @@ -845,6 +846,177 @@ static void alps_process_packet_v4(struct psmo=
use *psmouse)
>>  	alps_report_semi_mt_data(psmouse, f->fingers);
>>  }
>> =20
>> +static bool alps_is_valid_package_v7(struct psmouse *psmouse)
>> +{
>> +	if ((psmouse->pktcnt =3D=3D 3) && ((psmouse->packet[2] & 0x40) !=3D=
 0x40))
>> +		return false;
>> +	if ((psmouse->pktcnt =3D=3D 4) && ((psmouse->packet[3] & 0x48) !=3D=
 0x48))
>> +		return false;
>> +	if ((psmouse->pktcnt =3D=3D 6) && ((psmouse->packet[5] & 0x40) !=3D=
 0x0))
>> +		return false;
>> +	return true;
>=20
> Maybe:
>=20
> 	switch (psmouse->pktcnt) {
> 	case 3:
> 		return (psmouse->packet[2] & 0x40) =3D=3D 0x40;
>=20
> 	case 4:
> 		return (psmouse->packet[3] & 0x48) =3D=3D 0x48;
>=20
> 	case 6:
> 		return (psmouse->packet[5] & 0x40) =3D=3D 0x00;
> 	}
>=20
> 	return true;
>=20
> ?

Will fix.

>=20
>=20
>> +}
>> +
>> +static unsigned char alps_get_packet_id_v7(char *byte)
>> +{
>> +	unsigned char packet_id;
>> +
>> +	if (byte[4] & 0x40)
>> +		packet_id =3D V7_PACKET_ID_TWO;
>> +	else if (byte[4] & 0x01)
>> +		packet_id =3D V7_PACKET_ID_MULTI;
>> +	else if ((byte[0] & 0x10) && !(byte[4] & 0x43))
>> +		packet_id =3D V7_PACKET_ID_NEW;
>> +	else if (byte[1] =3D=3D 0x00 && byte[4] =3D=3D 0x00)
>> +		packet_id =3D V7_PACKET_ID_IDLE;
>> +	else
>> +		packet_id =3D V7_PACKET_ID_UNKNOWN;
>> +
>> +	return packet_id;
>> +}
>> +
>> +static void alps_get_finger_coordinate_v7(struct input_mt_pos *mt,
>> +					  unsigned char *pkt,
>> +					  unsigned char pkt_id)
>> +{
>> +	mt[0].x =3D ((pkt[2] & 0x80) << 4);
>> +	mt[0].x |=3D ((pkt[2] & 0x3F) << 5);
>> +	mt[0].x |=3D ((pkt[3] & 0x30) >> 1);
>> +	mt[0].x |=3D (pkt[3] & 0x07);
>> +	mt[0].y =3D (pkt[1] << 3) | (pkt[0] & 0x07);
>> +
>> +	mt[1].x =3D ((pkt[3] & 0x80) << 4);
>> +	mt[1].x |=3D ((pkt[4] & 0x80) << 3);
>> +	mt[1].x |=3D ((pkt[4] & 0x3F) << 4);
>> +	mt[1].y =3D ((pkt[5] & 0x80) << 3);
>> +	mt[1].y |=3D ((pkt[5] & 0x3F) << 4);
>> +
>> +	if (pkt_id =3D=3D V7_PACKET_ID_TWO) {
>> +		mt[1].x &=3D ~0x000F;
>> +		mt[1].y |=3D 0x000F;
>> +	} else if (pkt_id =3D=3D V7_PACKET_ID_MULTI) {
>> +		mt[1].x &=3D ~0x003F;
>> +		mt[1].y &=3D ~0x0020;
>> +		mt[1].y |=3D ((pkt[4] & 0x02) << 4);
>> +		mt[1].y |=3D 0x001F;
>> +	} else if (pkt_id =3D=3D V7_PACKET_ID_NEW) {
>> +		mt[1].x &=3D ~0x003F;
>> +		mt[1].x |=3D (pkt[0] & 0x20);
>> +		mt[1].y |=3D 0x000F;
>> +	}
>> +
>> +	mt[0].y =3D 0x7FF - mt[0].y;
>> +	mt[1].y =3D 0x7FF - mt[1].y;
>> +}
>> +
>> +static int alps_get_mt_count(struct input_mt_pos *mt)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < MAX_TOUCHES && mt[i].x !=3D 0 && mt[i].y !=3D 0;=
 i++)
>> +		;
>=20
> 		/* empty */;
>=20
> just to make sure...

Will fix.

>=20
>> +
>> +	return i;
>> +}
>> +
>> +static int alps_decode_packet_v7(struct alps_fields *f,
>> +				  unsigned char *p,
>> +				  struct psmouse *psmouse)
>> +{
>> +	unsigned char pkt_id;
>> +
>> +	pkt_id =3D alps_get_packet_id_v7(p);
>> +	if (pkt_id =3D=3D V7_PACKET_ID_IDLE)
>> +		return 0;
>> +	if (pkt_id =3D=3D V7_PACKET_ID_UNKNOWN)
>> +		return -1;
>> +
>> +	alps_get_finger_coordinate_v7(f->mt, p, pkt_id);
>> +
>> +	if (pkt_id =3D=3D V7_PACKET_ID_TWO || pkt_id =3D=3D V7_PACKET_ID_M=
ULTI) {
>> +		f->left =3D (p[0] & 0x80) >> 7;
>> +		f->right =3D (p[0] & 0x20) >> 5;
>> +		f->middle =3D (p[0] & 0x10) >> 4;
>> +	}
>> +
>> +	if (pkt_id =3D=3D V7_PACKET_ID_TWO)
>> +		f->fingers =3D alps_get_mt_count(f->mt);
>> +	else if (pkt_id =3D=3D V7_PACKET_ID_MULTI)
>> +		f->fingers =3D 3 + (p[5] & 0x03);
>> +
>> +	return 0;
>> +}
>> +
>> +static void alps_process_trackstick_packet_v7(struct psmouse *psmou=
se)
>> +{
>> +	struct alps_data *priv =3D psmouse->private;
>> +	unsigned char *packet =3D psmouse->packet;
>> +	struct input_dev *dev2 =3D priv->dev2;
>> +	int x, y, z, left, right, middle;
>> +
>> +	/*
>> +	 *        b7 b6 b5 b4 b3 b2 b1 b0
>> +	 * Byte0   0  1  0  0  1  0  0  0
>> +	 * Byte1   1  1  *  *  1  M  R  L
>> +	 * Byte2  X7  1 X5 X4 X3 X2 X1 X0
>> +	 * Byte3  Z6  1 Y6 X6  1 Y2 Y1 Y0
>> +	 * Byte4  Y7  0 Y5 Y4 Y3  1  1  0
>> +	 * Byte5 T&P  0 Z5 Z4 Z3 Z2 Z1 Z0
>> +	 * M / R / L: Middle / Right / Left button
>> +	 */
>> +
>> +	x =3D ((packet[2] & 0xbf)) | ((packet[3] & 0x10) << 2);
>> +	y =3D (packet[3] & 0x07) | (packet[4] & 0xb8) |
>> +	    ((packet[3] & 0x20) << 1);
>> +	z =3D (packet[5] & 0x3f) | ((packet[3] & 0x80) >> 1);
>> +
>> +	left =3D (packet[1] & 0x01);
>> +	right =3D (packet[1] & 0x02) >> 1;
>> +	middle =3D (packet[1] & 0x04) >> 2;
>> +
>> +	/* Divide 2 since trackpoint's speed is too fast */
>> +	input_report_rel(dev2, REL_X, (char)x / 2);
>> +	input_report_rel(dev2, REL_Y, -((char)y / 2));
>> +
>> +	input_report_key(dev2, BTN_LEFT, left);
>> +	input_report_key(dev2, BTN_RIGHT, right);
>> +	input_report_key(dev2, BTN_MIDDLE, middle);
>> +
>> +	input_sync(dev2);
>> +}
>> +
>> +static void alps_process_touchpad_packet_v7(struct psmouse *psmouse=
)
>> +{
>> +	struct alps_data *priv =3D psmouse->private;
>> +	struct input_dev *dev =3D psmouse->dev;
>> +	struct alps_fields *f =3D &priv->f;
>> +
>> +	memset(f, 0, sizeof(*f));
>> +
>> +	if (priv->decode_fields(f, psmouse->packet, psmouse))
>> +		return;
>> +
>> +	alps_report_mt_data(psmouse, alps_get_mt_count(f->mt));
>> +
>> +	input_mt_report_finger_count(dev, f->fingers);
>> +
>> +	input_report_key(dev, BTN_LEFT, f->left);
>> +	input_report_key(dev, BTN_RIGHT, f->right);
>> +	input_report_key(dev, BTN_MIDDLE, f->middle);
>> +
>> +	input_sync(dev);
>> +}
>> +
>> +static void alps_process_packet_v7(struct psmouse *psmouse)
>> +{
>> +	unsigned char *packet =3D psmouse->packet;
>> +
>> +	if ((packet[0] =3D=3D 0x48) && ((packet[4] & 0x47) =3D=3D 0x06))
>> +		alps_process_trackstick_packet_v7(psmouse);
>> +	else
>> +		alps_process_touchpad_packet_v7(psmouse);
>> +}
>> +
>>  static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
>>  					unsigned char packet[],
>>  					bool report_buttons)
>> @@ -1009,6 +1181,14 @@ static psmouse_ret_t alps_process_byte(struct=
 psmouse *psmouse)
>>  		return PSMOUSE_BAD_DATA;
>>  	}
>> =20
>> +	if (priv->proto_version =3D=3D ALPS_PROTO_V7 &&
>> +			!alps_is_valid_package_v7(psmouse)) {
>> +		psmouse_dbg(psmouse, "refusing packet[%i] =3D %x\n",
>> +			    psmouse->pktcnt - 1,
>> +			    psmouse->packet[psmouse->pktcnt - 1]);
>> +		return PSMOUSE_BAD_DATA;
>> +	}
>> +
>>  	if (psmouse->pktcnt =3D=3D psmouse->pktsize) {
>>  		priv->process_packet(psmouse);
>>  		return PSMOUSE_FULL_PACKET;
>> @@ -1121,6 +1301,22 @@ static int alps_rpt_cmd(struct psmouse *psmou=
se, int init_command,
>>  	return 0;
>>  }
>> =20
>> +static int alps_check_valid_firmware_id(unsigned char id[])
>=20
> bool
>=20
>> +{
>> +	int valid =3D 1;
>=20
> bool; true
>=20
>> +
>> +	if (id[0] =3D=3D 0x73)
>> +		valid =3D 1;
>=20
> true
>=20
>> +	else if (id[0] =3D=3D 0x88) {
>> +		if ((id[1] =3D=3D 0x07) ||
>> +		    (id[1] =3D=3D 0x08) ||
>> +		    ((id[1] & 0xf0) =3D=3D 0xB0))
>> +			valid =3D 1;
>=20
> true
>=20
>> +	}
>> +
>> +	return valid;
>=20
> Hmmm, does not make sense - it is never false...

Right, if you look at the code it factors out (below)
valid should clearly be initialized to false, good catch.

Or even better, don't have valid at all simply use
"return true" in the if blocks and "return false"
at the end, that's what I'll do for v2.




>=20
>> +}
>> +
>>  static int alps_enter_command_mode(struct psmouse *psmouse)
>>  {
>>  	unsigned char param[4];
>> @@ -1130,8 +1326,7 @@ static int alps_enter_command_mode(struct psmo=
use *psmouse)
>>  		return -1;
>>  	}
>> =20
>> -	if ((param[0] !=3D 0x88 || (param[1] !=3D 0x07 && param[1] !=3D 0x=
08)) &&
>> -	    param[0] !=3D 0x73) {
>> +	if (!alps_check_valid_firmware_id(param)) {
>>  		psmouse_dbg(psmouse,
>>  			    "unknown response while entering command mode\n");
>>  		return -1;
>> @@ -1785,6 +1980,32 @@ static int alps_hw_init_dolphin_v1(struct psm=
ouse *psmouse)
>>  	return 0;
>>  }


Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
