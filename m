From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [2/6] 2.6.21-rc2: known regressions
Date: Thu, 8 Mar 2007 21:46:02 +0200
Message-ID: <20070308194602.GE17114@mellanox.co.il>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015034.GG3441@stusta.de> <20070308123143.GF5149@mellanox.co.il> <Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Jeff Chua <jeff.chua.linux@gmail.com>, pavel@suse.cz, linux-pm@lists.osdl.org, lenb@kernel.org, linux-acpi@vger.kernel.org, luming.yu@intel.com, Arkadiusz Miskiewicz <arekm@maven.pl>, Konstantin Karasyov <konstantin.a.karasyov@intel.com>, Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net, Thomas Meyer <thomas.mey@web.de>, Meelis Roos <mroos@linux.ee>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Janosch Machowinski <jmachowinski@gmx.de>, vladimir.p.lebedev@intel.com, Ash Milsted <thatistosayiseenem@gawab.com>, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-input@vger.kernel.org

> Quoting Linus Torvalds <torvalds@linux-foundation.org>:
> > 
> > Here's the status with -rc3: better, but still does not work as well as 2.6.20.
> 
> Ok. I think we mostly solved the irq-related stuff, but you might want to 
> check whether you have CONFIG_NOHZ on or off and whether that makes a 
> difference.

This testing was done without NO_HZ.

-- 
MST
