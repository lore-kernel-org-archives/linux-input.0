From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH v4 7/7] HID: sony: Add blink support to the Sixaxis and
 DualShock 4 LEDs
Date: Fri, 04 Apr 2014 19:41:43 -0400
Message-ID: <533F4337.8000101@gmail.com>
References: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>    <1396456285-23755-8-git-send-email-frank.praznik@oh.rr.com>    <fe23d57ea4d63af433e87f6641e5c339.squirrel@mungewell.org>    <533EBE48.5010100@oh.rr.com>    <9eabb4ae4fb93b4c51816953fc453e4f.squirrel@mungewell.org>    <533EFBFC.1000105@gmail.com> <a7a124f17fadaebb5c6e42337a25421a.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54893 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbaDDXlq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Apr 2014 19:41:46 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so4084342iec.21
        for <linux-input@vger.kernel.org>; Fri, 04 Apr 2014 16:41:46 -0700 (PDT)
In-Reply-To: <a7a124f17fadaebb5c6e42337a25421a.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Frank Praznik <frank.praznik@oh.rr.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On 4/4/2014 17:13, simon@mungewell.org wrote:
> I see the driver has a special case/function for setting blink with 
> 'sony_led_blink_set()' which could be made to do funky stuff but that 
> might very rapidly become messy.
>> These software-only triggers are why I'm thinking it would be good to
>> have an extra global control for controlling the whole light bar
>> synchronously.
> A while ago (summer 2012) I messed around with the idea of 'chaining'
> (grouping) leds together into a linked list, such that any actions on the
> head of the list were duplicated to all leds in the chain.
>
> The chain was created by a new trigger 'chain' and given the parameter of
> the led to follow. I got as far as some code (wanted to learn about linked
> lists in the kernel), but don't remember whether it worked properly on
> not.
>
> In this use case we could 'chain' the red->blue, and then have the blue
> trigger set as 'timer' (or 'heartbeat') to cause a 'off->purple' blinking.
> This would remove the contention in your scheme of having two places/leds
> ('red' and 'all') which could be set differently.
>
> I can see if there's still some code on my disk if others are interested
> in the idea.
> Simon.

This sounds kind of like how things work now: The blink function maps 
all blink requests to any of the LEDs to one global value and uses that 
to set the hardware delay on/off values.

I'd be interested in seeing your solution if you still have it, but that 
still sounds like it still wouldn't work in the case of something like 
the heartbeat trigger which doesn't actually use the blink function, 
just runs it's own internal timer and just changes the brightness every 
so often.  The LED code in the module doesn't know where the commands 
are coming from, just that it's being told to change brightness so it 
wouldn't know which commands come from a trigger and should effect 
everything vs which are user commands and should just change the 
brightness of that specific LED.
