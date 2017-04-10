From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: Crash caused by hid-rmi and no longer working touchscreen
Date: Mon, 10 Apr 2017 12:41:38 -0700
Message-ID: <b2dab9bf-28ff-09f3-7eba-6a29ca201804@synaptics.com>
References: <b79b88c8-770a-13f6-5668-c3a94254e5e0@gmail.com>
 <alpine.LSU.2.20.1704101515380.28004@cbobk.fhfr.pm>
 <20170410183802.GA39262@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:32052 "EHLO
        us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbdDJTlj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 15:41:39 -0400
In-Reply-To: <20170410183802.GA39262@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Gabriele Mazzotta <gabriele.mzt@gmail.com>, benjamin.tissoires@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Cameron Gutman <aicommander@gmail.com>, Thorsten Leemhuis <linux@leemhuis.info>, Nick Dyer <nick@shmanahar.org>, Christopher Heiny <cheiny@synaptics.com>

On 04/10/2017 11:38 AM, Dmitry Torokhov wrote:
> On Mon, Apr 10, 2017 at 03:18:03PM +0200, Jiri Kosina wrote:
>> [ a couple more people from "the other regression thread" added to CC ]
>>
>> On Mon, 10 Apr 2017, Gabriele Mazzotta wrote:
>>
>>> Hi,
>>>
>>> I'm having troubles with hid-rmi using 4.11-rc6. I'm getting some
>>> "rmi_hid_read_block: timeout elapsed" errors and ultimately the
>>> crash you can see at the end of this mail. I will reply to this
>>> mail with a full log that shows all the errors.
>>>
>>> The problem seems to be caused by commit 279967a65b320d174a507498ae
>>> ("HID: rmi: Handle all Synaptics touchpads using hid-rmi").
>>>
>>> My laptop has a Synaptics touchpad and a Synaptics touchscreen.
>>> Because of that commit, hid-rmi is used for both the devices, while
>>> it has always been used only for the touchpad. Needless to say that
>>> the touchscreen no longer works.
>>>
>>> If I revert that commit, everything goes back to normal.
>> Alright, given this is a second regression cause by this switch, I suggest
>> to revert this one for 4.11 still, and work on fixing this properly for
>> 4.12.
>>
>> If noone raises any objections (a few more people added to Cc), I'll queue
>> a 4.11-rc revert tomorrow.
> Yes, we also have this:
>
> 	https://bugzilla.kernel.org/show_bug.cgi?id=195287

I suspect that the issue might be that both of these touchscreens have 
the HID_GD_POINTER usage defined in their HID report descriptor. This 
might be because the firmware is configured to support pens. It looks 
like the Asus T302CA from the bug does have a pen and the XPS13 9333 may 
simply have firmware which has pen support enabled. The HID_GD_POINTER 
usage is used in hid-core to differentiate between touchpads and 
touchscreens. So if a touchscreen has HID_GD_POINTER defined then 
hid-core will bind hid-rmi to it. None, of my test systems have pen 
support so I did not anticipate this.

Also, the reason why we can't just support touchscreens using hid-rmi is 
because the firmware for HID touchscreens lacks the functionality of 
reporting the attention data (finger positions) in a single report. It 
ends up being less efficient to run HID touchscreens in RMI mode.

> so reverting seems prudent at this time.

Yes, I agree we should revert the commit. There simply isn't enough time 
to come up with and test a new method for differentiating touchpads and 
touchscreens before 4.11 is released.

Andrew

> Thanks.
>

