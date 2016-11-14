From: Daniel Eriksson <imerion@gmail.com>
Subject: Re: [HP Pavilion x2 - 12-b003nf] Synaptics touchpad not configured by
 HID RMI
Date: Mon, 14 Nov 2016 15:09:51 +0100
Message-ID: <CALYLGY23QzLh0VPH41K2v0wVHtHmhc_QPNEVKPtxeUAPs-4ypw@mail.gmail.com>
References: <CALYLGY0iV=kJxKku2sY1CnpONjzi-FJcZEbVtaUGRJgKKZrHTQ@mail.gmail.com>
 <20161104080828.GB20334@mail.corp.redhat.com> <CALYLGY1ZNd+ZVkA65bRH4epH7+WWpAe-knwK1pmChLkPyvpvjg@mail.gmail.com>
 <CALYLGY0FcRPFjKFT9PeABtSPQ5DFpvp4YnWUR_bU5Cg5jWwO2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33561 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752214AbcKNOJx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Nov 2016 09:09:53 -0500
Received: by mail-yw0-f193.google.com with SMTP id s68so6708261ywg.0
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2016 06:09:52 -0800 (PST)
In-Reply-To: <CALYLGY0FcRPFjKFT9PeABtSPQ5DFpvp4YnWUR_bU5Cg5jWwO2A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: aduggan@synaptics.com, jikos@kernel.org, linux-input@vger.kernel.org

Now I tried this branch as well :
https://github.com/bentiss/linux/commits/synaptics-rmi4-v4.8%2B

But I can't seem to get it to boot. I got a "gave up waiting for root
device". Something about missing modules and an alert followed by a
long UUID that does not exist. Probably has nothing to do with the hid
driver though, I probably just did something wrong when configuring or
compiling the kernel.

Thought I'd let you know. If there are other branches that needs
testing for this new hid driver I can do so. Especially good if there
are .debs available, so nothing get's screwed up along the compilation
process. :)


On Sun, Nov 6, 2016 at 4:51 PM, Daniel Eriksson <imerion@gmail.com> wrote:
> I managed to compile my own kernel, and can now confirm this branch:
> https://github.com/aduggan/linux/tree/development/hid-rmi
>
> Works perfect with the hardware I described. Two-finger scrolling,
> edge scrolling and correct acceleration all works as they should. :)
>
> Thanks to all involved! Now I only hope this gets pushed upstream soon. :)
>
>
> On Sat, Nov 5, 2016 at 3:10 AM, Daniel Eriksson <imerion@gmail.com> wrote:
>> On Fri, Nov 4, 2016 at 9:08 AM, Benjamin Tissoires
>> <benjamin.tissoires@redhat.com> wrote:
>>> On Nov 04 2016 or thereabouts, Daniel Eriksson wrote:
>>>> Hi! I'm having some trouble with my touchpad, so I figured I'd send a
>>>> report. Details can be seen below.
>>>>
>>>>
>>>> [1.] One line summary of the problem:
>>>>
>>>> Synaptics touchpad fail to be configured by HID RMI on a HP Pavilion
>>>> x2 (12-b003nf)
>>>>
>>>>
>>>> [2.] Full description of the problem/report:
>>>>
>>>> Touchpad on the HP Pavilion X2 12" does nothing after boot. dmesg shows:
>>>>
>>>> [    6.032160] hid-rmi 0003:06CB:7D29.0001: No 2D sensor found, giving up.
>>>> [    6.032273] hid-rmi 0003:06CB:7D29.0001: Error while initializing F11 (-19).
>>>
>>> Your sensor is probably using the F12 2D sensor, not the F11. We are
>>> aware of this issue, and patches has already been submitted. We need
>>> them to be pushed upstream...
>>>
>>> Meanwhile, if you can compile a kernel, you might be interested in:
>>> - https://github.com/aduggan/linux/tree/development/hid-rmi (branch
>>>   hid-rmi) -> this has been tested against F12 on RMI4 over HID
>>> - https://github.com/bentiss/linux/commits/synaptics-rmi4-v4.8%2B (
>>>   branch synaptics-rmi4-v4.8+) -> this is what matches the latest
>>>   submission (the HID part has not been tested and thus not submitted)
>>>
>>> Any help in testing would be appreciated! :)
>>>
>>> Cheers,
>>> Benjamin
>>>
>>
>> I see, great to hear! Any idea how long it would take to get it pushed upstream?
>> I want to help you test, but I'm not sure I can get the kernel
>> compilation right. I'll give it a go and return if I get any results!
>>
>> Thanks!
>>
>> Daniel
>>
>>
>>>> [    6.044758] hid-rmi 0003:06CB:7D29.0001: hiddev0,hidraw1: USB HID
>>>> v1.11 Mouse [SYNAPTICS Synaptics HIDUSB TouchPad V03] on
>>>> usb-0000:00:14.0-2.1/input0
>>>> [    6.044761] hid-rmi 0003:06CB:7D29.0001: Device failed to be
>>>> properly configured
>>>>
>>>> Latest bios is installed.
>>>>
>>>>
>>>> [3.] Keywords
>>>>
>>>>
>>>> [4.] Kernel version
>>>>
>>>> Linux version 4.8.6-040806-generic (kernel@tangerine) (gcc version
>>>> 6.2.0 20161005 (Ubuntu 6.2.0-5ubuntu12) ) #201610310831 SMP Mon Oct 31
>>>> 12:33:48 UTC 2016
>>>>
>>>>
>>>> [5.] Output of Oops.. message
>>>>
>>>> Not applicable.
>>>>
>>>>
>>>> [6.] A small shell script or example program which triggers the problem
>>>>
>>>> Not applicable. Problem always appears.
