From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH v4 7/7] HID: sony: Add blink support to the Sixaxis and
 DualShock 4 LEDs
Date: Wed, 09 Apr 2014 13:41:37 -0400
Message-ID: <53458651.5080507@gmail.com>
References: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>    <1396456285-23755-8-git-send-email-frank.praznik@oh.rr.com>    <fe23d57ea4d63af433e87f6641e5c339.squirrel@mungewell.org>    <533EBE48.5010100@oh.rr.com> <5ab597fe6a7cc937a8d41df6df7adc47.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:50696 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbaDIRlt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 13:41:49 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so2763342iec.37
        for <linux-input@vger.kernel.org>; Wed, 09 Apr 2014 10:41:49 -0700 (PDT)
In-Reply-To: <5ab597fe6a7cc937a8d41df6df7adc47.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>
Cc: HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On 4/9/2014 01:51, simon@mungewell.org wrote:
> Unfortunately I was unable to find the 'led chaining' code I mentioned. I
> guess it has been lost to the sands of time....
>
>>> 3rd Party Intec - Was unable to get any controlled blinking. As
>>> previously
>>> mentioned all leds flash (automatic, as if first plugged in) whenever
>>> all
>>> leds are turned off.
>>> I can control all leds in a static on/off mode, but can't set any
>>> blinking/timer behaviour
>> It sounds like this controller just doesn't implement all of the
>> behavior of the official controller.  I'm not sure how to fix it if it's
>> not obeying the instructions in valid output reports and I don't have
>> one to test personally.  Do the lights flash properly when the
>> controller is used with a PS3?
> I was able to patch the code so that I could turn all LEDs off my Intec
> controller, see attached. Tested this against the Intec and the SixAxis.

Thanks for taking care of this.  I'll add it to the v5 series when I 
send it in a couple of days.

>
> I was not able to make the LEDs flash in a controlled fashion, so you
> might be right about the controller not working properly - although my
> comments in python script suggests I did have something going.... must be
> missing a snippet of info.
>
>
> I also found that on the SixAxis, when I reported that I had to set 1st
> LED off before I could set it on.... this only applies when the controller
> was off and then plugged into USB. At this point the LEDs are slow
> flashing, and the 'brightness' reports as 1 (driver code only writes to
> device if value is changed).
>
> If the device was already on (LEDs flashing) then only the 1st LED is set
> on plug in, and I can turn LEDs off/on straight away.

Yeah, the controller overriding user settings and flashing by itself 
until the PS button is pushed is a particularly annoying aspect of the 
Sixaxis on USB and there is no perfect way to handle it.  I wish that I 
could just submit a report from within the driver the first time the PS 
button is pressed to restore the LED state, but that could mess with 
hidraw applications.  The next-best solution would probably be to not 
filter redundant LED state settings for Sixaxis controllers on USB.  
This way, userland can stop the flashing without having to toggle an LED 
on/off or off/on if they are already set to the desired state.  I'll 
make the change for v5.

Thanks again for all of the testing :)
