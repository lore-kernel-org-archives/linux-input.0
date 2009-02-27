From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] mtd: sh: maple: Support the Dreamcast visual memory unit as a flash mapping
Date: Fri, 27 Feb 2009 16:08:05 +0900
Message-ID: <20090227070805.GD28802@linux-sh.org>
References: <1234641948.6609.13.camel@localhost.localdomain> <1234642605.6609.17.camel@localhost.localdomain> <1234643202.6609.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1234643202.6609.25.camel@localhost.localdomain>
Sender: linux-sh-owner@vger.kernel.org
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: dwmw2 <dwmw2@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On Sat, Feb 14, 2009 at 08:26:42PM +0000, Adrian McMenamin wrote:
> This patch adds support for the Sega Dreamcast visual memory unit as a
> flash mapping. It requires changes in the maple bus driver (posted
> separately) to support block reads and writes.
> 
> The VMU is a 'smart' flash device, with a built-in 8-bit controller -
> for instance there is an erase before a write but it is hidden from the
> user. But the device's overall behaviour means it works well with the
> mtd layer and it is appropriate to add it as an mtd mapping.
> 
> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

If someone from the MTD side wants to Ack this, I can fold it in to my
tree on top of the maple patch that it depends on, which I already have
queued.
