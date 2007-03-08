From: Ash Milsted <thatistosayiseenem@gawab.com>
Subject: Re: [2/6] 2.6.21-rc2: known regressions
Date: Thu, 8 Mar 2007 12:03:03 +0000
Message-ID: <20070308120303.d285e4a3.thatistosayiseenem@gawab.com>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org>
	<20070305015034.GG3441@stusta.de>
	<45EE9D52.9060807@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45EE9D52.9060807@garzik.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jeff Garzik <jeff@garzik.org>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Jeff Chua <jeff.chua.linux@gmail.com>, pavel@suse.cz, linux-pm@lists.osdl.org, lenb@kernel.org, linux-acpi@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, luming.yu@intel.com, Arkadiusz Miskiewicz <arekm@maven.pl>, Konstantin Karasyov <konstantin.a.karasyov@intel.com>, greg@kroah.com, linux-usb-devel@lists.sourceforge.net, Thomas Meyer <thomas.mey@web.de>, Meelis Roos <mroos@linux.ee>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Janosch Machowinski <jmachowinski@gmx.de>, vladimir.p.lebedev@intel.com, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 07 Mar 2007 06:09:06 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Adrian Bunk wrote:
> > Subject    : AT keyboard only works with pci=noacpi
> > References : http://lkml.org/lkml/2007/3/3/68
> > Submitter  : Ash Milsted <thatistosayiseenem@gawab.com>
> > Status     : unknown
> 
> 
> sounds like a BIOS bug, even though it appears to be a regression?
> 

Resolved here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=117332735404395&w=2

Was a bug in the i8042 driver it seems.

Ash
