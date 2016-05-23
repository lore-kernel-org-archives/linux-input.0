From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH v3] input: tablet: add Pegasus Notetaker tablet driver
Date: Mon, 23 May 2016 19:19:01 +0200
Message-ID: <57433B85.1050301@posteo.de>
References: <1464003592-24043-1-git-send-email-martink@posteo.de>
 <1464006414.12181.53.camel@suse.com> <5742FB0F.5070508@posteo.de>
 <1464008447.12181.58.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464008447.12181.58.camel@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: dmitry.torokhov@gmail.com, kernel-testers@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am 2016-05-23 um 15:00 schrieb Oliver Neukum:
> On Mon, 2016-05-23 at 14:43 +0200, Martin Kepplinger wrote:
>> Am 2016-05-23 um 14:26 schrieb Oliver Neukum:
>>> On Mon, 2016-05-23 at 13:39 +0200, Martin Kepplinger wrote:
>>>
>>>> It's *really* fun to use as an input tablet though! So let's support this
>>>> for everybody.
>>>
>>> Hi,
>>>
>>> I am afraid there are a few issues.
>>
>> Thanks for having a look, comments below.
>>
>>>
>>> 1. Why the kernel thread?
>>
>> I provide switching to the xy tablet mode by pressing a button during
>> runtime. So usb_control_msg() is called from the thread, not the
>> interrupt routine.
>>
>> We don't get in the way of any user app. If we leave that functionality
>> out, users may have to un- and replug in the device after using
>> userspace apps that transfer data or the like.
> 
> The functionality is OK, but the implementation, though creative,
> is buggy.
> 
> a - multiple devices will fail
> b - you have a race condition that will fail to wake the thread
>     if it is still running when the button is pressed again
> 
> Kernel threads are wasteful. Using the normal system work queue might be
> much easier

You're right. I'll definitely change this.

> 
>>> 2. This driver has questionable power management.
>>
>> I think I do it how others do it. Suspend/resume works. Anything
>> specific required here?
> 
> Runtime PM is missing.

There is no way to turn the device off. So like any other mouse or input
tablet we don't use runtime PM.

In case the Pen is out of range or off, we just don't handle URBs and do
nothing.

... but I may miss something, so in this case please get back to me.

thanks

                       martin

> 
> 	Regards
> 		Oliver
> 
> 
