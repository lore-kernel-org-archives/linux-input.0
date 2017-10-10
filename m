From: Wei-Ning Huang <wnhuang@google.com>
Subject: Re: [PATCH v3] HID: hid-multitouch: support fine-grain orientation reporting
Date: Tue, 10 Oct 2017 12:22:01 +0800
Message-ID: <CABicQ-XBBKOe0MiV-kDm2c5SsrF9s-e73P-kuEr8+8kZmpyi6Q@mail.gmail.com>
References: <20170928094234.7270-1-wnhuang@google.com> <nycvar.YFH.7.76.1710051133530.14384@jbgna.fhfr.qr>
 <20171006081339.GD865@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:44363 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdJJEWD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Oct 2017 00:22:03 -0400
Received: by mail-oi0-f48.google.com with SMTP id v132so23755643oie.1
        for <linux-input@vger.kernel.org>; Mon, 09 Oct 2017 21:22:03 -0700 (PDT)
In-Reply-To: <20171006081339.GD865@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@chromium.org>

Hi Benjamin,

Thanks for the review. I've fixed according to your comments and sent
the v4 patch:
https://patchwork.kernel.org/patch/9995003/

Wei-Ning

On Fri, Oct 6, 2017 at 4:13 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> Hi,
>
> On Oct 05 2017 or thereabouts, Jiri Kosina wrote:
>>
>> [ adding Benjamin to CC ]
>>
>> On Thu, 28 Sep 2017, Wei-Ning Huang wrote:
>>
>> > The current hid-multitouch driver only allow the report of two
>> > orientations, vertical and horizontal. We use the Azimuth orientation
>> > usage 0x3F under the Digitizer usage page to report orientation if the
>> > device supports it.
>> >
>> > Changelog:
>> >   v1 -> v2:
>> >    - Fix commit message.
>> >    - Remove resolution reporting for ABS_MT_ORIENTATION.
>> >   v2 -> v3:
>> >    - Fix commit message.
>> >
>> > Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
>> > Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
>> > ---
>> >  drivers/hid/hid-multitouch.c | 35 +++++++++++++++++++++++++++++++++--
>> >  include/linux/hid.h          |  1 +
>> >  2 files changed, 34 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch=
.c
>> > index 440b999304a5..f9801d1b1eae 100644
>> > --- a/drivers/hid/hid-multitouch.c
>> > +++ b/drivers/hid/hid-multitouch.c
>> > @@ -84,11 +84,12 @@ MODULE_LICENSE("GPL");
>> >  #define MT_IO_FLAGS_PENDING_SLOTS  2
>> >
>> >  struct mt_slot {
>> > -   __s32 x, y, cx, cy, p, w, h;
>> > +   __s32 x, y, cx, cy, p, w, h, a;
>> >     __s32 contactid;        /* the device ContactID assigned to this s=
lot */
>> >     bool touch_state;       /* is the touch valid? */
>> >     bool inrange_state;     /* is the finger in proximity of the senso=
r? */
>> >     bool confidence_state;  /* is the touch made by a finger? */
>> > +   bool has_azimuth;       /* the contact reports azimuth */
>> >  };
>> >
>> >  struct mt_class {
>> > @@ -591,6 +592,20 @@ static int mt_touch_input_mapping(struct hid_devi=
ce *hdev, struct hid_input *hi,
>> >                     td->cc_index =3D field->index;
>> >                     td->cc_value_index =3D usage->usage_index;
>> >                     return 1;
>> > +           case HID_DG_AZIMUTH:
>> > +                   hid_map_usage(hi, usage, bit, max,
>> > +                           EV_ABS, ABS_MT_ORIENTATION);
>> > +                   /*
>> > +                    * Azimuth has the range of [0, MAX) representing =
a full
>> > +                    * revolution. Set ABS_MT_ORIENTATION to a quarter=
 of
>> > +                    * MAX according the definition of ABS_MT_ORIENTAT=
ION
>> > +                    */
>> > +                   input_set_abs_params(hi->input, ABS_MT_ORIENTATION=
,
>> > +                           0, field->logical_maximum / 4,
>
> Shouldn't this be "-field->logical_maximum / 4, field->logical_maximum / =
4,"?
>
> Also, if HID_DG_HEIGHT is seen after HID_DG_AZIMUTH, it'll change the
> ABS_MT_ORIENTATION you just set here.
>
>> > +                           cls->sn_move ?
>> > +                           field->logical_maximum / cls->sn_move : 0,=
 0);
>> > +                   mt_store_field(usage, td, hi);
>> > +                   return 1;
>> >             case HID_DG_CONTACTMAX:
>> >                     /* we don't set td->last_slot_field as contactcoun=
t and
>> >                      * contact max are global to the report */
>> > @@ -683,6 +698,10 @@ static void mt_complete_slot(struct mt_device *td=
, struct input_dev *input)
>> >                     int wide =3D (s->w > s->h);
>> >                     int major =3D max(s->w, s->h);
>> >                     int minor =3D min(s->w, s->h);
>> > +                   int orientation =3D wide;
>> > +
>> > +                   if (s->has_azimuth)
>> > +                           orientation =3D s->a;
>> >
>> >                     /*
>> >                      * divided by two to match visual scale of touch
>> > @@ -699,7 +718,8 @@ static void mt_complete_slot(struct mt_device *td,=
 struct input_dev *input)
>> >                     input_event(input, EV_ABS, ABS_MT_TOOL_Y, s->cy);
>> >                     input_event(input, EV_ABS, ABS_MT_DISTANCE,
>> >                             !s->touch_state);
>> > -                   input_event(input, EV_ABS, ABS_MT_ORIENTATION, wid=
e);
>> > +                   input_event(input, EV_ABS, ABS_MT_ORIENTATION,
>> > +                           orientation);
>> >                     input_event(input, EV_ABS, ABS_MT_PRESSURE, s->p);
>> >                     input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, maj=
or);
>> >                     input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, min=
or);
>> > @@ -789,6 +809,17 @@ static void mt_process_mt_event(struct hid_device=
 *hid, struct hid_field *field,
>> >                     break;
>> >             case HID_DG_CONTACTCOUNT:
>> >                     break;
>> > +           case HID_DG_AZIMUTH:
>> > +                   /*
>> > +                    * Azimuth is counter-clockwise and ranges from [0=
, MAX)
>> > +                    * (a full revolution). Convert it to clockwise ra=
nging
>> > +                    * [-MAX/2, MAX/2].
>
> It took me a while to get this right. The problem is the definition of
> ABS_MT_ORIENTATION says that we report [-MAX/4, MAX/4], *but* we can go
> out of range to [-MAX/2, MAX/2] to report upside down ellipsis.
>
> So this is correct, but I'd like to have some mention of [-MAX/4, MAX/4]
> in this comment, to ease further rereading of the code.
>
> Cheers,
> Benjamin
>
>> > +                    */
>> > +                   if (value > field->logical_maximum / 2)
>> > +                           value -=3D field->logical_maximum;
>> > +                   td->curdata.a =3D -value;
>> > +                   td->curdata.has_azimuth =3D true;
>> > +                   break;
>> >             case HID_DG_TOUCH:
>> >                     /* do nothing */
>> >                     break;
>> > diff --git a/include/linux/hid.h b/include/linux/hid.h
>> > index ab05a86269dc..d81b9b6fd83a 100644
>> > --- a/include/linux/hid.h
>> > +++ b/include/linux/hid.h
>> > @@ -281,6 +281,7 @@ struct hid_item {
>> >
>> >  #define HID_DG_DEVICECONFIG        0x000d000e
>> >  #define HID_DG_DEVICESETTINGS      0x000d0023
>> > +#define HID_DG_AZIMUTH             0x000d003f
>> >  #define HID_DG_CONFIDENCE  0x000d0047
>> >  #define HID_DG_WIDTH               0x000d0048
>> >  #define HID_DG_HEIGHT              0x000d0049
>> > --
>> > 2.12.2
>> >
>>
>> --
>> Jiri Kosina
>> SUSE Labs
>>



--=20
Wei-Ning Huang, =E9=BB=83=E5=81=89=E5=AF=A7 | Software Engineer, Google Inc=
., Taiwan |
wnhuang@google.com | Cell: +886 910-380678
