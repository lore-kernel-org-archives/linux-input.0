From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH v4 7/7] HID: sony: Add blink support to the Sixaxis and
 DualShock 4 LEDs
Date: Fri, 04 Apr 2014 14:37:48 -0400
Message-ID: <533EFBFC.1000105@gmail.com>
References: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>    <1396456285-23755-8-git-send-email-frank.praznik@oh.rr.com>    <fe23d57ea4d63af433e87f6641e5c339.squirrel@mungewell.org>    <533EBE48.5010100@oh.rr.com> <9eabb4ae4fb93b4c51816953fc453e4f.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:56802 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbaDDShw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Apr 2014 14:37:52 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so3794810ier.13
        for <linux-input@vger.kernel.org>; Fri, 04 Apr 2014 11:37:51 -0700 (PDT)
In-Reply-To: <9eabb4ae4fb93b4c51816953fc453e4f.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>
Cc: HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On 4/4/2014 12:11, simon@mungewell.org wrote:
> Why not make the triggers/etc apply across the board, so it doesn't matter
> which led the command is sent to - it's just registered/copied to the
> first (red?) led data[].

Unfortunately, it's not that simple.  There is no API for setting 
triggers from within the module and from looking at the code for these 
triggers, some set the hardware blink rate which will blink the whole 
light bar and some just use their own software timers and send 
brightness commands which will only effect the LED they are set on which 
results in unpredictable behavior depending on how the trigger is 
implemented.

These software-only triggers are why I'm thinking it would be good to 
have an extra global control for controlling the whole light bar 
synchronously.  Even if you set all the LEDs to the same software 
trigger the colors may not flash in sync if the trigger starts a 
separate timer for each LED and in some cases the trigger may mangle the 
user defined brightness settings (ie. the heartbeat trigger doesn't read 
the current brightness and just uses the maximum).

With an extra global switch, you can set the desired brightness levels 
for each color, then just use the global control to set the on/off state 
and get consistent blink behavior even if the trigger uses software 
timers or doesn't care about the user's brightness settings.  Plus, if 
for some reason you do want to flash individual colors, setting the 
blink rate of an individual color will always blink only that color 
instead of potentially blinking the whole light bar if the trigger tries 
to set the hardware blink rate.

I think it will be more functional, more predictable and less confusing.

>
>>> 3rd Party Intec - Was unable to get any controlled blinking.
>> It sounds like this controller just doesn't implement all of the
>> behavior of the official controller.  I'm not sure how to fix it if it's
>> not obeying the instructions in valid output reports and I don't have
>> one to test personally.  Do the lights flash properly when the
>> controller is used with a PS3?
> I presume that they just reversed engineered what they thought to be
> correct, I don't have a Playstation so can't confirm for certain.
>
> In my testing from a year ago or so, I could make the blink work via
> sending data with python. The script can be found here:
> http://www.spinics.net/lists/linux-input/msg28271.html
>
> Note: "Which LED to enable(LED1..4 << 1, 0x20=none)"
>
> Cheers,
> Simon
>

I'll take a look, but without having that particular controller all I 
can do is take a shot in the dark.
