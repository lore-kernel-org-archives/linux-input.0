From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 12/20] Input: atmel_mxt_ts - simplify event reporting
Date: Mon, 19 Mar 2012 17:06:10 +0800
Message-ID: <CAGS+omCHJjHeo7cjhVADxP8c0nThjKOfvkdcbPC7eMHFdWfqjQ@mail.gmail.com>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
 <1331640263-18935-13-git-send-email-djkurtz@chromium.org> <20120319082653.GB15965@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:48388 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab2CSJGb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 05:06:31 -0400
Received: by qcqw6 with SMTP id w6so1150010qcq.19
        for <linux-input@vger.kernel.org>; Mon, 19 Mar 2012 02:06:31 -0700 (PDT)
In-Reply-To: <20120319082653.GB15965@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

On Mon, Mar 19, 2012 at 4:26 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Hi Daniel,
>
>> Instead of carrying around per-finger state in the driver instance, =
just
>> report each finger as it arrives to the input layer, and let the inp=
ut
>> layer (evdev) hold the event state (which it does anyway).
>>
>> Also, the atmel pad reports "amplitude", which is reported to usersp=
ace
>> using the "PRESSURE" event type. =A0The variables now reflect this.
>>
>> Note: this driver does not really do MT-B properly. Each input repor=
t
>> (a goup of input events followed by a SYN_REPORT) only contains data=
 for
>> a single contact. =A0When multiple fingers are present on a device, =
each is
>> properly reported in its own MT_SLOT. =A0However, there is only ever=
 one
>> MT_SLOT per SYN_REPORT. =A0This is fixed in a subsequent patch.
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> ---
>
> Simplification looking good overall, together with that later
> patch. Please find some comments below.
>
>> =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0122 +++++++++------=
---------------
>> =A01 files changed, 36 insertions(+), 86 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/inpu=
t/touchscreen/atmel_mxt_ts.c
>> index 4363511..fa692e5 100644
>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> @@ -194,6 +194,7 @@
>> =A0#define MXT_BOOT_STATUS_MASK 0x3f
>>
>> =A0/* Touch status */
>> +#define MXT_UNGRIP =A0 =A0 =A0 =A0 =A0 (1 << 0)
>> =A0#define MXT_SUPPRESS =A0 =A0 =A0 =A0 (1 << 1)
>> =A0#define MXT_AMP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << =
2)
>> =A0#define MXT_VECTOR =A0 =A0 =A0 =A0 =A0 (1 << 3)
>> @@ -238,14 +239,6 @@ struct mxt_message {
>> =A0 =A0 =A0 u8 message[7];
>> =A0};
>>
>> -struct mxt_finger {
>> - =A0 =A0 int status;
>> - =A0 =A0 int x;
>> - =A0 =A0 int y;
>> - =A0 =A0 int area;
>> - =A0 =A0 int pressure;
>> -};
>> -
>> =A0/* Each client has this additional data */
>> =A0struct mxt_data {
>> =A0 =A0 =A0 struct i2c_client *client;
>> @@ -253,7 +246,6 @@ struct mxt_data {
>> =A0 =A0 =A0 const struct mxt_platform_data *pdata;
>> =A0 =A0 =A0 struct mxt_object *object_table;
>> =A0 =A0 =A0 struct mxt_info info;
>> - =A0 =A0 struct mxt_finger finger[MXT_MAX_FINGER];
>> =A0 =A0 =A0 unsigned int irq;
>> =A0 =A0 =A0 unsigned int max_x;
>> =A0 =A0 =A0 unsigned int max_y;
>> @@ -526,97 +518,55 @@ static int mxt_write_object(struct mxt_data *d=
ata,
>> =A0 =A0 =A0 return mxt_write_reg(data->client, reg + offset, 1, &val=
);
>> =A0}
>>
>> -static void mxt_input_report(struct mxt_data *data, int single_id)
>> -{
>> - =A0 =A0 struct mxt_finger *finger =3D data->finger;
>> - =A0 =A0 struct input_dev *input_dev =3D data->input_dev;
>> - =A0 =A0 int status =3D finger[single_id].status;
>> - =A0 =A0 int finger_num =3D 0;
>> - =A0 =A0 int id;
>> -
>> - =A0 =A0 for (id =3D 0; id < MXT_MAX_FINGER; id++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!finger[id].status)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_mt_slot(input_dev, id);
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_mt_report_slot_state(input_dev, MT_T=
OOL_FINGER,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 finger[id]=
=2Estatus !=3D MXT_RELEASE);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (finger[id].status !=3D MXT_RELEASE) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 finger_num++;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev=
, ABS_MT_TOUCH_MAJOR,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 finger[id].area);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev=
, ABS_MT_POSITION_X,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 finger[id].x);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev=
, ABS_MT_POSITION_Y,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 finger[id].y);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev=
, ABS_MT_PRESSURE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 finger[id].pressure);
>> - =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 finger[id].status =3D 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 }
>> -
>> - =A0 =A0 input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
>> -
>> - =A0 =A0 if (status !=3D MXT_RELEASE) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_X, finger[=
single_id].x);
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_Y, finger[=
single_id].y);
>> - =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ABS_PRE=
SSURE, finger[single_id].pressure);
>> - =A0 =A0 }
>> -
>> - =A0 =A0 input_sync(input_dev);
>> -}
>> -
>> =A0static void mxt_input_touchevent(struct mxt_data *data,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct mxt_message *message, int id)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
mxt_message *message, int id)
>> =A0{
>> - =A0 =A0 struct mxt_finger *finger =3D data->finger;
>> =A0 =A0 =A0 struct device *dev =3D &data->client->dev;
>> - =A0 =A0 u8 status =3D message->message[0];
>> + =A0 =A0 struct input_dev *input_dev =3D data->input_dev;
>> + =A0 =A0 u8 status;
>> =A0 =A0 =A0 int x;
>> =A0 =A0 =A0 int y;
>> =A0 =A0 =A0 int area;
>> - =A0 =A0 int pressure;
>> -
>> - =A0 =A0 /* Check the touch is present on the screen */
>> - =A0 =A0 if (!(status & MXT_DETECT)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (status & MXT_RELEASE) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "[%d] release=
d\n", id);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 finger[id].status =3D MXT_=
RELEASE;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mxt_input_report(data, id)=
;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> - =A0 =A0 }
>> -
>> - =A0 =A0 /* Check only AMP detection */
>> - =A0 =A0 if (!(status & (MXT_PRESS | MXT_MOVE)))
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 int amplitude;
>>
>> + =A0 =A0 status =3D message->message[0];
>> =A0 =A0 =A0 x =3D (message->message[1] << 4) | ((message->message[3]=
 >> 4) & 0xf);
>> =A0 =A0 =A0 y =3D (message->message[2] << 4) | ((message->message[3]=
 & 0xf));
>> =A0 =A0 =A0 if (data->max_x < 1024)
>> - =A0 =A0 =A0 =A0 =A0 =A0 x =3D x >> 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 x >>=3D 2;
>> =A0 =A0 =A0 if (data->max_y < 1024)
>> - =A0 =A0 =A0 =A0 =A0 =A0 y =3D y >> 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 y >>=3D 2;
>>
>> =A0 =A0 =A0 area =3D message->message[4];
>> - =A0 =A0 pressure =3D message->message[5];
>> -
>> - =A0 =A0 dev_dbg(dev, "[%d] %s x: %d, y: %d, area: %d\n", id,
>> - =A0 =A0 =A0 =A0 =A0 =A0 status & MXT_MOVE ? "moved" : "pressed",
>> - =A0 =A0 =A0 =A0 =A0 =A0 x, y, area);
>> -
>> - =A0 =A0 finger[id].status =3D status & MXT_MOVE ?
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MXT_MOVE :=
 MXT_PRESS;
>> - =A0 =A0 finger[id].x =3D x;
>> - =A0 =A0 finger[id].y =3D y;
>> - =A0 =A0 finger[id].area =3D area;
>> - =A0 =A0 finger[id].pressure =3D pressure;
>> + =A0 =A0 amplitude =3D message->message[5];
>> +
>> + =A0 =A0 dev_dbg(dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 "[%d] %c%c%c%c%c%c%c%c x: %d y: %d area: %=
d amp: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 (status & MXT_DETECT) ? 'D' : '.',
>> + =A0 =A0 =A0 =A0 =A0 =A0 (status & MXT_PRESS) ? 'P' : '.',
>> + =A0 =A0 =A0 =A0 =A0 =A0 (status & MXT_RELEASE) ? 'R' : '.',
>> + =A0 =A0 =A0 =A0 =A0 =A0 (status & MXT_MOVE) ? 'M' : '.',
>> + =A0 =A0 =A0 =A0 =A0 =A0 (status & MXT_VECTOR) ? 'V' : '.',
>> + =A0 =A0 =A0 =A0 =A0 =A0 (status & MXT_AMP) ? 'A' : '.',
>> + =A0 =A0 =A0 =A0 =A0 =A0 (status & MXT_SUPPRESS) ? 'S' : '.',
>> + =A0 =A0 =A0 =A0 =A0 =A0 (status & MXT_UNGRIP) ? 'U' : '.',
>> + =A0 =A0 =A0 =A0 =A0 =A0 x, y, area, amplitude);
>> +
>> + =A0 =A0 input_mt_slot(input_dev, id);
>> + =A0 =A0 input_mt_report_slot_state(input_dev, MT_TOOL_FINGER,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sta=
tus & MXT_DETECT);
>> +
>> + =A0 =A0 if (status & MXT_DETECT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_MT_POSITIO=
N_X, x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_MT_POSITIO=
N_Y, y);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_MT_PRESSUR=
E, amplitude);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* TODO: This should really be sqrt(area) =
*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input_dev, ABS_MT_TOUCH_M=
AJOR, area);
>
> The functional relationship might not be perfect, but at least the
> reported scale should match the position units, as several userspace
> drivers depend on its accuracy. If the line size looks reasonable in
> mtview, for instance, it should be fine.

Please note this patch doesn't actually change how TOUCH_MAJOR is
reported.  All I did here was add the TODO, since reporting 'area' as
TOUCH_MAJOR looks suspect to me :).  Unfortunately, I don't actually
know the relationship between what the firmware sends as 'area' and
the position units...  perhaps someone with more experience with how
the firmware works could help us here.

-Dan

>
>> + =A0 =A0 }
>>
>> - =A0 =A0 mxt_input_report(data, id);
>> + =A0 =A0 input_mt_report_pointer_emulation(input_dev, false);
>> + =A0 =A0 input_sync(input_dev);
>> =A0}
>>
>> =A0static irqreturn_t mxt_interrupt(int irq, void *dev_id)
>> --
>
> Thanks,
> Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
