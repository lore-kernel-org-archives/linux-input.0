From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: Method to power off HID device from driver?
Date: Wed, 7 Dec 2016 13:21:07 -0800
Message-ID: <CANndSKnrDmKG27Lji_3VeazHg_UtOGr-yVbFEb+o-dyEhi45UQ@mail.gmail.com>
References: <CANndSKn1JE0Fnxgn9rpUyR1fUv7GM_Y4xwpfevSUiOYnVSYYig@mail.gmail.com>
 <CANndSK=-V0DXWh=XCr=GUAyWvQ0ZKrRfDdkvhFMbVWTj57+uiQ@mail.gmail.com> <D5A9B8BF-4720-4BB4-826E-CCA150D2976F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34159 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932594AbcLGVVJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2016 16:21:09 -0500
Received: by mail-vk0-f46.google.com with SMTP id x186so219393761vkd.1
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2016 13:21:08 -0800 (PST)
In-Reply-To: <D5A9B8BF-4720-4BB4-826E-CCA150D2976F@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Dec 6, 2016 at 7:20 PM, Cameron Gutman <aicommander@gmail.com> wrote:
> Hi,
>
>> On Dec 6, 2016, at 4:25 PM, Roderick Colenbrander <roderick@gaikai.com> wrote:
>>
>> Hi,
>>
>> I looked a bit deeper and found EV_PWR, though it isn't clearly
>> defined, but it is used in some places for purposes like this. Would
>> this be an acceptable method?
>>
>
> I am interested in this too. I recently implemented the ability to
> turn off wireless Xbox 360 controllers in [0], but there is no way
> to activate this functionality without suspending the whole system.
> Some folks [1] have asked for this ability in other scenarios.
>
> [0]: Commit f712a5a05228058f6b74 ("Input: xpad - power off wireless
>                                    360 controllers on suspend")
> [1]: https://github.com/paroj/xpad/issues/52
>
>> Thanks,
>> Roderick
>>
>> On Thu, Dec 1, 2016 at 6:05 PM, Roderick Colenbrander
>> <roderick@gaikai.com> wrote:
>>> Hi,
>>>
>>> Some of the devices I'm dealing with have methods to disconnect the
>>> device through HID reports. This is mostly useful for wireless devices
>>> to save battery and power them off e.g. when no activity in a wihle or
>>> user wants to turn device off (some devices don't have a power off
>>> button).
>>>
>>> I was trying to figure out if it there is some generic way without
>>> inventing a driver specific method. So far I haven't found anything on
>>> the HID side. The use case is not that common often a user would
>>> unplug a cable, but for some devices there is no real other way.
>>>
>>> The closest thing I found was 'poweroff' as supported by device power
>>> management spec:
>>> https://www.kernel.org/doc/Documentation/power/devices.txt. The HID
>>> drivers only support a subset of this so far.
>>>
>>> Does anyone have a good suggestion for handling this?
>>>
>>> Thanks,
>>> Roderick
>>
>>
>>
>> --
>> Roderick Colenbrander
>> Senior Manager of Software Engineering
>> Gaikai, a Sony Interactive Entertainment Company
>> roderick@gaikai.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Great, I was actually about to look at the xpad driver, because I saw
the auto_poweroff. The poweroff functionality you desire for xpad is
the same as I need as well.

I'm doing some more digging in the best way of handling this, but not
much luck. The best lead I have is the 'input_dev_poweroff' call in
drivers/input/input.c. I wonder if this call should get a callback,
which drivers can optionally provide to do a poweroff. So far I'm not
exactly sure how this poweroff is triggered and whether it is the
appropriate thing to hook into.

Any suggestions welcome :)
