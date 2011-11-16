From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: Correct General touch PID
Date: Wed, 16 Nov 2011 15:02:23 +0100
Message-ID: <CAN+gG=GceWC95Yc-mdpX+H-Lf_jgWd6uAYDa7Xoq=EaoRXBnPA@mail.gmail.com>
References: <1321439992-5221-1-git-send-email-benjamin.tissoires@gmail.com>
	<alpine.LNX.2.00.1111161457110.15187@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58667 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757119Ab1KPOCZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 09:02:25 -0500
In-Reply-To: <alpine.LNX.2.00.1111161457110.15187@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Wed, Nov 16, 2011 at 14:57, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 16 Nov 2011, Benjamin Tissoires wrote:
>
>> Genera Touch told us that 0001 is their single point device
>> and 0003 is the multitouch one. Apparently, we made the tests
>> someone having a prototype, and not the final product.
>> They said it should be safe to do the switch.
>>
>> this partially revert 5572da08a784621f2ab4fdc8dc65471261871795
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
>> Cc: stable@vger.kernel.org
>> ---
>> =A0drivers/hid/hid-core.c | =A0 =A02 +-
>> =A0drivers/hid/hid-ids.h =A0| =A0 =A02 +-
>> =A02 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 6780796..5278f1f 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1727,8 +1727,8 @@ static const struct hid_device_id hid_ignore_l=
ist[] =3D {
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DE=
VICE_ID_ESSENTIAL_REALITY_P5) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH)=
 },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM)=
 },
>> + =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0001) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0002) },
>> - =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0003) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0004) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_4_PHI=
DGETSERVO_30) },
>> =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_GLAB, USB_DEVICE_ID_1_PHI=
DGETSERVO_30) },
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 0a541a9..75062c3 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -256,7 +256,7 @@
>> =A0#define USB_DEVICE_ID_GAMERON_DUAL_PCS_ADAPTOR =A0 =A0 =A0 0x0002
>>
>> =A0#define USB_VENDOR_ID_GENERAL_TOUCH =A00x0dfc
>> -#define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0001
>> +#define USB_DEVICE_ID_GENERAL_TOUCH_WIN7_TWOFINGERS 0x0003
>>
>> =A0#define USB_VENDOR_ID_GLAB =A0 =A0 =A0 =A0 =A0 0x06c2
>> =A0#define USB_DEVICE_ID_4_PHIDGETSERVO_30 =A0 =A0 =A00x0038
>
> Thanks Benjamin, applied. I guess you'd like to have that one in 3.2
> still, right?

right ;-)

thanks a lot Jiri,
Benjamin

>
> --
> Jiri Kosina
> SUSE Labs
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
