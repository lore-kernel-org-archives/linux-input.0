From: Darren Hart <dvhart@infradead.org>
Subject: Re: Silead DMI driver
Date: Thu, 4 May 2017 15:39:59 -0700
Message-ID: <20170504223959.GA4793@fury>
References: <20170424132356.044ae04f@endymion>
 <20170424165935.GA12374@dtor-ws>
 <20170428113321.2ceb103b@endymion>
 <20170428172529.GC4949@dtor-ws>
 <20170503101945.11e47b2b@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170503101945.11e47b2b@endymion>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, May 03, 2017 at 10:19:45AM +0200, Jean Delvare wrote:
> > 
> > Yes, that is surely the rule. We do not merge the code until it is
> > absolutely, 100% bug free. That is why are about to release 4.11 and
> > stable 4.9 is at 25.
> 
> I perceive some sarcasm here ;-) But I'm not sure where you are getting
> at. Of course we release imperfect code, and that's why we have the
> stable kernel branches. But the idea of these branches is to backport
> fixes that were found after the branch was released.
> 
> In this case, I see the 2 fixes have been written on April 3rd and
> committed on April 13th, which correspond to rc1 and rc2 of the v4.11
> release, respectively. It means you had plenty of time to send these
> fixes to Linus before v4.11 final. You decided not to. This has nothing
> to do with the stable branches process.

The determination for what gets sent to Linus at what point in the rc cycle is
*really* subjective and involves a number of human factors. e.g. If it would
have been OK for RC2, but the maintainer was sick that week and Linus was
trigger happy, then by RC4 it might no longer be deemed acceptable change. It
just isn't as black and white as we'd sometimes like processes to be. Things
like this are also prioritized relative the other patches and fixes in the queue
at the time, which affects where available time can be spent.

Perhaps we made the wrong call here, that's entirely possible, and I'm perfectly
up to accepting that. It's also possible if you had all the context from that
time (which cannot be embodied entirely in the email thread) you would have made
the same call. So, points well taken, and I will certainly be more aware of
these sorts of issues going forward.

-- 
Darren Hart
VMware Open Source Technology Center
