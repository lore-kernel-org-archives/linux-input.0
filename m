From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 2/2] HID: sony: Update device ids
Date: Wed, 5 Oct 2016 21:59:05 -0700
Message-ID: <CANndSK=SDNjEqFNcAxkM0UGaQdwx1ik0HEVFu9xaMNuqY5FwVA@mail.gmail.com>
References: <1475720335-17447-1-git-send-email-roderick@gaikai.com>
 <1475720335-17447-2-git-send-email-roderick@gaikai.com> <d036f01a80c7d947f2958744ff36a844.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33564 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbcJFE7H (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 00:59:07 -0400
Received: by mail-vk0-f53.google.com with SMTP id z126so7808669vkd.0
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2016 21:59:06 -0700 (PDT)
In-Reply-To: <d036f01a80c7d947f2958744ff36a844.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

You are right wasn't aware of that. Easy to change tomorrow and will
send an updated version.

On Wed, Oct 5, 2016 at 9:09 PM, Simon Wood <simon@mungewell.org> wrote:
> On Wed, October 5, 2016 8:18 pm, Roderick Colenbrander wrote:
>> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
>>
>>
>> Support additional DS4 model.
>>
>>
>> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
>> ---
>> drivers/hid/hid-ids.h  | 1 + drivers/hid/hid-sony.c | 4 ++++ 2 files
>> changed, 5 insertions(+)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h index
>> cd59c79..27f82cc 100644 --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -899,6 +899,7 @@
>> #define USB_DEVICE_ID_SONY_PS3_BDREMOTE               0x0306
>> #define USB_DEVICE_ID_SONY_PS3_CONTROLLER     0x0268
>> #define USB_DEVICE_ID_SONY_PS4_CONTROLLER     0x05c4
>> +#define USB_DEVICE_ID_SONY_PS4_CONTROLLER_2  0x09cc
>> #define USB_DEVICE_ID_SONY_MOTION_CONTROLLER  0x03d5
>> #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER      0x042f
>> #define USB_DEVICE_ID_SONY_BUZZ_CONTROLLER            0x0002
>> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c index
>> c9916cc..3acdb68 100644 --- a/drivers/hid/hid-sony.c
>> +++ b/drivers/hid/hid-sony.c
>> @@ -2639,6 +2639,10 @@ static const struct hid_device_id sony_devices[] =
>> {
>> .driver_data = DUALSHOCK4_CONTROLLER_USB },
>> { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY,
>> USB_DEVICE_ID_SONY_PS4_CONTROLLER),
>> .driver_data = DUALSHOCK4_CONTROLLER_BT },
>> +     { HID_USB_DEVICE(USB_VENDOR_ID_SONY,
>> USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
>> +             .driver_data = DUALSHOCK4_CONTROLLER_USB },
>> +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY,
>> USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
>> +             .driver_data = DUALSHOCK4_CONTROLLER_BT },
>> /* Nyko Core Controller for PS3 */
>> { HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE,
>> USB_DEVICE_ID_SINO_LITE_CONTROLLER),
>> .driver_data = SIXAXIS_CONTROLLER_USB | SINO_LITE_CONTROLLER },
>
> I think you also need to patch hid-core.c, like:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-core.c?id=refs/tags/v4.8#n2057
>
> Great that these patches are coming... thanks.
> Simon
>



-- 
Roderick Colenbrander
Senior Manager of Software Engineering
Gaikai, a Sony Computer Entertainment Company
roderick@gaikai.com
