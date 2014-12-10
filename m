From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 3/3] HID: wacom: Report input events for each finger on
 generic devices
Date: Wed, 10 Dec 2014 15:25:52 -0500
Message-ID: <CAN+gG=Et-WHZcgLT2GRRJ8GKDt3E6D1yEwezotrJ=Bzd+dhMdg@mail.gmail.com>
References: <1417815453-10618-1-git-send-email-killertofu@gmail.com>
	<1417815453-10618-2-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:53501 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933208AbaLJUZx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Dec 2014 15:25:53 -0500
Received: by mail-qg0-f54.google.com with SMTP id l89so2768113qgf.27
        for <linux-input@vger.kernel.org>; Wed, 10 Dec 2014 12:25:52 -0800 (PST)
In-Reply-To: <1417815453-10618-2-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>

On Fri, Dec 5, 2014 at 4:37 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> The existing generic touch code only reports events after reading an
> entire HID report, which practically means that only data about the last
> contact in a report will ever be provided to userspace. This patch uses
> a trick from hid-multitouch.c to discover what type of field is at the
> end of each contact; when such a field is encountered all the stored
> contact data will be reported.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---

Thanks for the v2 Jason.

I think we are closes to it. I have some comments on the style, but
now that I have read it more carefully, I have a better idea of it,
and the patch is not so scary.

Jiri. If you reviewed it and took it, that's fine. If not, then I
think there is still room for improvements.

Cheers,
Benjamin

> Changes from v1:
>  * Patch renamed from "HID: wacom: Report input events immediately upon receipt"
>  * Instead of reporting on-reciept, events are bundled and sent at the end of each contact
>  * Adds code to discover 'last_slot_field' based on hid-multitouch.c implementation
>
>  drivers/hid/wacom_wac.c | 94 ++++++++++++++++++++++++++++++++-----------------
>  drivers/hid/wacom_wac.h |  1 +
>  2 files changed, 63 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index c33f889..75fc16e 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1381,35 +1381,68 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
>  {
>         struct wacom *wacom = hid_get_drvdata(hdev);
>         struct wacom_wac *wacom_wac = &wacom->wacom_wac;
> -       unsigned touch_max = wacom_wac->features.touch_max;

not sure we really need to remove the temporary variable touch_max here.

> +       struct wacom_features *features = &wacom_wac->features;
>
>         switch (usage->hid) {
>         case HID_GD_X:
> -               if (touch_max == 1)
> +               features->last_slot_field = usage->hid;
> +               if (features->touch_max == 1)

these changes (touchmax => features->touch_max) hinder a little bit
the actual change, that is worrisome :)

>                         wacom_map_usage(wacom, usage, field, EV_ABS, ABS_X, 4);
>                 else
>                         wacom_map_usage(wacom, usage, field, EV_ABS,
>                                         ABS_MT_POSITION_X, 4);
>                 break;
>         case HID_GD_Y:
> -               if (touch_max == 1)
> +               features->last_slot_field = usage->hid;
> +               if (features->touch_max == 1)
>                         wacom_map_usage(wacom, usage, field, EV_ABS, ABS_Y, 4);
>                 else
>                         wacom_map_usage(wacom, usage, field, EV_ABS,
>                                         ABS_MT_POSITION_Y, 4);
>                 break;
>         case HID_DG_CONTACTID:
> +               features->last_slot_field = usage->hid;
>                 break;
>         case HID_DG_INRANGE:
> +               features->last_slot_field = usage->hid;
>                 break;
>         case HID_DG_INVERT:
> +               features->last_slot_field = usage->hid;
>                 break;
>         case HID_DG_TIPSWITCH:
> +               features->last_slot_field = usage->hid;
>                 wacom_map_usage(wacom, usage, field, EV_KEY, BTN_TOUCH, 0);
>                 break;
>         }
>  }
>
> +static void wacom_wac_finger_slot(struct wacom_wac *wacom_wac,
> +               struct input_dev *input)
> +{
> +       struct hid_data *hid_data = &wacom_wac->hid_data;
> +       bool mt = wacom_wac->features.touch_max > 1;
> +       bool prox = hid_data->tipswitch &&
> +                   !wacom_wac->shared->stylus_in_proximity;
> +
> +       if (mt) {

Personal taste. I don't like the "if (mt)" approach in this patch. I
preferred the old approach:
if (mt)
    wacom_wac_finger_mt_slot()
else
    wacom_wac_finger_touch()

i.e. one function per case.

> +               int slot;
> +
> +               slot = input_mt_get_slot_by_key(input, hid_data->id);
> +               input_mt_slot(input, slot);
> +               input_mt_report_slot_state(input, MT_TOOL_FINGER, prox);
> +       }
> +       else {
> +               input_report_key(input, BTN_TOUCH, prox);
> +       }
> +
> +       if (prox) {
> +               input_report_abs(input, mt ? ABS_MT_POSITION_X : ABS_X,
> +                                hid_data->x);
> +               input_report_abs(input, mt ? ABS_MT_POSITION_Y : ABS_Y,
> +                                hid_data->y);
> +       }
> +}
> +
>  static int wacom_wac_finger_event(struct hid_device *hdev,
>                 struct hid_field *field, struct hid_usage *usage, __s32 value)
>  {
> @@ -1432,36 +1465,35 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
>         }
>
>
> +       if (usage->usage_index + 1 == field->report_count) {
> +               if (usage->hid == wacom_wac->features.last_slot_field)

OK, I think it would be fair to assume that the FW guys will send N
full touches by report. IIRC, I had the case where sometimes they add
some random axis in the end (like X or Y), just to make me cry :)
should be good here though (and we can have access to the FW guys if
they do something too much funny :-P )

> +                       wacom_wac_finger_slot(wacom_wac, wacom_wac->input);
> +       }
> +
>         return 0;
>  }
>
> -static void wacom_wac_finger_mt_report(struct wacom_wac *wacom_wac,
> -               struct input_dev *input, bool touch)
> +static int wacom_wac_finger_touches(struct hid_device *hdev)

It took me a while to understand what this function was. It simply
returns the number of touches that has been recorded in the report (I
was mislead by the git diff I think).
We should rename this in something else
(wacom_wac_finger_get_touches_count or something better - I am bad at
naming things).

Second question, why the need to return the touch count?

>  {
> -       int slot;
> -       struct hid_data *hid_data = &wacom_wac->hid_data;
> +       struct wacom *wacom = hid_get_drvdata(hdev);
> +       struct wacom_wac *wacom_wac = &wacom->wacom_wac;
> +       struct input_dev *input = wacom_wac->input;
> +       unsigned touch_max = wacom_wac->features.touch_max;
> +       int count = 0;
> +       int i;
>
> -       slot = input_mt_get_slot_by_key(input, hid_data->id);
> +       if (touch_max == 1)
> +               return wacom_wac->hid_data.tipswitch &&
> +                      !wacom_wac->shared->stylus_in_proximity;
>
> -       input_mt_slot(input, slot);
> -       input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
> -       if (touch) {
> -               input_report_abs(input, ABS_MT_POSITION_X, hid_data->x);
> -               input_report_abs(input, ABS_MT_POSITION_Y, hid_data->y);
> +       for (i = 0; i < input->mt->num_slots; i++) {
> +               struct input_mt_slot *ps = &input->mt->slots[i];
> +               int id = input_mt_get_value(ps, ABS_MT_TRACKING_ID);
> +               if (id >= 0)
> +                       count++;
>         }
> -       input_mt_sync_frame(input);
> -}
> -
> -static void wacom_wac_finger_single_touch_report(struct wacom_wac *wacom_wac,
> -               struct input_dev *input, bool touch)
> -{
> -       struct hid_data *hid_data = &wacom_wac->hid_data;
>
> -       if (touch) {
> -               input_report_abs(input, ABS_X, hid_data->x);
> -               input_report_abs(input, ABS_Y, hid_data->y);
> -       }
> -       input_report_key(input, BTN_TOUCH, touch);
> +       return count;
>  }
>
>  static void wacom_wac_finger_report(struct hid_device *hdev,
> @@ -1470,18 +1502,16 @@ static void wacom_wac_finger_report(struct hid_device *hdev,
>         struct wacom *wacom = hid_get_drvdata(hdev);
>         struct wacom_wac *wacom_wac = &wacom->wacom_wac;
>         struct input_dev *input = wacom_wac->input;
> -       bool touch = wacom_wac->hid_data.tipswitch &&
> -                    !wacom_wac->shared->stylus_in_proximity;
> -       unsigned touch_max = wacom_wac->features.touch_max;
>
> -       if (touch_max > 1)
> -               wacom_wac_finger_mt_report(wacom_wac, input, touch);
> +       if (wacom_wac->features.touch_max > 1)

I think removing the touch_max variable hides a little bit the changes too.

> +               input_mt_sync_frame(input);
>         else
> -               wacom_wac_finger_single_touch_report(wacom_wac, input, touch);
> +               wacom_wac_finger_slot(wacom_wac, input);

Not sure there is a need to call wacom_wac_finger_slot() for single
touch devices. Your current implementation in wacom_finger_event
should match also single finger tablets.

> +
>         input_sync(input);
>
>         /* keep touch state for pen event */
> -       wacom_wac->shared->touch_down = touch;
> +       wacom_wac->shared->touch_down = wacom_wac_finger_touches(hdev);
>  }
>
>  #define WACOM_PEN_FIELD(f)     (((f)->logical == HID_DG_STYLUS) || \
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 128cbb3..6e256206 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -144,6 +144,7 @@ struct wacom_features {
>         int pktlen;
>         bool check_for_hid_type;
>         int hid_type;
> +       int last_slot_field;
>  };
>
>  struct wacom_shared {
> --
> 2.1.3
>
