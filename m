From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 3/4] input - wacom : support one finger touch the
 touchscreen way
Date: Fri, 11 Feb 2011 12:24:05 -0800
Message-ID: <AANLkTin0PWuMaB1T9sXj-VF9JUST3U=fHszR0RXG=ih4@mail.gmail.com>
References: <1297387962-13723-1-git-send-email-pinglinux@gmail.com>
	<20110211195656.GA2287@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38539 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757264Ab1BKUYH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 15:24:07 -0500
Received: by wwa36 with SMTP id 36so2984719wwa.1
        for <linux-input@vger.kernel.org>; Fri, 11 Feb 2011 12:24:05 -0800 (PST)
In-Reply-To: <20110211195656.GA2287@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org

On Fri, Feb 11, 2011 at 11:56 AM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
> On Thu, Feb 10, 2011 at 05:32:42PM -0800, Ping Cheng wrote:
>> There are two types of 1FGT devices supported in wacom_wac.c.
>> Changing them to follow the existing touchscreen format, i.e.,
>> only report BTN_TOUCH as a valid tool type.
>>
>> Touch data will be ignored if pen is in proximity. This requires
>> a touch up sent if touch was down when pen comes in. The touch up
>> event should be sent before any pen events emitted. Otherwise,
>> two pointers would race for the cursor.
>>
>> However, we can not send a touch up inside wacom_tpc_pen since
>> pen and touch are on different logical port. That is why we
>> have to check if touch is up before sending pen events.
>>
>> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>> ---
>
> Hi Ping,
>
>> =A0drivers/input/tablet/wacom_wac.c | =A0125 +++++++++++++----------=
--------------
>> =A0drivers/input/tablet/wacom_wac.h | =A0 =A01 +
>> =A02 files changed, 45 insertions(+), 81 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet=
/wacom_wac.c
>> index 15bab99..fc0669d 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -675,51 +675,35 @@ static int wacom_intuos_irq(struct wacom_wac *=
wacom)
>> =A0 =A0 =A0 return 1;
>> =A0}
>>
>> -static void wacom_tpc_touch_out(struct wacom_wac *wacom, int idx)
>> -{
>> - =A0 =A0 struct input_dev *input =3D wacom->input;
>> - =A0 =A0 int finger =3D idx + 1;
>> -
>> - =A0 =A0 input_report_abs(input, ABS_X, 0);
>> - =A0 =A0 input_report_abs(input, ABS_Y, 0);
>> - =A0 =A0 input_report_abs(input, ABS_MISC, 0);
>> - =A0 =A0 input_report_key(input, wacom->tool[finger], 0);
>> - =A0 =A0 if (!idx)
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, 0);
>> - =A0 =A0 input_event(input, EV_MSC, MSC_SERIAL, finger);
>> - =A0 =A0 input_sync(input);
>> -}
>> -
>> -static void wacom_tpc_touch_in(struct wacom_wac *wacom, size_t len)
>> +static int wacom_tpc_single_touch(struct wacom_wac *wacom, size_t l=
en)
>> =A0{
>> =A0 =A0 =A0 char *data =3D wacom->data;
>> =A0 =A0 =A0 struct input_dev *input =3D wacom->input;
>> + =A0 =A0 bool prox =3D 0;
>>
>> - =A0 =A0 wacom->tool[1] =3D BTN_TOOL_DOUBLETAP;
>> - =A0 =A0 wacom->id[0] =3D TOUCH_DEVICE_ID;
>> -
>> - =A0 =A0 if (len !=3D WACOM_PKGLEN_TPC1FG) {
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 switch (data[0]) {
>> + =A0 =A0 if (!wacom->shared->stylus_in_proximity) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (len =3D=3D WACOM_PKGLEN_TPC1FG)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prox =3D data[0] & 0x01;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else =A0/* with capacity */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prox =3D data[1] & 0x01;
>> + =A0 =A0 } else if (wacom->shared->touch_down)
>> + =A0 =A0 =A0 =A0 =A0 =A0 prox =3D 0;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 case WACOM_REPORT_TPC1FG:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, AB=
S_X, le16_to_cpup((__le16 *)&data[2]));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, AB=
S_Y, le16_to_cpup((__le16 *)&data[4]));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, AB=
S_PRESSURE, le16_to_cpup((__le16 *)&data[6]));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BT=
N_TOUCH, le16_to_cpup((__le16 *)&data[6]));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, AB=
S_MISC, wacom->id[0]);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, wa=
com->tool[1], 1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(input);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 } else {
>> + =A0 =A0 if (len =3D=3D WACOM_PKGLEN_TPC1FG) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_X, get_unali=
gned_le16(&data[1]));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_Y, get_unali=
gned_le16(&data[3]));
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, 1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_MISC, wacom->i=
d[1]);
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, wacom->tool[1], 1)=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_sync(input);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_X, le16_to_cpu=
p((__le16 *)&data[2]));
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_Y, le16_to_cpu=
p((__le16 *)&data[4]));
>> =A0 =A0 =A0 }
>> + =A0 =A0 input_report_key(input, BTN_TOUCH, prox);
>> +
>> + =A0 =A0 /* keep prox bit to send proper out-prox event */
>> + =A0 =A0 wacom->shared->touch_down =3D prox;
>> +
>> + =A0 =A0 return 1;
>> =A0}
>>
>> =A0static int wacom_tpc_pen(struct wacom_wac *wacom)
>> @@ -731,7 +715,7 @@ static int wacom_tpc_pen(struct wacom_wac *wacom=
)
>>
>> =A0 =A0 =A0 prox =3D data[1] & 0x20;
>>
>> - =A0 =A0 if (!wacom->shared->stylus_in_proximity) { /* first in pro=
x */
>> + =A0 =A0 if (!wacom->shared->stylus_in_proximity) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Going into proximity select tool */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->tool[0] =3D (data[1] & 0x0c) ? BT=
N_TOOL_RUBBER : BTN_TOOL_PEN;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->tool[0] =3D=3D BTN_TOOL_PEN)
>> @@ -740,58 +724,36 @@ static int wacom_tpc_pen(struct wacom_wac *wac=
om)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[0] =3D ERASER_=
DEVICE_ID;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->stylus_in_proximity =3D t=
rue;
>
> Relying on additional events coming in to execute the part below this
> comment is not causing any troubles, then?

That is right. My testing result shows a smooth transition between
touch and pen with this addition. This logical should be applied to
Bamboo pen and touch as well (I see the same issue there). But, it is
outside of this patchset. So, hopefully someone will make that change
later.

>> + =A0 =A0 } else if (!wacom->shared->touch_down) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_STYLUS, data[1=
] & 0x02);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_STYLUS2, data[=
1] & 0x10);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_X, le16_to_cpu=
p((__le16 *)&data[2]));
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_Y, le16_to_cpu=
p((__le16 *)&data[4]));
>> + =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D ((data[7] & 0x01) << 8) | dat=
a[6];
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pressure < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D features->pre=
ssure_max + pressure + 1;
>
> And that conversion again...

Well, no code change. Just move them around.

>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, pres=
sure);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, data[1]=
 & 0x05);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!prox) { /* out-prox */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[0] =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->stylus_in_p=
roximity =3D false;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input, wacom->tool[0], pr=
ox);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 }
>> - =A0 =A0 input_report_key(input, BTN_STYLUS, data[1] & 0x02);
>> - =A0 =A0 input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
>> - =A0 =A0 input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&dat=
a[2]));
>> - =A0 =A0 input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&dat=
a[4]));
>> - =A0 =A0 pressure =3D ((data[7] & 0x01) << 8) | data[6];
>> - =A0 =A0 if (pressure < 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 pressure =3D features->pressure_max + pres=
sure + 1;
>> - =A0 =A0 input_report_abs(input, ABS_PRESSURE, pressure);
>> - =A0 =A0 input_report_key(input, BTN_TOUCH, data[1] & 0x05);
>> - =A0 =A0 if (!prox) { /* out-prox */
>> - =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[0] =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->stylus_in_proximity =3D fal=
se;
>> - =A0 =A0 }
>> - =A0 =A0 input_report_key(input, wacom->tool[0], prox);
>>
>> - =A0 =A0 return 1;
>> + =A0 =A0 return 0;
>> =A0}
>>
>> =A0static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
>> =A0{
>> =A0 =A0 =A0 char *data =3D wacom->data;
>> - =A0 =A0 int prox =3D 0;
>>
>> =A0 =A0 =A0 dbg("wacom_tpc_irq: received report #%d", data[0]);
>>
>> - =A0 =A0 if (len =3D=3D WACOM_PKGLEN_TPC1FG ||
>> - =A0 =A0 =A0 =A0 data[0] =3D=3D WACOM_REPORT_TPC1FG) { =A0 /* singl=
e touch */
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->shared->stylus_in_proximity) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (wacom->id[1] & 0x01)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_tpc_=
touch_out(wacom, 0);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[1] =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (len =3D=3D WACOM_PKGLEN_TPC1FG)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prox =3D data[0] & 0x01;
>> - =A0 =A0 =A0 =A0 =A0 =A0 else =A0/* with capacity */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prox =3D data[1] & 0x01;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (prox)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_tpc_touch_in(wacom, =
len);
>> - =A0 =A0 =A0 =A0 =A0 =A0 else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_tpc_touch_out(wacom,=
 0);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[0] =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* keep prox bit to send proper out-prox e=
vent */
>> - =A0 =A0 =A0 =A0 =A0 =A0 wacom->id[1] =3D prox;
>> - =A0 =A0 } else if (data[0] =3D=3D WACOM_REPORT_PENABLED)
>> + =A0 =A0 if (len =3D=3D WACOM_PKGLEN_TPC1FG || data[0] =3D=3D WACOM=
_REPORT_TPC1FG)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_single_touch(wacom, len);
>> + =A0 =A0 else if (data[0] =3D=3D WACOM_REPORT_PENABLED)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wacom_tpc_pen(wacom);
>>
>> =A0 =A0 =A0 return 0;
>> @@ -1172,6 +1134,8 @@ void wacom_setup_input_capabilities(struct inp=
ut_dev *input_dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fall through */
>>
>> =A0 =A0 =A0 case TABLETPC:
>> + =A0 =A0 =A0 =A0 =A0 =A0 __clear_bit(ABS_MISC, input_dev->absbit);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TOO=
L_DOUBLETAP ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=3D BTN=
_TOOL_TRIPLETAP) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_=
dev, ABS_X,
>> @@ -1180,7 +1144,6 @@ void wacom_setup_input_capabilities(struct inp=
ut_dev *input_dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_=
dev, ABS_Y,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_ca=
lculate_touch_res(features->y_max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_phy));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_DOUBLET=
AP, input_dev->keybit);
>
> Where is doubletap set now?

Oops. I must have missed that in 4/4. I'll add it in the new version
after I hear from you for the other comments.

I didn't think touchscreen needs a DOUBLETAP. It is meant for
touchpad. However, I have agreed with Chris to add DOUBLETAP anyway.
Having worked on this set for so long, I guess I must have
accidentally removed it somehow...

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type !=3D BTN_TOOL_=
PEN)
>> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet=
/wacom_wac.h
>> index 8f747dd..835f756 100644
>> --- a/drivers/input/tablet/wacom_wac.h
>> +++ b/drivers/input/tablet/wacom_wac.h
>> @@ -88,6 +88,7 @@ struct wacom_features {
>>
>> =A0struct wacom_shared {
>> =A0 =A0 =A0 bool stylus_in_proximity;
>> + =A0 =A0 bool touch_down;
>> =A0};
>>
>> =A0struct wacom_wac {
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
