From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/5] hid: sony: Add support for the Sony Motion Controller
Date: Tue, 5 May 2015 23:55:50 +0200
Message-ID: <20150505215550.GA22219@amd>
References: <1430793272-11545-1-git-send-email-frank.praznik@oh.rr.com>
 <1430793272-11545-3-git-send-email-frank.praznik@oh.rr.com>
 <20150505211640.GA10272@amd>
 <20150505213606.GB15218@amd>
 <20150505214736.GA16332@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57928 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbbEEV4B (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2015 17:56:01 -0400
Content-Disposition: inline
In-Reply-To: <20150505214736.GA16332@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Hi!

> root@duo:/sys/class/leds/0003:054C:03D5.0002:global# echo 4 | fftest
> /dev/input/event8
> Force feedback test program.
> HOLD FIRMLY YOUR WHEEL OR JOYSTICK TO PREVENT DAMAGES
> 
> Device /dev/input/event8 opened
> Features:
>   * Absolute axes: X, Y, Z, RZ, Misc ,
>       [27 00 00 00 00 FF FF 7F ]
>         * Relative axes:
> 	    [00 00 ]
> 	      * Force feedback effects types: Periodic, Rumble, Gain,
> 	          Force feedback periodic effects: Square, Triangle,
> 		  Sine,
> 		      [00 00 00 00 00 00 00 00 00 00 03 07 01 00 00 00
> 		      ]
> 		        * Number of simultaneous effects: 16
> 
> Setting master gain to 75% ... OK
> Uploading effect #0 (Periodic sinusoidal) ... OK (id 0)
> Uploading effect #1 (Constant) ... Error: Invalid argument
> Uploading effect #2 (Spring) ... Error: Invalid argument
> Uploading effect #3 (Damper) ... Error: Invalid argument
> Uploading effect #4 (Strong rumble, with heavy motor) ... OK (id 1)
> Uploading effect #5 (Weak rumble, with light motor) ... OK (id 2)
> Enter effect number, -1 to exit
> Now Playing: Strong Rumble
> Enter effect number, -1 to exit
> Read error
> Stopping effects
> root@duo:/sys/class/leds/0003:054C:03D5.0002:global#
> 
> If it has just one motor, should it say so in the description? Not
> advertising both heavy and light motor.

Umm. Using echo with fftest was not good idea. Using it from command
line, it works normally.

Thanks and sorry for confusion,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
