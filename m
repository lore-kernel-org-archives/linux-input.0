From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Tue, 9 May 2017 16:47:09 -0700
Message-ID: <dee48656-1993-b52d-5451-7a0cb186f18a@synaptics.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
 <CAN+gG=FxbBc78Aw+WUxSFBfhTxbgGRJWTftgoRYYR-+1-OMioQ@mail.gmail.com>
 <4a35fbdc-b79f-dfc4-835d-f1339506c1c5@gmail.com>
 <CAN+gG=F41=cokdoWa=VVHTg6tXOg=vx0SAdCW5vyc9SMJu8X+w@mail.gmail.com>
 <09314823-31c8-5855-d55c-3427b58b42ca@gmail.com>
 <CAN+gG=GY_0OKXNhmbDWmfEg0o4=Vf81r4rH3BGVmyd0suJdAtA@mail.gmail.com>
 <1f16ba27-99cd-d16d-f09f-97dcda1bd358@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:44325 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbdEIXrK (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 May 2017 19:47:10 -0400
In-Reply-To: <1f16ba27-99cd-d16d-f09f-97dcda1bd358@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arek Burdach <arek.burdach@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: =?UTF-8?Q?St=c3=a9phane_Chatty?= <chatty@enac.fr>, linux-input <linux-input@vger.kernel.org>

HI Arek,

On 05/09/2017 04:17 PM, Arek Burdach wrote:
> Hi,
>
> I've tried described by you solution:
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 37084b645785..81f271554b6c 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2510,6 +2510,7 @@ static const struct hid_device_id 
> hid_ignore_list[] = {

You need to add this to the hid_have_special_driver[] and not the 
hid_ignore_list[].

But, if you do success in binding hid-rmi to a touchscreen it won't 
work. The firmware between touchpads and touchscreens are different 
enough that the hid-rmi driver will be looking for data which does not 
exist in touchscreen's HID report. These differences also mean that it 
really isn't a good idea to try to support touchscreens with hid-rmi. It 
would actually result in more transactions and be less efficient then 
simply using hid-multitouch. That's why hid-core checks for the 
HID_SCAN_FLAG_GD_POINTER in an attempt to make sure it's binding to a 
touchpad and not a touchscreen.

>         { HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, 
> USB_DEVICE_ID_SYNAPTICS_WTP) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, 
> USB_DEVICE_ID_SYNAPTICS_DPAD) },
>  #endif
> +       { HID_I2C_DEVICE(USB_VENDOR_ID_SYNAPTICS, 0x1786) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, 
> USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
>         { }
>  };
> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index 5b40c2614599..ac2ea6ad2e53 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -714,6 +714,7 @@ static void rmi_remove(struct hid_device *hdev)
>  }
>
>  static const struct hid_device_id rmi_id[] = {
> +       { HID_I2C_DEVICE(USB_VENDOR_ID_SYNAPTICS, 0x1786) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_RAZER, 
> USB_DEVICE_ID_RAZER_BLADE_14),
>                 .driver_data = RMI_DEVICE_HAS_PHYS_BUTTONS },
>         { HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, 
> USB_DEVICE_ID_LENOVO_X1_COVER) },
>
>
> and now neither hid-touchscreen nor hid-rmi peaking up my touchscreen 
> (also missing hidraw device)
>
> Any other idea how to force hid-rmi to peak the device?
>
> Cheers,
> Arek
>
> On 09.05.2017 16:02, Benjamin Tissoires wrote:
>> On Tue, May 9, 2017 at 2:51 PM, Arek Burdach <arek.burdach@gmail.com> 
>> wrote:
>>> On 09.05.2017 14:20, Benjamin Tissoires wrote:
>>>> On Tue, May 9, 2017 at 11:20 AM, Arek Burdach <arek.burdach@gmail.com>
>>>> wrote:
>>>>> Hi,
>>>>>
>>>>> Thank you for response.
>>>>>
>>>>> On 09.05.2017 10:35, Benjamin Tissoires wrote:
>>>>>> On Sat, May 6, 2017 at 9:28 PM, Arek Burdach 
>>>>>> <arek.burdach@gmail.com>
>>>>>> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> A week ago I've reported a bug:
>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=195625 Is there anybody
>>>>>>> that
>>>>>>> can
>>>>>>> help me with it?
>>>>>> I can have a look at it.
>>>>>> Please attach the full outputs of hid-recorder and evemu-record 
>>>>>> in the
>>>>>> bugs, or it'll be difficult for us to debug it.
>>>>> I've attached full logs for two situations. More details in the 
>>>>> issue.
>>>> Thanks, looks like a firmware issue (I'll comment in the bug).
>>> Sorry for my noob questions, but do you suggest that it can't be 
>>> fixed by
>>> changes in kernel modules and I need to report it to the manufacturer?
>> Yes. Though Andrew, in CC, works for Synaptics and might give us some 
>> pointers.
>>
>>> If it so, do you have an idea why it works well on Windows? Do they 
>>> have
>>> some strange hacks in their drivers?
>> I have no ideas how well it works under Windows, and I have no ideas
>> if there are some strange hacks in the Windows nor in the Syanptics
>> driver (I would assume so).
>>

We don't provide any drivers for touchscreens on Windows. So I don't 
know how Microsoft is handling a situation like this.

Andrew

>>>
>>>
>>>>>>> I found out that some touchpads (and possible touchscreens?) are
>>>>>>> handled
>>>>>>> by
>>>>>>> both hid-multitouch and hid-rmi drivers. Is there a way to 
>>>>>>> verify how
>>>>>>> the
>>>>>>> touchscreen would work on hid-rmi drivers? I've tested it with 
>>>>>>> kernel
>>>>>>> 4.11.0-rc1 version where was this change:
>>>>>>> 279967a65b320d174a507498aea7d44db3fee7f4 HID: rmi: Handle all 
>>>>>>> Synaptics
>>>>>>> touchpads using hid-rmi
>>>>>>> which was reverted in later kernel's version. On this version, 
>>>>>>> only my
>>>>>>> touchpad was handled by hid-rmi, touchscreen was still handled by
>>>>>>> hid-multitouch. Maybe I should change something in code or in
>>>>>>> compilation
>>>>>>> configuration to force hid-rmi?
>>>>>> Well, with 279967a65 applied, the system would know if the device 
>>>>>> can
>>>>>> be handled through hid-rmi or not. If hid-multitouch was still used,
>>>>>> that means that the device was not designed to be used as a rmi 
>>>>>> device
>>>>>> at all (i.e. hid-rmi will not be able to talk to it).
>>>>> In this patch, there is verified if hid group is
>>>>> HID_GROUP_MULTITOUCH_WIN_8.
>>>>> Maybe this touchscreen is in group with greater priority during
>>>>> recognition.
>>>>> Can I verify it somehow?
>>>> With the logs you gave, the touchscreen is indeed Win 8 certified.
>>>>
>>>>> Also HID_GROUP_MULTITOUCH_WIN_8 recognition is done by this:
>>>>>> usage == 0xff0000c5 && parser->global.report_count == 256 &&
>>>>>> parser->global.report_size == 8
>>>>> I assume that it is correct way to verify that. I wonder if it is
>>>>> possible
>>>>> that something changed for a new devices.
>>>> Nope, looks good for your device. The reason why hid-rmi is not
>>>> picking up your device is because of the check "parser->scan_flags &
>>>> HID_SCAN_FLAG_GD_POINTER": this matches only to indirect devices
>>>> (touchpads).
>>>>
>>>> If you can recompile your hid and hid-rmi modules, you can try 
>>>> giving a
>>>> shot at:
>>>> - adding HID_I2C_DEVICE(USB_VENDOR_ID_SYNAPTICS, 0x1786) }, in
>>>> hid_have_special_driver[] in hid-core.c
>>>> - adding a corresponding line in rmi_id[] in file hid-rmi.c.
>>>>
>>>> This should force the device to bind to hid-rmi and you'll be able to
>>>> see if the device works better in this situation or not.
>>> Sorry for another noob question, but if I switch to hid-rmi, it should
>>> potentially produce other output in both /dev/hidraw output and
>>> /dev/input/event output or only in the second one?
>> The more, the better. Please provide all logs, hidraw and evemu.
>>
>>> I'm just wonder what is the pipeline.
>>>
>>> I'll give a try to it and revert back to you with results. Thank you 
>>> for
>>> tip!
>> No worries.
>>
>> Cheers,
>> Benjamin
>>
>>>
>>>> Cheers,
>>>> Benjamin
>>>>
>>>>> Cheers,
>>>>> Arek
>>>>>
>>>>>
>>>>>> Cheers,
>>>>>> Benjamin
>>>>>>
>>>>>>> Or it is a wrong way to go? I would be grateful for your help.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Arek
>>>>>
>

