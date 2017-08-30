From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: Correct coordinate system of touchring and
 pen twist
Date: Tue, 29 Aug 2017 17:37:00 -0700
Message-ID: <CANRwn3Qt4wr4dSi2=diw_5Yh2w67TpW6zxgUY+csZLzykgqGXA@mail.gmail.com>
References: <20170824230902.4381-1-killertofu@gmail.com> <CAF8JNhJggOk6ie-_75PoMvu=5mt=Tp+JaP96XoeM=t=MV5OOvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAF8JNhJggOk6ie-_75PoMvu=5mt=Tp+JaP96XoeM=t=MV5OOvw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "# v3.17+" <stable@vger.kernel.org>, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 29, 2017 at 11:34 AM, Ping Cheng <pinglinux@gmail.com> wrote:
> On Thu, Aug 24, 2017 at 4:09 PM, Jason Gerecke <killertofu@gmail.com> wro=
te:
>> The MobileStudio Pro, Cintiq Pro, and 2nd-gen Intuos Pro devices use a
>> different coordinate system for their touchring and pen twist than prior
>> devices. Prior devices had zero aligned to the tablet's left and would
>> increase clockwise. Userspace expects data from the kernel to be in this
>> old coordinate space, so adjustments are necessary.
>>
>> While the coordinate system for pen twist is formally defined by the HID
>> standard, no such definition existed for the touchring at the time these
>> tablets were introduced. Future tablets are expected to report touchring
>> data using the same "zero-up clockwise-increasing" coordinate system
>> defined for twist.
>>
>> Fixes: 60a2218698 ("HID: wacom: generic: add support for touchring")
>> Fixes: 50066a042d ("HID: wacom: generic: Add support for height, tilt, a=
nd twist usages")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>
> Thank you Jason for catching and correcting the issue.
>
> Intuos Pro 2 series supports wireless/bluetooth connection, which was
> implemented in its own routine. Should we also update that code path?
> Except that, the patch is:
>
> Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
>
> Cheers,
> Ping
>

Good call. I've also found a second issue with the wireless codepath's
handling of negative numbers that also needs fixing. I'll send an
updated patchset shortly.

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>> ---
>>  drivers/hid/wacom_wac.c | 52 ++++++++++++++++++++++++++++++++++++++++++=
++++++-
>>  1 file changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
>> index bb17d7bbefd3..7f0b3d497ecb 100644
>> --- a/drivers/hid/wacom_wac.c
>> +++ b/drivers/hid/wacom_wac.c
>> @@ -1616,6 +1616,20 @@ static int wacom_tpc_irq(struct wacom_wac *wacom,=
 size_t len)
>>         return 0;
>>  }
>>
>> +static int wacom_offset_rotation(struct input_dev *input, struct hid_us=
age *usage,
>> +                                int value, int num, int denom)
>> +{
>> +       struct input_absinfo *abs =3D &input->absinfo[usage->code];
>> +       int range =3D (abs->maximum - abs->minimum + 1);
>> +
>> +       value +=3D num*range/denom;
>> +       if (value > abs->maximum)
>> +               value -=3D range;
>> +       else if (value < abs->minimum)
>> +               value +=3D range;
>> +       return value;
>> +}
>> +
>>  int wacom_equivalent_usage(int usage)
>>  {
>>         if ((usage & HID_USAGE_PAGE) =3D=3D WACOM_HID_UP_WACOMDIGITIZER)=
 {
>> @@ -1898,6 +1912,7 @@ static void wacom_wac_pad_event(struct hid_device =
*hdev, struct hid_field *field
>>         unsigned equivalent_usage =3D wacom_equivalent_usage(usage->hid)=
;
>>         int i;
>>         bool is_touch_on =3D value;
>> +       bool do_report =3D false;
>>
>>         /*
>>          * Avoid reporting this event and setting inrange_state if this =
usage
>> @@ -1912,6 +1927,29 @@ static void wacom_wac_pad_event(struct hid_device=
 *hdev, struct hid_field *field
>>         }
>>
>>         switch (equivalent_usage) {
>> +       case WACOM_HID_WD_TOUCHRING:
>> +               /*
>> +                * Userspace expects touchrings to increase in value wit=
h
>> +                * clockwise gestures and have their zero point at the
>> +                * tablet's left. HID events "should" be clockwise-
>> +                * increasing and zero at top, though the MobileStudio
>> +                * Pro and 2nd-gen Intuos Pro don't do this...
>> +                */
>> +               if (hdev->vendor =3D=3D 0x56a &&
>> +                   (hdev->product =3D=3D 0x34d || hdev->product =3D=3D =
0x34e ||  /* MobileStudio Pro */
>> +                    hdev->product =3D=3D 0x357 || hdev->product =3D=3D =
0x358)) { /* Intuos Pro 2 */
>> +                       value =3D (field->logical_maximum - value);
>> +
>> +                       if (hdev->product =3D=3D 0x357 || hdev->product =
=3D=3D 0x358)
>> +                               value =3D wacom_offset_rotation(input, u=
sage, value, 3, 16);
>> +                       else if (hdev->product =3D=3D 0x34d || hdev->pro=
duct =3D=3D 0x34e)
>> +                               value =3D wacom_offset_rotation(input, u=
sage, value, 1, 2);
>> +               }
>> +               else {
>> +                       value =3D wacom_offset_rotation(input, usage, va=
lue, 1, 4);
>> +               }
>> +               do_report =3D true;
>> +               break;
>>         case WACOM_HID_WD_TOUCHRINGSTATUS:
>>                 if (!value)
>>                         input_event(input, usage->type, usage->code, 0);
>> @@ -1945,10 +1983,14 @@ static void wacom_wac_pad_event(struct hid_devic=
e *hdev, struct hid_field *field
>>                                          value, i);
>>                  /* fall through*/
>>         default:
>> +               do_report =3D true;
>> +               break;
>> +       }
>> +
>> +       if (do_report) {
>>                 input_event(input, usage->type, usage->code, value);
>>                 if (value)
>>                         wacom_wac->hid_data.pad_input_event_flag =3D tru=
e;
>> -               break;
>>         }
>>  }
>>
>> @@ -2089,6 +2131,14 @@ static void wacom_wac_pen_event(struct hid_device=
 *hdev, struct hid_field *field
>>                 wacom_wac->serial[0] =3D (wacom_wac->serial[0] & ~0xFFFF=
FFFFULL);
>>                 wacom_wac->serial[0] |=3D (__u32)value;
>>                 return;
>> +       case HID_DG_TWIST:
>> +               /*
>> +                * Userspace expects pen twist to have its zero point wh=
en
>> +                * the buttons/finger is on the tablet's left. HID value=
s
>> +                * are zero when buttons are toward the top.
>> +                */
>> +               value =3D wacom_offset_rotation(input, usage, value, 1, =
4);
>> +               break;
>>         case WACOM_HID_WD_SENSE:
>>                 wacom_wac->hid_data.sense_state =3D value;
>>                 return;
>> --
>> 2.14.1
>>
