From: Vladislav Naumov <vnaum@vnaum.com>
Subject: Re: [PATCH 2/2] hid: input: add HID_QUIRK_REUSE_AXES and fix dragonrise
Date: Tue, 27 Sep 2016 21:17:32 +0600
Message-ID: <CABnEwuryj9rbeETuO+agekioq8wFd_6H0cZPCs+=Ft8c-=5j9g@mail.gmail.com>
References: <20160926025839.2790-1-adi@adirat.com> <20160926025839.2790-2-adi@adirat.com>
 <20160926092903.GC19261@mail.corp.redhat.com> <f3f844b7-777e-41ce-4661-bcf8735763c6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33947 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752183AbcI0PSE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Sep 2016 11:18:04 -0400
In-Reply-To: <f3f844b7-777e-41ce-4661-bcf8735763c6@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ioan-Adrian Ratiu <adi@adirat.com>, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Yes, I still have one of those!
0079:0011 DragonRise Inc. Gamepad
Left shift buttons are broken now, but axis and main buttons are still working.
Axis is handled properly with 3.16.0-4-686-pae #1 SMP Debian
3.16.7-ckt25-2 (2016-04-08) i686 GNU/Linux from debian/stable.
I can test what you want.
Should I apply the patch from forwarded message to upstream kernel, or
I can just pull it from some host with everything applied?

On Mon, Sep 26, 2016 at 4:53 PM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> Hi Benjamin,
>
> On 09/26/2016 12:29 PM, Benjamin Tissoires wrote:
>>
>> Ideally, we need to have Dragon Rise 0x0011 tested too. Nick, would you
>> mind checking it if you still have this particular device?
>
>
> I never had it, but perhaps Vladislav still has some.
>
> Vladislav, would you be able to test a change to the kernel module for your
> Dragonrise gamepads?
>
> Please see below for context.
>
> Thank you.
>
> Nick
>
> On 09/26/2016 12:29 PM, Benjamin Tissoires wrote:
>>
>> On Sep 26 2016 or thereabouts, Ioan-Adrian Ratiu wrote:
>>>
>>> Commit 79346d620e9d ("HID: input: force generic axis to be mapped to
>>> their
>>> user space axis") made mapping generic axes to their userspace
>>> equivalents
>>> mandatory and some lower end gamepads which were depending on the
>>> previous
>>> behaviour suffered severe regressions because they were reusing axes and
>>> expecting hid-input to multiplex their map to the respective userspace
>>> axis
>>> by always searching for and using the next available axis.
>>
>>
>> Yes, I apologies for the breakage and the regression, though I must say
>> that for now, only one hardware maker and one device (or range of devices
>> from the look of it) has needed to be quirked.
>>
>>>
>>> Now the result is that different device axes appear on a single axis in
>>> userspace, which is clearly a regression in the hid-input driver because
>>> it
>>> needs to continue to handle this hardware as expected before the forcing
>>> to provide the same interface to userspace.
>>>
>>> Since these lower-end gamepads like 0079:0006 are definitely the
>>> exception,
>>> create a quirk to fix them.
>>
>>
>> Given that we only have this particular vendor that is an issue, I'd
>> rather see the fix in hid-dr.c. The reason being that you actually don't
>> need to have a global quirk and this simplifies the path in hid-input.
>> Plus for users, they can just upgrade hid-dr without having to recompile
>> their kernel when hid-core is not compiled as a module.
>>
>> The cleanest solution that wouldn't require any quirk in hid-core is to
>> simply add an .input_mapping() callback in hid-dr.c.
>>
>> The code of the callback could be something like (untested):
>>
>> static int dr_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>>                 struct hid_field *field, struct hid_usage *usage,
>>                 unsigned long **bit, int *max)
>> {
>>         switch (usage->hid) {
>>         /*
>>          * revert the old hid-input behavior where axes
>>          * can be randomly assigned when the hid usage is
>>          * reused.
>>          */
>>         case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
>>         case HID_GD_RX: case HID_GD_RY: case HID_GD_RZ:
>>                 if (field->flags & HID_MAIN_ITEM_RELATIVE)
>>                         map_rel(usage->hid & 0xf);
>>                 else
>>                         map_abs(usage->hid & 0xf);
>>                 return 1;
>>         }
>>
>>         return 0;
>> }
>>
>> Hopefully, something like this should revert the old behavior for all
>> hid-dr touchpads.
>>
>> Ideally, we need to have Dragon Rise 0x0011 tested too. Nick, would you
>> mind checking it if you still have this particular device?
>>
>> Cheers,
>> Benjamin
>>
>>>
>>> Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
>>> ---
>>>  drivers/hid/hid-dr.c    |  2 ++
>>>  drivers/hid/hid-input.c | 16 +++++++++++-----
>>>  include/linux/hid.h     |  1 +
>>>  3 files changed, 14 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
>>> index 2523f8a..27fc826 100644
>>> --- a/drivers/hid/hid-dr.c
>>> +++ b/drivers/hid/hid-dr.c
>>> @@ -274,6 +274,8 @@ static int dr_probe(struct hid_device *hdev, const
>>> struct hid_device_id *id)
>>>                         hid_hw_stop(hdev);
>>>                         goto err;
>>>                 }
>>> +               /* has only 5 axes and reuses X, Y */
>>> +               hdev->quirks |= HID_QUIRK_REUSE_AXES;
>>>                 break;
>>>         }
>>>
>>> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
>>> index fb9ace1..1cc6fe4 100644
>>> --- a/drivers/hid/hid-input.c
>>> +++ b/drivers/hid/hid-input.c
>>> @@ -633,11 +633,17 @@ static void hidinput_configure_usage(struct
>>> hid_input *hidinput, struct hid_fiel
>>>                 /* These usage IDs map directly to the usage codes. */
>>>                 case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
>>>                 case HID_GD_RX: case HID_GD_RY: case HID_GD_RZ:
>>> -                       if (field->flags & HID_MAIN_ITEM_RELATIVE)
>>> -                               map_rel(usage->hid & 0xf);
>>> -                       else
>>> -                               map_abs_clear(usage->hid & 0xf);
>>> -                       break;
>>> +
>>> +                       /* if quirk is active don't force the userspace
>>> mapping,
>>> +                        * instead search and use the next available
>>> axis.
>>> +                        */
>>> +                       if (!(device->quirks & HID_QUIRK_REUSE_AXES)) {
>>> +                               if (field->flags &
>>> HID_MAIN_ITEM_RELATIVE)
>>> +                                       map_rel(usage->hid & 0xf);
>>> +                               else
>>> +                                       map_abs_clear(usage->hid & 0xf);
>>> +                               break;
>>> +                       }
>>>
>>>                 case HID_GD_SLIDER: case HID_GD_DIAL: case HID_GD_WHEEL:
>>>                         if (field->flags & HID_MAIN_ITEM_RELATIVE)
>>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>>> index 75b66ec..0979920 100644
>>> --- a/include/linux/hid.h
>>> +++ b/include/linux/hid.h
>>> @@ -320,6 +320,7 @@ struct hid_item {
>>>  #define HID_QUIRK_NO_EMPTY_INPUT               0x00000100
>>>  #define HID_QUIRK_NO_INIT_INPUT_REPORTS                0x00000200
>>>  #define HID_QUIRK_ALWAYS_POLL                  0x00000400
>>> +#define HID_QUIRK_REUSE_AXES                   0x00000800
>>>  #define HID_QUIRK_SKIP_OUTPUT_REPORTS          0x00010000
>>>  #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID                0x00020000
>>>  #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP 0x00040000
>>> --
>>> 2.10.0
>>>
>
