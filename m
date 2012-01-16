From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH 1/2] hid-multitouch: add support for trackpads
Date: Mon, 16 Jan 2012 18:30:01 +0100
Message-ID: <CAN+gG=EaZ3vzZh6CxRQgy4irRUkN4Fiv5_b0YR4hLq-3koQwRw@mail.gmail.com>
References: <1326469531-26808-1-git-send-email-benjamin.tissoires@enac.fr>
	<20120116145304.GA9828@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120116145304.GA9828@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Henrik,

thanks for the review.

Comments in-lined:

On Mon, Jan 16, 2012 at 15:53, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> Hi Benjamin,
>
>> * some multitouch trackpads present the touch usage. This needs to b=
e
>> filtered as it will conflict with mt-implementation.
>> * trackpads send BTN_TOOL_* to notify how many fingers are present
>> (this is used by xorg to use synaptics instead of generic evdev)
>> * trackpads like Perixx 701 are not different from a hid point of vi=
ew
>> from a touchscreen, and we need to manually set them as touchpad.
>
> Missing subject line?

=2E... see the subject of the mail "[PATCH 1/2] hid-multitouch: add
support for trackpads"

we can eventually change it...



>
>> @@ -265,17 +266,31 @@ static int mt_input_mapping(struct hid_device =
*hdev, struct hid_input *hi,
>> =A0{
>> =A0 =A0 =A0 struct mt_device *td =3D hid_get_drvdata(hdev);
>> =A0 =A0 =A0 struct mt_class *cls =3D &td->mtclass;
>> + =A0 =A0 int code;
>>
>> =A0 =A0 =A0 /* Only map fields from TouchScreen or TouchPad collecti=
ons.
>> =A0 =A0 =A0 =A0 =A0 * We need to ignore fields that belong to other =
collections
>> =A0 =A0 =A0 =A0 =A0 * such as Mouse that might have the same Generic=
Desktop usages. */
>> =A0 =A0 =A0 if (field->application =3D=3D HID_DG_TOUCHSCREEN)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(INPUT_PROP_DIRECT, hi->input->pr=
opbit);
>> - =A0 =A0 else if (field->application =3D=3D HID_DG_TOUCHPAD)
>> - =A0 =A0 =A0 =A0 =A0 =A0 set_bit(INPUT_PROP_POINTER, hi->input->pro=
pbit);
>> - =A0 =A0 else
>> + =A0 =A0 else if (field->application !=3D HID_DG_TOUCHPAD)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> + =A0 =A0 /* In case of an indirect device (touchpad), we need to ad=
d
>> + =A0 =A0 =A0* specific BTN_TOOL_* to be handled by the synaptics xo=
rg
>> + =A0 =A0 =A0* driver.
>> + =A0 =A0 =A0* We also consider that touchscreens providing buttons =
are touchpads.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (field->application =3D=3D HID_DG_TOUCHPAD ||
>> + =A0 =A0 =A0 =A0 (usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_BUTTON=
 ||
>> + =A0 =A0 =A0 =A0 cls->is_indirect) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_bit(INPUT_PROP_POINTER, hi->input->pro=
pbit);
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_bit(BTN_TOOL_FINGER, hi->input->keybit=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_bit(BTN_TOOL_DOUBLETAP, hi->input->key=
bit);
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_bit(BTN_TOOL_TRIPLETAP, hi->input->key=
bit);
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_bit(BTN_TOOL_QUADTAP, hi->input->keybi=
t);
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 /* eGalax devices provide a Digitizer.Stylus input which=
 overrides
>> =A0 =A0 =A0 =A0* the correct Digitizers.Finger X/Y ranges.
>> =A0 =A0 =A0 =A0* Let's just ignore this input. */
>> @@ -389,9 +404,20 @@ static int mt_input_mapping(struct hid_device *=
hdev, struct hid_input *hi,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last=
_field_index =3D field->index;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TOUCH:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Legacy devices use TIPS=
WITCH and not TOUCH.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Let's just ignore thi=
s field. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* let hid-input decide for the others *=
/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>
>> + =A0 =A0 case HID_UP_BUTTON:
>> + =A0 =A0 =A0 =A0 =A0 =A0 code =3D ((usage->hid - 1) & HID_USAGE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 code +=3D BTN_MOUSE;
>
> Any reason not to write ((usage->hid - 1) & HID_USAGE) | BTN_MOUSE?

Just copy/paste from hid-input.c

but agree, this can be factorized.

I'll send a v2 with the next patch

Thanks,
Benjamin

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 hid_map_usage(hi, usage, bit, max, EV_KEY,=
 code);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(hi->input, EV_KEY, co=
de);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> +
>> =A0 =A0 =A0 case 0xff000000:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we do not want to map these: no input=
-oriented meaning */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> @@ -453,6 +479,7 @@ static void mt_complete_slot(struct mt_device *t=
d)
>> =A0static void mt_emit_event(struct mt_device *td, struct input_dev =
*input)
>> =A0{
>> =A0 =A0 =A0 int i;
>> + =A0 =A0 int finger_count =3D 0;
>>
>> =A0 =A0 =A0 for (i =3D 0; i < td->maxcontacts; ++i) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mt_slot *s =3D &(td->slots[i]);
>> @@ -477,12 +504,14 @@ static void mt_emit_event(struct mt_device *td=
, struct input_dev *input)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_AB=
S, ABS_MT_PRESSURE, s->p);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_AB=
S, ABS_MT_TOUCH_MAJOR, major);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(input, EV_AB=
S, ABS_MT_TOUCH_MINOR, minor);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 finger_count++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->seen_in_this_frame =3D false;
>>
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 input_mt_report_pointer_emulation(input, true);
>> + =A0 =A0 input_mt_report_finger_count(input, finger_count);
>> =A0 =A0 =A0 input_sync(input);
>> =A0 =A0 =A0 td->num_received =3D 0;
>> =A0}
>> @@ -538,6 +567,9 @@ static int mt_event(struct hid_device *hid, stru=
ct hid_field *field,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (value)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->num_=
expected =3D value;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case HID_DG_TOUCH:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* do nothing */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fallback to the gener=
ic hidinput handling */
>> --
>> 1.7.4.4
>
> Looks good otherwise.
>
> Thanks,
> Henrik
