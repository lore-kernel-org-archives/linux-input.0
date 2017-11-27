From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] HID: asus: Add product-id for the T100TAF and T100HA
 keyboard docks
Date: Mon, 27 Nov 2017 18:00:24 +0100
Message-ID: <47b2d7b2-c24b-2705-5be6-9c100d0ed4c0@redhat.com>
References: <20171126154010.954-1-hdegoede@redhat.com>
 <20171127083531.GD30708@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752578AbdK0RAf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Nov 2017 12:00:35 -0500
In-Reply-To: <20171127083531.GD30708@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Hi,

On 27-11-17 09:35, Benjamin Tissoires wrote:
> On Nov 26 2017 or thereabouts, Hans de Goede wrote:
>> The T100TAF and T100HA keyboard docks have the same special keys and
>> custom protocol multitouch touchpad as the T100TA, but use a different
>> product id.
>>
>> The T100TAF and T100HA both use the same product id, but the T100HA's
>> touchpad has a different coordinate range.
>>
>> This commits adds supports for the new USB id and uses a dmi-check to
>> determine if we're dealing with the T100TAF or T100HA.
> 
> This feels really wrong. Either people at Asus are insane, either the
> Windows driver has a query to fetch the correct logical and physical
> min/max.

I'm afraid it is probably the first reason and not the second reason,
when I was working on Linux webcam support one of the issues was that in
many Asus laptops the webcam module is mounted upside down and thus sends
an upside-down picture. I asked via via if Asus internally had a list
of which webcams are upside down, the answer was: no. Asus simply maintains
a hacked-together driver-repository per model laptop, in which they
put hacks until the driver works for that model. At least that is what
they do with webcams, I would not be surprised if that downloading
the T100TAF driver and putting it on the T100HA results in the driver
internally using the wrong coordinate range, something which the user
will likely not notice anyway since for most usage the coordinate range
does not matter.

> Could you share the hid-recorder output of the touchpad? Ideally, I'd
> like to compare it between the 2 (T100TAF and T100HA).

Since this is using a custom report-id hid-recorder does not seem
to record any data, even with the driver loaded. Anyways here is the
descriptor, which is what I guess you're most interested in:

D: 0
R: 85 05 01 09 02 a1 01 85 01 09 01 a1 00 05 09 19 01 29 02 15 00 25 01 75 01 95 02 81 02 95 06 81 03 05 01 09 30 09 31 09 38 15 81 25 7f 75 08 95 03 81 06 c0 c0 06 00 ff 09 c5 a1 01 85 0d 09 c5 15 00 26 ff 00 75 08 95 04 b1 02 85 5d 09 01 95 1b 75 08 81 06 c0
N: ASUS Tech Inc. ASUS HID Device
P: usb-0000:00:14.0-3.3/input2
I: 3 0b05 1807

Decoded that is:

Usage Page (Desktop),               ; Generic desktop controls (01h)
Usage (Mouse),                      ; Mouse (02h, application collection)
Collection (Application),
     Report ID (1),
     Usage (Pointer),                ; Pointer (01h, physical collection)
     Collection (Physical),
         Usage Page (Button),        ; Button (09h)
         Usage Minimum (01h),
         Usage Maximum (02h),
         Logical Minimum (0),
         Logical Maximum (1),
         Report Size (1),
         Report Count (2),
         Input (Variable),
         Report Count (6),
         Input (Constant, Variable),
         Usage Page (Desktop),       ; Generic desktop controls (01h)
         Usage (X),                  ; X (30h, dynamic value)
         Usage (Y),                  ; Y (31h, dynamic value)
         Usage (Wheel),              ; Wheel (38h, dynamic value)
         Logical Minimum (-127),
         Logical Maximum (127),
         Report Size (8),
         Report Count (3),
         Input (Variable, Relative),
     End Collection,
End Collection,
Usage Page (FF00h),                 ; FF00h, vendor-defined
Usage (C5h),
Collection (Application),
     Report ID (13),
     Usage (C5h),
     Logical Minimum (0),
     Logical Maximum (255),
     Report Size (8),
     Report Count (4),
     Feature (Variable),
     Report ID (93),
     Usage (01h),
     Report Count (27),
     Report Size (8),
     Input (Variable, Relative),
End Collection

IOW it says it is a mouse + a custom section for the special keys,
so no useful info there.

I've asked the T100TAF reporter to also collect a descriptor for the
T100TAF.

> If there is no differences, we might need to resort to have someone
> sniff the usb traces from a Windows VM :/

There may be some difference in the descriptors, but I wonder if that
is better then just identifying the model, since that is what we are
really after and the 2 docks are not compatible.

TL;DR: I really believe that my patch 'as is' is probably the best
solution.

Regards,

Hans


>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=197849
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -The new device-id is for both the T100TAF and the T100HA
>> -The T100HA touchpad has different coordinate ranges, take this into account
>> -Rebase on top of hid/for-4.16/hid-quirks-cleanup/_base
>> -Drop the ASUS T100TA entry from hid_have_special_driver, things work fine
>>   without it
>> ---
>>   drivers/hid/hid-asus.c   | 24 ++++++++++++++++++++++--
>>   drivers/hid/hid-ids.h    |  3 ++-
>>   drivers/hid/hid-quirks.c |  1 -
>>   3 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index 1bb7b63b3150..6d2894b7d8e7 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -26,6 +26,7 @@
>>    * any later version.
>>    */
>>   
>> +#include <linux/dmi.h>
>>   #include <linux/hid.h>
>>   #include <linux/module.h>
>>   #include <linux/input/mt.h>
>> @@ -119,6 +120,15 @@ static const struct asus_touchpad_info asus_t100ta_tp = {
>>   	.max_contacts = 5,
>>   };
>>   
>> +static const struct asus_touchpad_info asus_t100ha_tp = {
>> +	.max_x = 2640,
>> +	.max_y = 1320,
>> +	.res_x = 30, /* units/mm */
>> +	.res_y = 29, /* units/mm */
>> +	.contact_size = 5,
>> +	.max_contacts = 5,
>> +};
>> +
>>   static const struct asus_touchpad_info asus_t100chi_tp = {
>>   	.max_x = 2640,
>>   	.max_y = 1320,
>> @@ -606,7 +616,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>   
>>   		if (intf->altsetting->desc.bInterfaceNumber == T100_TPAD_INTF) {
>>   			drvdata->quirks = QUIRK_SKIP_INPUT_MAPPING;
>> -			drvdata->tp = &asus_t100ta_tp;
>> +			/*
>> +			 * The T100HA uses the same USB-ids as the T100TAF,
>> +			 * but has different max_x / max_y values.
>> +			 */
>> +			if (dmi_match(DMI_PRODUCT_NAME, "T100HAN"))
>> +				drvdata->tp = &asus_t100ha_tp;
>> +			else
>> +				drvdata->tp = &asus_t100ta_tp;
>>   		}
>>   	}
>>   
>> @@ -751,7 +768,10 @@ static const struct hid_device_id asus_devices[] = {
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>>   		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3), QUIRK_G752_KEYBOARD },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>> -		USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD),
>> +		USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD),
>> +	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>> +		USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
>>   	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 5da3d6256d25..dc1db8558850 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -178,7 +178,8 @@
>>   #define USB_VENDOR_ID_ASUSTEK		0x0b05
>>   #define USB_DEVICE_ID_ASUSTEK_LCM	0x1726
>>   #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
>> -#define USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD	0x17e0
>> +#define USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD	0x17e0
>> +#define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD	0x1807
>>   #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
>>   #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
>>   #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
>> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
>> index 015e0c10248b..1cf1e9a0d699 100644
>> --- a/drivers/hid/hid-quirks.c
>> +++ b/drivers/hid/hid-quirks.c
>> @@ -284,7 +284,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3) },
>> -	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD) },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
>>   	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
>>   	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD) },
>> -- 
>> 2.14.3
>>
