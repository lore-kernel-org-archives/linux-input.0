From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [2/6] 2.6.21-rc2: known regressions
Date: Sat, 10 Mar 2007 10:01:21 +0100
Message-ID: <20070310090121.GB15647@elte.hu>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015034.GG3441@stusta.de> <20070308123143.GF5149@mellanox.co.il> <Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org> <20070308192554.GA2999@elte.hu> <20070308230705.GA4611@elte.hu> <Pine.LNX.4.64.0703081545110.10832@woody.linux-foundation.org> <20070309174821.GA31754@linuxtv.org> <20070309233508.GB2197@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070309233508.GB2197@elf.ucw.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pavel Machek <pavel@suse.cz>
Cc: Johannes Stezenbach <js@linuxtv.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-pm@lists.osdl.org, lenb@kernel.org, linux-acpi@vger.kernel.org, luming.yu@intel.com, Arkadiusz Miskiewicz <arekm@maven.pl>, Konstantin Karasyov <konstantin.a.karasyov@intel.com>, Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net, Thomas Meyer <thomas.mey@web.de>, Meelis Roos <mroos@linux.ee>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Janosch Machowinski <jmachowinski@gmx.de>, vladimir.p.lebedev@intel.com, Ash Milsted <thatistosayiseenem@gawab.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.
List-Id: linux-input@vger.kernel.org


* Pavel Machek <pavel@suse.cz> wrote:

> > Even if one doesn't use the fb console at all, radeonfb apparently 
> > is still required on some ThinkPad models to work around BIOS bugs:
> > 
> > http://www.thinkwiki.org/wiki/Problem_with_high_power_drain_in_ACPI_sleep#Radeon_GPU_not_powered_off
> 
> 
> s2ram should be able to work around this, it has parts from 
> radeontool. (suspend.sf.net).

i'm wondering, do you have any idea how Windows handles the 
suspend/resume quirks problem area? Do they "curse BIOS vendors and 
maintain a large DB of DMI-driven exceptions", or do they perhaps have 
some fundamentally better approach than us? If it's the former, then we 
might as well try to bring more automatism (and more of your database) 
into the kernel itself.

btw., the s2ram database seems quite a bit spotty:

 $ ./s2ram -n
 Machine is unknown.
 This machine can be identified by:
     sys_vendor   = "System manufacturer"
     sys_product  = "System Product Name"
     sys_version  = "System Version"
     bios_version = "ASUS A8N-E ACPI BIOS Revision 1008"

 $ ./s2ram -n
 Machine is unknown.
 This machine can be identified by:
    sys_vendor   = "Hewlett-Packard "
    sys_product  = "compaq nx9030 (PG630ET#ABD)       "
    sys_version  = "Rev 1           "
    bios_version = "F.15    "
 See http://en.opensuse.org/S2ram for details.

even at the link above i didnt find any clear algorithm about how to 
extend the quirks-list and the white-list - while i expect that most 
people experience what i did: that s2ram doesnt know their boxes. 
(otherwise they would not visit that URL at all i suspect)

	Ingo
