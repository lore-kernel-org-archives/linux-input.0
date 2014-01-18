From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2] HID: sony: Cache the output report for the Dualshock 4
Date: Sat, 18 Jan 2014 11:32:11 +0100
Message-ID: <CANq1E4QH_XbShAMQrCAW46dKkP7wmz6jRjA0+3xE0ag=fhDHQQ@mail.gmail.com>
References: <alpine.DEB.2.10.1401171443040.3454@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:64157 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbaARKk1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jan 2014 05:40:27 -0500
Received: by mail-ie0-f175.google.com with SMTP id ar20so1830462iec.34
        for <linux-input@vger.kernel.org>; Sat, 18 Jan 2014 02:40:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.10.1401171443040.3454@franz-virtual-machine>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Fri, Jan 17, 2014 at 8:46 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Retrieve and cache the output report for the Dualshock 4 in sony_probe()
> instead of repeatedly walking the report list in the worker function.

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
>
> ---
>
>  Apply against jikos/hid.git/for-3.14/sony
>
>  drivers/hid/hid-sony.c | 55 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index edffe2c..277da77 100644
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
> @@ -822,6 +806,33 @@ static void sony_destroy_ff(struct hid_device *hdev)
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
> +                       if (report->size < req_size) {
> +                               hid_err(hdev, "Output report 0x%02x (%i bits) is smaller than requested size (%i bits)\n",
> +                                       req_id, report->size, req_size);
> +                               return -EINVAL;
> +                       }
> +                       sc->output_report = report;
> +                       return 0;
> +               }
> +       }
> +
> +       hid_err(hdev, "Unable to locate output report 0x%02x\n", req_id);
> +
> +       return -EINVAL;
> +}
> +
>  static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  {
>         int ret;
> @@ -866,7 +877,11 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
>                 ret = sixaxis_set_operational_bt(hdev);
>         else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
> -               ret = 0;
> +               /* Report 5 (31 bytes) is used to send data to the controller via USB */
> +               ret = sony_set_output_report(sc, 0x05, 248);
> +               if (ret < 0)
> +                       goto err_stop;
> +
>                 INIT_WORK(&sc->state_worker, dualshock4_state_worker);
>         } else {
>                 ret = 0;
> --
> 1.8.3.2
>
