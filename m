From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [BUG] New Kernel Bugs
Date: Tue, 13 Nov 2007 18:10:53 +0000
Message-ID: <20071113181053.GB1356@flint.arm.linux.org.uk>
References: <32209efe0711122242m3a5f081asf1c11a38b24db10c@mail.gmail.com> <20071113031553.3c7b5c16.akpm@linux-foundation.org> <4739ADA2.4060604@rtr.ca> <alpine.LFD.0.9999.0711131521590.3265@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0711131521590.3265@localhost.localdomain>
Sender: netdev-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Lord <liml@rtr.ca>, alsa-devel@alsa-project.org, netdev@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, Natalie Protasevich <protasnb@gmail.com>, linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

On Tue, Nov 13, 2007 at 05:07:21PM +0100, Thomas Gleixner wrote:
> On Tue, 13 Nov 2007, Mark Lord wrote:
> 
> > Andrew Morton wrote:
> > > On Mon, 12 Nov 2007 22:42:32 -0800 "Natalie Protasevich"
> > > <protasnb@gmail.com> wrote:
> > ..
> > > > with CONFIG_NO_HZ and/or CONFIG_HPET_TIMER set kernel 2.6.23 doesn't
> > > > boot (ARM, Timer)
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=9229
> > > > Kernel: 2.6.23
> > > 
> > > No response from developers
> > ..
> 
> The bug report is bogus. ARM has no CONFIG_HPET_TIMER. 

Plus we've just merged a fix for NO_HZ on PXA platforms due to an utterly
broken one-shot implementation.  So chances are this problem is now fixed.

However, I object strongly to Andrew's responses to these bugs.  He's
completely out of line.

Given the wide range of ARM platforms today, it is utterly idiotic to
expect a single person to be able to provide responses for all ARM bugs.
I for one wish I'd never *VOLUNTEERED* to be a part of the kernel
bugzilla, and really *WISH* I could pull out of that function.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
