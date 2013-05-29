From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Dependencies in the HID subsystem
Date: Wed, 29 May 2013 22:52:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305292245090.30576@pobox.suse.cz>
References: <1369855174.4306.198.camel@chaos.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1369855174.4306.198.camel@chaos.site>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Michal Marek <mmarek@suse.cz>, linux-input@vger.kernel.org, linux-kbuild <linux-kbuild@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, 29 May 2013, Jean Delvare wrote:

> I am worried and confused by some Kconfig dependencies in the HID
> subsystem.
> 
> There are 11 HID device drivers which are defined in drivers/hid/Kconfig
> with:
> 
> 	tristate "..." if EXPERT
> 	default !EXPERT
> 
> Unless EXPERT is enabled (and that's not the default), these driver
> entries are hidden and automatically selected. If CONFIG_HID=m, they are
> selected as modules. If CONFIG_HID=y, they are built into the kernel. So
> it is impossible to have CONFIG_HID=y and build these device drivers as
> modules - as device drivers typically are.
> 
> I would like to understand the reasoning behind this complexity. What is
> so special about these 11 drivers, that we can't just let the (kernel
> configuring) user chose if he/she wants them and in what form?

That's quite a old story with some history behind. Linus himself 
originally requested it, then much later asked the same question you did. 
See some background here:

	https://lkml.org/lkml/2010/5/20/227

The thing is, that things indeed have changed quite a bit since then. We 
are no longer in a situation that the generic driver would serve 99.99% of 
the world and the specific drivers would be just quirks.

> Wouldn't "default !EXPERT" and a good old "If unsure, say Y" in the help
> text be enough?

Normally, yes. This was all introduced back when separating out all the 
messy quirks from generic hid driver into sub-drivers for maintaing 
sort-of backwards compatibility and avoid confusion.

> Also I find it unpleasant that this construct completely hides the
> option from the user, as if it did not exist, except if other options
> depend on it. This is inconsistent and makes it difficult for the user
> to know whether a specific kernel version includes a given driver or not
> (one has to check .config afterward to know the answer.)

Yes. Again, purely historical reasons.

> Put in short, I don't like the way things are today and would welcome
> changes in this area.

As things have changed a lot since 2.6.28, we can try to put things more 
in line now for 3.11 or so.

-- 
Jiri Kosina
SUSE Labs
