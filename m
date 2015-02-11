From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Dell ALPS patches for Dell Latitude 7250 & 7450
Date: Wed, 11 Feb 2015 08:38:58 +0100
Message-ID: <54DB0712.4050306@redhat.com>
References: <201502101419.53861@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58807 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbbBKHjK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2015 02:39:10 -0500
In-Reply-To: <201502101419.53861@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>

Hi,

On 10-02-15 14:19, Pali Roh=C3=A1r wrote:
> Hello,
>
> now I found on Dell support website, that they also provide
> psmouse/alps.c driver for new Dell Latitude 7250 & 7450 machines:
> http://www.dell.com/support/home/gh/en/ghdhs1/Drivers/DriversDetails?=
driverId=3DN5V5D
>
> It is again in Ubuntu support package and so users and developers
> who do not use Ubuntu probably do not know about it...
>
> Dell alps.c driver introduced ALPS protocol v8 and v9. I did not
> found anything on linux-input ML about it, so to make sure that
> support for new ALPS/Dell models for linux do not disappear I'm
> sending diff against linux v3.14-rc1 version (which looks like to
> be version of which Dell introduced they changes)...

Thanks for this and the other related mail. I also have an alps.c
directly from alps themselves which adds support for v8 and v9
protocols. The problem is that like with v7 the code is not really
in a state where we want to take it as is, e.g. it does clickpad
softbutton emulation in the kernel instead of leaving it to userspace.

I spend a considerable amount of time cleaning up the alps code itself
and then adding a cleaner version of the v7 code, we should do the same
for the v8 and v9 code probably but that requires someone with hardware
access so that we can actually test the end result.

Regards,

Hans


>
>
> --- linux-3.14-rc1/drivers/input/mouse/alps.c	2015-02-08 12:38:06.507=
282067 +0100
> +++ goliad-mlk-14_A03.fish.tar.gz/debs/touchpad-alps-trusty-dkms_2014=
0325_all.deb/usr/src/touchpad-alps-trusty-20140325/alps.c	2014-06-06 04=
:21:48.000000000 +0200
> @@ -20,6 +20,7 @@
>   #include <linux/input/mt.h>
>   #include <linux/serio.h>
>   #include <linux/libps2.h>
> +#include <linux/kernel.h>
>
>   #include "psmouse.h"
>   #include "alps.h"
> @@ -32,6 +33,11 @@
>   #define ALPS_REG_BASE_RUSHMORE	0xc2c0
>   #define ALPS_REG_BASE_PINNACLE	0x0000
>
> +#define LEFT_BUTTON_BIT			0x01
> +#define RIGHT_BUTTON_BIT		0x02
> +
> +#define V7_LARGE_MOVEMENT		130
> +
>   static const struct alps_nibble_commands alps_v3_nibble_commands[] =
=3D {
>   	{ PSMOUSE_CMD_SETPOLL,		0x00 }, /* 0 */
>   	{ PSMOUSE_CMD_RESET_DIS,	0x00 }, /* 1 */
> @@ -99,6 +105,10 @@ static const struct alps_nibble_commands
>   #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
>   #define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved=
 with
>   					   6-byte ALPS packet */
> +#define ALPS_BTNLESS			0x100	/* ALPS ClickPad flag */
> +
> +#define	DOL_IS_APDATA(_BY)			((_BY[0]&0x01)=3D=3D0x01)
> +#define	DOL_IS_PROFDATA(_BY)		((_BY[0]&0x20)=3D=3D0x20)
>
>   static const struct alps_model_info alps_model_data[] =3D {
>   	{ { 0x32, 0x02, 0x14 },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS=
 | ALPS_DUALPOINT },	/* Toshiba Salellite Pro M10 */
> @@ -140,6 +150,20 @@ static void alps_set_abs_params_mt(struc
>    * isn't valid per PS/2 spec.
>    */
>
> +static unsigned int alps_pt_distance(struct alps_abs_data *pt0,
> +				    struct alps_abs_data *pt1)
> +{
> +	int vect_x, vect_y;
> +
> +	if (!pt0 || !pt1)
> +		return 0;
> +
> +	vect_x =3D pt0->x - pt1->x;
> +	vect_y =3D pt0->y - pt1->y;
> +
> +	return int_sqrt(vect_x * vect_x + vect_y * vect_y);
> +}
> +
>   /* Packet formats are described in Documentation/input/alps.txt */
>
>   static bool alps_is_valid_first_byte(struct alps_data *priv,
> @@ -296,8 +320,8 @@ static void alps_process_bitmap_dolphin(
>   	y_map =3D fields->y_map;
>
>   	if (!x_map || !y_map)
> -		return;
> -
> +        return;
> +=09
>   	/* Get Most-significant and Least-significant bit */
>   	x_msb =3D fls(x_map);
>   	x_lsb =3D ffs(x_map);
> @@ -306,8 +330,8 @@ static void alps_process_bitmap_dolphin(
>
>   	/* Most-significant bit should never exceed max sensor line number=
 */
>   	if (x_msb > priv->x_bits || y_msb > priv->y_bits)
> -		return;
> -
> +        return;
> +=09
>   	*x1 =3D *y1 =3D *x2 =3D *y2 =3D 0;
>
>   	if (fields->fingers > 1) {
> @@ -320,11 +344,11 @@ static void alps_process_bitmap_dolphin(
>   		end_bit =3D y_msb - 1;
>   		box_middle_y =3D (priv->y_max * (start_bit + end_bit)) /
>   				(2 * (priv->y_bits - 1));
> -		*x1 =3D fields->x;
> -		*y1 =3D fields->y;
> +		*x1 =3D fields->pt.x;
> +		*y1 =3D fields->pt.y;
>   		*x2 =3D 2 * box_middle_x - *x1;
>   		*y2 =3D 2 * box_middle_y - *y1;
> -	}
> +	}=09
>   }
>
>   /*
> @@ -461,6 +485,55 @@ static void alps_report_semi_mt_data(str
>   	alps_set_slot(dev, 1, num_fingers =3D=3D 2, x2, y2);
>   }
>
> +static void alps_report_semi_mt_data_ex(struct input_dev *dev, int n=
um_fingers,
> +				     struct alps_abs_data coord[])
> +{
> +	unsigned char i;
> +
> +	for (i =3D 0; i < num_fingers; i++) {
> +		if (!coord[i].x || !coord[i].y || !coord[i].z) {
> +			alps_set_slot(dev, i, 0, coord[i].x, coord[i].y);
> +		}
> +		else {
> +			alps_set_slot(dev, i, 1, coord[i].x, coord[i].y);
> +		}
> +	}
> +}
> +
> +static void alps_report_coord_and_btn(struct psmouse *psmouse,
> +				      struct alps_fields *f)
> +{
> +	struct input_dev *dev;
> +
> +	if (!psmouse || !f)
> +		return;
> +
> +	dev =3D psmouse->dev;
> +
> +	if (f->fingers) {
> +		input_report_key(dev, BTN_TOUCH, 1);
> +
> +		alps_report_semi_mt_data(dev, f->fingers,
> +			f->pt_img[0].x, f->pt_img[0].y,
> +			f->pt_img[1].x, f->pt_img[1].y);
> +		input_mt_report_finger_count(dev, f->fingers);
> +
> +		input_report_abs(dev, ABS_X, f->pt_img[0].x);
> +		input_report_abs(dev, ABS_Y, f->pt_img[0].y);
> +		input_report_abs(dev, ABS_PRESSURE, f->pt_img[0].z);
> +	} else {
> +		input_report_key(dev, BTN_TOUCH, 0);
> +		input_mt_report_finger_count(dev, 0);
> +		input_report_abs(dev, ABS_PRESSURE, 0);
> +	}
> +
> +	input_report_key(dev, BTN_LEFT, f->btn.left);
> +	input_report_key(dev, BTN_RIGHT, f->btn.right);
> +	input_report_key(dev, BTN_MIDDLE, f->btn.middle);
> +
> +	input_sync(dev);
> +}
> +
>   static void alps_process_trackstick_packet_v3(struct psmouse *psmou=
se)
>   {
>   	struct alps_data *priv =3D psmouse->private;
> @@ -523,13 +596,22 @@ static void alps_process_trackstick_pack
>
>   static void alps_decode_buttons_v3(struct alps_fields *f, unsigned =
char *p)
>   {
> -	f->left =3D !!(p[3] & 0x01);
> -	f->right =3D !!(p[3] & 0x02);
> -	f->middle =3D !!(p[3] & 0x04);
> -
> -	f->ts_left =3D !!(p[3] & 0x10);
> -	f->ts_right =3D !!(p[3] & 0x20);
> -	f->ts_middle =3D !!(p[3] & 0x40);
> +	f->btn.left =3D !!(p[3] & 0x01);
> +	f->btn.right =3D !!(p[3] & 0x02);
> +	f->btn.middle =3D !!(p[3] & 0x04);
> +
> +	f->btn.ts_left =3D !!(p[3] & 0x10);
> +	f->btn.ts_right =3D !!(p[3] & 0x20);
> +	f->btn.ts_middle =3D !!(p[3] & 0x40);
> +}
> +
> +/* proto_v9 */
> +static void alps_decode_button_ss3(struct alps_fields *f, unsigned c=
har *p,
> +				struct alps_data *priv)
> +{
> +	if(f->dol_packet_type =3D=3D DOL_GPDATA ||
> +	   f->dol_packet_type =3D=3D DOL_APDATA)
> +		f->btn.left =3D !!(p[3]&0x01);
>   }
>
>   static void alps_decode_pinnacle(struct alps_fields *f, unsigned ch=
ar *p,
> @@ -546,10 +628,10 @@ static void alps_decode_pinnacle(struct
>   		   ((p[2] & 0x7f) << 1) |
>   		   (p[4] & 0x01);
>
> -	f->x =3D ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) |
> +	f->pt.x =3D ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) |
>   	       ((p[0] & 0x30) >> 4);
> -	f->y =3D ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
> -	f->z =3D p[5] & 0x7f;
> +	f->pt.y =3D ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
> +	f->pt.z =3D p[5] & 0x7f;
>
>   	alps_decode_buttons_v3(f, p);
>   }
> @@ -559,7 +641,7 @@ static void alps_decode_rushmore(struct
>   {
>   	alps_decode_pinnacle(f, p, psmouse);
>
> -	/* Rushmore's packet decode has a bit difference with Pinnacle's */
> +	/* rushmore's packet decode has a bit difference with pinnacle's */
>   	f->is_mp =3D !!(p[5] & 0x40);
>   	f->fingers =3D max((p[5] & 0x3), ((p[5] >> 2) & 0x3)) + 1;
>   	f->x_map |=3D (p[5] & 0x10) << 11;
> @@ -572,18 +654,14 @@ static void alps_decode_dolphin(struct a
>   	u64 palm_data =3D 0;
>   	struct alps_data *priv =3D psmouse->private;
>
> -	f->first_mp =3D !!(p[0] & 0x02);
> -	f->is_mp =3D !!(p[0] & 0x20);
> -
> -	if (!f->is_mp) {
> -		f->x =3D ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
> -		f->y =3D ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
> -		f->z =3D (p[0] & 4) ? 0 : p[5] & 0x7f;
> -		alps_decode_buttons_v3(f, p);
> -	} else {
> +	f->is_mp =3D 0;
> +	f->first_mp =3D 0;
> +=09
> +	if ( DOL_IS_PROFDATA(p) ){
> +		f->is_mp =3D 1;
> +		f->dol_packet_type =3D DOL_PROFDATA;
>   		f->fingers =3D ((p[0] & 0x6) >> 1 |
>   		     (p[0] & 0x10) >> 2);
> -
>   		palm_data =3D (p[1] & 0x7f) |
>   			    ((p[2] & 0x7f) << 7) |
>   			    ((p[4] & 0x7f) << 14) |
> @@ -598,6 +676,400 @@ static void alps_decode_dolphin(struct a
>   		/* X-profile is stored in p(n) to p(n+m-1), m =3D x_bits; */
>   		f->x_map =3D (palm_data >> priv->y_bits) &
>   			   (BIT(priv->x_bits) - 1);
> +	}else{
> +		if ( DOL_IS_APDATA(p) ){
> +			f->dol_packet_type =3D DOL_APDATA;
> +			f->fingers =3D 2;
> +			f->pt_img[0].x =3D p[1]<<3;
> +			f->pt_img[0].y =3D p[2]<<2;
> +			f->pt_img[0].z =3D 64;
> +			f->pt_img[1].x =3D p[4]<<3;
> +			f->pt_img[1].y =3D p[5]<<2;
> +			f->pt_img[1].z =3D 64;
> +		}else{// is gp data
> +			f->dol_packet_type =3D DOL_GPDATA;
> +			f->first_mp =3D !!(p[0]&0x02);
> +			f->pt.x =3D f->pt_img[0].x =3D ((p[1] & 0x7f) | ((p[4] & 0x0f) <<=
 7));
> +			f->pt.y =3D f->pt_img[0].y =3D ((p[2] & 0x7f) | ((p[4] & 0xf0) <<=
 3));
> +			f->pt.z =3D f->pt_img[0].z =3D (p[0] & 4) ? 0 : p[5] & 0x7f;
> +			/*
> +				Button number will be included in the PROFILE data for a 3-f
> +				packet. So do not change .fingers because it will be updated
> +				in Profile data packet.
> +			*/
> +			if(!f->first_mp)
> +				f->fingers =3D
> +					(f->pt_img[0].x && f->pt_img[0].y && f->pt_img[0].z)?1:0;
> +		}
> +	=09
> +		if(priv->proto_version =3D=3D ALPS_PROTO_V9){
> +			alps_decode_button_ss3(f, p, priv);
> +		}else{
> +			alps_decode_buttons_v3(f, p);
> +		}=09
> +	}
> +}
> +
> +unsigned char alps_get_pkt_id_ss4_v1(char *byte)
> +{
> +	unsigned char pkt_id =3D SS4_PACKET_ID_IDLE;
> +
> +	if (((byte[0] & 0xFF) =3D=3D 0x08) && ((byte[1] & 0xFF) =3D=3D 0x10=
) &&
> +	     ((byte[2] & 0xFF) =3D=3D 0x00) && ((byte[3] & 0x8F) =3D=3D 0x0=
8) &&
> +	     ((byte[4] & 0xFF) =3D=3D 0x01) && ((byte[5] & 0xFF) =3D=3D 0x0=
0)) {
> +		pkt_id =3D SS4_PACKET_ID_IDLE;
> +	}
> +	else if (((byte[0] & 0x08) =3D=3D 0x08) && ((byte[1] & 0x10) =3D=3D=
 0x10) &&
> +		((byte[3] & 0x8E) =3D=3D 0x08) && ((byte[4] & 0x81) =3D=3D 0x01) )=
 {
> +		pkt_id =3D SS4_PACKET_ID_ONE;
> +	}
> +	else if(((byte[0] & 0x08) =3D=3D 0x08) && ((byte[3] & 0x08) =3D=3D =
0x08) &&
> +		  ((byte[4] & 0x01) =3D=3D 0x01) ){
> +		if(((byte[5] & 0x01) =3D=3D 0x01))
> +			pkt_id =3D SS4_PACKET_ID_TWO;
> +		else
> +			pkt_id =3D SS4_PACKET_ID_MULTI;
> +	}
> +
> +	return pkt_id;
> +}
> +
> +unsigned char alps_get_pkt_id_ss4_v2(char *byte)
> +{
> +	unsigned char pkt_id =3D SS4_PACKET_ID_IDLE;
> +
> +	if (((byte[0] & 0xFF) =3D=3D 0x18) && ((byte[1] & 0xFF) =3D=3D 0x10=
) &&
> +	     ((byte[2] & 0xFF) =3D=3D 0x00) && ((byte[3] & 0x88) =3D=3D 0x0=
8) &&
> +	     ((byte[4] & 0xFF) =3D=3D 0x10) && ((byte[5] & 0xFF) =3D=3D 0x0=
0)) {
> +		pkt_id =3D SS4_PACKET_ID_IDLE;
> +	}
> +	else if (!(byte[3] & 0x10)) {
> +		pkt_id =3D SS4_PACKET_ID_ONE;
> +	}
> +	else {
> +		if (!(byte[3] & 0x20)) {
> +			pkt_id =3D SS4_PACKET_ID_TWO;
> +		}
> +		else {
> +			pkt_id =3D SS4_PACKET_ID_MULTI;
> +		}
> +	}
> +
> +	return pkt_id;
> +}
> +
> +static void alps_process_btnless_click(struct psmouse *psmouse, stru=
ct alps_fields *f)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +=09
> +	if (!f->btn.left)
> +		return;
> +
> +	// Clear button flag
> +	f->btn.left =3D 0;
> +
> +	switch (f->fingers) {
> +	case 1:
> +		// In Left Resting Area
> +		if (PT_IN_LEFT_BTN_AREA(f->pt_img[0].x, f->pt_img[0].y, priv->x_ma=
x, priv->y_max)) {
> +			f->btn.left =3D 1;
> +		}
> +		// In Right Resting Area
> +		else if (PT_IN_RIGHT_BTN_AREA(f->pt_img[0].x, f->pt_img[0].y, priv=
->x_max, priv->y_max)) {
> +			f->btn.right =3D 1;
> +		}
> +		// In Normal area
> +		else {
> +			f->btn.left =3D 1;
> +		}
> +		break;
> +
> +	case 2:
> +		// Both two fingers are in Normal area
> +		if (!PT_IN_BTN_AREA(f->pt_img[0].x, f->pt_img[0].y, priv->x_max, p=
riv->y_max) &&
> +			!PT_IN_BTN_AREA(f->pt_img[1].x, f->pt_img[1].y, priv->x_max, priv=
->y_max)) {
> +			f->btn.right =3D 1;
> +		}
> +		// Either one finger is in Right Area
> +		else if (PT_IN_RIGHT_BTN_AREA(f->pt_img[0].x, f->pt_img[0].y, priv=
->x_max, priv->y_max) ||
> +				 PT_IN_RIGHT_BTN_AREA(f->pt_img[1].x, f->pt_img[1].y, priv->x_ma=
x, priv->y_max)) {
> +			f->btn.right =3D 1;
> +		}
> +		else {
> +			f->btn.left =3D 1;
> +		}
> +		break;
> +=09
> +	case 3:
> +		f->btn.middle =3D 1;
> +		break;
> +
> +	case 0:
> +	default:
> +		break;
> +	}
> +}
> +
> +static void alps_process_resting_finger(struct psmouse *psmouse, str=
uct alps_fields *f, struct alps_abs_data *output, unsigned char *p_fn)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	static struct alps_abs_data prev_pt[10];
> +	static struct alps_abs_data init_pt[10];
> +	static unsigned char is_moved[10];
> +	static unsigned char prev_fn =3D 0;
> +	static unsigned char prev_coord_is_output[10];
> +	unsigned char cur_coord_is_output[10];
> +	unsigned char in_resting_area[10];
> +	unsigned char i, index;
> +	unsigned char output_fn =3D 0;
> +
> +	memset(in_resting_area, 0, sizeof(in_resting_area));
> +	memset(cur_coord_is_output, 0, sizeof(cur_coord_is_output));
> +
> +	// Clear "is_moved" flag when finger number changed
> +	if (f->fingers !=3D prev_fn) {
> +		memset(is_moved, 0, sizeof(is_moved));
> +		memcpy(init_pt, f->pt_img, sizeof(f->pt_img));
> +	}
> +
> +	// Calculate output finger
> +	for (i =3D 0, index =3D 0; i < f->fingers; i++) {
> +		if (is_moved[i] =3D=3D 0 && (abs(f->pt_img[i].x - init_pt[i].x) > =
RESTING_FN_LARGE_MOVEMENT) ) {
> +			is_moved[i] =3D 1;
> +		}
> +
> +		// Check if in resting area
> +		if (PT_IN_BTN_AREA(f->pt_img[i].x, f->pt_img[i].y, priv->x_max, pr=
iv->y_max)) {
> +			in_resting_area[i] =3D 1;
> +		}
> +
> +		if (!in_resting_area[i] || (in_resting_area[i] && is_moved[i])) {
> +			memcpy(&output[index++], &f->pt_img[i], sizeof(struct alps_abs_da=
ta));
> +			cur_coord_is_output[i] =3D 1;
> +			output_fn ++;=09
> +        }
> +	}
> +=09
> +	// A normal finger becomes a resting finger
> +	for (i =3D 0; i < f->fingers; i++) {
> +		if (prev_coord_is_output[i] && !cur_coord_is_output[i] && f->pt_im=
g[i].z) {
> +			output_fn =3D 0;
> +			memset(output, 0, sizeof(struct alps_abs_data)*f->fingers);
> +		}
> +	}
> +
> +	memcpy(prev_pt, f->pt_img, sizeof(f->pt_img));
> +	memcpy(prev_coord_is_output, cur_coord_is_output, sizeof(cur_coord_=
is_output));
> +	prev_fn =3D f->fingers;
> +	*p_fn =3D output_fn;
> +}
> +
> +static void alps_decode_ss4_v1(struct alps_fields *f, unsigned char =
*p, struct psmouse *psmouse)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	unsigned char pkt_id;
> +	unsigned int no_data_x, no_data_y;
> +
> +	if (!psmouse || !f || !p )
> +		return;
> +
> +	pkt_id =3D alps_get_pkt_id_ss4_v1(p);
> +
> +	// Current packet is 1Finger coordinate packet
> +	switch (pkt_id) {
> +	case SS4_PACKET_ID_ONE:
> +		f->pt_img[0].x =3D SS4_1F_X_V1(p);
> +		f->pt_img[0].y =3D SS4_1F_Y_V1(p);
> +		f->pt_img[0].z =3D ((SS4_1F_Z_V1(p)) * 2) & 0x7f;	// Keep Z-value =
in 0-127
> +
> +		f->large_fn |=3D COSMO_1F_LFB(p) ? 0x01 : 0x00;
> +
> +		f->fingers =3D 1;
> +		f->first_mp =3D 0;
> +		f->is_mp =3D 0;
> +		break;
> +
> +	case SS4_PACKET_ID_TWO:
> +		if (priv->flags & ALPS_BTNLESS) {
> +			f->pt_img[0].x =3D SS4_BTL_MF_X_V1( p, 0 ) ;
> +			f->pt_img[0].y =3D SS4_BTL_MF_Y_V1( p, 0 ) ;
> +			f->pt_img[1].x =3D SS4_BTL_MF_X_V1( p, 1 ) ;
> +			f->pt_img[1].y =3D SS4_BTL_MF_Y_V1( p, 1 ) ;
> +		}
> +		else {
> +			f->pt_img[0].x =3D SS4_STD_MF_X_V1( p, 0 ) ;
> +			f->pt_img[0].y =3D SS4_STD_MF_Y_V1( p, 0 ) ;
> +			f->pt_img[1].x =3D SS4_STD_MF_X_V1( p, 1 ) ;
> +			f->pt_img[1].y =3D SS4_STD_MF_Y_V1( p, 1 ) ;
> +		}
> +		f->pt_img[0].z =3D SS4_MF_Z_V1( p, 0 ) ? 0x30 : 0;
> +		f->pt_img[1].z =3D SS4_MF_Z_V1( p, 1 ) ? 0x30 : 0;
> +
> +		if (SS4_IS_MF_CONTINUE_V1(p)) {
> +			f->first_mp =3D 1;
> +		}
> +		else {
> +			f->fingers =3D 2;
> +			f->first_mp =3D 0;
> +		}
> +		f->is_mp =3D 0;
> +=09
> +		break;
> +
> +	case SS4_PACKET_ID_MULTI:
> +		if (priv->flags & ALPS_BTNLESS) {
> +			f->pt_img[2].x =3D SS4_BTL_MF_X_V1( p, 0 ) ;
> +			f->pt_img[2].y =3D SS4_BTL_MF_Y_V1( p, 0 ) ;
> +			f->pt_img[3].x =3D SS4_BTL_MF_X_V1( p, 1 ) ;
> +			f->pt_img[3].y =3D SS4_BTL_MF_Y_V1( p, 1 ) ;
> +			no_data_x =3D SS4_MFPACKET_NO_AX_BL;
> +			no_data_y =3D SS4_MFPACKET_NO_AY_BL;
> +		}
> +		else {
> +			f->pt_img[2].x =3D SS4_STD_MF_X_V1( p, 0 ) ;
> +			f->pt_img[2].y =3D SS4_STD_MF_Y_V1( p, 0 ) ;
> +			f->pt_img[3].x =3D SS4_STD_MF_X_V1( p, 1 ) ;
> +			f->pt_img[3].y =3D SS4_STD_MF_Y_V1( p, 1 ) ;
> +			no_data_x =3D SS4_MFPACKET_NO_AX;
> +			no_data_y =3D SS4_MFPACKET_NO_AY;
> +		}
> +		f->pt_img[2].z =3D SS4_MF_Z_V1( p, 0 ) ? 0x30 : 0;
> +		f->pt_img[3].z =3D SS4_MF_Z_V1( p, 1 ) ? 0x30 : 0;
> +
> +		f->first_mp =3D 0;
> +		f->is_mp =3D 1;
> +
> +		if (SS4_IS_5F_DETECTED_V1(p)) {
> +			f->fingers =3D 5;
> +		}
> +		else if (f->pt_img[3].x =3D=3D no_data_x &&
> +			     f->pt_img[3].y =3D=3D no_data_y) {
> +			f->fingers =3D 3;
> +			f->pt_img[3].x =3D 0;
> +			f->pt_img[3].y =3D 0;
> +			f->pt_img[3].z =3D 0;
> +		}
> +		else {
> +			f->fingers =3D 4;
> +		}
> +		break;
> +
> +	case SS4_PACKET_ID_IDLE:
> +	default:
> +		memset(f, 0, sizeof(struct alps_fields));
> +		break;
> +	}
> +
> +	f->btn.left =3D !!(SS4_BTN_V1(p) & 0x01) ;
> +	if (!(priv->flags & ALPS_BTNLESS)) {
> +		f->btn.right =3D !!(SS4_BTN_V1(p) & 0x02) ;
> +		f->btn.middle =3D !!(SS4_BTN_V1(p) & 0x04) ;
> +	}
> +}
> +
> +static void alps_decode_ss4_v2(struct alps_fields *f, unsigned char =
*p, struct psmouse *psmouse)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	unsigned char pkt_id;
> +	unsigned int no_data_x, no_data_y;
> +
> +	if (!psmouse || !f || !p )
> +		return;
> +
> +	pkt_id =3D alps_get_pkt_id_ss4_v2(p);
> +
> +	// Current packet is 1Finger coordinate packet
> +	switch (pkt_id) {
> +	case SS4_PACKET_ID_ONE:
> +		f->pt_img[0].x =3D SS4_1F_X_V2(p);
> +		f->pt_img[0].y =3D SS4_1F_Y_V2(p);
> +		f->pt_img[0].z =3D ((SS4_1F_Z_V2(p)) * 2) & 0x7f;	// Keep Z-value =
in 0-127
> +		f->large_fn |=3D COSMO_1F_LFB_V2(p) ? 0x01 : 0x00;
> +
> +		f->fingers =3D 1;
> +		f->first_mp =3D 0;
> +		f->is_mp =3D 0;
> +		break;
> +
> +	case SS4_PACKET_ID_TWO:
> +		if (priv->flags & ALPS_BTNLESS) {
> +			f->pt_img[0].x =3D SS4_BTL_MF_X_V2( p, 0 ) ;
> +			f->pt_img[0].y =3D SS4_BTL_MF_Y_V2( p, 0 ) ;
> +			f->pt_img[1].x =3D SS4_BTL_MF_X_V2( p, 1 ) ;
> +			f->pt_img[1].y =3D SS4_BTL_MF_Y_V2( p, 1 ) ;
> +		}
> +		else {
> +			f->pt_img[0].x =3D SS4_STD_MF_X_V2( p, 0 ) ;
> +			f->pt_img[0].y =3D SS4_STD_MF_Y_V2( p, 0 ) ;
> +			f->pt_img[1].x =3D SS4_STD_MF_X_V2( p, 1 ) ;
> +			f->pt_img[1].y =3D SS4_STD_MF_Y_V2( p, 1 ) ;
> +		}
> +		f->pt_img[0].z =3D SS4_MF_Z_V2( p, 0 ) ? 0x30 : 0;
> +		f->pt_img[1].z =3D SS4_MF_Z_V2( p, 1 ) ? 0x30 : 0;
> +
> +		f->large_fn |=3D COSMO_MF_LF_V2( p, 0 ) ? 0x01 : 0 ;
> +		f->large_fn |=3D COSMO_MF_LF_V2( p, 1 ) ? 0x02 : 0 ;
> +
> +		if (SS4_IS_MF_CONTINUE_V2(p)) {
> +			f->first_mp =3D 1;
> +		}
> +		else {
> +			f->fingers =3D 2;
> +			f->first_mp =3D 0;
> +		}
> +		f->is_mp =3D 0;
> +		break;
> +
> +	case SS4_PACKET_ID_MULTI:
> +		if (priv->flags & ALPS_BTNLESS) {
> +			f->pt_img[2].x =3D SS4_BTL_MF_X_V2( p, 0 ) ;
> +			f->pt_img[2].y =3D SS4_BTL_MF_Y_V2( p, 0 ) ;
> +			f->pt_img[3].x =3D SS4_BTL_MF_X_V2( p, 1 ) ;
> +			f->pt_img[3].y =3D SS4_BTL_MF_Y_V2( p, 1 ) ;
> +			no_data_x =3D SS4_MFPACKET_NO_AX_BL;
> +			no_data_y =3D SS4_MFPACKET_NO_AY_BL;
> +		}
> +		else {
> +			f->pt_img[2].x =3D SS4_STD_MF_X_V2( p, 0 ) ;
> +			f->pt_img[2].y =3D SS4_STD_MF_Y_V2( p, 0 ) ;
> +			f->pt_img[3].x =3D SS4_STD_MF_X_V2( p, 1 ) ;
> +			f->pt_img[3].y =3D SS4_STD_MF_Y_V2( p, 1 ) ;
> +			no_data_x =3D SS4_MFPACKET_NO_AX;
> +			no_data_y =3D SS4_MFPACKET_NO_AY;
> +		}
> +		f->pt_img[2].z =3D SS4_MF_Z_V2( p, 0 ) ? 0x30 : 0;
> +		f->pt_img[3].z =3D SS4_MF_Z_V2( p, 1 ) ? 0x30 : 0;
> +
> +		f->large_fn |=3D COSMO_MF_LF_V2( p, 0 ) ? 0x04 : 0 ;
> +		f->large_fn |=3D COSMO_MF_LF_V2( p, 1 ) ? 0x08 : 0 ;
> +		f->first_mp =3D 0;
> +		f->is_mp =3D 1;
> +
> +		if (SS4_IS_5F_DETECTED_V2(p)) {
> +			f->fingers =3D 5;
> +		}
> +		else if (f->pt_img[3].x =3D=3D no_data_x &&
> +			     f->pt_img[3].y =3D=3D no_data_y) {
> +			f->fingers =3D 3;
> +			f->pt_img[3].x =3D 0;
> +			f->pt_img[3].y =3D 0;
> +			f->pt_img[3].z =3D 0;
> +		}
> +		else {
> +			f->fingers =3D 4;
> +		}
> +		break;
> +
> +	case SS4_PACKET_ID_IDLE:
> +	default:
> +		memset(f, 0, sizeof(struct alps_fields));
> +		break;
> +	}
> +
> +	f->btn.left =3D !!(SS4_BTN_V2(p) & 0x01) ;
> +	if (!(priv->flags & ALPS_BTNLESS)) {
> +		f->btn.right =3D !!(SS4_BTN_V2(p) & 0x02) ;
> +		f->btn.middle =3D !!(SS4_BTN_V2(p) & 0x04) ;
>   	}
>   }
>
> @@ -658,7 +1130,7 @@ static void alps_process_touchpad_packet
>   				 * there is no need to compare with bmap_fn.
>   				 */
>   				alps_process_bitmap_dolphin(priv, &f, &x1, &y1,
> -							    &x2, &y2);
> +							    &x2, &y2);		=09
>   			}
>   		} else {
>   			priv->multi_packet =3D 0;
> @@ -690,7 +1162,7 @@ static void alps_process_touchpad_packet
>   	 * with x, y, and z all zero, so these seem to be flukes.
>   	 * Ignore them.
>   	 */
> -	if (f.x && f.y && !f.z)
> +	if (f.pt.x && f.pt.y && !f.pt.z)
>   		return;
>
>   	/*
> @@ -698,12 +1170,12 @@ static void alps_process_touchpad_packet
>   	 * to rely on ST data.
>   	 */
>   	if (!fingers) {
> -		x1 =3D f.x;
> -		y1 =3D f.y;
> -		fingers =3D f.z > 0 ? 1 : 0;
> +		x1 =3D f.pt.x;
> +		y1 =3D f.pt.y;
> +		fingers =3D f.pt.z > 0 ? 1 : 0;
>   	}
> -
> -	if (f.z >=3D 64)
> +=09
> +	if (f.pt.z >=3D 64)
>   		input_report_key(dev, BTN_TOUCH, 1);
>   	else
>   		input_report_key(dev, BTN_TOUCH, 0);
> @@ -712,22 +1184,22 @@ static void alps_process_touchpad_packet
>
>   	input_mt_report_finger_count(dev, fingers);
>
> -	input_report_key(dev, BTN_LEFT, f.left);
> -	input_report_key(dev, BTN_RIGHT, f.right);
> -	input_report_key(dev, BTN_MIDDLE, f.middle);
> -
> -	if (f.z > 0) {
> -		input_report_abs(dev, ABS_X, f.x);
> -		input_report_abs(dev, ABS_Y, f.y);
> +	input_report_key(dev, BTN_LEFT, f.btn.left);
> +	input_report_key(dev, BTN_RIGHT, f.btn.right);
> +	input_report_key(dev, BTN_MIDDLE, f.btn.middle);
> +
> +	if (f.pt.z > 0) {
> +		input_report_abs(dev, ABS_X, f.pt.x);
> +		input_report_abs(dev, ABS_Y, f.pt.y);
>   	}
> -	input_report_abs(dev, ABS_PRESSURE, f.z);
> +	input_report_abs(dev, ABS_PRESSURE, f.pt.z);
>
>   	input_sync(dev);
>
>   	if (!(priv->quirks & ALPS_QUIRK_TRACKSTICK_BUTTONS)) {
> -		input_report_key(dev2, BTN_LEFT, f.ts_left);
> -		input_report_key(dev2, BTN_RIGHT, f.ts_right);
> -		input_report_key(dev2, BTN_MIDDLE, f.ts_middle);
> +		input_report_key(dev2, BTN_LEFT, f.btn.ts_left);
> +		input_report_key(dev2, BTN_RIGHT, f.btn.ts_right);
> +		input_report_key(dev2, BTN_MIDDLE, f.btn.ts_middle);
>   		input_sync(dev2);
>   	}
>   }
> @@ -752,6 +1224,66 @@ static void alps_process_packet_v3(struc
>   	alps_process_touchpad_packet_v3_v5(psmouse);
>   }
>
> +/* proto_v9 */
> +static void alps_process_touchpad_packet_ss3(struct psmouse *psmouse=
)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	unsigned char *packet =3D psmouse->packet;
> +	struct input_dev *dev =3D psmouse->dev;
> +	int fingers =3D 0;
> +	struct alps_fields f =3D {0};
> +	struct alps_abs_data 	pt_output[2] =3D {{0,0,0},{0,0,0}};
> +	unsigned char output_fn_num =3D 0;
> +=09
> +	priv->decode_fields(&f,packet,psmouse);
> +
> +	if ((!!priv->multi_packet) !=3D (!!f.is_mp)){
> +		priv->multi_packet =3D 0;
> +		return ;
> +	}
> +
> +	/* When f.first_mp is 1, next packet should be a
> +	 *	bitmap packet(when there is no error).
> +	 */
> +	priv->multi_packet =3D f.first_mp;
> +=09
> +	/* Don't process any 3-f data */
> +	if(f.first_mp || f.is_mp)
> +	{
> +		return;
> +	}=09
> +
> +	/*
> +	 * If we don't have MT data or the bitmaps were empty, we have
> +	 * to rely on ST data.
> +	 */
> +	fingers =3D f.fingers;
> +=09
> +	alps_process_resting_finger(psmouse, &f, pt_output, &output_fn_num)=
;
> +	alps_process_btnless_click(psmouse, &f);
> +
> +	if (pt_output[0].z || pt_output[1].z)
> +		input_report_key(dev, BTN_TOUCH, 1);
> +	else
> +		input_report_key(dev, BTN_TOUCH, 0);
> +
> +	alps_report_semi_mt_data_ex(dev, 2, pt_output);
> +
> +	input_mt_report_finger_count(dev, output_fn_num);
> +
> +	input_report_key(dev, BTN_LEFT, f.btn.left);
> +	input_report_key(dev, BTN_RIGHT, f.btn.right);
> +	input_report_key(dev, BTN_MIDDLE, f.btn.middle);
> +
> +	if (pt_output[0].z > 0) {
> +		input_report_abs(dev, ABS_X, pt_output[0].x);
> +		input_report_abs(dev, ABS_Y, pt_output[0].y);
> +	}
> +	input_report_abs(dev, ABS_PRESSURE, pt_output[0].z?16:0);
> +
> +	input_sync(dev);
> +}
> +
>   static void alps_process_packet_v6(struct psmouse *psmouse)
>   {
>   	struct alps_data *priv =3D psmouse->private;
> @@ -919,6 +1451,421 @@ static void alps_process_packet_v4(struc
>   	input_sync(dev);
>   }
>
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
> +}
> +
> +static int alps_drop_unsupported_packet_v7(struct psmouse *psmouse)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	int drop =3D 1;
> +
> +	if (priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_NEW ||
> +	    priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_TWO ||
> +	    priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_MULTI ||
> +	    priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_IDLE)
> +		drop =3D 0;
> +
> +	return drop;
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
> +static void alps_get_finger_coordinate_v7(struct alps_abs_data *pt,
> +					  unsigned char *pkt,
> +					  unsigned char pkt_id)
> +{
> +	if ((pkt_id =3D=3D V7_PACKET_ID_TWO) ||
> +	   (pkt_id =3D=3D V7_PACKET_ID_MULTI) ||
> +	   (pkt_id =3D=3D V7_PACKET_ID_NEW)) {
> +		pt[0].x =3D ((pkt[2] & 0x80) << 4);
> +		pt[0].x |=3D ((pkt[2] & 0x3F) << 5);
> +		pt[0].x |=3D ((pkt[3] & 0x30) >> 1);
> +		pt[0].x |=3D (pkt[3] & 0x07);
> +		pt[0].y =3D (pkt[1] << 3) | (pkt[0] & 0x07);
> +
> +		pt[1].x =3D ((pkt[3] & 0x80) << 4);
> +		pt[1].x |=3D ((pkt[4] & 0x80) << 3);
> +		pt[1].x |=3D ((pkt[4] & 0x3F) << 4);
> +		pt[1].y =3D ((pkt[5] & 0x80) << 3);
> +		pt[1].y |=3D ((pkt[5] & 0x3F) << 4);
> +
> +		if (pkt_id =3D=3D V7_PACKET_ID_TWO) {
> +			pt[1].x &=3D ~0x000F;
> +			pt[1].y |=3D 0x000F;
> +		} else if (pkt_id =3D=3D V7_PACKET_ID_MULTI) {
> +			pt[1].x &=3D ~0x003F;
> +			pt[1].y &=3D ~0x0020;
> +			pt[1].y |=3D ((pkt[4] & 0x02) << 4);
> +			pt[1].y |=3D 0x001F;
> +		} else if (pkt_id =3D=3D V7_PACKET_ID_NEW) {
> +			pt[1].x &=3D ~0x003F;
> +			pt[1].x |=3D (pkt[0] & 0x20);
> +			pt[1].y |=3D 0x000F;
> +		}
> +
> +		pt[0].y =3D 0x7FF - pt[0].y;
> +		pt[1].y =3D 0x7FF - pt[1].y;
> +
> +		pt[0].z =3D (pt[0].x && pt[0].y) ? 62 : 0;
> +		pt[1].z =3D (pt[1].x && pt[1].y) ? 62 : 0;
> +	}
> +}
> +
> +static void alps_decode_packet_v7(struct alps_fields *f,
> +				  unsigned char *p,
> +				  struct psmouse *psmouse)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +
> +	priv->r.v7.pkt_id =3D alps_get_packet_id_v7(p);
> +
> +	alps_get_finger_coordinate_v7(f->pt_img, p, priv->r.v7.pkt_id);
> +
> +	priv->r.v7.rest_left =3D 0;
> +	priv->r.v7.rest_right =3D 0;
> +	priv->r.v7.additional_fingers =3D 0;
> +	memset(&f->btn, 0, sizeof(struct alps_btn));
> +=09
> +	if (priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_TWO ||
> +	    priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_MULTI) {
> +
> +		if (priv->flags & ALPS_BTNLESS) {
> +			priv->r.v7.rest_left =3D (p[0] & 0x10) >> 4;
> +			priv->r.v7.rest_right =3D (p[0] & 0x20) >> 5;
> +			f->btn.middle =3D (p[0] & 0x80) >> 7;
> +		}
> +		else {
> +			f->btn.left =3D (p[0] & 0x80) >> 7;
> +			f->btn.right =3D (p[0] & 0x20) >> 5;
> +			f->btn.middle =3D (p[0] & 0x10) >> 4;
> +		}
> +	}
> +
> +	if (priv->r.v7.pkt_id =3D=3D V7_PACKET_ID_MULTI)
> +		priv->r.v7.additional_fingers =3D p[5] & 0x03;
> +}
> +
> +static void alps_set_each_pt_attr_v7(struct psmouse *psmouse,
> +				     struct alps_abs_data *pt,
> +				     struct alps_bl_pt_attr *pt_attr)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	unsigned int dist;
> +
> +	if (!pt_attr->is_init_pt_got && pt->z !=3D 0) {
> +		pt_attr->is_init_pt_got =3D 1;
> +		pt_attr->is_counted =3D 0;
> +		memcpy(&pt_attr->init_pt, pt, sizeof(pt_attr->init_pt));
> +	}
> +
> +	if (pt->z !=3D 0) {
> +		if (pt->y < priv->resting_zone_y_min) {
> +			/* A finger is recognized as a non-resting finger if it's
> +			position is outside the resting finger zone.*/
> +			pt_attr->zone =3D ZONE_NORMAL;
> +			pt_attr->is_counted =3D 1;
> +		} else {
> +			/* A finger is recognized as a resting finger if it's position
> +			is inside the resting finger zone and there's no large movement
> +			from it's touch down position.*/
> +			pt_attr->zone =3D ZONE_RESTING;
> +
> +			if (pt->x > priv->x_max / 2)
> +				pt_attr->zone |=3D ZONE_RIGHT_BTN;
> +			else
> +				pt_attr->zone |=3D ZONE_LEFT_BTN;
> +		=09
> +			/* A resting finger will turn to be a non-resting finger if it
> +			has made large movement from it's touch down position. A
> +			non-resting finger will never turn to a resting finger before
> +			it leaves the touchpad surface.*/
> +			if (pt_attr->is_init_pt_got) {
> +				dist =3D alps_pt_distance(pt, &pt_attr->init_pt);
> +
> +				if (dist > V7_LARGE_MOVEMENT)
> +					pt_attr->is_counted =3D 1;
> +			}
> +		}
> +	}
> +}
> +
> +static void alps_set_pt_attr_v7(struct psmouse *psmouse,
> +				       struct alps_fields *f)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	int i;
> +
> +	switch (priv->r.v7.pkt_id) {
> +	case  V7_PACKET_ID_TWO:
> +	case  V7_PACKET_ID_MULTI:
> +		for (i =3D 0; i < V7_IMG_PT_NUM; i++)
> +			alps_set_each_pt_attr_v7(psmouse,
> +						 &f->pt_img[i],
> +						 &priv->pt_attr[i]);
> +		break;
> +	default:
> +		/*All finger attributes are cleared when packet ID is 'IDLE', 'New=
'
> +		or other unknown IDs. An 'IDLE' packet indicates that there's no
> +		finger and no button activity. A 'NEW' packet indicates the finger
> +		position in packet is not continues from previous packet. Such as
> +		the condition there's finger placed or lifted. In these cases,
> +		finger attributes will be reset.*/
> +
> +		memset(priv->pt_attr, 0, sizeof(priv->pt_attr[0]) * V7_IMG_PT_NUM)=
;
> +		break;
> +	}
> +}
> +
> +static void alps_cal_output_finger_num_v7(struct psmouse *psmouse,
> +					struct alps_fields *f)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	unsigned int fn =3D 0;
> +	int i;
> +
> +	switch (priv->r.v7.pkt_id) {
> +	case V7_PACKET_ID_IDLE:
> +	case V7_PACKET_ID_NEW:
> +		/*No finger is reported when packet ID is 'IDLE' or 'New'.
> +		An 'IDLE' packet indicates that there's no finger on touchpad.
> +		A 'NEW' packet indicates there's finger placed or lifted. Finger
> +		position of 'New' packet is not continues from the previous packet=
=2E*/
> +		fn =3D 0;
> +		break;
> +	case V7_PACKET_ID_TWO:
> +		if (f->pt_img[0].z =3D=3D 0) {
> +			/*The first finger slot is zero when a non-resting finger
> +			lifted and remaining only one resting finger on touchpad.
> +			Hardware report the remaining resting finger in second slot.
> +			This resting is ignored*/
> +			fn =3D 0;
> +		} else if (f->pt_img[1].z =3D=3D 0) {
> +			/* The second finger slot is zero if there's only one finger*/
> +			fn =3D 1;
> +		} else {
> +			/*All non-resting fingers will be counted to report*/
> +			fn =3D 0;
> +			for (i =3D 0; i < V7_IMG_PT_NUM; i++) {
> +				if (priv->pt_attr[i].is_counted)
> +					fn++;
> +			}
> +
> +			/*In the case that both fingers are
> +			resting fingers, report the first one*/
> +			if (!priv->pt_attr[0].is_counted &&
> +			    !priv->pt_attr[1].is_counted) {
> +				fn =3D 1;
> +			}
> +		}
> +		break;
> +	case V7_PACKET_ID_MULTI:
> +		/*A packet ID 'MULTI' indicats that at least 3 non-resting
> +		finger exist.*/
> +		fn =3D 3 + priv->r.v7.additional_fingers;
> +		break;
> +	}
> +
> +	f->fingers =3D fn;
> +}
> +
> +static void alps_assign_buttons_v7(struct psmouse *psmouse,
> +				   struct alps_fields *f)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +
> +	/* It's ClickPad */
> +	if (priv->flags & ALPS_BTNLESS) {
> +		if (!f->btn.middle)
> +			goto exit;
> +
> +		f->btn.middle =3D 0;
> +		if (priv->prev_btn.left || priv->prev_btn.middle || priv->prev_btn=
=2Eright) {
> +			memcpy(&f->btn, &priv->prev_btn, sizeof(struct alps_btn));
> +			goto exit;
> +		}
> +
> +		if (priv->r.v7.rest_right ||
> +		    priv->pt_attr[0].zone & ZONE_RIGHT_BTN ||
> +		    priv->pt_attr[1].zone & ZONE_RIGHT_BTN) {
> +			f->btn.right =3D 1;
> +		} else {
> +			f->btn.left =3D 1;
> +		}
> +
> +		goto exit;
> +	}
> +
> +	/* It's Standard, do nothing */
> +
> +exit:
> +	memcpy(&priv->prev_btn, &f->btn, sizeof(struct alps_btn));
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
> +	x =3D ((packet[2] & 0xBF)) | ((packet[3] & 0x10) << 2);
> +	y =3D (packet[3] & 0x03) | (packet[4] & 0xB8) | ((packet[3] & 0x20)=
 << 1);
> +	z =3D (packet[5] & 0x3F) | ((packet[3] & 0x80) >> 1);
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
> +
> +}
> +
> +static void alps_process_touchpad_packet_v7(struct psmouse *psmouse)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	struct alps_fields f =3D {0};
> +	unsigned char *packet =3D psmouse->packet;
> +
> +	priv->decode_fields(&f, packet, psmouse);
> +
> +	if (alps_drop_unsupported_packet_v7(psmouse))
> +		return;
> +
> +	alps_set_pt_attr_v7(psmouse, &f);
> +
> +	alps_cal_output_finger_num_v7(psmouse, &f);
> +
> +	alps_assign_buttons_v7(psmouse, &f);
> +
> +	alps_report_coord_and_btn(psmouse, &f);
> +}
> +
> +static void alps_process_packet_v7(struct psmouse *psmouse)
> +{
> +	unsigned char *packet =3D psmouse->packet;
> +
> +	if ((packet[0] =3D=3D 0x48) && ((packet[4] & 0x47) =3D=3D 0x06)) {
> +		alps_process_trackstick_packet_v7(psmouse);
> +	} else {
> +		alps_process_touchpad_packet_v7(psmouse);
> +	}
> +
> +}
> +
> +static void alps_process_packet_ss4(struct psmouse *psmouse)
> +{
> +	struct alps_data *priv =3D psmouse->private;
> +	unsigned char *packet =3D psmouse->packet;
> +	struct input_dev *dev =3D psmouse->dev;
> +	struct alps_fields f;
> +	struct alps_abs_data output_data[5];
> +	unsigned char output_fn;
> +
> +	memset(&f, 0, sizeof(struct alps_fields));
> +	priv->decode_fields(&f, packet, psmouse);
> +
> +	if (priv->multi_packet) {
> +		/*
> +		 * Sometimes the first packet will indicate a multi-packet
> +		 * sequence, but sometimes the next multi-packet would not come.
> +		 * Check for this, and when it happens process the
> +		 * position packet as usual.
> +		 */
> +		if (f.is_mp) {
> +			/* Now process the 1st packet */
> +			priv->decode_fields(&f, priv->multi_data, psmouse);
> +		} else {
> +			priv->multi_packet =3D 0;
> +		}
> +	}
> +
> +	/*
> +	 * "f.is_mp" would always be '0' after merging the 1st and 2nd pack=
et.
> +	 * When it is set, it means 2nd packet comes without 1st packet com=
e.
> +	 */
> +	if (f.is_mp)
> +	{
> +		return;
> +	}
> +
> +	// Save the first packet
> +	if (!priv->multi_packet && f.first_mp) {
> +		priv->multi_packet =3D 1;
> +		memcpy(priv->multi_data, packet, sizeof(priv->multi_data));
> +		return;
> +	}
> +=09
> +	priv->multi_packet =3D 0;
> +
> +	// Set "output_data" and "output_fn"
> +	memset(&output_data[0], 0, sizeof(output_data));
> +	if (priv->flags & ALPS_BTNLESS) {
> +		alps_process_resting_finger(psmouse, &f, output_data, &output_fn);
> +		alps_process_btnless_click(psmouse, &f);
> +	}
> +	else {
> +		memcpy(&output_data[0], &f.pt_img[0], sizeof(struct alps_abs_data)=
 * f.fingers);
> +		output_fn =3D f.fingers;
> +	}
> +
> +	f.pt.x =3D output_data[0].x;
> +	f.pt.y =3D output_data[0].y;
> +	f.pt.z =3D output_data[0].z;
> +
> +	if (output_data[0].z || output_data[1].z || output_data[2].z || out=
put_data[3].z)
> +		input_report_key(dev, BTN_TOUCH, 1);
> +	else
> +		input_report_key(dev, BTN_TOUCH, 0);
> +
> +	alps_report_semi_mt_data_ex(dev, 4, output_data);
> +
> +	input_mt_report_finger_count(dev, output_fn);
> +
> +	input_report_key(dev, BTN_LEFT, f.btn.left);
> +	input_report_key(dev, BTN_RIGHT, f.btn.right);
> +	input_report_key(dev, BTN_MIDDLE, f.btn.middle);
> +
> +	if (f.pt.z > 0) {
> +		input_report_abs(dev, ABS_X, f.pt.x);
> +		input_report_abs(dev, ABS_Y, f.pt.y);
> +	}
> +	input_report_abs(dev, ABS_PRESSURE, f.pt.z);
> +
> +	input_sync(dev);
> +}
> +
>   static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
>   					unsigned char packet[],
>   					bool report_buttons)
> @@ -1046,11 +1993,20 @@ static void alps_flush_packet(unsigned l
>   	serio_continue_rx(psmouse->ps2dev.serio);
>   }
>
> +static bool alps_is_valid_package_ss4(struct psmouse *psmouse)
> +{
> +	if(psmouse->pktcnt =3D=3D 4 && ((psmouse->packet[3] & 0x08) !=3D 0x=
08))
> +		return false;
> +	if(psmouse->pktcnt =3D=3D 6 && ((psmouse->packet[5] & 0x10) !=3D 0x=
0))
> +		return false;
> +	return true;
> +}
> +
>   static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
>   {
>   	struct alps_data *priv =3D psmouse->private;
>
> -	if ((psmouse->packet[0] & 0xc8) =3D=3D 0x08) { /* PS/2 packet */
> +	if ((psmouse->packet[0] & 0xc8) =3D=3D 0x08 && priv->proto_version =
!=3D ALPS_PROTO_V8) { /* Can not distinguish V8's first byte from PS/2 =
packet's */
>   		if (psmouse->pktcnt =3D=3D 3) {
>   			alps_report_bare_ps2_packet(psmouse, psmouse->packet,
>   						    true);
> @@ -1083,6 +2039,15 @@ static psmouse_ret_t alps_process_byte(s
>   		return PSMOUSE_BAD_DATA;
>   	}
>
> +	if ((priv->proto_version =3D=3D ALPS_PROTO_V7 && !alps_is_valid_pac=
kage_v7(psmouse)) ||
> +		(priv->proto_version =3D=3D ALPS_PROTO_V8 && !alps_is_valid_packag=
e_ss4(psmouse)))
> +	{
> +		psmouse_dbg(psmouse, "refusing packet[%i] =3D %x\n",
> +			    psmouse->pktcnt - 1,
> +			    psmouse->packet[psmouse->pktcnt - 1]);
> +		return PSMOUSE_BAD_DATA;
> +	}
> +
>   	if (psmouse->pktcnt =3D=3D psmouse->pktsize) {
>   		priv->process_packet(psmouse);
>   		return PSMOUSE_FULL_PACKET;
> @@ -1195,6 +2160,22 @@ static int alps_rpt_cmd(struct psmouse *
>   	return 0;
>   }
>
> +static int alps_check_valid_firmware_id(unsigned char id[])
> +{
> +	int valid =3D 1;
> +
> +	if (id[0] =3D=3D 0x73)
> +		valid =3D 1;
> +	else if (id[0] =3D=3D 0x88) {
> +		if ((id[1] =3D=3D 0x07) ||
> +		    (id[1] =3D=3D 0x08) ||
> +		    ((id[1] & 0xf0) =3D=3D 0xB0))
> +			valid =3D 1;
> +	}
> +
> +	return valid;
> +}
> +
>   static int alps_enter_command_mode(struct psmouse *psmouse)
>   {
>   	unsigned char param[4];
> @@ -1204,8 +2185,7 @@ static int alps_enter_command_mode(struc
>   		return -1;
>   	}
>
> -	if ((param[0] !=3D 0x88 || (param[1] !=3D 0x07 && param[1] !=3D 0x0=
8)) &&
> -	    param[0] !=3D 0x73) {
> +	if (!alps_check_valid_firmware_id(param)) {
>   		psmouse_dbg(psmouse,
>   			    "unknown response while entering command mode\n");
>   		return -1;
> @@ -1707,6 +2687,32 @@ error:
>   	return ret;
>   }
>
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
>   /* Must be in command mode when calling this function */
>   static int alps_absolute_mode_v4(struct psmouse *psmouse)
>   {
> @@ -1796,6 +2802,97 @@ error:
>   	return -1;
>   }
>
> +static int alps_get_otp_values_ss4(struct psmouse *psmouse, unsigned=
 char index, unsigned char otp[])
> +{
> +	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> +	switch (index) {
> +	case 0:
> +		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM)  ||
> +		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM)  ||
> +		    ps2_command(ps2dev, otp, PSMOUSE_CMD_GETINFO) )
> +		    	return -1;
> +	=09
> +		break;
> +
> +	case 1:
> +		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL)  ||
> +		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL)  ||
> +		    ps2_command(ps2dev, otp, PSMOUSE_CMD_GETINFO) )
> +			return -1;
> +
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +int alps_update_device_area_ss4_v1(unsigned char otp[][4], struct al=
ps_data *priv)
> +{
> +	int	num_x_electrode ;
> +	int	num_y_electrode ;
> +
> +	num_x_electrode =3D SS4_NUMSENSOR_XOFFSET + (otp[1][0]		& 0x0F);
> +	num_y_electrode =3D ((otp[1][0] >> 4)	& 0x0F);
> +
> +	priv->x_max =3D (num_x_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
> +	priv->y_max =3D (num_y_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
> +
> +	return 0;
> +}
> +
> +int alps_update_device_area_ss4_v2(unsigned char otp[][4], struct al=
ps_data *priv)
> +{
> +	int	num_x_electrode ;
> +	int	num_y_electrode ;
> +
> +	num_x_electrode =3D SS4_NUMSENSOR_XOFFSET + (otp[1][0] & 0x0F);
> +	if ((priv->fw_ver[1] > 2) || (priv->fw_ver[1] =3D=3D 2 && priv->fw_=
ver[2] > 0x33))
> +		num_y_electrode =3D SS4_NUMSENSOR_YOFFSET + ((otp[1][0] >> 4) & 0x=
07);
> +	else
> +		num_y_electrode =3D ((otp[1][0] >> 4) & 0x0F);
> +
> +	priv->x_max =3D (num_x_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
> +	priv->y_max =3D (num_y_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
> +
> +	return 0;
> +}
> +
> +int alps_update_btn_info_ss4(unsigned char otp[][4], struct alps_dat=
a *priv)
> +{
> +
> +	unsigned char is_btnless =3D 0;
> +
> +	is_btnless =3D (otp[1][1] >> 3) &  0x01;
> +
> +	if (is_btnless) {
> +		priv->flags |=3D ALPS_BTNLESS;
> +	}
> +=09
> +	return 0;
> +}
> +
> +static int alps_set_defaults_ss4(struct psmouse *psmouse, struct alp=
s_data *priv)
> +{
> +	unsigned char otp[2][4];
> +
> +	memset(otp, 0, sizeof(otp));
> +
> +	if (alps_get_otp_values_ss4(psmouse, 0, &otp[0][0]) ||
> +	    alps_get_otp_values_ss4(psmouse, 1, &otp[1][0]))
> +		return -1;
> +
> +	if (priv->fw_ver[1] >=3D 2) {
> +		alps_update_device_area_ss4_v2(otp, priv);
> +	}
> +	else {
> +		alps_update_device_area_ss4_v1(otp, priv);
> +	}
> +
> +	alps_update_btn_info_ss4(otp, priv);
> +
> +	return 0;
> +}
> +
>   static int alps_dolphin_get_device_area(struct psmouse *psmouse,
>   					struct alps_data *priv)
>   {
> @@ -1859,6 +2956,61 @@ static int alps_hw_init_dolphin_v1(struc
>   	return 0;
>   }
>
> +static int alps_hw_init_ss3(struct psmouse *psmouse)
> +{
> +	struct ps2dev *ps2dev 	=3D &psmouse->ps2dev;
> +	unsigned char 	f3param0 =3D 0x00,
> +					f3param1 =3D 0x00;
> +=09
> +	if (alps_enter_command_mode(psmouse))
> +        goto error;
> +=09
> +	/* Set to 2 pt-mode */
> +	f3param0 =3D 0x50;
> +	f3param1 =3D 0x3c;
> +	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
> +	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
> +	    ps2_command(ps2dev, &f3param0, PSMOUSE_CMD_SETRATE) ||
> +	    ps2_command(ps2dev, &f3param1, PSMOUSE_CMD_SETRATE))
> +		goto error;
> +
> +	/* output APDATA when 1 finger is in resting area */
> +	f3param0 =3D 0xc8;
> +	f3param1 =3D 0x28;
> +	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
> +	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
> +	    ps2_command(ps2dev, &f3param0, PSMOUSE_CMD_SETRATE) ||
> +	    ps2_command(ps2dev, &f3param1, PSMOUSE_CMD_SETRATE))
> +			goto error;
> +
> +	return 0;
> +=09
> +error:
> +	return -1;
> +}
> +
> +
> +static int alps_hw_init_ss4(struct psmouse *psmouse)
> +{
> +	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> +	char param[2] =3D {0x64, 0x28};
> +	int ret =3D -1;
> +
> +	/* enter absolute mode */
> +	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
> +	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
> +	    ps2_command(ps2dev, &param[0], PSMOUSE_CMD_SETRATE) ||
> +	    ps2_command(ps2dev, &param[1], PSMOUSE_CMD_SETRATE)) {
> +		goto error;
> +	}
> +
> +	return ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> +
> +error:=09
> +	alps_exit_command_mode(psmouse);
> +	return ret;
> +}
> +
>   static void alps_set_defaults(struct alps_data *priv)
>   {
>   	priv->byte0 =3D 0x8f;
> @@ -1878,6 +3030,7 @@ static void alps_set_defaults(struct alp
>   		priv->set_abs_params =3D alps_set_abs_params_st;
>   		priv->x_max =3D 1023;
>   		priv->y_max =3D 767;
> +		priv->slot_number =3D 1;
>   		break;
>   	case ALPS_PROTO_V3:
>   		priv->hw_init =3D alps_hw_init_v3;
> @@ -1886,6 +3039,7 @@ static void alps_set_defaults(struct alp
>   		priv->decode_fields =3D alps_decode_pinnacle;
>   		priv->nibble_commands =3D alps_v3_nibble_commands;
>   		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> +		priv->slot_number =3D 2;
>   		break;
>   	case ALPS_PROTO_V4:
>   		priv->hw_init =3D alps_hw_init_v4;
> @@ -1893,6 +3047,7 @@ static void alps_set_defaults(struct alp
>   		priv->set_abs_params =3D alps_set_abs_params_mt;
>   		priv->nibble_commands =3D alps_v4_nibble_commands;
>   		priv->addr_command =3D PSMOUSE_CMD_DISABLE;
> +		priv->slot_number =3D 2;
>   		break;
>   	case ALPS_PROTO_V5:
>   		priv->hw_init =3D alps_hw_init_dolphin_v1;
> @@ -1908,6 +3063,7 @@ static void alps_set_defaults(struct alp
>   		priv->y_max =3D 660;
>   		priv->x_bits =3D 23;
>   		priv->y_bits =3D 12;
> +		priv->slot_number =3D 2;
>   		break;
>   	case ALPS_PROTO_V6:
>   		priv->hw_init =3D alps_hw_init_v6;
> @@ -1916,6 +3072,58 @@ static void alps_set_defaults(struct alp
>   		priv->nibble_commands =3D alps_v6_nibble_commands;
>   		priv->x_max =3D 2047;
>   		priv->y_max =3D 1535;
> +		priv->slot_number =3D 1;
> +		break;
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
> +		if (priv->fw_ver[1] =3D=3D 0xBA) {
> +			priv->flags =3D 0;
> +			priv->resting_zone_y_min =3D priv->y_max;	/* No resting finger ar=
ea */
> +		}
> +		else {
> +			priv->flags =3D ALPS_BTNLESS;
> +			priv->resting_zone_y_min =3D 0x654;
> +		}
> +
> +		priv->slot_number =3D 2;
> +		break;
> +	case ALPS_PROTO_V8:
> +		if (priv->fw_ver[1] >=3D 2) {
> +			priv->decode_fields =3D alps_decode_ss4_v2;
> +		} else {
> +			priv->decode_fields =3D alps_decode_ss4_v1;
> +		}
> +		priv->hw_init =3D alps_hw_init_ss4;
> +		priv->process_packet =3D alps_process_packet_ss4;
> +		priv->set_abs_params =3D alps_set_abs_params_mt;
> +		priv->nibble_commands =3D alps_v3_nibble_commands;
> +		priv->addr_command =3D PSMOUSE_CMD_RESET_WRAP;
> +		priv->x_max =3D 0xfff;
> +		priv->y_max =3D 0x7ff;
> +		priv->byte0 =3D 0x18;
> +		priv->mask0 =3D 0x18;
> +		priv->flags =3D 0;
> +		priv->slot_number =3D 4;
> +		break;
> +	case ALPS_PROTO_V9:
> +		priv->hw_init =3D alps_hw_init_ss3;
> +		priv->process_packet =3D alps_process_touchpad_packet_ss3;
> +		priv->decode_fields =3D alps_decode_dolphin;
> +		priv->set_abs_params =3D alps_set_abs_params_mt;
> +		priv->nibble_commands =3D alps_v3_nibble_commands;
> +		priv->byte0 =3D 0xc8;
> +		priv->mask0 =3D 0xc8;
> +		priv->slot_number =3D 2;	=09
>   		break;
>   	}
>   }
> @@ -1975,6 +3183,9 @@ static int alps_identify(struct psmouse
>   	    alps_exit_command_mode(psmouse))
>   		return -EIO;
>
> +	/* Save the Firmware version */
> +	memcpy(priv->fw_ver, ec, 3);
> +
>   	if (alps_match_table(psmouse, priv, e7, ec) =3D=3D 0) {
>   		return 0;
>   	} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D =
0x50 &&
> @@ -1985,6 +3196,11 @@ static int alps_identify(struct psmouse
>   			return -EIO;
>   		else
>   			return 0;
> +	} else if (ec[0] =3D=3D 0x88 && (ec[1] & 0xf0) =3D=3D 0xB0) {
> +		priv->proto_version =3D ALPS_PROTO_V7;
> +		alps_set_defaults(priv);
> +
> +		return 0;
>   	} else if (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0x08) {
>   		priv->proto_version =3D ALPS_PROTO_V3;
>   		alps_set_defaults(priv);
> @@ -2007,6 +3223,22 @@ static int alps_identify(struct psmouse
>   		alps_set_defaults(priv);
>
>   		return 0;
> +	} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D 0=
x14) {
> +		priv->proto_version =3D ALPS_PROTO_V8;
> +		alps_set_defaults(priv);
> +
> +		if(alps_set_defaults_ss4(psmouse, priv))
> +			return -EIO;
> +		else
> +			return 0;
> +	} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 && e7[2] =3D=3D 0=
xc8){
> +		priv->proto_version =3D ALPS_PROTO_V9;
> +		alps_set_defaults(priv);
> +	=09
> +		if (alps_dolphin_get_device_area(psmouse, priv))
> +			return -EIO;
> +		else
> +			return 0;
>   	}
>
>   	psmouse_info(psmouse,
> @@ -2048,7 +3280,7 @@ static void alps_set_abs_params_mt(struc
>   				   struct input_dev *dev1)
>   {
>   	set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
> -	input_mt_init_slots(dev1, 2, 0);
> +	input_mt_init_slots(dev1, priv->slot_number, 0);
>   	input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0=
);
>   	input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0=
);
>
> @@ -2164,16 +3396,17 @@ init_fail:
>   int alps_detect(struct psmouse *psmouse, bool set_properties)
>   {
>   	struct alps_data dummy;
> -
> -	if (alps_identify(psmouse, &dummy) < 0)
> -		return -1;
> -
> +=09
> +    if (alps_identify(psmouse, &dummy) < 0)
> +        return -1;
> +
>   	if (set_properties) {
>   		psmouse->vendor =3D "ALPS";
>   		psmouse->name =3D dummy.flags & ALPS_DUALPOINT ?
>   				"DualPoint TouchPad" : "GlidePoint";
>   		psmouse->model =3D dummy.proto_version << 8;
>   	}
> +=09
>   	return 0;
>   }
>
> --- linux-3.14-rc1/drivers/input/mouse/alps.h	2015-02-08 12:39:28.367=
799685 +0100
> +++ goliad-mlk-14_A03.fish.tar.gz/debs/touchpad-alps-trusty-dkms_2014=
0325_all.deb/usr/src/touchpad-alps-trusty-20140325/alps.h	2014-06-06 04=
:21:48.000000000 +0200
> @@ -18,11 +18,140 @@
>   #define ALPS_PROTO_V4	4
>   #define ALPS_PROTO_V5	5
>   #define ALPS_PROTO_V6	6
> +#define ALPS_PROTO_V7	7	/* t3btl t4s */
> +#define ALPS_PROTO_V8	8	/* ss4 */
> +#define ALPS_PROTO_V9	9	/* ss3btl */
> +
> +
> +#define MAX_IMG_PT_NUM		5
> +#define V7_IMG_PT_NUM		2
> +
> +#define ZONE_NORMAL				0x01
> +#define ZONE_RESTING			0x02
> +#define ZONE_LEFT_BTN			0x04
> +#define ZONE_RIGHT_BTN			0x08
>
>   #define DOLPHIN_COUNT_PER_ELECTRODE	64
>   #define DOLPHIN_PROFILE_XOFFSET		8	/* x-electrode offset */
>   #define DOLPHIN_PROFILE_YOFFSET		1	/* y-electrode offset */
>
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
> +enum SS4_PACKET_ID {
> +	SS4_PACKET_ID_IDLE =3D 0,
> +	SS4_PACKET_ID_ONE,
> +	SS4_PACKET_ID_TWO,
> +	SS4_PACKET_ID_MULTI,
> +};
> +
> +#define SS4_COUNT_PER_ELECTRODE			256
> +#define SS4_NUMSENSOR_XOFFSET				7
> +#define SS4_NUMSENSOR_YOFFSET				7
> +#define SS4_BUTTONLESS_BUTTONS	0x01			// SWC status			( 0:SW OFF,	  =
1: SW ON	)
> +
> +#define SS4_MASK_NORMAL_BUTTONS	0x07
> +
> +#define SS4_1F_X_V1(_b)			( ( ( _b[ 0 ] << 5 ) & 0x1E00 ) | \
> +								  ( ( _b[ 0 ] << 6 ) & 0x01C0 ) | \
> +								  ( ( _b[ 1 ] >> 2 ) & 0x0038 ) | \
> +								  ( ( _b[ 1 ] >> 1 ) & 0x0007 ) \
> +								)
> +#define SS4_1F_Y_V1(_b)			( ( ( _b[ 2 ] >> 1 ) & 0x007F ) | \
> +								  ( ( _b[ 4 ] << 5 ) & 0x0F80 ) \
> +								)
> +#define SS4_1F_Z_V1(_b)			( _b[ 5 ] & 0xFF )
> +
> +#define	COSMO_1F_LFB(_b)		( ( _b[ 4 ] >> 1 ) & 0x01 )
> +
> +#define SS4_BTN_V1(_b)		( _b[ 3 ] & SS4_BUTTONLESS_BUTTONS )
> +
> +#define SS4_STD_MF_X_V1(_b,_i)	( ( ( _b[ 0 + _i * 3 ] >> 2 ) & 0x002=
0 ) | \
> +								  ( ( _b[ 1 + _i * 3 ] << 5 ) & 0x1FC0 ) \
> +								)
> +
> +#define SS4_STD_MF_Y_V1(_b,_i)	( ( ( _b[ 0 + _i * 3 ] >> 2 ) & 0x001=
0 ) | \
> +								  ( ( _b[ 2 + _i * 3 ] << 4 ) & 0x0FE0 ) \
> +								)
> +
> +#define SS4_BTL_BTN_V1(_b)		( _b[ 3 ] &SS4_BUTTONLESS_BUTTONS )
> +
> +#define SS4_BTL_MF_X_V1(_b,_i) 	( SS4_STD_MF_X_V1(_b,_i) | ( ( _b[ 0=
 + _i * 3 ] << 2 ) & 0x0010 ) )
> +
> +#define SS4_BTL_MF_Y_V1(_b,_i)	 ( SS4_STD_MF_Y_V1(_b,_i) | ( ( _b[ 0=
 + _i * 3 ] << 2 ) & 0x0008 ) )
> +
> +#define SS4_MF_Z_V1(_b,_i)		( ( _b[ 0 + _i * 3 ] >> 4 ) & 0x0003 )
> +
> +#define SS4_IS_MF_CONTINUE_V1(_b)	( ( _b[ 0 ] & 0x01 ) =3D=3D 0x01 )
> +#define SS4_IS_5F_DETECTED_V1(_b)	( ( _b[ 0 ] & 0x01 ) =3D=3D 0x01 )
> +
> +#define SS4_1F_X_V2(_b)			( (   _b[ 0 ]        & 0x0007 ) | \
> +								  ( ( _b[ 1 ] << 3 ) & 0x0078 ) | \
> +								  ( ( _b[ 1 ] << 2 ) & 0x0380 ) | \
> +								  ( ( _b[ 2 ] << 5 ) & 0x1C00 ) \
> +								)
> +
> +#define SS4_1F_Y_V2(_b)			( ( ( _b[ 2 ]      ) & 0x000F ) | \
> +								  ( ( _b[ 3 ] >> 2 ) & 0x0030 ) | \
> +								  ( ( _b[ 4 ] << 6 ) & 0x03C0 ) | \
> +								  ( ( _b[ 4 ] << 5 ) & 0x0C00 ) \
> +								)
> +
> +#define SS4_1F_Z_V2(_b)			( ( ( _b[ 5 ]      ) & 0x0F   ) | \
> +	                              			( ( _b[ 5 ] >> 1 ) & 0x70   ) | \
> +								  ( ( _b[ 4 ]      ) & 0x80   ) \
> +                                				)
> +
> +#define	COSMO_1F_LFB_V2(_b)	( ( ( _b[ 2 ] >> 4 ) & 0x01 ) =3D=3D 0x0=
1 )
> +
> +#define	COSMO_MF_LF_V2(_b,_i)	( ( _b[ 1 + _i * 3 ] & 0x0004 ) =3D=3D=
 0x0004 )
> +
> +#define SS4_BTN_V2(_b)		( (_b[ 0 ] >> 5 ) & SS4_MASK_NORMAL_BUTTONS =
)
> +#define SS4_STD_MF_X_V2(_b,_i)	( ( ( _b[ 0 + _i * 3 ]  << 5  ) & 0x0=
0E0 ) | \
> +								      ( ( _b[ 1 + _i * 3 ]  << 5  ) & 0x1F00 ) \
> +								    )
> +
> +#define SS4_STD_MF_Y_V2(_b,_i)	( ( ( _b[ 1 + _i * 3 ] << 3 ) & 0x001=
0 ) | \
> +								      ( ( _b[ 2 + _i * 3 ] << 5 ) & 0x01E0 ) | \
> +								      ( ( _b[ 2 + _i * 3 ] << 4 ) & 0x0E00 ) \
> +								    )
> +
> +#define SS4_BTL_MF_X_V2(_b,_i)	( SS4_STD_MF_X_V2(_b,_i) | ( ( _b[ 0 =
+ _i * 3 ] >> 3 ) & 0x0010 ) )
> +
> +#define SS4_BTL_MF_Y_V2(_b,_i)	( SS4_STD_MF_Y_V2(_b,_i) | ( ( _b[ 0 =
+ _i * 3 ] >> 3 ) & 0x0008 ) )
> +
> +#define SS4_MF_Z_V2(_b,_i)		( ( ( _b[ 1 + _i * 3 ]      ) & 0x0001 )=
 | \
> +								  ( ( _b[ 1 + _i * 3 ] >> 1 ) & 0x0002 ) \
> +								)
> +							=09
> +#define SS4_IS_MF_CONTINUE_V2(_b)	( ( _b[ 2 ] & 0x10 ) =3D=3D 0x10 )
> +#define SS4_IS_5F_DETECTED_V2(_b)	( ( _b[ 2 ] & 0x10 ) =3D=3D 0x10 )
> +
> +
> +#define SS4_MFPACKET_NO_AX				8160		// 8192-32 =3D 8160  Standard X-=
Coordinate value at no-finger
> +#define SS4_MFPACKET_NO_AY				4080		// 4096-16 =3D 4080  Standard Y-=
Coordinate value at no-finger
> +#define SS4_MFPACKET_NO_AX_BL			8176		// 8192-16 =3D 8176  Buttonles=
s X-Coordinate value at no-finger
> +#define SS4_MFPACKET_NO_AY_BL			4088		// 4096-8  =3D 4088  Buttonles=
s Y-Coordinate value at no-finger
> +
> +#define RESTING_FN_LARGE_MOVEMENT		50			// Threshold for resting fin=
ger's large movement
> +#define PT_IN_LEFT_BTN_AREA(_x,_y,_x_max,_y_max)	( ((_x)<(_x_max)/2)=
&&((_y)>(_y_max)*4/5) )
> +#define PT_IN_RIGHT_BTN_AREA(_x,_y,_x_max,_y_max)	( ((_x)>=3D(_x_max=
)/2)&&((_y)>(_y_max)*4/5) )
> +#define PT_IN_BTN_AREA(_x,_y,_x_max,_y_max)			( PT_IN_LEFT_BTN_AREA(=
_x,_y,_x_max,_y_max) || PT_IN_RIGHT_BTN_AREA(_x,_y,_x_max,_y_max) )
> +
>   /**
>    * struct alps_model_info - touchpad ID table
>    * @signature: E7 response string to match.
> @@ -46,7 +175,7 @@ struct alps_model_info {
>   	unsigned char command_mode_resp;
>   	unsigned char proto_version;
>   	unsigned char byte0, mask0;
> -	unsigned char flags;
> +	unsigned int flags;
>   };
>
>   /**
> @@ -66,15 +195,7 @@ struct alps_nibble_commands {
>   };
>
>   /**
> - * struct alps_fields - decoded version of the report packet
> - * @x_map: Bitmap of active X positions for MT.
> - * @y_map: Bitmap of active Y positions for MT.
> - * @fingers: Number of fingers for MT.
> - * @x: X position for ST.
> - * @y: Y position for ST.
> - * @z: Z position for ST.
> - * @first_mp: Packet is the first of a multi-packet report.
> - * @is_mp: Packet is part of a multi-packet report.
> + * struct alps_btn - decoded version of the button status
>    * @left: Left touchpad button is active.
>    * @right: Right touchpad button is active.
>    * @middle: Middle touchpad button is active.
> @@ -82,16 +203,7 @@ struct alps_nibble_commands {
>    * @ts_right: Right trackstick button is active.
>    * @ts_middle: Middle trackstick button is active.
>    */
> -struct alps_fields {
> -	unsigned int x_map;
> -	unsigned int y_map;
> -	unsigned int fingers;
> -	unsigned int x;
> -	unsigned int y;
> -	unsigned int z;
> -	unsigned int first_mp:1;
> -	unsigned int is_mp:1;
> -
> +struct alps_btn {
>   	unsigned int left:1;
>   	unsigned int right:1;
>   	unsigned int middle:1;
> @@ -102,6 +214,79 @@ struct alps_fields {
>   };
>
>   /**
> + * struct alps_btn - decoded version of the X Y Z postion for ST.
> + * @x: X position for ST.
> + * @y: Y position for ST.
> + * @z: Z position for ST.
> + */
> +struct alps_abs_data {
> +	unsigned int x;
> +	unsigned int y;
> +	unsigned int z;
> +};
> +
> +typedef enum _DOL_PACKET_TYPE
> +{
> +	DOL_UNKNOWN,
> +	DOL_GPDATA,
> +	DOL_PROFDATA,
> +	DOL_APDATA
> +}DOL_PACKET_TYPE;
> +
> +/**
> + * struct alps_fields - decoded version of the report packet
> + * @fingers: Number of fingers for MT.
> + * @pt: X Y Z postion for ST.
> + * @pt: X Y Z postion for image MT.
> + * @x_map: Bitmap of active X positions for MT.
> + * @y_map: Bitmap of active Y positions for MT.
> + * @first_mp: Packet is the first of a multi-packet report.
> + * @is_mp: Packet is part of a multi-packet report.
> + * @btn: Button activity status
> + */
> +struct alps_fields {
> +	unsigned int fingers;
> +	struct alps_abs_data pt;
> +	struct alps_abs_data pt_img[MAX_IMG_PT_NUM];
> +	unsigned int x_map;
> +	unsigned int y_map;
> +	unsigned int large_fn;
> +	unsigned int first_mp:1;
> +	unsigned int is_mp:1;
> +	DOL_PACKET_TYPE	dol_packet_type;
> +	struct alps_btn btn;
> +};
> +
> +/**
> + * struct v7_raw - data decoded from raw packet for V7.
> + * @pkt_id: An id that specifies the type of packet.
> + * @additional_fingers: Number of additional finger that is neighter=
 included
> + *  in pt slot nor reflected in rest_left and rest_right flag of dat=
a packet.
> + * @rest_left: There are fingers on left resting zone.
> + * @rest_right: There are fingers on right resting zone.
> + */
> +struct v7_raw {
> +	unsigned char pkt_id;
> +	unsigned int additional_fingers;
> +	unsigned char rest_left;
> +	unsigned char rest_right;
> +};
> +
> +/**
> + * struct alps_bl_pt_attr - generic attributes of touch points for b=
uttonless device
> + * @zone: The part of touchpad that the touch point locates
> + * @is_counted: The touch point is not a resting finger.
> + * @is_init_pt_got: The touch down point is got.
> + * @init_pt: The X Y Z position of the touch down point.
> + */
> +struct alps_bl_pt_attr {
> +	unsigned char zone;
> +	unsigned char is_counted;
> +	unsigned char is_init_pt_got;
> +	struct alps_abs_data init_pt;
> +};
> +
> +/**
>    * struct alps_data - private data structure for the ALPS driver
>    * @dev2: "Relative" device used to report trackstick or mouse acti=
vity.
>    * @phys: Physical path for the relative device.
> @@ -116,8 +301,10 @@ struct alps_fields {
>    * @flags: Additional device capabilities (passthrough port, tracks=
tick, etc.).
>    * @x_max: Largest possible X position value.
>    * @y_max: Largest possible Y position value.
> + * @resting_zone_y_min: Smallest Y postion value of the bottom resti=
ng zone.
>    * @x_bits: Number of X bits in the MT bitmap.
>    * @y_bits: Number of Y bits in the MT bitmap.
> + * @img_fingers: Number of image fingers.
>    * @hw_init: Protocol-specific hardware init function.
>    * @process_packet: Protocol-specific function to process a report =
packet.
>    * @decode_fields: Protocol-specific function to read packet bitfie=
lds.
> @@ -132,6 +319,11 @@ struct alps_fields {
>    * @fingers: Number of fingers from last MT report.
>    * @quirks: Bitmap of ALPS_QUIRK_*.
>    * @timer: Timer for flushing out the final report packet in the st=
ream.
> + * @v7: Data decoded from raw packet for V7
> + * @phy_btn: Physical button is active.
> + * @prev_phy_btn: Physical button of previous packet is active.
> + * @pressed_btn_bits: Pressed positon of button zone
> + * @pt_attr: Generic attributes of touch points for buttonless devic=
e.
>    */
>   struct alps_data {
>   	struct input_dev *dev2;
> @@ -142,11 +334,14 @@ struct alps_data {
>   	int addr_command;
>   	unsigned char proto_version;
>   	unsigned char byte0, mask0;
> -	unsigned char flags;
> +	unsigned int flags;
> +	unsigned char fw_ver[3];
>   	int x_max;
>   	int y_max;
> +	int resting_zone_y_min;
>   	int x_bits;
>   	int y_bits;
> +	unsigned char slot_number;
>
>   	int (*hw_init)(struct psmouse *psmouse);
>   	void (*process_packet)(struct psmouse *psmouse);
> @@ -161,6 +356,13 @@ struct alps_data {
>   	int fingers;
>   	u8 quirks;
>   	struct timer_list timer;
> +
> +	/* these are used for buttonless touchpad*/
> +	union {
> +		struct v7_raw v7;
> +	} r;
> +	struct alps_btn prev_btn;
> +	struct alps_bl_pt_attr pt_attr[MAX_IMG_PT_NUM];
>   };
>
>   #define ALPS_QUIRK_TRACKSTICK_BUTTONS	1 /* trakcstick buttons in tr=
ackstick packet */
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
