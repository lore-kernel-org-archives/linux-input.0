From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 04/14] HID: sony: validate HID output report details
Date: Thu, 29 Aug 2013 07:40:00 -0700
Message-ID: <CAGXu5jLAieQo8FkvEAU6D4c2i388Y3AnH3RNkdsyz3yg7K6sag@mail.gmail.com>
References: <alpine.LNX.2.00.1308282159590.22181@pobox.suse.cz>
	<CAN+gG=F8Y2aoEMr-Zy=JLgT3VT_QGTBi60Hem299p8Sdc-icVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:51827 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906Ab3H2OkB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 10:40:01 -0400
Received: by mail-ie0-f171.google.com with SMTP id 9so863736iec.16
        for <linux-input@vger.kernel.org>; Thu, 29 Aug 2013 07:40:01 -0700 (PDT)
In-Reply-To: <CAN+gG=F8Y2aoEMr-Zy=JLgT3VT_QGTBi60Hem299p8Sdc-icVg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

On Thu, Aug 29, 2013 at 2:48 AM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Wed, Aug 28, 2013 at 10:30 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>> From: Kees Cook <keescook@chromium.org>
>>
>> This driver must validate the availability of the HID output report and
>> its size before it can write LED states via buzz_set_leds(). This stops
>> a heap overflow that is possible if a device provides a malicious HID
>> output report:
>>
>> [  108.171280] usb 1-1: New USB device found, idVendor=054c, idProduct=0002
>> ...
>> [  117.507877] BUG kmalloc-192 (Not tainted): Redzone overwritten
>>
>> CVE-2013-2890
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: stable@kernel.org
>> ---
>>  drivers/hid/hid-sony.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
>> index 87fbe29..b987926 100644
>> --- a/drivers/hid/hid-sony.c
>> +++ b/drivers/hid/hid-sony.c
>> @@ -537,6 +537,10 @@ static int buzz_init(struct hid_device *hdev)
>>         drv_data = hid_get_drvdata(hdev);
>>         BUG_ON(!(drv_data->quirks & BUZZ_CONTROLLER));
>>
>> +       /* Validate expected report characteristics. */
>> +       if (!hid_validate_report(hdev, HID_OUTPUT_REPORT, 0, 1, 7))
>
> I don't have access to the device anymore, but I still kept the report
> descriptors (this is the interesting part):
>
> 0xa1, 0x02,                    //   Collection (Logical)              60
> 0x75, 0x08,                    //     Report Size (8)                 62
> 0x95, 0x07,                    //     Report Count (7)                64
> 0x46, 0xff, 0x00,              //     Physical Maximum (255)          66
> 0x26, 0xff, 0x00,              //     Logical Maximum (255)           69
> 0x09, 0x02,                    //     Usage (Vendor Usage 2)          72
> 0x91, 0x02,                    //     Output (Data,Var,Abs)           74
> 0xc0,                          //   End Collection                    76
>
> So with the current implementation of hid_validate_report(), it works,
> but if another Buzz controller show up at some point with extras
> fields in this output report... we will be screwed. So please, amend
> hid_validate_report(), or specifically test here that the LED output
> report is 7 bytes.

hid_validate_report() checks for "at least" 7 in this call, so it
should be fine, unless I've misunderstood something.

-Kees

>
> Cheers,
> Benjamin
>
>> +               return -ENODEV;
>> +
>>         buzz = kzalloc(sizeof(*buzz), GFP_KERNEL);
>>         if (!buzz) {
>>                 hid_err(hdev, "Insufficient memory, cannot allocate driver data\n");
>>
>> --
>> Jiri Kosina
>> SUSE Labs
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Kees Cook
Chrome OS Security
