From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2/6] 2.6.21-rc2: known regressions
Date: Fri, 9 Mar 2007 12:19:58 +0100
Message-ID: <20070309111957.GA3928@elf.ucw.cz>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015034.GG3441@stusta.de> <20070308123143.GF5149@mellanox.co.il> <Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org> <20070308192554.GA2999@elte.hu> <20070308230705.GA4611@elte.hu> <Pine.LNX.4.64.0703081545110.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703081545110.10832@woody.linux-foundation.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-pm@lists.osdl.org, lenb@kernel.org, linux-acpi@vger.kernel.org, luming.yu@intel.com, Arkadiusz Miskiewicz <arekm@maven.pl>, Konstantin Karasyov <konstantin.a.karasyov@intel.com>, Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net, Thomas Meyer <thomas.mey@web.de>, Meelis Roos <mroos@linux.ee>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Janosch Machowinski <jmachowinski@gmx.de>, vladimir.p.lebedev@intel.com, Ash Milsted <thatistosayiseenem@gawab.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-input@vger.kernel.org

Hi!

> > disabling the following radeonfb options in the .config made resume work 
> > again:
> 
> In general, don't even *try* to use radeonfb for suspend/resume.
> 
> I don't think it has ever worked, except on some very rare laptops 
> (largely PPC Macs) where people had enough information to set up the 
> PLL's.

It worked ok on thinkpad x32. BIOS did the setup in resume case (with
acpi_sleep=..., anyway), and radeonfb could pick the card up from there.

> I don't think the other framebuffer drivers are much better.
> 
> You're better off using the VGA console, and lettign X re-initialize the 
> graphics device. That generally at least has a reasonably good chance of 
> working.

suspend.sf.net, s2ram there has a long list of tricks. If you invent
new one, please add it there.

> Re-initializing graphics modes really is very hard. You can try with the 
> BIOS video hack (I forget the kernel command line to turn it on), but we 
> really do end up depending on X doing it better.

...or you can try vbetool; it is similar hack to acpi_sleep=... , but
it works for more people.

> Some day we may have modesetting support in the kernel for some graphics 
> hw, right now it's pretty damn spotty.

Yep, that's the way to go.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
