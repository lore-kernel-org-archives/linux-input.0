From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [linux-pm] [2/6] 2.6.21-rc2: known regressions
Date: Mon, 19 Mar 2007 16:33:25 -0400
Message-ID: <45FEF395.9050409@tmr.com>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org>	 <20070305015034.GG3441@stusta.de> <20070308123143.GF5149@mellanox.co.il>	 <Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org>	 <20070308192554.GA2999@elte.hu> <20070308230705.GA4611@elte.hu>	 <Pine.LNX.4.64.0703081545110.10832@woody.linux-foundation.org>	 <20070309111957.GA3928@elf.ucw.cz>  <20070318160707.GC12673@elte.hu> <1174236045.6832.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1174236045.6832.9.camel@localhost>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: jg@laptop.org
Cc: Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@ucw.cz>, Ash Milsted <thatistosayiseenem@gawab.com>, dmitry.torokhov@gmail.com, Arkadiusz Miskiewicz <arekm@maven.pl>, linux-pm@lists.osdl.org, Jens Axboe <jens.axboe@oracle.com>, linux-input@atrey.karlin.mff.cuni.cz, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, linux-usb-devel@lists.sourceforge.net, Jeff Chua <jeff.chua.linux@gmail.com>, Meelis Roos <mroos@linux.ee>, Janosch Machowinski <jmachowinski@gmx.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Thomas Meyer <thomas.mey@web.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

Jim Gettys wrote:
> On Sun, 2007-03-18 at 17:07 +0100, Ingo Molnar wrote:
>> * Pavel Machek <pavel@ucw.cz> wrote:
>>
>>>> Some day we may have modesetting support in the kernel for some 
>>>> graphics hw, right now it's pretty damn spotty.
>>> Yep, that's the way to go.
>> hey, i wildly supported this approach ever since 1996, when GGI came up
>> :-/
>>
> 
> So wildly you wrote tons of code.... ;-).
> 
> More seriously, at the time, XFree86 would have spat in your face for
> any such thing.  Thankfully, times are changing.
> 
> Also more seriously, a somewhat hybrid approach is in order for mode
> setting: simple mode setting isn't much code and is required for sane
> behavior on crash (it is nice to get oopses onto a screen); but the full
> blown mode setting/configuration problem is so large that on some
> hardware, it is likely left best left to a helper process (not the X
> server).
> 
> Also key to get sane behavior out of the scheduler is to get the X
> server to yield (sleep in the kernel) rather than busy waiting when the
> GPU is busy; a standardized interface for this for both fbdev and dri is
> in order.  Right now, X is a misbehaving compute bound process rather
> than the properly interactive process it can/should/will be, releasing
> the CPU whenever the hardware is busy. Needless to say, this wastes
> cycles and hurts interactivity with just about any scheduler you can
> devise. It isn't as if this is hard; on UNIX systems we did it in 1984
> or thereabouts.

What you say sounds good, assuming that the cost of a sleep is less than 
the cost of the busy wait. But this may be hardware, the waits may be 
very small and frequent, and if it's hitting a small hardware window 
like retrace, delays in response will cause the time period to be missed 
completely. This probably less critical with very smart cards, many of 
us don't run them.
> 
> Of course, in 1996, XFree86 would have ignored any such interfaces, in
> its insane quest for operating system independent user space drivers
> requiring no standard kernel interfaces.... (it is the second part of
> this where the true insanity lay).
>                                   - Jim
> 


-- 
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
