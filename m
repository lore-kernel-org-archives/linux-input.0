From: "Johnny.Chuang" <johnny.chuang@emc.com.tw>
Subject: RE: ELAN0732 I2C Touchscreen Driver
Date: Wed, 29 Mar 2017 16:02:53 +0800
Message-ID: <04c401d2a862$ddf0e8a0$99d2b9e0$@emc.com.tw>
References: <CALLvBir2m6iuq1ntwZU+ZTahCeHXZQ5DNUb7nPe9jSUXL-AOLA@mail.gmail.com> <CAKdAkRTnqwyjGcQjmmHxAOkWSMnADtO5WnyyndkwqP9wo_FcWw@mail.gmail.com> <001201d2a207$b4e6c8a0$1eb459e0$@emc.com.tw> <044e01d2a770$54da63e0$fe8f2ba0$@emc.com.tw> <CALLvBiqmzKegjKt9r2wt3PBTvOdaCBA3cVR48majEZfdptRGMA@mail.gmail.com> <CALLvBioysx1u3F8NUNMskM-CR5JO5CK7yT6WCt1WpwbH=5ZnWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:50436 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbdC2IDQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Mar 2017 04:03:16 -0400
In-Reply-To: <CALLvBioysx1u3F8NUNMskM-CR5JO5CK7yT6WCt1WpwbH=5ZnWA@mail.gmail.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'M K' <m.kolesinski@gmail.com>
Cc: =?UTF-8?B?J+W7luW0h+amric=?= <kt.liao@emc.com.tw>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, =?UTF-8?B?J0VMQU4g5YqJ5ZiJ6ae/Jw==?= <scott.liu@emc.com.tw>

Hi MK,

1. Please add the {.driver_data...} to a static in hid-multitouch.c
	static const struct hid_device_id mt_devices[] = {
		/* Elan i2c-hid TouchSystems panel */
		{ .driver_data = MT_CLS_DEFAULT,
			HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH, USB_VENDOR_ID_ELAN,
				USB_DEVICE_ID_ELAN_A) },
Please add in drivers/hid/hid-ids.h
	#define USB_VENDOR_ID_ELAN             0x04f3
	#define USB_DEVICE_ID_ELAN_A           0x0732

2. There are two separate modules (hid-multitouch.c and i2c-hid.c) you need to use. 

3. using MT_CLS_DEFAULT : Yes

4. HID_DEVICE() : My fault, miss an argument " HID_GROUP_MULTITOUCH " as above.

5. PID: 0x2B28 : As I know our I2CHID touch screen PID is 0x0732. I'm not sure what 0x2B28 is.

Please try it again, thanks.

Many thanks,
Johnny
-----Original Message-----
From: M K [mailto:m.kolesinski@gmail.com] 
Sent: Tuesday, March 28, 2017 4:16 PM
To: Johnny.Chuang
Cc: 廖崇榮; Dmitry Torokhov; linux-input@vger.kernel.org; ELAN 劉嘉駿
Subject: Re: ELAN0732 I2C Touchscreen Driver

And here's a screenshot of the device info in Windows:

On Tue, Mar 28, 2017 at 3:13 AM, M K <m.kolesinski@gmail.com> wrote:
> Hi Johnny,
>
> Did you mean to add the {.driver_data...} to a static in i2c-hid.c, or 
> in hid-multitouch.c?  If so, where?  After downloading the kernel 
> source and building these modules, it looks to me like 
> hid-multitouch.c is its own module (part of the Makefile for
> "M=drivers/hid") separate from i2c-hid ("M=drivers/hid/i2c-hid")
>
> Also, the comments in hid-multitouch.c state that definitions for 
> items using MT_CLS_DEFAULT don't do anything.  Finally, what device 
> type should I use?  The code you provided won't compile, because the
> HID_DEVICE() macro expects another argument.  I presume this would be 
> "HID_GROUP_MULTITOUCH" ?
>
> After trying the above, I recompiled the two modules and re-installed 
> them in my kernel using modprobe.  However, I could find no evidence 
> that the ELAN0732 device was actually detected as an input device (cat 
> /proc/bus/input/devices, and xinput both don't show anything new).  I 
> also tried rebooting (however, neither of these modules is in the 
> standard initramfs for Arch Linux, so I don't think rebooting is 
> necessary).
>
> Any other ideas?
>
> Also, here's a snippet of the DxDiag report from Windows..for this 
> vendor ID, it lists 4 devices (0x2B28)...not sure if this is the same 
> piece of hardware or not:
> "-------------------
> DirectInput Devices
> -------------------
>       Device Name: Mouse
>          Attached: 1
>     Controller ID: n/a
> Vendor/Product ID: n/a
>         FF Driver: n/a
>
>       Device Name: Keyboard
>          Attached: 1
>     Controller ID: n/a
> Vendor/Product ID: n/a
>         FF Driver: n/a
>
>       Device Name: HIDI2C Device
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x04F3, 0x2B28
>         FF Driver: n/a
>
>       Device Name: HIDI2C Device
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x04F3, 0x2B28
>         FF Driver: n/a
>
>       Device Name: HIDI2C Device
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x04F3, 0x2B28
>         FF Driver: n/a
>
>       Device Name: HIDI2C Device
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x04F3, 0x2B28
>         FF Driver: n/a
>
>       Device Name: HP Wireless Button Driver
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x0001, 0x0001
>         FF Driver: n/a
>
>       Device Name: ST_SENSOR_HUB
>          Attached: 1
>     Controller ID: 0x0
> Vendor/Product ID: 0x0483, 0x91D1
>         FF Driver: n/a
>
> Poll w/ Interrupt: No
>
> -----------"
>
>
>
>
> Thanks,
>
> MK
>
>
> On Mon, Mar 27, 2017 at 10:06 PM, Johnny.Chuang 
> <johnny.chuang@emc.com.tw> wrote:
>> Hi Dmitry,
>>
>> Sorry for late response.
>>
>> ELAN0732 is hid over i2c touch screen device.
>> There is a compatible linux inbox driver which is drivers/hid/i2c-hid/i2c-hid.c.
>> Please make i2c-hid.c as build-in driver or module.
>>
>> And please also add VID/PID at hid-ids.h and hid-multitouch.c 
>> drivers/hid/hid-ids.h
>>         #define USB_VENDOR_ID_ELAN      0x04f3
>>         #define USB_DEVICE_ID_ELAN_A    0x0732
>>         #define USB_DEVICE_ID_ELAN_B    0x000b
>> drivers/hid/hid-multitouch.c
>>         /* Elan i2c-hid TouchSystems panel */
>>         { .driver_data = MT_CLS_DEFAULT,
>>                 HID_DEVICE(BUS_I2C, USB_VENDOR_ID_ELAN,
>>                         USB_DEVICE_ID_ELAN_A) },
>>
>> Many thanks,
>> Johnny
>> -----Original Message-----
>> From: 廖崇榮 [mailto:kt.liao@emc.com.tw]
>> Sent: Tuesday, March 21, 2017 1:55 PM
>> To: 'Dmitry Torokhov'; 'M K'
>> Cc: linux-input@vger.kernel.org; 'ELAN 劉嘉駿'; 'Johnny.Chuang'
>> Subject: RE: ELAN0732 I2C Touchscreen Driver
>>
>> Add Johnny who handle ELAN touchscreen in loop.
>>
>> -----Original Message-----
>> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>> Sent: Tuesday, March 21, 2017 12:45 PM
>> To: M K; 廖崇榮
>> Cc: linux-input@vger.kernel.org; ELAN 劉嘉駿
>> Subject: Re: ELAN0732 I2C Touchscreen Driver
>>
>> On Sun, Mar 19, 2017 at 11:26 PM, M K <m.kolesinski@gmail.com> wrote:
>>> Is there a compatible driver for this device?  I've tried loading 
>>> various modules with no success (elants_i2c, hid_multitouch, etc.).
>>>
>>> The device shows up under /sys/bus/i2c/devices/i2c-ELAN0732:00
>>
>> You would need to add "ELAN0732" to elants_i2c_id table for elants_i2c to load and bind to the device.
>>
>>>
>>> However, xinput does not list it at all.
>>>
>>> This is an HP m6-ar004dx laptop (Envy x360) with touchscreen 
>>> display, and AMD FX-9800P processor.
>>>
>>> Scott Liu suggested I try posting here.
>>
>> Hmm, I'd expect Scott to know if elants_i2c could theoretically drive this device. KT, do you know by chance?
>> Hi Johnny,
>>         Could you help to check this TS issue Thanks.
>>
>> --
>> Dmitry
>>

