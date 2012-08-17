From: dturvene <dturvene@dahetral.com>
Subject: Re: New Alps protocol in the wild?
Date: Fri, 17 Aug 2012 12:46:36 -0400
Message-ID: <502E756C.4080509@dahetral.com>
References: <20120814103553.GF23370@arianrhod.panaceas.james.local> <87mx1xxy1y.fsf@gmail.com> <20120814160519.GC12473@artemis.panaceas.org> <87ipckwvp4.fsf@gmail.com> <87sjbnzau7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dahetral.com ([128.177.27.153]:39539 "EHLO dahetral.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758509Ab2HQQqo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Aug 2012 12:46:44 -0400
In-Reply-To: <87sjbnzau7.fsf@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: James <james@madingley.org>, Ignacio Casal Quinteiro <nacho.resa@gmail.com>, linux-input@vger.kernel.org

On 08/16/2012 01:04 AM, Ben Gamari wrote:
> Ben Gamari <bgamari.foss@gmail.com> writes:
>
> snip
>> Hopefully I'll find some more time in the next few days to figure out
>> the last few bits (primarily how multitouch events work). I wouldn't be
>> sad if someone finished the task for me, however.
>>
> Success! As it turns out, the process was actually not so bad. While I
> wasted much of the night trying to reverse the protocol, I realized that
> what I had come up with was nearly identical to the version 3
> documentation.  Trying the version 3 protocol with the device, I found
> that it was nearly immediately functional. It seems that while the
> initialization procedure has changed, the position report format is
> identical to previous generations.
>
> My tree[1] currently has a hacked brute-force initialization
> implementation, although it would probably be nice to figure out what
> this sequence actually means. Otherwise, it seems support for this device
> is a solved problem.
>
> Feel free to give my tree a try. I'd be interested to know whether it
> works for you.
>
> Cheers,
>
> - Ben
>
> [1] https://github.com/bgamari/linux/tree/alps
Ben -

I tried your fix on a Dell Inspiron 15R N5110 (I15R).  It did not work.  
Things I noticed:

1) Consistent with prior observations, the touchpad E7 signature for it 
is: 0x73 0x03 0x50, different than yours on the E6230.

2) Your alps_hw_init_v5 sequence does not work for my I15R.  I noticed 
that the sequence enters/exits command mode a couple times. Why not 
enter once, do the init and then exit?

3) When in command mode, the I15R accurately sets and retrieves 
registers (e.g. 0x0008 returns 0x00 0x08 0x02).  When not in command 
mode, all register reads return -1.  Oddly, the check in 
alps_enter_command_mode is 0x73 0x01 rather than 0x88 0x07.

So I think either I'm doing something wrong or I'm dealing with YAAP 
(Yet Another ALPS Protocol).

My question:  how did you get the protocol trace?  I think you said 
previously that the drive does some direct register I/O.  I couldn't see 
anything beyond PS/2 commands running under Virtual Box.

Dave

