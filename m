From: Dwayne Litzenberger <dlitz@patientway.com>
Subject: Re: evdev interface question: ABS_X without ABS_Y?
Date: Thu, 27 Oct 2011 09:53:13 -0400
Message-ID: <DAD9EEF9-9611-4B25-A810-EFEE4A3230CD@patientway.com>
References: <8A5EDD26-9BFD-4DAE-9C88-8E8D0908CE8B@patientway.com> <20111027054412.GC15725@core.coreip.homeip.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38545 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753251Ab1J0NxQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Oct 2011 09:53:16 -0400
In-Reply-To: <20111027054412.GC15725@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


On 2011-10-27, at 1:44 AM, Dmitry Torokhov wrote:
> On Wed, Oct 26, 2011 at 05:10:23PM -0400, Dwayne Litzenberger wrote:
>> Let's say I have a touchscreen, and I move my finger to (200,100).
>> I'll see something line this (simplified):
>> 
>>  EV_ABS ABS_X 200
>>  EV_ABS ABS_Y 100
>>  EV_SYN
>> 
>> Next, let's say I see something like this:
>> 
>>  EV_ABS ABS_Y 90
>>  EV_SYN
>> 
>> What is the meaning of that, from the perspective of userspace?
>> I see two possibilities.  Either:
>> 
>> 1. It's a move to (200,90), or
>> 2. It's a move to (0,90)
>> 
>> Which is the correct interpretation? 
> 
> Door #1.
> 
>> Is this documented anywhere?
> 
> From Documentation/input/event-codes.txt:
> 
> "The input protocol is a stateful protocol. Events are emitted only when
> values of event codes have changed. However, the state is maintained
> within the Linux input subsystem; drivers do not need to maintain the
> state and may attempt to emit unchanged values without harm. Userspace
> may obtain the current state of event code values using the EVIOCG*
> ioctls defined in linux/input.h."
> 
>> 
>> Apparently, the usbhid driver is generating events that imply #1, but
>> xserver-xorg-input-evdev interprets these according to #2.  I'm trying
>> to figure out what needs to be patched.  :)
> 
> xserver-xorg-input-evdev.

Awesome.  That's exactly what I need.  Thanks!

- Dwayne

