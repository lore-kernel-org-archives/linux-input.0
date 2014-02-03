From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2 1/6] HID: sony: Use low-level transport driver functions
Date: Mon, 3 Feb 2014 17:26:20 +0100
Message-ID: <CANq1E4QM_r74PR=hYH8yrybB4O2MUmdKUGf5yPhqVyG5D=wuhA@mail.gmail.com>
References: <1391102648-19381-1-git-send-email-frank.praznik@oh.rr.com>
	<1391102648-19381-2-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34232 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbaBCQ0V (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 11:26:21 -0500
Received: by mail-ie0-f170.google.com with SMTP id u16so6485961iet.1
        for <linux-input@vger.kernel.org>; Mon, 03 Feb 2014 08:26:20 -0800 (PST)
In-Reply-To: <1391102648-19381-2-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Thu, Jan 30, 2014 at 6:24 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> From: Franz Frank Praznik <frank.praznik@oh.rr.com>
>
> Change the dualshock4_state_worker function to use the low-level output_report
> function.
>
> Remove sony_set_output_report since it is no longer used.
>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  drivers/hid/hid-sony.c | 58 ++++++++++++++++----------------------------------
>  1 file changed, 18 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 2bd3f13..7a6d7c9 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -502,7 +502,6 @@ struct sony_sc {
>         spinlock_t lock;
>         struct hid_device *hdev;
>         struct led_classdev *leds[MAX_LEDS];
> -       struct hid_report *output_report;
>         unsigned long quirks;
>         struct work_struct state_worker;
>         struct power_supply battery;
> @@ -1053,21 +1052,26 @@ static void dualshock4_state_worker(struct work_struct *work)
>  {
>         struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
>         struct hid_device *hdev = sc->hdev;
> -       struct hid_report *report = sc->output_report;
> -       __s32 *value = report->field[0]->value;
> +       int offset;
> +
> +       __u8 buf[32] = { 0 };
>
> -       value[0] = 0x03;
> +       buf[0] = 0x05;
> +       buf[1] = 0x03;
> +       offset = 4;
>
>  #ifdef CONFIG_SONY_FF
> -       value[3] = sc->right;
> -       value[4] = sc->left;
> +       buf[offset++] = sc->right;
> +       buf[offset++] = sc->left;
> +#else
> +       offset += 2;
>  #endif
>
> -       value[5] = sc->led_state[0];
> -       value[6] = sc->led_state[1];
> -       value[7] = sc->led_state[2];
> +       buf[offset++] = sc->led_state[0];
> +       buf[offset++] = sc->led_state[1];
> +       buf[offset++] = sc->led_state[2];
>
> -       hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
> +       hdev->ll_driver->output_report(hdev, buf, sizeof(buf));

Ugh? You change SET_REPORT to output_report() here, which is not
supposed to be identical. Are you sure that works? A correct HID
device should accept both, but we're talking about gamepads here..

Thanks
David

>  }
>
>  #ifdef CONFIG_SONY_FF
> @@ -1200,33 +1204,6 @@ static void sony_battery_remove(struct sony_sc *sc)
>         sc->battery.name = NULL;
>  }
>
> -static int sony_set_output_report(struct sony_sc *sc, int req_id, int req_size)
> -{
> -       struct list_head *head, *list;
> -       struct hid_report *report;
> -       struct hid_device *hdev = sc->hdev;
> -
> -       list = &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
> -
> -       list_for_each(head, list) {
> -               report = list_entry(head, struct hid_report, list);
> -
> -               if (report->id == req_id) {
> -                       if (report->size < req_size) {
> -                               hid_err(hdev, "Output report 0x%02x (%i bits) is smaller than requested size (%i bits)\n",
> -                                       req_id, report->size, req_size);
> -                               return -EINVAL;
> -                       }
> -                       sc->output_report = report;
> -                       return 0;
> -               }
> -       }
> -
> -       hid_err(hdev, "Unable to locate output report 0x%02x\n", req_id);
> -
> -       return -EINVAL;
> -}
> -
>  static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
>                                         int w, int h)
>  {
> @@ -1291,10 +1268,11 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
>                 ret = sixaxis_set_operational_bt(hdev);
>         else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
> -               /* Report 5 (31 bytes) is used to send data to the controller via USB */
> -               ret = sony_set_output_report(sc, 0x05, 248);
> -               if (ret < 0)
> +               if (hdev->ll_driver->output_report == NULL) {
> +                       hid_err(hdev, "NULL output_report handler\n");
> +                       ret = -EINVAL;
>                         goto err_stop;
> +               }
>
>                 /* The Dualshock 4 touchpad supports 2 touches and has a
>                  * resolution of 1920x940.
> --
> 1.8.5.3
>
