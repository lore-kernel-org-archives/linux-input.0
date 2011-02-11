From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 4/4] input - wacom: Support 2FGT in MT format
Date: Fri, 11 Feb 2011 12:35:41 -0800
Message-ID: <AANLkTimBPBDCBzw0fbDpLf8F7N_zG+ceKJAC9Li15g5P@mail.gmail.com>
References: <1297387983-13761-1-git-send-email-pinglinux@gmail.com>
	<20110211202010.GB2287@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64346 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757749Ab1BKUfn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 15:35:43 -0500
Received: by wwa36 with SMTP id 36so2994737wwa.1
        for <linux-input@vger.kernel.org>; Fri, 11 Feb 2011 12:35:41 -0800 (PST)
In-Reply-To: <20110211202010.GB2287@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org

On Fri, Feb 11, 2011 at 12:20 PM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
> Hi Ping,
>
> On Thu, Feb 10, 2011 at 05:33:03PM -0800, Ping Cheng wrote:
>
> Given the nice patch below, there has to be _something_ to say about =
it here, hmm?
>
>> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>> =A0drivers/input/tablet/wacom_sys.c | =A0 12 ++++----
>> =A0drivers/input/tablet/wacom_wac.c | =A0 61 +++++++++++++++++++++++=
+++++++-------
>> =A02 files changed, 55 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet=
/wacom_sys.c
>> index fc38149..b97665f 100644
>> --- a/drivers/input/tablet/wacom_sys.c
>> +++ b/drivers/input/tablet/wacom_sys.c
>> @@ -193,16 +193,16 @@ static int wacom_parse_hid(struct usb_interfac=
e *intf, struct hid_descriptor *hi
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_USAGE_X:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (usag=
e =3D=3D WCM_DESKTOP) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (finger) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL_DOUBLETAP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL_FINGER;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset back */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKGL=
EN_TPC2FG;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL=
_TRIPLETAP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL=
_DOUBLETAP;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D BAMBOO_PT) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset back */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKGL=
EN_BBTOUCH;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL=
_TRIPLETAP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL=
_DOUBLETAP;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_phy =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_unaligned_l=
e16(&report[i + 5]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_max =3D
>> @@ -241,11 +241,11 @@ static int wacom_parse_hid(struct usb_interfac=
e *intf, struct hid_descriptor *hi
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case HID_USAGE_Y:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (usag=
e =3D=3D WCM_DESKTOP) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (finger) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL_DOUBLETAP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL_FINGER;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 if (features->type =3D=3D TABLETPC2FG) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset back */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKGL=
EN_TPC2FG;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL=
_TRIPLETAP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL=
_DOUBLETAP;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_max =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_unaligned_l=
e16(&report[i + 3]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_phy =3D
>> @@ -254,7 +254,7 @@ static int wacom_parse_hid(struct usb_interface =
*intf, struct hid_descriptor *hi
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 } else if (features->type =3D=3D BAMBOO_PT) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* need to reset back */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->pktlen =3D WACOM_PKGL=
EN_BBTOUCH;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL=
_TRIPLETAP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D BTN_TOOL=
_DOUBLETAP;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_phy =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_unaligned_l=
e16(&report[i + 3]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_max =3D
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet=
/wacom_wac.c
>> index fc0669d..39c289d 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -675,6 +675,38 @@ static int wacom_intuos_irq(struct wacom_wac *w=
acom)
>> =A0 =A0 =A0 return 1;
>> =A0}
>>
>> +static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
>> +{
>> + =A0 =A0 struct input_dev *input =3D wacom->input;
>> + =A0 =A0 unsigned char *data =3D wacom->data;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 if (wacom->shared->stylus_in_proximity && !wacom->shared->=
touch_down)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> Seeing one case handled out of four possible always makes me nervous.

The above statement is to avoid going through the input_mt_slot and
input_mt_report_slot_state routines without posting any meaningful
events. I guess it could be considered as a performance enhancement?

Which case makes you nervous? I'll take care of it ;).

>> +
>> + =A0 =A0 for (i =3D 0; i < 2; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int p =3D data[1] & (1 << i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 bool touch =3D p && !wacom->shared->stylus=
_in_proximity;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input, i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input, MT_TOOL_=
=46INGER, touch);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (touch) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int x =3D le16_to_cpup((__=
le16 *)&data[i * 2 + 2]) & 0x7fff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int y =3D le16_to_cpup((__=
le16 *)&data[i * 2 + 6]) & 0x7fff;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, AB=
S_MT_POSITION_X, x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, AB=
S_MT_POSITION_Y, y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* keep touch bit to send proper touch up =
event */
>> + =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->touch_down =3D max(touch, w=
acom->shared->touch_down);
>
> So only false->true is possible here.

Yeah, both are bools. What else can they take?

> What I can see from the patchset, only wacom_tpc_single_touch() will =
ever set touch_down to
> false. Is that sufficient?

No,  wacom_tpc_mt_touch can set touch_down to false too. When touch is
false, touch_down will be false. This happens when pen in prox or when
both fingers are up.

Where else do you see it can be changed? tpc_pen() can not do that
since it is on a different port, that's the reason of touch_down.

Ping

>> + =A0 =A0 }
>> +
>> + =A0 =A0 input_mt_report_pointer_emulation(input, true);
>> +
>> + =A0 =A0 return 1;
>> +}
>> +
>> =A0static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t=
 len)
>> =A0{
>> =A0 =A0 =A0 char *data =3D wacom->data;
>> @@ -753,6 +785,8 @@ static int wacom_tpc_irq(struct wacom_wac *wacom=
, size_t len)
>>
>> =A0 =A0 =A0 if (len =3D=3D WACOM_PKGLEN_TPC1FG || data[0] =3D=3D WAC=
OM_REPORT_TPC1FG)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_single_touch(wacom, len=
);
>> + =A0 =A0 else if (data[0] =3D=3D WACOM_REPORT_TPC2FG)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_mt_touch(wacom);
>> =A0 =A0 =A0 else if (data[0] =3D=3D WACOM_REPORT_PENABLED)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_pen(wacom);
>>
>> @@ -979,7 +1013,7 @@ void wacom_setup_device_quirks(struct wacom_fea=
tures *features)
>> =A0{
>>
>> =A0 =A0 =A0 /* touch device found but size is not defined. use defau=
lt */
>> - =A0 =A0 if (features->device_type =3D=3D BTN_TOOL_DOUBLETAP && !fe=
atures->x_max) {
>> + =A0 =A0 if (features->device_type =3D=3D BTN_TOOL_FINGER && !featu=
res->x_max) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_max =3D 1023;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_max =3D 1023;
>> =A0 =A0 =A0 }
>> @@ -991,7 +1025,7 @@ void wacom_setup_device_quirks(struct wacom_fea=
tures *features)
>>
>> =A0 =A0 =A0 /* quirks for bamboo touch */
>> =A0 =A0 =A0 if (features->type =3D=3D BAMBOO_PT &&
>> - =A0 =A0 =A0 =A0 features->device_type =3D=3D BTN_TOOL_TRIPLETAP) {
>> + =A0 =A0 =A0 =A0 features->device_type =3D=3D BTN_TOOL_DOUBLETAP) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_max <<=3D 5;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_max <<=3D 5;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_fuzz <<=3D 5;
>> @@ -1127,28 +1161,31 @@ void wacom_setup_input_capabilities(struct i=
nput_dev *input_dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> =A0 =A0 =A0 case TABLETPC2FG:
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TOOL_=
TRIPLETAP) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_TRIPLET=
AP, input_dev->keybit);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(input=
_dev, EV_MSC, MSC_SERIAL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TOOL_=
DOUBLETAP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_DOUBLET=
AP, input_dev->keybit);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(input_=
dev, 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input=
_dev, ABS_MT_TOOL_TYPE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0, MT_TOOL_MAX, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input=
_dev, ABS_MT_POSITION_X,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0, features->x_max, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input=
_dev, ABS_MT_POSITION_Y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0, features->y_max, 0, 0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fall through */
>>
>> =A0 =A0 =A0 case TABLETPC:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clear_bit(ABS_MISC, input_dev->absbit)=
;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TOOL_=
DOUBLETAP ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=3D BTN_T=
OOL_TRIPLETAP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type !=3D BTN_TOOL_PE=
N) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_=
dev, ABS_X,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_ca=
lculate_touch_res(features->x_max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->x_phy));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_=
dev, ABS_Y,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_ca=
lculate_touch_res(features->y_max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_phy));
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type !=3D BTN_TOOL_PE=
N)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break; =A0/* no need to =
process stylus stuff */
>> -
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fall through */
>>
>> =A0 =A0 =A0 case PL:
>> @@ -1166,7 +1203,7 @@ void wacom_setup_input_capabilities(struct inp=
ut_dev *input_dev,
>> =A0 =A0 =A0 case BAMBOO_PT:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clear_bit(ABS_MISC, input_dev->absbit)=
;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TOOL_=
TRIPLETAP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TOOL_=
DOUBLETAP) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_LEFT, inpu=
t_dev->keybit);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_FORWARD, i=
nput_dev->keybit);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_BACK, inpu=
t_dev->keybit);
>> --
>
> Thanks,
> Henrik
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
