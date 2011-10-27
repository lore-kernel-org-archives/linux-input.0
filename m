From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: evdev interface question: ABS_X without ABS_Y?
Date: Wed, 26 Oct 2011 22:44:12 -0700
Message-ID: <20111027054412.GC15725@core.coreip.homeip.net>
References: <8A5EDD26-9BFD-4DAE-9C88-8E8D0908CE8B@patientway.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43368 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab1J0FoR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Oct 2011 01:44:17 -0400
Received: by ggnb1 with SMTP id b1so2311653ggn.19
        for <linux-input@vger.kernel.org>; Wed, 26 Oct 2011 22:44:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8A5EDD26-9BFD-4DAE-9C88-8E8D0908CE8B@patientway.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dwayne Litzenberger <dlitz@patientway.com>
Cc: linux-input@vger.kernel.org

Hi Dwayne,

On Wed, Oct 26, 2011 at 05:10:23PM -0400, Dwayne Litzenberger wrote:
> I have a quick question about the /dev/input/eventX interface with
> userspace.
> 
> Let's say I have a touchscreen, and I move my finger to (200,100).
> I'll see something line this (simplified):
> 
>   EV_ABS ABS_X 200
>   EV_ABS ABS_Y 100
>   EV_SYN
> 
> Next, let's say I see something like this:
> 
>   EV_ABS ABS_Y 90
>   EV_SYN
> 
> What is the meaning of that, from the perspective of userspace?
> I see two possibilities.  Either:
> 
> 1. It's a move to (200,90), or
> 2. It's a move to (0,90)
> 
> Which is the correct interpretation? 

Door #1.

> Is this documented anywhere?

>From Documentation/input/event-codes.txt:

"The input protocol is a stateful protocol. Events are emitted only when
values of event codes have changed. However, the state is maintained
within the Linux input subsystem; drivers do not need to maintain the
state and may attempt to emit unchanged values without harm. Userspace
may obtain the current state of event code values using the EVIOCG*
ioctls defined in linux/input.h."

> 
> Apparently, the usbhid driver is generating events that imply #1, but
> xserver-xorg-input-evdev interprets these according to #2.  I'm trying
> to figure out what needs to be patched.  :)

xserver-xorg-input-evdev.

Thanks.

-- 
Dmitry
