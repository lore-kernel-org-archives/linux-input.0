From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Tue, 9 May 2017 14:20:50 +0200
Message-ID: <CAN+gG=F41=cokdoWa=VVHTg6tXOg=vx0SAdCW5vyc9SMJu8X+w@mail.gmail.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
 <CAN+gG=FxbBc78Aw+WUxSFBfhTxbgGRJWTftgoRYYR-+1-OMioQ@mail.gmail.com> <4a35fbdc-b79f-dfc4-835d-f1339506c1c5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34233 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753476AbdEIMU5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 May 2017 08:20:57 -0400
Received: by mail-qk0-f181.google.com with SMTP id k74so77955251qke.1
        for <linux-input@vger.kernel.org>; Tue, 09 May 2017 05:20:56 -0700 (PDT)
In-Reply-To: <4a35fbdc-b79f-dfc4-835d-f1339506c1c5@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arek Burdach <arek.burdach@gmail.com>
Cc: =?UTF-8?Q?St=C3=A9phane_Chatty?= <chatty@enac.fr>, Andrew Duggan <aduggan@synaptics.com>, linux-input <linux-input@vger.kernel.org>

On Tue, May 9, 2017 at 11:20 AM, Arek Burdach <arek.burdach@gmail.com> wrote:
> Hi,
>
> Thank you for response.
>
> On 09.05.2017 10:35, Benjamin Tissoires wrote:
>>
>> On Sat, May 6, 2017 at 9:28 PM, Arek Burdach <arek.burdach@gmail.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> A week ago I've reported a bug:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=195625 Is there anybody that
>>> can
>>> help me with it?
>>
>> I can have a look at it.
>> Please attach the full outputs of hid-recorder and evemu-record in the
>> bugs, or it'll be difficult for us to debug it.
>
> I've attached full logs for two situations. More details in the issue.

Thanks, looks like a firmware issue (I'll comment in the bug).

>
>
>>> I found out that some touchpads (and possible touchscreens?) are handled
>>> by
>>> both hid-multitouch and hid-rmi drivers. Is there a way to verify how the
>>> touchscreen would work on hid-rmi drivers? I've tested it with kernel
>>> 4.11.0-rc1 version where was this change:
>>> 279967a65b320d174a507498aea7d44db3fee7f4 HID: rmi: Handle all Synaptics
>>> touchpads using hid-rmi
>>> which was reverted in later kernel's version. On this version, only my
>>> touchpad was handled by hid-rmi, touchscreen was still handled by
>>> hid-multitouch. Maybe I should change something in code or in compilation
>>> configuration to force hid-rmi?
>>
>> Well, with 279967a65 applied, the system would know if the device can
>> be handled through hid-rmi or not. If hid-multitouch was still used,
>> that means that the device was not designed to be used as a rmi device
>> at all (i.e. hid-rmi will not be able to talk to it).
>
> In this patch, there is verified if hid group is HID_GROUP_MULTITOUCH_WIN_8.
> Maybe this touchscreen is in group with greater priority during recognition.
> Can I verify it somehow?

With the logs you gave, the touchscreen is indeed Win 8 certified.

>
> Also HID_GROUP_MULTITOUCH_WIN_8 recognition is done by this:
>>
>> usage == 0xff0000c5 && parser->global.report_count == 256 &&
>> parser->global.report_size == 8
>
> I assume that it is correct way to verify that. I wonder if it is possible
> that something changed for a new devices.

Nope, looks good for your device. The reason why hid-rmi is not
picking up your device is because of the check "parser->scan_flags &
HID_SCAN_FLAG_GD_POINTER": this matches only to indirect devices
(touchpads).

If you can recompile your hid and hid-rmi modules, you can try giving a shot at:
- adding HID_I2C_DEVICE(USB_VENDOR_ID_SYNAPTICS, 0x1786) }, in
hid_have_special_driver[] in hid-core.c
- adding a corresponding line in rmi_id[] in file hid-rmi.c.

This should force the device to bind to hid-rmi and you'll be able to
see if the device works better in this situation or not.

Cheers,
Benjamin

>
> Cheers,
> Arek
>
>
>> Cheers,
>> Benjamin
>>
>>> Or it is a wrong way to go? I would be grateful for your help.
>>>
>>> Regards,
>>> Arek
>
>
