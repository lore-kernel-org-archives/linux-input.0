From: Andre Guedes <andre.guedes@openbossa.org>
Subject: Re: [RFC] HID: uhid: Handle LED input events
Date: Mon, 5 Nov 2012 10:56:23 -0300
Message-ID: <CACJA=fUe8J_3ecX8q9Znnx0wmr3Rq5OMS0ny4qyc3NyXkVgqrw@mail.gmail.com>
References: <1351806939-4925-1-git-send-email-andre.guedes@openbossa.org>
	<CANq1E4Qq3yXFOx0L4aZQHRSDgMOnZjYU4o0oy_EULP=TDMNvmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47040 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab2KEN4X (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Nov 2012 08:56:23 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so3947081pad.19
        for <linux-input@vger.kernel.org>; Mon, 05 Nov 2012 05:56:23 -0800 (PST)
In-Reply-To: <CANq1E4Qq3yXFOx0L4aZQHRSDgMOnZjYU4o0oy_EULP=TDMNvmw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi David,

On Mon, Nov 5, 2012 at 9:58 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Andre
>
> On Thu, Nov 1, 2012 at 10:55 PM, Andre Guedes
> <andre.guedes@openbossa.org> wrote:
>> This patches adds support for handling LED input events in uhid
>> driver.
>>
>> When uhid receives an input LED event, we set the proper field,
>> create the output report and send it to userspace as UHID_OUTPUT
>> event. Others input events are sent to userspace as UHID_OUTPUT_EV
>> events.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>>  drivers/hid/uhid.c | 33 +++++++++++++++++++++++++++++----
>>  1 file changed, 29 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
>> index 714cd8c..e7b7cdc 100644
>> --- a/drivers/hid/uhid.c
>> +++ b/drivers/hid/uhid.c
>> @@ -122,15 +122,40 @@ static int uhid_hid_input(struct input_dev *input, unsigned int type,
>>         struct uhid_device *uhid = hid->driver_data;
>>         unsigned long flags;
>>         struct uhid_event *ev;
>> +       struct hid_field *field;
>> +       struct hid_report *report;
>> +       int offset;
>>
>>         ev = kzalloc(sizeof(*ev), GFP_ATOMIC);
>>         if (!ev)
>>                 return -ENOMEM;
>>
>> -       ev->type = UHID_OUTPUT_EV;
>> -       ev->u.output_ev.type = type;
>> -       ev->u.output_ev.code = code;
>> -       ev->u.output_ev.value = value;
>> +       switch (type) {
>> +       case EV_LED:
>> +               offset = hidinput_find_field(hid, type, code, &field);
>> +               if (offset == -1) {
>> +                       hid_warn(input, "event field not found\n");
>> +                       kfree(ev);
>> +                       return -1;
>> +               }
>> +
>> +               hid_set_field(field, offset, value);
>> +
>> +               report = field->report;
>> +
>> +               ev->type = UHID_OUTPUT;
>> +               ev->u.output.rtype = UHID_OUTPUT_REPORT;
>> +               hid_output_report(report, ev->u.output.data);
>> +               ev->u.output.size = ((report->size - 1) >> 3) + 1 +
>> +                                                       (report->id > 0);
>> +               break;
>> +
>> +       default:
>> +               ev->type = UHID_OUTPUT_EV;
>> +               ev->u.output_ev.type = type;
>> +               ev->u.output_ev.code = code;
>> +               ev->u.output_ev.value = value;
>
> I think kernel-coding-style uses "break" in default rules, too.

Ok, I'll check this.

>> +       }
>>
>>         spin_lock_irqsave(&uhid->qlock, flags);
>>         uhid_queue(uhid, ev);
>
> It looks like this was copied almost verbatim from usbhid/hid-core.c
> usb_hidinput_input_event() and __usbhid_submit_report() so I wonder
> why we do not provide a generic helper in hid-input.c.
>
> The code itself looks good, so how about pushing this into a helper in
> hid-input.c and using hid_output_raw_report(). We use this helper if
> hidinput_input_event is NULL and hid_output_raw_report() is non-NULL.
> Maybe Jiri has some comments on that, too. Adding him to CC.

I can work on that and send a new version. Lets see for Jiri have comments so.

Regards,

Andre
