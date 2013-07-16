From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC 3/8] HID: input: generic hidinput_input_event handler
Date: Tue, 16 Jul 2013 10:04:32 +0200
Message-ID: <CAN+gG=Hty+R0D38-pJV-3J4oVEGfezh14A2XB0ppkbbXOx5Nuw@mail.gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
	<1373908217-16748-4-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:53398 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab3GPIEf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jul 2013 04:04:35 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so276128lab.36
        for <linux-input@vger.kernel.org>; Tue, 16 Jul 2013 01:04:33 -0700 (PDT)
In-Reply-To: <1373908217-16748-4-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

On Mon, Jul 15, 2013 at 7:10 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> The hidinput_input_event() callback converts input events written from
> userspace into HID reports and sends them to the device. We currently
> implement this in every HID transport driver, even though most of them do
> the same.
>
> This provides a generic hidinput_input_event() implementation which is
> mostly copied from usbhid. It uses a delayed worker to allow multiple LED
> events to be collected into a single output event.
> We use the custom ->request() transport driver callback to allow drivers
> to adjust the outgoing report and handle the request asynchronously. If no
> custom ->request() callback is available, we fall back to the generic raw
> output report handler (which is synchronous).
>
> Drivers can still provide custom hidinput_input_event() handlers (see
> logitech-dj) if the generic implementation doesn't fit their needs.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  drivers/hid/hid-input.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/hid.h     |  1 +
>  2 files changed, 80 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 7480799..308eee8 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1137,6 +1137,74 @@ unsigned int hidinput_count_leds(struct hid_device *hid)
>  }
>  EXPORT_SYMBOL_GPL(hidinput_count_leds);
>
> +static void hidinput_led_worker(struct work_struct *work)
> +{
> +       struct hid_device *hid = container_of(work, struct hid_device,
> +                                             led_work);
> +       struct hid_field *field;
> +       struct hid_report *report;
> +       int len;
> +       __u8 *buf;
> +
> +       field = hidinput_get_led_field(hid);
> +       if (!field)
> +               return;
> +
> +       /*
> +        * field->report is accessed unlocked regarding HID core. So there might
> +        * be another incoming SET-LED request from user-space, which changes
> +        * the LED state while we assemble our outgoing buffer. However, this
> +        * doesn't matter as hid_output_report() correctly converts it into a
> +        * boolean value no matter what information is currently set on the LED
> +        * field (even garbage). So the remote device will always get a valid
> +        * request.
> +        * And in case we send a wrong value, a next led worker is spawned
> +        * for every SET-LED request so the following worker will send the
> +        * correct value, guaranteed!
> +        */
> +
> +       report = field->report;
> +
> +       /* use custom SET_REPORT request if possible (asynchronous) */
> +       if (hid->ll_driver->request)
> +               return hid->ll_driver->request(hid, report, HID_REQ_SET_REPORT);
> +
> +       /* fall back to generic raw-output-report */
> +       len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
> +       buf = kmalloc(len, GFP_KERNEL);
> +       if (!buf)
> +               return;
> +
> +       hid_output_report(report, buf);
> +       /* synchronous output report */
> +       hid->hid_output_raw_report(hid, buf, len, HID_OUTPUT_REPORT);
> +       kfree(buf);
> +}

Instead of writing a specific fallback in case hid->ll_driver->request
does not exist, I think it would make sense to implement a generic
hid_hw_request function in hid-input, so that HIDP and UHID will
benefit from it. I think it will be better because the implementation
I made in i2c-hid.c is nearly the exact same calls than the fallback
here.

> +
> +static int hidinput_input_event(struct input_dev *dev, unsigned int type,
> +                               unsigned int code, int value)
> +{
> +       struct hid_device *hid = input_get_drvdata(dev);
> +       struct hid_field *field;
> +       int offset;
> +
> +       if (type == EV_FF)
> +               return input_ff_event(dev, type, code, value);
> +
> +       if (type != EV_LED)
> +               return -1;
> +
> +       if ((offset = hidinput_find_field(hid, type, code, &field)) == -1) {
> +               hid_warn(dev, "event field not found\n");
> +               return -1;
> +       }
> +
> +       hid_set_field(field, offset, value);
> +
> +       schedule_work(&hid->led_work);
> +       return 0;
> +}
> +
>  static int hidinput_open(struct input_dev *dev)
>  {
>         struct hid_device *hid = input_get_drvdata(dev);
> @@ -1183,7 +1251,10 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid)
>         }
>
>         input_set_drvdata(input_dev, hid);
> -       input_dev->event = hid->ll_driver->hidinput_input_event;
> +       if (hid->ll_driver->hidinput_input_event)
> +               input_dev->event = hid->ll_driver->hidinput_input_event;
> +       else if (hid->ll_driver->request || hid->hid_output_raw_report)
> +               input_dev->event = hidinput_input_event;

with a generic hid_hw_request in hid-input, the else is simpler here.

>         input_dev->open = hidinput_open;
>         input_dev->close = hidinput_close;
>         input_dev->setkeycode = hidinput_setkeycode;
> @@ -1278,6 +1349,7 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
>         int i, j, k;
>
>         INIT_LIST_HEAD(&hid->inputs);
> +       INIT_WORK(&hid->led_work, hidinput_led_worker);
>
>         if (!force) {
>                 for (i = 0; i < hid->maxcollection; i++) {
> @@ -1379,6 +1451,12 @@ void hidinput_disconnect(struct hid_device *hid)
>                 input_unregister_device(hidinput->input);
>                 kfree(hidinput);
>         }
> +
> +       /* led_work is spawned by input_dev callbacks, but doesn't access the
> +        * parent input_dev at all. Once all input devices are removed, we
> +        * know that led_work will never get restarted, so we can cancel it
> +        * synchronously and are safe. */
> +       cancel_work_sync(&hid->led_work);

You missed the multi-lines comment formatting style on this one :)

>  }
>  EXPORT_SYMBOL_GPL(hidinput_disconnect);
>
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index b8058c5..ea4b828 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -456,6 +456,7 @@ struct hid_device {                                                 /* device report descriptor */
>         enum hid_type type;                                             /* device type (mouse, kbd, ...) */
>         unsigned country;                                               /* HID country */
>         struct hid_report_enum report_enum[HID_REPORT_TYPES];
> +       struct work_struct led_work;                                    /* delayed LED worker */
>
>         struct semaphore driver_lock;                                   /* protects the current driver, except during input */
>         struct semaphore driver_input_lock;                             /* protects the current driver */
> --
> 1.8.3.2
>

Cheers,
Benjamin
