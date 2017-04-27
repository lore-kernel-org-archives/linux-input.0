From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: Support i2c-hid multitouch compatible Wacom touchscreens
Date: Thu, 27 Apr 2017 15:48:22 -0700
Message-ID: <CANRwn3QrURkBgB4gjWfwz4WknpOefLAP9Pj7v=Ax9Z+VGKKPMA@mail.gmail.com>
References: <20170427135757.29947-1-jarkko.nikula@linux.intel.com> <20170427150928.GA28152@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35415 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161861AbdD0WsX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Apr 2017 18:48:23 -0400
Received: by mail-ua0-f195.google.com with SMTP id j59so3702392uad.2
        for <linux-input@vger.kernel.org>; Thu, 27 Apr 2017 15:48:23 -0700 (PDT)
In-Reply-To: <20170427150928.GA28152@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, Apr 27, 2017 at 8:09 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Apr 27 2017 or thereabouts, Jarkko Nikula wrote:
>> Vendor specific handling in hid_scan_report() overrides the hid->group
>> to HID_GROUP_WACOM for all devices with vendor ID equal to
>> USB_VENDOR_ID_WACOM.
>>
>> However there is an i2c-hid multitouch compatible Wacom touschreen which
>> is parsed as generic HID_GROUP_MULTITOUCH_WIN_8 device but
>> hid-multitouch doesn't probe because of this overriding.
>>
>> Support this touschreen by overring the group only when the bus is
>> different than I2C.
>>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> ---
>> I'm not an HID expert and I don't know is there any existing Wacom
>> tablets using the I2C bus. There are USB and Bluetooth tablets so that's
>
> I'd say there are other I2C Wacom tablets. Jason and Ping can confirm.
>

Absolutely. There are a number of I2C tablets out there. The device
table for wacom.ko includes "{ I2C_DEVICE_WACOM(HID_ANY_ID) }" so that
we can attempt to handle them.

>> the reason I'm checking id->bus !=3D BUS_I2C when overring the group.
>> I've done only basic testing that device is registered as an
>> hid-multitouch device and "hexdump /dev/input/eventX" produces a bunch
>> of hexadecimals when touschscreen is touched.
>
> What's the issue of having wacom.ko loaded for this particular
> touchscreen? wacom.ko should handle it properly.
>
> Cheers,
> Benjamin
>

I'm wondering the same thing. It looks like the vendor-specific
overrides occur after HID_GROUP_MULTITOUCH_WIN_8 would have been
set... Is the wacom module not a part of your kernel?

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


>> ---
>>  drivers/hid/hid-core.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index d162f0dc76e3..cfb0b7262de7 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -816,7 +816,8 @@ static int hid_scan_report(struct hid_device *hid)
>>        */
>>       switch (hid->vendor) {
>>       case USB_VENDOR_ID_WACOM:
>> -             hid->group =3D HID_GROUP_WACOM;
>> +             if (hid->bus !=3D BUS_I2C)
>> +                     hid->group =3D HID_GROUP_WACOM;
>>               break;
>>       case USB_VENDOR_ID_SYNAPTICS:
>>               if (hid->group =3D=3D HID_GROUP_GENERIC)
>> --
>> 2.11.0
>>
