From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Add support for the built-in digitizer in the Lenovo W700
Date: Wed, 22 Dec 2010 11:56:16 -0800
Message-ID: <AANLkTi=ptjY6N9Le8ern=jgwCj0k5exZ+5giaDd_hLr-@mail.gmail.com>
References: <1293046395-2264-1-git-send-email-pinglinux@gmail.com>
	<20101222194703.GA15605@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49932 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944Ab0LVT4S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Dec 2010 14:56:18 -0500
Received: by wyb28 with SMTP id 28so5418498wyb.19
        for <linux-input@vger.kernel.org>; Wed, 22 Dec 2010 11:56:16 -0800 (PST)
In-Reply-To: <20101222194703.GA15605@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ajay Ramaswamy <ajay@ramaswamy.net>

On Wed, Dec 22, 2010 at 11:47 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Dec 22, 2010 at 11:33:15AM -0800, Ping Cheng wrote:
>> From: Ajay Ramaswamy <ajay@ramaswamy.net>
>>
>> The patch is based on git://git.kernel.org/pub/scm/linux/kernel/git/=
dtor/input.git next
>>
>> Signed-off-by: Ajay Ramaswamy <ajay@ramaswamy.net>
>> Reviewed-by: Ping Cheng <pingc@wacom.com>
>
> Don't we need to add HID blacklist for this as well?

I thought about that as well (I don't have a system to test with).
Ajay told me that he did not need to do anything in hid-core.c for his
tablet to work. He has been using/testing the tablet for more than 4
months.

Hopefully, we'll get more feedback from the community when the patch
gets in the tree.

Thank you.

Ping

>> ---
>> =A0drivers/input/tablet/wacom.h =A0 =A0 | =A0 =A01 +
>> =A0drivers/input/tablet/wacom_wac.c | =A0 =A07 +++++++
>> =A02 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wac=
om.h
>> index de5adb1..23317bd 100644
>> --- a/drivers/input/tablet/wacom.h
>> +++ b/drivers/input/tablet/wacom.h
>> @@ -103,6 +103,7 @@ MODULE_DESCRIPTION(DRIVER_DESC);
>> =A0MODULE_LICENSE(DRIVER_LICENSE);
>>
>> =A0#define USB_VENDOR_ID_WACOM =A00x056a
>> +#define USB_VENDOR_ID_LENOVO 0x17ef
>>
>> =A0struct wacom {
>> =A0 =A0 =A0 dma_addr_t data_dma;
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet=
/wacom_wac.c
>> index 0b05254..0024d3e 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -1424,11 +1424,17 @@ static struct wacom_features wacom_features_=
0xD2 =3D
>> =A0 =A0 =A0 { "Wacom Bamboo Craft", =A0 WACOM_PKGLEN_BBFUN, =A0 =A0 =
14720, =A09200, 1023, 63, BAMBOO_PT };
>> =A0static struct wacom_features wacom_features_0xD3 =3D
>> =A0 =A0 =A0 { "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN, =A0 =A0 21=
648, 13530, 1023, 63, BAMBOO_PT };
>> +static const struct wacom_features wacom_features_0x6004 =3D
>> + =A0 =A0 { "ISD-V4", =A0 =A0 =A0 =A0 =A0 =A0 =A0 WACOM_PKGLEN_GRAPH=
IRE, =A012800, 8000, 255, 0, TABLETPC };
>>
>> =A0#define USB_DEVICE_WACOM(prod) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> =A0 =A0 =A0 USB_DEVICE(USB_VENDOR_ID_WACOM, prod), =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0\
>> =A0 =A0 =A0 .driver_info =3D (kernel_ulong_t)&wacom_features_##prod
>>
>> +#define USB_DEVICE_LENOVO(prod) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 USB_DEVICE(USB_VENDOR_ID_LENOVO, prod), =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 \
>> + =A0 =A0 .driver_info =3D (kernel_ulong_t)&wacom_features_##prod
>> +
>> =A0const struct usb_device_id wacom_ids[] =3D {
>> =A0 =A0 =A0 { USB_DEVICE_WACOM(0x00) },
>> =A0 =A0 =A0 { USB_DEVICE_WACOM(0x10) },
>> @@ -1501,6 +1507,7 @@ const struct usb_device_id wacom_ids[] =3D {
>> =A0 =A0 =A0 { USB_DEVICE_WACOM(0xE2) },
>> =A0 =A0 =A0 { USB_DEVICE_WACOM(0xE3) },
>> =A0 =A0 =A0 { USB_DEVICE_WACOM(0x47) },
>> + =A0 =A0 { USB_DEVICE_LENOVO(0x6004) },
>> =A0 =A0 =A0 { }
>> =A0};
>> =A0MODULE_DEVICE_TABLE(usb, wacom_ids);
>> --
>> 1.7.3.4
>>
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
