From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: sony: Cache the output report for the Dualshock 4
Date: Fri, 17 Jan 2014 18:34:42 +0100
Message-ID: <CANq1E4SB6bWS1qU8mobTVH3oYqT128WxFOd5TyfAOapEgwCX0A@mail.gmail.com>
References: <alpine.DEB.2.10.1401171135240.7355@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38837 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbaAQRem (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 12:34:42 -0500
Received: by mail-ig0-f173.google.com with SMTP id c10so2186663igq.0
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 09:34:42 -0800 (PST)
In-Reply-To: <alpine.DEB.2.10.1401171135240.7355@franz-virtual-machine>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Fri, Jan 17, 2014 at 5:42 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Retrieve and cache the output report for the Dualshock 4 in sony_probe()
> instead of repeatedly walking the report list in the worker function.
>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
>
> ---
>
>  Apply against jikos/hid.git/for-3.14/sony
>
>  drivers/hid/hid-sony.c | 63 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index edffe2c..4d5f6d1 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -298,6 +298,7 @@ static const unsigned int buzz_keymap[] = {
>  struct sony_sc {
>         struct hid_device *hdev;
>         struct led_classdev *leds[MAX_LEDS];
> +       struct hid_report *output_report;
>         unsigned long quirks;
>         struct work_struct state_worker;
>
> @@ -743,26 +744,9 @@ static void dualshock4_state_worker(struct work_struct *work)
>  {
>         struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
>         struct hid_device *hdev = sc->hdev;
> -       struct list_head *head, *list;
> -       struct hid_report *report;
> -       __s32 *value;
> -
> -       list = &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
> -
> -       list_for_each(head, list) {
> -               report = list_entry(head, struct hid_report, list);
> -
> -               /* Report 5 is used to send data to the controller via USB */
> -               if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && report->id == 5)
> -                       break;
> -       }
> -
> -       if (head == list) {
> -               hid_err(hdev, "Dualshock 4 output report not found\n");
> -               return;
> -       }
> +       struct hid_report *report = sc->output_report;
> +       __s32 *value = report->field[0]->value;
>
> -       value = report->field[0]->value;
>         value[0] = 0x03;
>
>  #ifdef CONFIG_SONY_FF
> @@ -822,6 +806,37 @@ static void sony_destroy_ff(struct hid_device *hdev)
>  }
>  #endif
>
> +static int sony_set_output_report(struct sony_sc *sc, int req_id, int req_size)
> +{
> +       struct list_head *head, *list;
> +       struct hid_report *report;
> +       struct hid_device *hdev = sc->hdev;
> +
> +       list = &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
> +
> +       list_for_each(head, list) {
> +               report = list_entry(head, struct hid_report, list);
> +
> +               if (report->id == req_id) {
> +                       if (report->size != req_size) {
> +                               hid_err(hdev, "Requested size of output report 0x%02x (%i bits) does not match actual size (%i bits)\n",
> +                                       req_id, req_size, report->size);
> +                               return -1;

-1 is not a valid error code, please use -EINVAL (or something else if
it's not appropriate). Furthermore, are you sure you don't want to
change the "report->size != req_size" to "report->size < req_size"? In
case any future device supports a bigger report. The send will then
still work as we just set the current state.

> +                       }
> +                       sc->output_report = report;
> +                       break;

Change this to "return 0;" so you can remove the "if (head == list)"
below and just do a "return -EINVAL;". If you don't like this, at
least change the -1 below to -EINVAL.

> +               }
> +       }
> +
> +       if (head == list) {
> +               hid_err(hdev, "Unable to locate output report 0x%02x\n",
> +                       req_id);
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
>  static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  {
>         int ret;
> @@ -858,6 +873,16 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 return ret;
>         }
>
> +       if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
> +               /* Report 0x05 (31 bytes) is used to send data to the controller via USB */
> +               ret = sony_set_output_report(sc, 0x05, 248);

Could you move this into the "else if (sc->quirks & DUALSHO...)"
below? Makes the code a lot simpler. And just move the "if (ret < 0)"
from below directly into this if() clause so the "else" is not needed.
So you end up with something like this:

else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
    ret = sixaxis_set_operational_bt(hdev);
else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
    /* Report 0x05 (31 bytes) is used to send data to the controller via USB */
    ret = sony_set_output_report(sc, 0x05, 248);
    if (ret < 0)
        goto err_stop;
    INIT_WORK(&sc->state_worker, dualshock4_state_worker);
} else {
    ret = 0;
}


Otherwise looks good. Thanks for the cleanup!
David

> +       } else {
> +               ret = 0;
> +       }
> +
> +       if (ret < 0)
> +               goto err_stop;
> +
>         if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
>                 hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
>                 ret = sixaxis_set_operational_usb(hdev);
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
