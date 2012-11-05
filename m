From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC] HID: uhid: Handle LED input events
Date: Mon, 5 Nov 2012 13:58:55 +0100
Message-ID: <CANq1E4Qq3yXFOx0L4aZQHRSDgMOnZjYU4o0oy_EULP=TDMNvmw@mail.gmail.com>
References: <1351806939-4925-1-git-send-email-andre.guedes@openbossa.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:58509 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab2KEM64 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Nov 2012 07:58:56 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so582441qcr.19
        for <linux-input@vger.kernel.org>; Mon, 05 Nov 2012 04:58:55 -0800 (PST)
In-Reply-To: <1351806939-4925-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Andre

On Thu, Nov 1, 2012 at 10:55 PM, Andre Guedes
<andre.guedes@openbossa.org> wrote:
> This patches adds support for handling LED input events in uhid
> driver.
>
> When uhid receives an input LED event, we set the proper field,
> create the output report and send it to userspace as UHID_OUTPUT
> event. Others input events are sent to userspace as UHID_OUTPUT_EV
> events.
>
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  drivers/hid/uhid.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 714cd8c..e7b7cdc 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -122,15 +122,40 @@ static int uhid_hid_input(struct input_dev *input, unsigned int type,
>         struct uhid_device *uhid = hid->driver_data;
>         unsigned long flags;
>         struct uhid_event *ev;
> +       struct hid_field *field;
> +       struct hid_report *report;
> +       int offset;
>
>         ev = kzalloc(sizeof(*ev), GFP_ATOMIC);
>         if (!ev)
>                 return -ENOMEM;
>
> -       ev->type = UHID_OUTPUT_EV;
> -       ev->u.output_ev.type = type;
> -       ev->u.output_ev.code = code;
> -       ev->u.output_ev.value = value;
> +       switch (type) {
> +       case EV_LED:
> +               offset = hidinput_find_field(hid, type, code, &field);
> +               if (offset == -1) {
> +                       hid_warn(input, "event field not found\n");
> +                       kfree(ev);
> +                       return -1;
> +               }
> +
> +               hid_set_field(field, offset, value);
> +
> +               report = field->report;
> +
> +               ev->type = UHID_OUTPUT;
> +               ev->u.output.rtype = UHID_OUTPUT_REPORT;
> +               hid_output_report(report, ev->u.output.data);
> +               ev->u.output.size = ((report->size - 1) >> 3) + 1 +
> +                                                       (report->id > 0);
> +               break;
> +
> +       default:
> +               ev->type = UHID_OUTPUT_EV;
> +               ev->u.output_ev.type = type;
> +               ev->u.output_ev.code = code;
> +               ev->u.output_ev.value = value;

I think kernel-coding-style uses "break" in default rules, too.

> +       }
>
>         spin_lock_irqsave(&uhid->qlock, flags);
>         uhid_queue(uhid, ev);

It looks like this was copied almost verbatim from usbhid/hid-core.c
usb_hidinput_input_event() and __usbhid_submit_report() so I wonder
why we do not provide a generic helper in hid-input.c.

The code itself looks good, so how about pushing this into a helper in
hid-input.c and using hid_output_raw_report(). We use this helper if
hidinput_input_event is NULL and hid_output_raw_report() is non-NULL.
Maybe Jiri has some comments on that, too. Adding him to CC.

Regards
David
