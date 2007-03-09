From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [2/6] 2.6.21-rc2: known regressions
Date: Fri, 9 Mar 2007 10:00:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703090949140.10832@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org>
 <20070305015034.GG3441@stusta.de> <20070308123143.GF5149@mellanox.co.il>
 <Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org>
 <20070308192554.GA2999@elte.hu> <20070308230705.GA4611@elte.hu>
 <Pine.LNX.4.64.0703081545110.10832@woody.linux-foundation.org>
 <20070309105635.GA11635@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070309105635.GA11635@elte.hu>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Jeff Chua <jeff.chua.linux@gmail.com>, pavel@suse.cz, linux-pm@lists.osdl.org, lenb@kernel.org, linux-acpi@vger.kernel.org, luming.yu@intel.com, Arkadiusz Miskiewicz <arekm@maven.pl>, Konstantin Karasyov <konstantin.a.karasyov@intel.com>, Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net, Thomas Meyer <thomas.mey@web.de>, Meelis Roos <mroos@linux.ee>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Janosch Machowinski <jmachowinski@gmx.de>, vladimir.p.lebedev@intel.com, Ash Milsted <thatistosayiseenem@gawab.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-input@vger.kernel.org



On Fri, 9 Mar 2007, Ingo Molnar wrote:
> > Some day we may have modesetting support in the kernel for some 
> > graphics hw, right now it's pretty damn spotty.
> 
> having no video is what i'd have expected - but getting a /hang/ is not 
> what i'd have expected.

I debugged a case exactly like this (with the TRACE_RESUME() thing) back 
last November on my laptop.

The problem is that radeonfb actually *tries* to re-initialize the 
graphics chips, but because it doesn't know all the details, it does it 
wrong, and hangs the whole chip.

I forget exactly where it happened, and it might well be different for 
you. But this is exactly what TRACE_RESUME can be used to pinpoint if you 
want to try to debug it. 

			Linus
