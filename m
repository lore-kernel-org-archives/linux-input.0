From: Arek Burdach <arek.burdach@gmail.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Tue, 9 May 2017 14:51:33 +0200
Message-ID: <09314823-31c8-5855-d55c-3427b58b42ca@gmail.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
 <CAN+gG=FxbBc78Aw+WUxSFBfhTxbgGRJWTftgoRYYR-+1-OMioQ@mail.gmail.com>
 <4a35fbdc-b79f-dfc4-835d-f1339506c1c5@gmail.com>
 <CAN+gG=F41=cokdoWa=VVHTg6tXOg=vx0SAdCW5vyc9SMJu8X+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33346 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbdEIMvl (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 May 2017 08:51:41 -0400
Received: by mail-qt0-f194.google.com with SMTP id a46so13601933qte.0
        for <linux-input@vger.kernel.org>; Tue, 09 May 2017 05:51:36 -0700 (PDT)
In-Reply-To: <CAN+gG=F41=cokdoWa=VVHTg6tXOg=vx0SAdCW5vyc9SMJu8X+w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: =?UTF-8?Q?St=c3=a9phane_Chatty?= <chatty@enac.fr>, Andrew Duggan <aduggan@synaptics.com>, linux-input <linux-input@vger.kernel.org>


On 09.05.2017 14:20, Benjamin Tissoires wrote:
> On Tue, May 9, 2017 at 11:20 AM, Arek Burdach <arek.burdach@gmail.com> wrote:
>> Hi,
>>
>> Thank you for response.
>>
>> On 09.05.2017 10:35, Benjamin Tissoires wrote:
>>> On Sat, May 6, 2017 at 9:28 PM, Arek Burdach <arek.burdach@gmail.com>
>>> wrote:
>>>> Hi,
>>>>
>>>> A week ago I've reported a bug:
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=195625 Is there anybody that
>>>> can
>>>> help me with it?
>>> I can have a look at it.
>>> Please attach the full outputs of hid-recorder and evemu-record in the
>>> bugs, or it'll be difficult for us to debug it.
>> I've attached full logs for two situations. More details in the issue.
> Thanks, looks like a firmware issue (I'll comment in the bug).
Sorry for my noob questions, but do you suggest that it can't be fixed 
by changes in kernel modules and I need to report it to the manufacturer?
If it so, do you have an idea why it works well on Windows? Do they have 
some strange hacks in their drivers?


>
>>
>>>> I found out that some touchpads (and possible touchscreens?) are handled
>>>> by
>>>> both hid-multitouch and hid-rmi drivers. Is there a way to verify how the
>>>> touchscreen would work on hid-rmi drivers? I've tested it with kernel
>>>> 4.11.0-rc1 version where was this change:
>>>> 279967a65b320d174a507498aea7d44db3fee7f4 HID: rmi: Handle all Synaptics
>>>> touchpads using hid-rmi
>>>> which was reverted in later kernel's version. On this version, only my
>>>> touchpad was handled by hid-rmi, touchscreen was still handled by
>>>> hid-multitouch. Maybe I should change something in code or in compilation
>>>> configuration to force hid-rmi?
>>> Well, with 279967a65 applied, the system would know if the device can
>>> be handled through hid-rmi or not. If hid-multitouch was still used,
>>> that means that the device was not designed to be used as a rmi device
>>> at all (i.e. hid-rmi will not be able to talk to it).
>> In this patch, there is verified if hid group is HID_GROUP_MULTITOUCH_WIN_8.
>> Maybe this touchscreen is in group with greater priority during recognition.
>> Can I verify it somehow?
> With the logs you gave, the touchscreen is indeed Win 8 certified.
>
>> Also HID_GROUP_MULTITOUCH_WIN_8 recognition is done by this:
>>> usage == 0xff0000c5 && parser->global.report_count == 256 &&
>>> parser->global.report_size == 8
>> I assume that it is correct way to verify that. I wonder if it is possible
>> that something changed for a new devices.
> Nope, looks good for your device. The reason why hid-rmi is not
> picking up your device is because of the check "parser->scan_flags &
> HID_SCAN_FLAG_GD_POINTER": this matches only to indirect devices
> (touchpads).
>
> If you can recompile your hid and hid-rmi modules, you can try giving a shot at:
> - adding HID_I2C_DEVICE(USB_VENDOR_ID_SYNAPTICS, 0x1786) }, in
> hid_have_special_driver[] in hid-core.c
> - adding a corresponding line in rmi_id[] in file hid-rmi.c.
>
> This should force the device to bind to hid-rmi and you'll be able to
> see if the device works better in this situation or not.
Sorry for another noob question, but if I switch to hid-rmi, it should 
potentially produce other output in both /dev/hidraw output and 
/dev/input/event output or only in the second one?
I'm just wonder what is the pipeline.

I'll give a try to it and revert back to you with results. Thank you for 
tip!

>
> Cheers,
> Benjamin
>
>> Cheers,
>> Arek
>>
>>
>>> Cheers,
>>> Benjamin
>>>
>>>> Or it is a wrong way to go? I would be grateful for your help.
>>>>
>>>> Regards,
>>>> Arek
>>

