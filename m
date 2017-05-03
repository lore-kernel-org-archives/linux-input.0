From: Jean Delvare <jdelvare@suse.de>
Subject: Re: Silead DMI driver
Date: Wed, 3 May 2017 10:19:45 +0200
Message-ID: <20170503101945.11e47b2b@endymion>
References: <20170424132356.044ae04f@endymion>
        <20170424165935.GA12374@dtor-ws>
        <20170428113321.2ceb103b@endymion>
        <20170428172529.GC4949@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170428172529.GC4949@dtor-ws>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmirty,

On Fri, 28 Apr 2017 10:25:29 -0700, Dmitry Torokhov wrote:
> On Fri, Apr 28, 2017 at 11:33:21AM +0200, Jean Delvare wrote:
> > While this is a laudable goal, how will it scale in practice? I mean,
> > most drivers do need quirks in one form or another. Are we really going
> > to double the number of "drivers" (as in .c files and modules) and
> > Kconfig options to cleanly separate quirks from the device drivers
> > proper?
> 
> I do not see minimizing number of drivers as a goal. I also expect that

I do. A number of operations are directly dependent of the number of
available or loaded drivers. Splitting things into more small pieces
only helps performance up to a point, after which it backfires.

> devices that get one driver wrong would require more fixups. As far as

Not sure what you mean, sorry. "Getting one driver wrong"?

> having multiple config options - you do realize that even if we move
> these chunks into existing drivers they can still be protected by config
> options?

Good point, I indeed missed that. But somehow I think I find it less
confusing to have the driver-specific quirks option pop up right after
I say y or m to the driver in question, than having 2 seemingly
independent options in different menus in the configuration tree.
Darren just added the missing dependency, which makes things a bit
better, but doesn't solve the other "problems".

> > (...)
> > I'm speechless. If you believe that this kind of bug isn't worth
> > fixing quickly
> 
> Would you mind telling me what is s horrible about this bug that
> requires it to be fixed immediately. In practical terms please.

I guess this is just a case of the straw breaking the camel's back. The
non-modularity, then the horrible design, then the DMI check on every
I2C device addition on X86 every system, and now casting to the wrong
struct (and spending time verifying that it should be just OK in
practice, instead of applying a two-liner, obviously safe fix)... That
was just too much.

Ironically, the only reason why this (otherwise major) bug won't cause
any problem in practice is because you use strncmp to compare the names,
when strcmp would have been sufficient and preferable. So it's a case
of two mistakes compensating each other.

> > (...)
> > I thought the rule about upstream kernel code acceptance was that
> > you should get things right first, no matter how much time and how
> > many iterations it takes, and then we commit the result. Apparently
> > this has changed while I was not looking :-(
> 
> Yes, that is surely the rule. We do not merge the code until it is
> absolutely, 100% bug free. That is why are about to release 4.11 and
> stable 4.9 is at 25.

I perceive some sarcasm here ;-) But I'm not sure where you are getting
at. Of course we release imperfect code, and that's why we have the
stable kernel branches. But the idea of these branches is to backport
fixes that were found after the branch was released.

In this case, I see the 2 fixes have been written on April 3rd and
committed on April 13th, which correspond to rc1 and rc2 of the v4.11
release, respectively. It means you had plenty of time to send these
fixes to Linus before v4.11 final. You decided not to. This has nothing
to do with the stable branches process.

I remember from my classes at school about software engineering: "the
sooner a problem is detected and fixed, the lower the cost of the fix."
It seems that was have a good case for a study here. Just think of the
time we all have spent writing and reading these mails (and I deleted
half of what I wrote before sending it.)

-- 
Jean Delvare
SUSE L3 Support
