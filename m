From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH] HID: hid-multitouch: support fine-grain orientation reporting
Date: Tue, 26 Sep 2017 22:55:26 -0700
Message-ID: <CAE_wzQ-o8R5+6pr64qpd8+xZ7P0s_Nfj7puo6sXJqSFsziQ2Uw@mail.gmail.com>
References: <20170927030312.5573-1-wnhuang@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:50768 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbdI0Fzb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 27 Sep 2017 01:55:31 -0400
Received: by mail-lf0-f49.google.com with SMTP id d4so6594285lfj.7
        for <linux-input@vger.kernel.org>; Tue, 26 Sep 2017 22:55:30 -0700 (PDT)
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com. [209.85.215.45])
        by smtp.gmail.com with ESMTPSA id t4sm2174482ljb.14.2017.09.26.22.55.27
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2017 22:55:27 -0700 (PDT)
Received: by mail-lf0-f45.google.com with SMTP id l196so6561269lfl.1
        for <linux-input@vger.kernel.org>; Tue, 26 Sep 2017 22:55:27 -0700 (PDT)
In-Reply-To: <20170927030312.5573-1-wnhuang@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei-Ning Huang <wnhuang@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@chromium.org>, Jiri Kosina <jikos@kernel.org>, Wei-Ning Huang <wnhuang@google.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, rydberg@bitmath.org

Hi Wei-Ning,

On Tue, Sep 26, 2017 at 8:03 PM, Wei-Ning Huang <wnhuang@chromium.org> wrote:
>
> The current hid-multitouch driver only allow the report of two
> orientations, vertical and horizontal. We use the Azimuth orientation
> usage 0x5b under the Digitizer usage page to report orientation directly
> from the hid device. A new quirk MT_QUIRK_REPORT_ORIENTATION is added so
> user can enable this only if their device supports it.

The patch description is stale, there is no quirk anymore, and the
usage is 0x3f.

>
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  drivers/hid/hid-multitouch.c | 38 ++++++++++++++++++++++++++++++++++++--
>  include/linux/hid.h          |  1 +
>  2 files changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 440b999304a5..4663bf4b2892 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -84,11 +84,12 @@ MODULE_LICENSE("GPL");
>  #define MT_IO_FLAGS_PENDING_SLOTS      2
>
>  struct mt_slot {
> -       __s32 x, y, cx, cy, p, w, h;
> +       __s32 x, y, cx, cy, p, w, h, a;
>         __s32 contactid;        /* the device ContactID assigned to this slot */
>         bool touch_state;       /* is the touch valid? */
>         bool inrange_state;     /* is the finger in proximity of the sensor? */
>         bool confidence_state;  /* is the touch made by a finger? */
> +       bool has_azimuth;       /* the contact reports azimuth */
>  };
>
>  struct mt_class {
> @@ -591,6 +592,23 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>                         td->cc_index = field->index;
>                         td->cc_value_index = usage->usage_index;
>                         return 1;
> +               case HID_DG_AZIMUTH:
> +                       hid_map_usage(hi, usage, bit, max,
> +                               EV_ABS, ABS_MT_ORIENTATION);
> +                       /*
> +                        * Azimuth has the range of [0, MAX) representing a full
> +                        * revolution. Set ABS_MT_ORIENTATION to a quarter of
> +                        * MAX according the definition of ABS_MT_ORIENTATION
> +                        */
> +                       input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
> +                               0, field->logical_maximum / 4,
> +                               cls->sn_move ?
> +                               field->logical_maximum / cls->sn_move : 0, 0);
> +                       input_abs_set_res(hi->input, ABS_MT_ORIENTATION,
> +                               hidinput_calc_abs_res(field,
> +                                       ABS_MT_ORIENTATION));

I do not think resolution makes sense for ABS_MT_ORIENTATION. The MAX
always corresponds to 90 degrees.

> +                       mt_store_field(usage, td, hi);
> +                       return 1;
>                 case HID_DG_CONTACTMAX:
>                         /* we don't set td->last_slot_field as contactcount and
>                          * contact max are global to the report */
> @@ -683,6 +701,10 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>                         int wide = (s->w > s->h);
>                         int major = max(s->w, s->h);
>                         int minor = min(s->w, s->h);
> +                       int orientation = wide;
> +
> +                       if (s->has_azimuth)
> +                               orientation = s->a;
>
>                         /*
>                          * divided by two to match visual scale of touch
> @@ -699,7 +721,8 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
>                         input_event(input, EV_ABS, ABS_MT_TOOL_Y, s->cy);
>                         input_event(input, EV_ABS, ABS_MT_DISTANCE,
>                                 !s->touch_state);
> -                       input_event(input, EV_ABS, ABS_MT_ORIENTATION, wide);
> +                       input_event(input, EV_ABS, ABS_MT_ORIENTATION,
> +                               orientation);
>                         input_event(input, EV_ABS, ABS_MT_PRESSURE, s->p);
>                         input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
>                         input_event(input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
> @@ -789,6 +812,17 @@ static void mt_process_mt_event(struct hid_device *hid, struct hid_field *field,
>                         break;
>                 case HID_DG_CONTACTCOUNT:
>                         break;
> +               case HID_DG_AZIMUTH:
> +                       /*
> +                        * Azimuth is counter-clockwise and ranges from [0, MAX)
> +                        * (a full revolution). Convert it to clockwise ranging
> +                        * [-MAX/2, MAX/2].

Benjamin, Henrik, have you worked with devices reporting azimuth? I
assume MS HID spec uses 0 to represent due North, same as we have in
Linux:

https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/supporting-usages-in-digitizer-report-descriptors

> +                        */
> +                       if (value > field->logical_maximum / 2)
> +                               value -= field->logical_maximum;
> +                       td->curdata.a = -value;
> +                       td->curdata.has_azimuth = true;
> +                       break;
>                 case HID_DG_TOUCH:
>                         /* do nothing */
>                         break;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ab05a86269dc..d81b9b6fd83a 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -281,6 +281,7 @@ struct hid_item {
>
>  #define HID_DG_DEVICECONFIG    0x000d000e
>  #define HID_DG_DEVICESETTINGS  0x000d0023
> +#define HID_DG_AZIMUTH         0x000d003f
>  #define HID_DG_CONFIDENCE      0x000d0047
>  #define HID_DG_WIDTH           0x000d0048
>  #define HID_DG_HEIGHT          0x000d0049
> --
> 2.12.2
>

Thanks,
Dmitry
