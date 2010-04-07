From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [BUG] hid NULL ptr deref on usb reset with hid disabled quirk
Date: Wed, 07 Apr 2010 20:03:42 +0200
Message-ID: <4BBCC8FE.2040009@redhat.com>
References: <4BBC4B51.8060005@redhat.com> <1270659702.27948.9.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12264 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab0DGSCR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Apr 2010 14:02:17 -0400
In-Reply-To: <1270659702.27948.9.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: linux-usb <linux-input@vger.kernel.org>

Hi,

On 04/07/2010 07:01 PM, Christoph Fritz wrote:
> Am Mittwoch, den 07.04.2010, 11:07 +0200 schrieb Hans de Goede:
>
>> usbhid.quirks=0x1908:0x1315:0x4
>>
>> To the kernel cmdline. But this results in triggering a bug in the hid
>> driver. When a device has the ignore quirk (which the above command sets)
>
> As I can see, 0x4 HID_QUIRK_IGNORE happens after add_device.
>
> just a guess:
>
> diff --cc drivers/input/serio/i8042-x86ia64io.h
> index ead0494,924e8ed..0000000
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 2e2aa75..19e6a60 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1683,6 +1683,7 @@ static const struct hid_device_id hid_ignore_list[] = {
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
> +	{ HID_USB_DEVICE(0x1908, 0x1315) },
>   	{ }
>   };
>
>

Thanks, but I already have a patch for hiding the interface completely at the
usb subsys level, as was the intention of the device manufacturer (see the link in my
original mail). With that patch things work fine. The purpose of this bug report was
to point out that add a HID_QUIRK_IGNORE on the cmdline for any device, has the
potential of triggering a NULL ptr deref.

Which should be fixed IMHO, either by not allowing passing HID_QUIRK_IGNORE
on the cmdline (although that would seem counter productive to me), or by
fixing the code in question.

Regards,

Hans
