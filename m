From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 2/4] HID: sony: Use standard output reports instead of raw
 reports to send data to the Dualshock 4.
Date: Fri, 17 Jan 2014 12:09:55 +0100
Message-ID: <CANq1E4R3ryPDaivJE-TW=zBnOp9yD5+=-vpVP9zy9OACvud1yw@mail.gmail.com>
References: <alpine.DEB.2.10.1401162134560.15779@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43799 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbaAQLJ5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 06:09:57 -0500
Received: by mail-ie0-f171.google.com with SMTP id to1so5309234ieb.16
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 03:09:56 -0800 (PST)
In-Reply-To: <alpine.DEB.2.10.1401162134560.15779@franz-virtual-machine>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Fri, Jan 17, 2014 at 3:42 AM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Use regular HID output reports instead of raw reports in the
> dualshock4_state_worker function.  (Thanks Simon Mungewell)

This description is actually wrong. hid_output_raw_report() is used
for regular HID output reports. What you do, is using SET_REPORT to
synchronously set output-reports. Anyhow, see below for comments.

> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
>
> ---
>
>  Apply against jikos/hid.git/for-3.14/sony
>
>  drivers/hid/hid-sony.c | 45 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 2f992e1..e623131 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -664,28 +664,39 @@ static void sixaxis_state_worker(struct work_struct *work)
>  static void dualshock4_state_worker(struct work_struct *work)
>  {
>         struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
> -       unsigned char buf[] = {
> -               0x05,
> -               0x03, 0x00, 0x00, 0x00, 0x00,
> -               0x00, 0x00, 0x00, 0x00, 0x00,
> -               0x00, 0x00, 0x00, 0x00, 0x00,
> -               0x00, 0x00, 0x00, 0x00, 0x00,
> -               0x00, 0x00, 0x00, 0x00, 0x00,
> -               0x00, 0x00, 0x00, 0x00, 0x00,
> -               0x00,
> -       };
> +       struct hid_device *hdev = sc->hdev;
> +       struct list_head *head, *list;
> +       struct hid_report *report;
> +       __s32 *value;
> +
> +       list = &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
> +
> +       list_for_each(head, list) {
> +               report = list_entry(head, struct hid_report, list);
> +
> +               /* Report 5 is used to send data to the controller via USB */
> +               if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && report->id == 5)
> +                       break;
> +       }
> +
> +       if (head == list) {
> +               hid_err(hdev, "Dualshock 4 output report not found\n");

Are you sure you want to print this error on *every* invokation? I'd
rather like to see this "list_for_each()" in ->probe() and then print
the error once. In ->probe() after you called hid_parse(), the
report-descriptor will not get changed again so it's safe to cache the
report pointer there. At least I don't know any code-path where we'd
change it again. Maybe @Jiri can confirm that.

I'd also like to see a safety check that the given report is long
enough. Otherwise, you might write out of buffer bounds below. But you
can do all this in ->probe().

Thanks
David

> +               return;
> +       }
> +
> +       value = report->field[0]->value;
> +       value[0] = 0x03;
>
>  #ifdef CONFIG_SONY_FF
> -       buf[4] = sc->right;
> -       buf[5] = sc->left;
> +       value[3] = sc->right;
> +       value[4] = sc->left;
>  #endif
>
> -       buf[6] = sc->led_state[0];
> -       buf[7] = sc->led_state[1];
> -       buf[8] = sc->led_state[2];
> +       value[5] = sc->led_state[0];
> +       value[6] = sc->led_state[1];
> +       value[7] = sc->led_state[2];
>
> -       sc->hdev->hid_output_raw_report(sc->hdev, buf, sizeof(buf),
> -                                       HID_OUTPUT_REPORT);
> +       hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
>  }
>
>  #ifdef CONFIG_SONY_FF
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
