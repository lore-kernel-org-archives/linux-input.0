From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [2/6] 2.6.21-rc2: known regressions
Date: Fri, 9 Mar 2007 00:12:46 +0100
Message-ID: <20070308231246.GA6267@elte.hu>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015034.GG3441@stusta.de> <20070308123143.GF5149@mellanox.co.il> <Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org> <20070308192554.GA2999@elte.hu> <20070308230705.GA4611@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070308230705.GA4611@elte.hu>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Jeff Chua <jeff.chua.linux@gmail.com>, pavel@suse.cz, linux-pm@lists.osdl.org, lenb@kernel.org, linux-acpi@vger.kernel.org, luming.yu@intel.com, Arkadiusz Miskiewicz <arekm@maven.pl>, Konstantin Karasyov <konstantin.a.karasyov@intel.com>, Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net, Thomas Meyer <thomas.mey@web.de>, Meelis Roos <mroos@linux.ee>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Janosch Machowinski <jmachowinski@gmx.de>, vladimir.p.lebedev@intel.com, Ash Milsted <thatistosayiseenem@gawab.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-input@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> Here's another suspend/resume artifact: one of my boxes wouldnt 
> resume, it hangs at:
> 
> [    1.456633] pci 0000:00:18.2: resuming
> [    1.456641] pci 0000:00:18.3: resuming
> [    1.456648] 8139too 0000:05:07.0: resuming
> [    1.456667] radeonfb 0000:01:00.0: resuming
> 
> the box is pingable but otherwise no console and it's hung as well. [I 
> got the log above via netconsole]

unfortunately there's no way to get any backtrace out of the system at 
this point - the timer interrupts are not active yet here, so i cannot 
use the softlockup_tick patch to sample the lockup. Since it's pingable 
i'll try to hack a dump_stack() into icmp_reply() ;-)

	Ingo
