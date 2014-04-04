From: simon@mungewell.org
Subject: Re: [PATCH v4 7/7] HID: sony: Add blink support to the Sixaxis and
 DualShock 4 LEDs
Date: Fri, 4 Apr 2014 17:13:55 -0400
Message-ID: <a7a124f17fadaebb5c6e42337a25421a.squirrel@mungewell.org>
References: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>
    <1396456285-23755-8-git-send-email-frank.praznik@oh.rr.com>
    <fe23d57ea4d63af433e87f6641e5c339.squirrel@mungewell.org>
    <533EBE48.5010100@oh.rr.com>
    <9eabb4ae4fb93b4c51816953fc453e4f.squirrel@mungewell.org>
    <533EFBFC.1000105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:48325 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaDDVN5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Apr 2014 17:13:57 -0400
In-Reply-To: <533EFBFC.1000105@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

> On 4/4/2014 12:11, simon@mungewell.org wrote:
>> Why not make the triggers/etc apply across the board, so it doesn't
>> matter
>> which led the command is sent to - it's just registered/copied to the
>> first (red?) led data[].
>
> Unfortunately, it's not that simple.

It never is.... :-(

> There is no API for setting
> triggers from within the module and from looking at the code for these
> triggers, some set the hardware blink rate which will blink the whole
> light bar and some just use their own software timers and send
> brightness commands which will only effect the LED they are set on which
> results in unpredictable behavior depending on how the trigger is
> implemented.

I see the driver has a special case/function for setting blink with
'sony_led_blink_set()' which could be made to do funky stuff but that
might very rapidly become messy.

> These software-only triggers are why I'm thinking it would be good to
> have an extra global control for controlling the whole light bar
> synchronously.

A while ago (summer 2012) I messed around with the idea of 'chaining'
(grouping) leds together into a linked list, such that any actions on the
head of the list were duplicated to all leds in the chain.

The chain was created by a new trigger 'chain' and given the parameter of
the led to follow. I got as far as some code (wanted to learn about linked
lists in the kernel), but don't remember whether it worked properly on
not.

In this use case we could 'chain' the red->blue, and then have the blue
trigger set as 'timer' (or 'heartbeat') to cause a 'off->purple' blinking.
This would remove the contention in your scheme of having two places/leds
('red' and 'all') which could be set differently.

I can see if there's still some code on my disk if others are interested
in the idea.
Simon.



