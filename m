From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] Blackfin serial driver: this driver enable SPORTs
 on Blackfin emulate UART
Date: Mon, 15 Oct 2007 15:22:45 -0700
Message-ID: <20071015152245.12d29f8b.akpm@linux-foundation.org>
References: <1192098220-25828-1-git-send-email-bryan.wu@analog.com>
	<1192098220-25828-4-git-send-email-bryan.wu@analog.com>
	<20071015133326.995a4f38.akpm@linux-foundation.org>
	<8bd0f97a0710151503u4b57dd4aoc4b50d936e17adb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <8bd0f97a0710151503u4b57dd4aoc4b50d936e17adb0@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: bryan.wu@analog.com, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 15 Oct 2007 18:03:35 -0400
"Mike Frysinger" <vapier.adi@gmail.com> wrote:

> > It is not a good idea to create files in /proc which have spaces in their
> > names.  Yes, userspace _should_ be able to cope with that in all cases, but
> > all software sucks, even including userspace ;)
> >
> > I'd suggest that we be defensive here, and avoid using spaces in filenames.
> 
> i'm not sure i follow ... these are the names given to request_irq()
> which means this is what shows up in /proc/interrupts ... does this
> function also create an actual file somewhere in /proc that i am not
> aware of ?

err, umm, yeah.  But the same argument applies: it is imprudent to have
space-containing records in /proc/interrupts.

However it seems that we've already done that in several places so I guess
any /proc/interrupts-parsing programs are already coping with it OK.
