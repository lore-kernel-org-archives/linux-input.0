From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 09 Mar 2010 23:40:05 -0500
Message-ID: <4B9722A5.1030607@seas.upenn.edu>
References: <4B760D60.6020907@seas.upenn.edu> <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz> <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu> <4B96C4A8.3060005@euromail.se> <4B96CB41.9040804@seas.upenn.edu> <4B96D85A.4060604@euromail.se> <4B96DBEE.4060605@seas.upenn.edu> <20100309234223.GB29942@core.coreip.homeip.net> <4B96E8B9.1040605@seas.upenn.edu> <20100310034742.GA20434@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:35056 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756282Ab0CJEkW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 23:40:22 -0500
In-Reply-To: <20100310034742.GA20434@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, chatty@enac.fr

On 03/09/2010 10:47 PM, Dmitry Torokhov wrote:
> On Tue, Mar 09, 2010 at 07:32:57PM -0500, Rafi Rubin wrote:
>> On 03/09/2010 06:42 PM, Dmitry Torokhov wrote:
>>> On Tue, Mar 09, 2010 at 06:38:22PM -0500, Rafi Rubin wrote:
>>>> On 03/09/2010 06:23 PM, Henrik Rydberg wrote:
>>>>> Rafi Rubin wrote:
>>>>>>> Single touch should be goverened by one of BTN_TOUCH or ABS_PRESSURE.
>>>>>>> BTN_TOOL_DOUBLETAP is a two-finger event.
>>>>>>
>>>>>> That definitely makes sense to me.  I really don't know why wacom uses
>>>>>> double tap there.
>>>>>>
>>>>>> Is there any harm in letting through the BTN_0 events?  Is the "rdesc"
>>>>>> mapping defined by the hardware or hid?
>>>>>
>>>>> I cannot imagine BTN_0 will do any harm. In synaptics, the BTN_X buttons are
>>>>> mapped to multibuttons without clear-cut usage. The button events that carry
>>>>> well-defined semantic meaning with regard to touch screens are BTN_TOUCH (any
>>>>> finger), BTN_TOOL_FINGER (one finger), BTN_TOOL_PEN (pen), BTN_TOOL_DOUBLETAP
>>>>> (two fingers) and BTN_TOOL_TRIPLETAP (three fingers or more).
>>>>>
>>>>> Henrik
>>>>>
>>>>
>>>> Perhaps we should have a general touch device document.
>>>>
>>>> I looked at the evdev code.  And as you say for single touch
>>>> devices, BTN_TOUCH is the bit that matters.  It only broken because
>>>> I pulled the TOUCH<- 0 when I removed BTN_0.
>>>>
>>>> So why does evdev associate BTN_TOOL_FINGER with touchpads
>>>> (resulting in the wrong set of assumptions and a poorly calibrated
>>>> touch screen)?  I suppose that's really a discussion for another
>>>> list.
>>>>
>>>
>>> Historic reasons. When Synaptics driver was in works we needed an event
>>> that is different from BTN_TOUCH to differentiate from touchscreens.
>>
>> So should I clear the BTN_TOOL_FINGER bit for ntrig, or push to
>> clean up evdev?
>>
>> At the moment nothing is actually expecting or emitting the finger
>> events.  Given the move to actual mt support does it make sense to
>> use finger, double and triple for single touch events?  I'd vote for
>> letting the user space mt tools handle more advanced button clicks.
>>
>
> I'd opt for this as well; let's leave BTN_TOOL_FINGER to touchpads.

Ok. I'll clear FINGER.  For now, I'll leave the incorrect DOUBLETAP as 
is to avoid breaking compatibility with the wacom driver.  Ugly or not, 
most people I've heard from who use this device use that driver.

What's the proper style for labeling code as deprecated and to be 
removed after viable alternatives are well established?

Rafi
