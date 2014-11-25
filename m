From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 3/3] HID: wacom: Report input events immediately upon receipt
Date: Tue, 25 Nov 2014 10:52:58 -0500
Message-ID: <CAN+gG=Gt=9F24FA=mCpszyXNOR3=nJRPA2Pu1_ich6WsJXrzjQ@mail.gmail.com>
References: <1416871934-14133-1-git-send-email-killertofu@gmail.com>
	<1416871934-14133-4-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:34518 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbaKYPw7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2014 10:52:59 -0500
Received: by mail-qa0-f54.google.com with SMTP id i13so556026qae.41
        for <linux-input@vger.kernel.org>; Tue, 25 Nov 2014 07:52:58 -0800 (PST)
In-Reply-To: <1416871934-14133-4-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>

Hi Jason,

On Mon, Nov 24, 2014 at 6:32 PM, Jason Gerecke <killertofu@gmail.com> wrote:
> Multitouch tablets cannot work properly if wacom_wac_finger_event simply
> stores the event details, since details about former fingers will be
> overwritten by later ones (causing wacom_wac_finger_report to effectively
> only report the state of the *last* finger in the packet).
>
> This patch modifies the logic so that events are generated as soon as
> possible in response to events. We do temporarily store HID_DG_TIPSWITCH
> value since the value of HID_DG_CONTACTID is (at least in for the tablets
> I've tested) not known until shortly afterwards.
>

OK, so, I don't like this one either :-(

I perfectly understand that the previous code worked in the only case
where there is only one contact per report. But this patch assumes
that the contact ID will come right after the tip switch if I
understood correctly. This assumption may strike back in the future
(like mine did), so we should be smarter.

In hid-multitouch, we count the total number of mt fields, then divide
by the number of time we see ContactID. This gives us the number of
fields per touch, and we then have a hook called when we reach this
number of fields while processing the report.
It's not perfect, but it's generic.

If you have a better idea, I am all ears, but unless the FW guys can
give us some guarantees regarding the HID descriptor*, I think we
should go for the most generic possible solution.

BTW, what I dislike here is that I am pretty sure that if we take this
one, we will have to revert part of it to have a 2-steps processing.
Relying on the order of the hid fields is simply not possible in the
long term.

Cheers,
Benjamin

* even if they give some guarantees, I am not sure I will trust them :)

> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
>  drivers/hid/wacom_wac.c | 77 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 44 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index a55e0ed..3eaa98a 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1412,19 +1412,40 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
>  {
>         struct wacom *wacom = hid_get_drvdata(hdev);
>         struct wacom_wac *wacom_wac = &wacom->wacom_wac;
> +       struct hid_data *data = &wacom_wac->hid_data;
> +       unsigned mt = wacom_wac->features.touch_max > 1;
> +       struct input_dev *input = wacom_wac->input;
> +       bool prox = data->tipswitch && !wacom_wac->shared->stylus_in_proximity;
> +       int slot;
>
>         switch (usage->hid) {
>         case HID_GD_X:
> -               wacom_wac->hid_data.x = value;
> +               if (prox) {
> +                       input_report_abs(input,
> +                                        mt ? ABS_MT_POSITION_X : ABS_X,
> +                                        value);
> +               }
>                 break;
>         case HID_GD_Y:
> -               wacom_wac->hid_data.y = value;
> +               if (prox) {
> +                       input_report_abs(input,
> +                                        mt ? ABS_MT_POSITION_Y : ABS_Y,
> +                                        value);
> +               }
>                 break;
>         case HID_DG_CONTACTID:
> -               wacom_wac->hid_data.id = value;
> +               slot = input_mt_get_slot_by_key(input, value);
> +
> +               input_mt_slot(input, slot);
> +               input_mt_report_slot_state(input, MT_TOOL_FINGER, prox);
>                 break;
>         case HID_DG_TIPSWITCH:
> -               wacom_wac->hid_data.tipswitch = value;
> +               data->tipswitch = value;
> +               if (!mt) {
> +                       prox = data->tipswitch &&
> +                             !wacom_wac->shared->stylus_in_proximity;
> +                       input_report_key(input, BTN_TOUCH, prox);
> +               }
>                 break;
>         }
>
> @@ -1432,33 +1453,26 @@ static int wacom_wac_finger_event(struct hid_device *hdev,
>         return 0;
>  }
>
> -static void wacom_wac_finger_mt_report(struct wacom_wac *wacom_wac,
> -               struct input_dev *input, bool touch)
> +static int wacom_wac_finger_touches(struct hid_device *hdev)
>  {
> -       int slot;
> -       struct hid_data *hid_data = &wacom_wac->hid_data;
> -
> -       slot = input_mt_get_slot_by_key(input, hid_data->id);
> -
> -       input_mt_slot(input, slot);
> -       input_mt_report_slot_state(input, MT_TOOL_FINGER, touch);
> -       if (touch) {
> -               input_report_abs(input, ABS_MT_POSITION_X, hid_data->x);
> -               input_report_abs(input, ABS_MT_POSITION_Y, hid_data->y);
> -       }
> -       input_mt_sync_frame(input);
> -}
> +       struct wacom *wacom = hid_get_drvdata(hdev);
> +       struct wacom_wac *wacom_wac = &wacom->wacom_wac;
> +       struct input_dev *input = wacom_wac->input;
> +       unsigned touch_max = wacom_wac->features.touch_max;
> +       int count = 0;
> +       int i;
>
> -static void wacom_wac_finger_single_touch_report(struct wacom_wac *wacom_wac,
> -               struct input_dev *input, bool touch)
> -{
> -       struct hid_data *hid_data = &wacom_wac->hid_data;
> +       if (touch_max == 1)
> +               return (wacom_wac->hid_data.tipswitch &&
> +                      !wacom_wac->shared->stylus_in_proximity);
>
> -       if (touch) {
> -               input_report_abs(input, ABS_X, hid_data->x);
> -               input_report_abs(input, ABS_Y, hid_data->y);
> +       for (i = 0; i < input->mt->num_slots; i++) {
> +               struct input_mt_slot *ps = &input->mt->slots[i];
> +               int id = input_mt_get_value(ps, ABS_MT_TRACKING_ID);
> +               if (id >= 0)
> +                       count++;
>         }
> -       input_report_key(input, BTN_TOUCH, touch);
> +       return count;
>  }
>
>  static void wacom_wac_finger_report(struct hid_device *hdev,
> @@ -1467,18 +1481,15 @@ static void wacom_wac_finger_report(struct hid_device *hdev,
>         struct wacom *wacom = hid_get_drvdata(hdev);
>         struct wacom_wac *wacom_wac = &wacom->wacom_wac;
>         struct input_dev *input = wacom_wac->input;
> -       bool touch = wacom_wac->hid_data.tipswitch &&
> -                    !wacom_wac->shared->stylus_in_proximity;
>         unsigned touch_max = wacom_wac->features.touch_max;
>
>         if (touch_max > 1)
> -               wacom_wac_finger_mt_report(wacom_wac, input, touch);
> -       else
> -               wacom_wac_finger_single_touch_report(wacom_wac, input, touch);
> +               input_mt_sync_frame(input);
> +
>         input_sync(input);
>
>         /* keep touch state for pen event */
> -       wacom_wac->shared->touch_down = touch;
> +       wacom_wac->shared->touch_down = wacom_wac_finger_touches(hdev);
>  }
>
>  #define WACOM_PEN_FIELD(f)     (((f)->logical == HID_DG_STYLUS) || \
> --
> 2.1.3
>
