From: Derya <derya.kiran@yahoo.de>
Subject: Re: [PATCH 2/2 ] Surface Pro 2 HID sensor, wacom, keyboard/multitouch
 composite device
Date: Fri, 07 Mar 2014 18:57:34 +0100
Message-ID: <531A088E.30207@yahoo.de>
References: <5319EB7C.5070209@yahoo.de>	<5319EC8D.9070302@yahoo.de> <CAN+gG=EpfxeOGvUUQvLxRL9o_SWSmRJkuD7qDc6JkUz1aP_GNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm11-vm8.bullet.mail.ir2.yahoo.com ([212.82.96.169]:45158 "EHLO
	nm11-vm8.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752969AbaCGR5h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Mar 2014 12:57:37 -0500
In-Reply-To: <CAN+gG=EpfxeOGvUUQvLxRL9o_SWSmRJkuD7qDc6JkUz1aP_GNw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>


Am 07.03.2014 18:01, schrieb Benjamin Tissoires:
> On Fri, Mar 7, 2014 at 10:58 AM, Derya <derya.kiran@yahoo.de> wrote:
>> Enumeration quirks for Surface Pro 2 sensor-hub
>>
>> Signed-off-by: Derya <derya.kiran@yahoo.de>
>> ---
>>   drivers/hid/hid-sensor-hub.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
>> index 9c22e14..16f4bb8 100644
>> --- a/drivers/hid/hid-sensor-hub.c
>> +++ b/drivers/hid/hid-sensor-hub.c
>> @@ -668,6 +668,15 @@ static const struct hid_device_id sensor_hub_devices[]
>> = {
>>       { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_STM_0,
>>               USB_DEVICE_ID_STM_HID_SENSOR),
>>               .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
>> +    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
>> USB_VENDOR_ID_MICROSOFT,
>> +             USB_DEVICE_ID_MS_TOUCH_COVER_2),
>> +            .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
>> +    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
>> USB_VENDOR_ID_MICROSOFT,
>> +             USB_DEVICE_ID_MS_TYPE_COVER_2),
>> +            .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
>> +    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
>> USB_VENDOR_ID_MICROSOFT,
>> +             USB_DEVICE_ID_MS_SURFACE_PRO_2),
>> +            .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> this seems to be pretty heavy to have all three product id in the sensor hub.
> Is it mandatory?

We can post prune this until I have the time to have a closer look into 
the sensor stuff. The problem is the product id changes with the covers. 
We can use HID_ANY_ID instead of the product id, but that will apply to 
other MS devices, too. There are more MS Covers out there, I don't know 
how the others behave and I don't know, if the Surface Pro 1 needs it also.
>
> Cheers,
> Benjamin
>
>>       { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
>>                HID_ANY_ID) },
>>       { }
>> --
>> 1.8.3.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

