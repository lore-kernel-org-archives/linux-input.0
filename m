From: Wei-Ning Huang <wnhuang@google.com>
Subject: Re: [PATCH] HID: hid-multitouch: support fine-grain orientation reporting
Date: Thu, 28 Sep 2017 17:25:38 +0800
Message-ID: <CABicQ-UNraLqx-Mu97wiVp0Z5_kY=sNfrSD08OkKHzUjMy-3yg@mail.gmail.com>
References: <20170927030312.5573-1-wnhuang@google.com> <CAE_wzQ-o8R5+6pr64qpd8+xZ7P0s_Nfj7puo6sXJqSFsziQ2Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE_wzQ-o8R5+6pr64qpd8+xZ7P0s_Nfj7puo6sXJqSFsziQ2Uw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, rydberg@bitmath.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

I sent v2 to fix the commit message and orientation. Thanks.
https://patchwork.kernel.org/patch/9975565/

Wei-Ning

On Wed, Sep 27, 2017 at 1:55 PM, Dmitry Torokhov <dtor@chromium.org> wrote:
> Hi Wei-Ning,
>
> On Tue, Sep 26, 2017 at 8:03 PM, Wei-Ning Huang <wnhuang@chromium.org> wr=
ote:
>>
>> The current hid-multitouch driver only allow the report of two
>> orientations, vertical and horizontal. We use the Azimuth orientation
>> usage 0x5b under the Digitizer usage page to report orientation directly
>> from the hid device. A new quirk MT_QUIRK_REPORT_ORIENTATION is added so
>> user can enable this only if their device supports it.
>
> The patch description is stale, there is no quirk anymore, and the
> usage is 0x3f.
>
>>
>> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
>> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
>> ---
>>  drivers/hid/hid-multitouch.c | 38 ++++++++++++++++++++++++++++++++++++-=
-
>>  include/linux/hid.h          |  1 +
>>  2 files changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>> index 440b999304a5..4663bf4b2892 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -84,11 +84,12 @@ MODULE_LICENSE("GPL");
>>  #define MT_IO_FLAGS_PENDING_SLOTS      2
>>
>>  struct mt_slot {
>> -       __s32 x, y, cx, cy, p, w, h;
>> +       __s32 x, y, cx, cy, p, w, h, a;
>>         __s32 contactid;        /* the device ContactID assigned to this=
 slot */
>>         bool touch_state;       /* is the touch valid? */
>>         bool inrange_state;     /* is the finger in proximity of the sen=
sor? */
>>         bool confidence_state;  /* is the touch made by a finger? */
>> +       bool has_azimuth;       /* the contact reports azimuth */
>>  };
>>
>>  struct mt_class {
>> @@ -591,6 +592,23 @@ static int mt_touch_input_mapping(struct hid_device=
 *hdev, struct hid_input *hi,
>>                         td->cc_index =3D field->index;
>>                         td->cc_value_index =3D usage->usage_index;
>>                         return 1;
>> +               case HID_DG_AZIMUTH:
>> +                       hid_map_usage(hi, usage, bit, max,
>> +                               EV_ABS, ABS_MT_ORIENTATION);
>> +                       /*
>> +                        * Azimuth has the range of [0, MAX) representin=
g a full
>> +                        * revolution. Set ABS_MT_ORIENTATION to a quart=
er of
>> +                        * MAX according the definition of ABS_MT_ORIENT=
ATION
>> +                        */
>> +                       input_set_abs_params(hi->input, ABS_MT_ORIENTATI=
ON,
>> +                               0, field->logical_maximum / 4,
>> +                               cls->sn_move ?
>> +                               field->logical_maximum / cls->sn_move : =
0, 0);
>> +                       input_abs_set_res(hi->input, ABS_MT_ORIENTATION,
>> +                               hidinput_calc_abs_res(field,
>> +                                       ABS_MT_ORIENTATION));
>
> I do not think resolution makes sense for ABS_MT_ORIENTATION. The MAX
> always corresponds to 90 degrees.
>
>> +                       mt_store_field(usage, td, hi);
>> +                       return 1;
>>                 case HID_DG_CONTACTMAX:
>>                         /* we don't set td->last_slot_field as contactco=
unt and
>>                          * contact max are global to the report */
>> @@ -683,6 +701,10 @@ static void mt_complete_slot(struct mt_device *td, =
struct input_dev *input)
>>                         int wide =3D (s->w > s->h);
>>                         int major =3D max(s->w, s->h);
>>                         int minor =3D min(s->w, s->h);
>> +                       int orientation =3D wide;
>> +
>> +                       if (s->has_azimuth)
>> +                               orientation =3D s->a;
>>
>>                         /*
>>                          * divided by two to match visual scale of touch
>> @@ -699,7 +721,8 @@ static void mt_complete_slot(struct mt_device *td, s=
truct input_dev *input)
>>                         input_event(input, EV_ABS, ABS_MT_TOOL_Y, s->cy)=
;
>>                         input_event(input, EV_ABS, ABS_MT_DISTANCE,
>>                                 !s->touch_state);
>> -                       input_event(input, EV_ABS, ABS_MT_ORIENTATION, w=
ide);
>> +                       input_event(input, EV_ABS, ABS_MT_ORIENTATION,
>> +                               orientation);
>>                         input_event(input, EV_ABS, ABS_MT_PRESSURE, s->p=
);
>>                         input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, m=
ajor);
>>                         input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, m=
inor);
>> @@ -789,6 +812,17 @@ static void mt_process_mt_event(struct hid_device *=
hid, struct hid_field *field,
>>                         break;
>>                 case HID_DG_CONTACTCOUNT:
>>                         break;
>> +               case HID_DG_AZIMUTH:
>> +                       /*
>> +                        * Azimuth is counter-clockwise and ranges from =
[0, MAX)
>> +                        * (a full revolution). Convert it to clockwise =
ranging
>> +                        * [-MAX/2, MAX/2].
>
> Benjamin, Henrik, have you worked with devices reporting azimuth? I
> assume MS HID spec uses 0 to represent due North, same as we have in
> Linux:
>
> https://docs.microsoft.com/en-us/windows-hardware/design/component-guidel=
ines/supporting-usages-in-digitizer-report-descriptors
>
>> +                        */
>> +                       if (value > field->logical_maximum / 2)
>> +                               value -=3D field->logical_maximum;
>> +                       td->curdata.a =3D -value;
>> +                       td->curdata.has_azimuth =3D true;
>> +                       break;
>>                 case HID_DG_TOUCH:
>>                         /* do nothing */
>>                         break;
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index ab05a86269dc..d81b9b6fd83a 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -281,6 +281,7 @@ struct hid_item {
>>
>>  #define HID_DG_DEVICECONFIG    0x000d000e
>>  #define HID_DG_DEVICESETTINGS  0x000d0023
>> +#define HID_DG_AZIMUTH         0x000d003f
>>  #define HID_DG_CONFIDENCE      0x000d0047
>>  #define HID_DG_WIDTH           0x000d0048
>>  #define HID_DG_HEIGHT          0x000d0049
>> --
>> 2.12.2
>>
>
> Thanks,
> Dmitry



--=20
Wei-Ning Huang, =E9=BB=83=E5=81=89=E5=AF=A7 | Software Engineer, Google Inc=
., Taiwan |
wnhuang@google.com | Cell: +886 910-380678
