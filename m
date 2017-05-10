From: Arek Burdach <arek.burdach@gmail.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Wed, 10 May 2017 11:36:46 +0200
Message-ID: <03d13b14-1f97-eee7-4131-60ef014cbf50@gmail.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
 <CAN+gG=FxbBc78Aw+WUxSFBfhTxbgGRJWTftgoRYYR-+1-OMioQ@mail.gmail.com>
 <4a35fbdc-b79f-dfc4-835d-f1339506c1c5@gmail.com>
 <CAN+gG=F41=cokdoWa=VVHTg6tXOg=vx0SAdCW5vyc9SMJu8X+w@mail.gmail.com>
 <09314823-31c8-5855-d55c-3427b58b42ca@gmail.com>
 <CAN+gG=GY_0OKXNhmbDWmfEg0o4=Vf81r4rH3BGVmyd0suJdAtA@mail.gmail.com>
 <1f16ba27-99cd-d16d-f09f-97dcda1bd358@gmail.com>
 <dee48656-1993-b52d-5451-7a0cb186f18a@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34724 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbdEJJgt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 May 2017 05:36:49 -0400
Received: by mail-qt0-f194.google.com with SMTP id l39so3340329qtb.1
        for <linux-input@vger.kernel.org>; Wed, 10 May 2017 02:36:49 -0700 (PDT)
In-Reply-To: <dee48656-1993-b52d-5451-7a0cb186f18a@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: =?UTF-8?Q?St=c3=a9phane_Chatty?= <chatty@enac.fr>, linux-input <linux-input@vger.kernel.org>

Hi Andrew,

On 10.05.2017 01:47, Andrew Duggan wrote:
> HI Arek,
>
> On 05/09/2017 04:17 PM, Arek Burdach wrote:
>> Hi,
>>
>> I've tried described by you solution:
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 37084b645785..81f271554b6c 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -2510,6 +2510,7 @@ static const struct hid_device_id 
>> hid_ignore_list[] = {
>
> You need to add this to the hid_have_special_driver[] and not the 
> hid_ignore_list[].
Nice score for me - two lines and one bug :-)

> But, if you do success in binding hid-rmi to a touchscreen it won't 
> work. The firmware between touchpads and touchscreens are different 
> enough that the hid-rmi driver will be looking for data which does not 
> exist in touchscreen's HID report. These differences also mean that it 
> really isn't a good idea to try to support touchscreens with hid-rmi. 
> It would actually result in more transactions and be less efficient 
> then simply using hid-multitouch. That's why hid-core checks for the 
> HID_SCAN_FLAG_GD_POINTER in an attempt to make sure it's binding to a 
> touchpad and not a touchscreen.
It was just like you predict. On rmi, after first tap on screen, hidraw 
produced infinite number of events and it is not usable anymore.


>>
>> On 09.05.2017 16:02, Benjamin Tissoires wrote:
>>> On Tue, May 9, 2017 at 2:51 PM, Arek Burdach 
>>> <arek.burdach@gmail.com> wrote:
>>>> On 09.05.2017 14:20, Benjamin Tissoires wrote:
>>>>> On Tue, May 9, 2017 at 11:20 AM, Arek Burdach 
>>>>> <arek.burdach@gmail.com>
>>>>> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Thank you for response.
>>>>>>
>>>>>> On 09.05.2017 10:35, Benjamin Tissoires wrote:
>>>>>>> On Sat, May 6, 2017 at 9:28 PM, Arek Burdach 
>>>>>>> <arek.burdach@gmail.com>
>>>>>>> wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> A week ago I've reported a bug:
>>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=195625 Is there 
>>>>>>>> anybody
>>>>>>>> that
>>>>>>>> can
>>>>>>>> help me with it?
>>>>>>> I can have a look at it.
>>>>>>> Please attach the full outputs of hid-recorder and evemu-record 
>>>>>>> in the
>>>>>>> bugs, or it'll be difficult for us to debug it.
>>>>>> I've attached full logs for two situations. More details in the 
>>>>>> issue.
>>>>> Thanks, looks like a firmware issue (I'll comment in the bug).
>>>> Sorry for my noob questions, but do you suggest that it can't be 
>>>> fixed by
>>>> changes in kernel modules and I need to report it to the manufacturer?
>>> Yes. Though Andrew, in CC, works for Synaptics and might give us 
>>> some pointers.
>>>
>>>> If it so, do you have an idea why it works well on Windows? Do they 
>>>> have
>>>> some strange hacks in their drivers?
>>> I have no ideas how well it works under Windows, and I have no ideas
>>> if there are some strange hacks in the Windows nor in the Syanptics
>>> driver (I would assume so).
>>>
>
> We don't provide any drivers for touchscreens on Windows. So I don't 
> know how Microsoft is handling a situation like this.
Do you know what should be changed in firmware to make hid-touchscreen 
driver works correctly? Or maybe you know someone who is responsible for 
firmware for this device and whom I can call to gather this information?

Cheers,
Arek
