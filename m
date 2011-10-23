From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH v2 6/6] Input: wacom - 3rd gen Bamboo P&Touch packet support
Date: Sun, 23 Oct 2011 17:14:39 -0500
Message-ID: <CAGzDe_ZxiXjtFn583cwX8MBXo2BOouChVhFTrkDCDYumXCZA7g@mail.gmail.com>
References: <1318988593-2712-1-git-send-email-chris@cnpbagwell.com>
	<20111022122654.GA2368@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50271 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab1JWWOk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Oct 2011 18:14:40 -0400
Received: by eye27 with SMTP id 27so5037366eye.19
        for <linux-input@vger.kernel.org>; Sun, 23 Oct 2011 15:14:39 -0700 (PDT)
In-Reply-To: <20111022122654.GA2368@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com

On Sat, Oct 22, 2011 at 7:26 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Hi Chris,
>
> looks like a neat device, please find some comments below.

Yep, its a very nice tablet for multitouch work.

>
>> 3rd generation Bamboo Pen and Touch tablets reuse the older
>> stylus packet but add an extra fixed zero pad byte to end.
>>
>> The touch packets are quite different since it supports tracking
>> of up to 16 touches. The packet is 64-byte fixed size but contains
>> up to 15 smaller messages indicating data for a single touch or
>> for tablet button presses.
>>
>> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
>> ---
>>
>> New in v2. =A0There were 2 sets of indentation errors that were fixe=
d.
>> No code change. =A0No changes in other 5 patches so only resending t=
his
>> one.
>>
>> =A0drivers/input/tablet/wacom_wac.c | =A0 94 +++++++++++++++++++++++=
+++++++++++++--
>> =A0drivers/input/tablet/wacom_wac.h | =A0 =A04 +-
>> =A02 files changed, 93 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet=
/wacom_wac.c
>> index d1ced32..13d86c5 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -836,6 +836,64 @@ static int wacom_bpt_touch(struct wacom_wac *wa=
com)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned =
char *data)
>> +{
>> + =A0 =A0 struct input_dev *input =3D wacom->input;
>> + =A0 =A0 int slot_id =3D data[0] - 2;
>
> Are we sure slot_id < 0 cannot happen?

Good point.  That looks suspicious to casual review.  I'll add a commen=
t there.

It can't be < 0 because the if() that calls this function makes sure
msg_id in between values 2 and 17.

>
>> + =A0 =A0 bool touch =3D data[1] & 0x80;
>> +
>> + =A0 =A0 touch =3D touch && !wacom->shared->stylus_in_proximity;
>> +
>> + =A0 =A0 input_mt_slot(input, slot_id);
>> + =A0 =A0 input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
>> +
>> + =A0 =A0 if (touch) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int x =3D (data[2] << 4) | (data[4] >> 4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 int y =3D (data[3] << 4) | (data[4] & 0x0f=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 int w =3D data[6];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_MT_POSITION_X,=
 x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_MT_POSITION_Y,=
 y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_MT_TOUCH_MAJOR=
, w);
>> + =A0 =A0 }
>> +}
>> +
>> +static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned=
 char *data)
>> +{
>> + =A0 =A0 struct input_dev *input =3D wacom->input;
>> +
>> + =A0 =A0 input_report_key(input, BTN_LEFT, (data[1] & 0x08) !=3D 0)=
;
>> + =A0 =A0 input_report_key(input, BTN_FORWARD, (data[1] & 0x04) !=3D=
 0);
>> + =A0 =A0 input_report_key(input, BTN_BACK, (data[1] & 0x02) !=3D 0)=
;
>> + =A0 =A0 input_report_key(input, BTN_RIGHT, (data[1] & 0x01) !=3D 0=
);
>> +}
>> +
>> +static int wacom_bpt3_touch(struct wacom_wac *wacom)
>> +{
>> + =A0 =A0 struct input_dev *input =3D wacom->input;
>> + =A0 =A0 unsigned char *data =3D wacom->data;
>> + =A0 =A0 int count =3D data[1] & 0x03;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 /* data has up to 7 fixed sized 8-byte messages starting a=
t data[2] */
>> + =A0 =A0 for (i =3D 0; i < count && i < 8; i++) {
>
> The definition of count seems to imply that the test "i < 8" is unnec=
essary.

True.  I'll remove that.  Thanks.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 int offset =3D (8 * i)+2;
>
> style problem: please use ") + 2"
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 int msg_id =3D data[offset];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (msg_id >=3D 2 && msg_id <=3D 17)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_bpt3_touch_msg(wacom=
, data+offset);
>
> ditto
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 else if (msg_id =3D=3D 128)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_bpt3_button_msg(waco=
m, data+offset);
>
> ditto

OK. I'll fix style issues.

Chris

>
>> +
>> + =A0 =A0 }
>> +
>> + =A0 =A0 input_mt_report_pointer_emulation(input, true);
>> +
>> + =A0 =A0 input_sync(input);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> =A0static int wacom_bpt_pen(struct wacom_wac *wacom)
>> =A0{
>> =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
>> @@ -906,7 +964,9 @@ static int wacom_bpt_irq(struct wacom_wac *wacom=
, size_t len)
>> =A0{
>> =A0 =A0 =A0 if (len =3D=3D WACOM_PKGLEN_BBTOUCH)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_bpt_touch(wacom);
>> - =A0 =A0 else if (len =3D=3D WACOM_PKGLEN_BBFUN)
>> + =A0 =A0 else if (len =3D=3D WACOM_PKGLEN_BBTOUCH3)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return wacom_bpt3_touch(wacom);
>> + =A0 =A0 else if (len =3D=3D WACOM_PKGLEN_BBFUN || len =3D=3D WACOM=
_PKGLEN_BBPEN)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_bpt_pen(wacom);
>>
>> =A0 =A0 =A0 return 0;
>> @@ -1025,9 +1085,9 @@ void wacom_setup_device_quirks(struct wacom_fe=
atures *features)
>> =A0 =A0 =A0 =A0 =A0 features->type =3D=3D BAMBOO_PT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->quirks |=3D WACOM_QUIRK_MULTI_=
INPUT;
>>
>> - =A0 =A0 /* quirks for bamboo touch */
>> + =A0 =A0 /* quirk for bamboo touch with 2 low res touches */
>> =A0 =A0 =A0 if (features->type =3D=3D BAMBOO_PT &&
>> - =A0 =A0 =A0 =A0 features->device_type =3D=3D BTN_TOOL_DOUBLETAP) {
>> + =A0 =A0 =A0 =A0 features->pktlen =3D=3D WACOM_PKGLEN_BBTOUCH) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_max <<=3D 5;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_max <<=3D 5;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_fuzz <<=3D 5;
>> @@ -1213,7 +1273,21 @@ void wacom_setup_input_capabilities(struct in=
put_dev *input_dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_FINGE=
R, input_dev->keybit);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_DOUBL=
ETAP, input_dev->keybit);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(input_=
dev, 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->pktlen =3D=3D=
 WACOM_PKGLEN_BBTOUCH3) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(=
BTN_TOOL_TRIPLETAP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 input_dev->keybit);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(=
BTN_TOOL_QUADTAP,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 input_dev->keybit);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_i=
nit_slots(input_dev, 16);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_=
abs_params(input_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ABS_MT_TOUCH_MAJOR,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00, 255, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_i=
nit_slots(input_dev, 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(inp=
ut_dev, ABS_MT_POSITION_X,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A00, features->x_max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0features->x_fuzz, 0);
>> @@ -1479,6 +1553,15 @@ static const struct wacom_features wacom_feat=
ures_0xDA =3D
>> =A0static struct wacom_features wacom_features_0xDB =3D
>> =A0 =A0 =A0 { "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN, =A02164=
8, 13700, 1023,
>> =A0 =A0 =A0 =A0 31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>> +static const struct wacom_features wacom_features_0xDD =3D
>> + =A0 =A0 =A0 =A0{ "Wacom Bamboo Connect", WACOM_PKGLEN_BBPEN, =A0 =A0=
 14720, =A09200, 1023,
>> + =A0 =A0 =A0 =A0 =A031, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_R=
ES };
>> +static const struct wacom_features wacom_features_0xDE =3D
>> + =A0 =A0 =A0 =A0{ "Wacom Bamboo 16FG 4x5", WACOM_PKGLEN_BBPEN, =A0 =
=A014720, =A09200, 1023,
>> + =A0 =A0 =A0 =A0 =A031, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_R=
ES };
>> +static const struct wacom_features wacom_features_0xDF =3D
>> + =A0 =A0 =A0 =A0{ "Wacom Bamboo 16FG 6x8", WACOM_PKGLEN_BBPEN, =A0 =
=A021648, 13700, 1023,
>> + =A0 =A0 =A0 =A0 =A031, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_R=
ES };
>> =A0static const struct wacom_features wacom_features_0x6004 =3D
>> =A0 =A0 =A0 { "ISD-V4", =A0 =A0 =A0 =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRA=
PHIRE, =A012800, =A08000, =A0255,
>> =A0 =A0 =A0 =A0 0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>> @@ -1574,6 +1657,9 @@ const struct usb_device_id wacom_ids[] =3D {
>> =A0 =A0 =A0 { USB_DEVICE_WACOM(0xD8) },
>> =A0 =A0 =A0 { USB_DEVICE_WACOM(0xDA) },
>> =A0 =A0 =A0 { USB_DEVICE_WACOM(0xDB) },
>> + =A0 =A0 { USB_DEVICE_WACOM(0xDD) },
>> + =A0 =A0 { USB_DEVICE_WACOM(0xDE) },
>> + =A0 =A0 { USB_DEVICE_WACOM(0xDF) },
>> =A0 =A0 =A0 { USB_DEVICE_WACOM(0xF0) },
>> =A0 =A0 =A0 { USB_DEVICE_WACOM(0xCC) },
>> =A0 =A0 =A0 { USB_DEVICE_WACOM(0x90) },
>> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet=
/wacom_wac.h
>> index 53eb71b..d54ffcb 100644
>> --- a/drivers/input/tablet/wacom_wac.h
>> +++ b/drivers/input/tablet/wacom_wac.h
>> @@ -12,7 +12,7 @@
>> =A0#include <linux/types.h>
>>
>> =A0/* maximum packet length for USB devices */
>> -#define WACOM_PKGLEN_MAX =A0 =A0 32
>> +#define WACOM_PKGLEN_MAX =A0 =A0 64
>>
>> =A0/* packet length for individual models */
>> =A0#define WACOM_PKGLEN_PENPRTN =A07
>> @@ -22,6 +22,8 @@
>> =A0#define WACOM_PKGLEN_TPC1FG =A0 5
>> =A0#define WACOM_PKGLEN_TPC2FG =A014
>> =A0#define WACOM_PKGLEN_BBTOUCH 20
>> +#define WACOM_PKGLEN_BBPEN =A0 10
>> +#define WACOM_PKGLEN_BBTOUCH3 =A0 =A0 =A0 =A064
>>
>> =A0/* device IDs */
>> =A0#define STYLUS_DEVICE_ID =A0 =A0 0x02
>> --
>> 1.7.6.4
>
> Thanks,
> Henrik
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
