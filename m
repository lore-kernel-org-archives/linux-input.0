From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] Fujitsu application panel driver (rev3)
Date: Sun, 16 Sep 2007 16:22:58 -0400
Message-ID: <200709161623.00286.dtor@insightbb.com>
References: <20070702111724.43ee5b43@freepuppy.localdomain.hemminger.net> <200709140130.59732.dtor@insightbb.com> <20070916215516.2934abad@oldman.hemminger.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070916215516.2934abad@oldman.hemminger.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Stephen,

On Sunday 16 September 2007 15:55, Stephen Hemminger wrote:
> On Fri, 14 Sep 2007 01:30:58 -0400
> Dmitry Torokhov <dtor@insightbb.com> wrote:
> 
> > Hi Stephen,
> > 
> > On Wednesday 12 September 2007 07:38, Stephen Hemminger wrote:
> > > This driver supports the application buttons on some Fujitsu Lifebook laptops.
> > > It is based on the earlier apanel driver done by Jochen Eisenger, but
> > > with many changes.  The original driver used ioctl's and a separate
> > > user space program;  see http://apanel.sourceforge.net/tech.php
> > > This version hooks into the input subsystem so that the normal
> > > Gnome/KDE shortcuts work without any userspace changes.
> > > 
> > > The Mail Led is handled via leds class device.
> > > 
> > 
> > Thank you very much for convering the led to led subsystem. I tried
> > implementing loadable keymap support in the driver, could you please
> > try the patch below and if it still works for you then I will apply
> > it to my tree.
> > 
> 
> Sorry, you are raising the bar for new drivers, higher than existing code.
> It is really bad (second system syndrome), if maintainers keep wanting
> new code to to more than existing drivers.
> 
> Please take driver AS IS. Go ahead and add loadable key map support,

I think I did that. I just asked you to run another test to make sure I did
not screw up. Please find the time to do that and the patch will be applied.
Unfortunately I do not own the hardware in question to do such test myself.

> but fix all the other drivers in the tree at the same time that use the existing
> interface.
> 

I will, time permitting. The support for doing loadable keymaps for drivers
with sparse scancodes (or their equivalent) was added not so long ago,
that's why there are a few drivers that don't implement loadable keymaps.
But still many others do.

-- 
Dmitry
