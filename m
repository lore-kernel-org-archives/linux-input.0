From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] HID: fix A4Tech horizontal scrolling
Date: Tue, 7 May 2019 15:01:51 +1000
Message-ID: <20190507050150.GA9838@jelly>
References: <20190502213639.7632-1-spaz16@wp.pl>
 <CAO-hwJLbFv3S9M5N+BKBuafj8H-vToy=2VQd=cvohmaTHLMC3A@mail.gmail.com>
 <1a40ea07-368a-93f6-8335-dec7ae50bbf4@gmail.com>
 <CAO-hwJKNH7WoJV-X+egK5cJNNtxamh0L0e1er5dkiTt6KvrmSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJKNH7WoJV-X+egK5cJNNtxamh0L0e1er5dkiTt6KvrmSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Igor Kushnir <igorkuo@gmail.com>, =?utf-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <spaz16@wp.pl>, Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, May 03, 2019 at 01:59:23PM +0200, Benjamin Tissoires wrote:
> Hi,
> 
> On Fri, May 3, 2019 at 11:43 AM Igor Kushnir <igorkuo@gmail.com> wrote:
> >
> > Hi Benjamin,
> >
> > On 5/3/19 10:36 AM, Benjamin Tissoires wrote:
> > > Hi,
> > >
> > > On Thu, May 2, 2019 at 11:37 PM Błażej Szczygieł <spaz16@wp.pl> wrote:
> > >>
> > >> Since recent high resolution scrolling changes the A4Tech driver must
> > >> check for the "REL_WHEEL_HI_RES" usage code.
> > >>
> > >> Fixes: 2dc702c991e3774af9d7ce410eef410ca9e2357e (HID: input: use the
> > >> Resolution Multiplier for high-resolution scrolling)
> > >>
> > >> Signed-off-by: Błażej Szczygieł <spaz16@wp.pl>
> > >
> > > Thanks for the patch. I do not doubt this fixes the issues, but I
> > > still wonder if we should not export REL_HWHEEL_HI_RES instead of
> > > REL_HWHEEL events.
> >
> >
> > If you mean exporting REL_HWHEEL_HI_RES instead of REL_HWHEEL from
> > hid-a4tech.c, then it makes sense to me, though I do not know the code
> > well enough to be certain.
> 
> Yep, that's what I meant. I am worried that userspace doesn't know
> well how to deal with a device that mixes the new and old REL_WHEEL
> events.

sorry, I'm not sure what you mean here. The new events are always mixed with
the old ones anyway, and both should be treated as separate event streams.
The kernel interface to userspace is fairly easy to deal with, it's the rest
that's a bit of mess.

[..]

> >
> 
> OK, thanks both of you for your logs, this is helpful.
> So just in case I need to come back later, the horizontal wheel is
> "just" the normal wheel plus a modifier in the report.
> 
> Anyway, ideally, can we have a v2 of the patch with the 2 changes
> requested above in the commit message and the introduction of
> REL_HWHEEL_HI_RES events in addition to REL_HWHEEL?
> REL_HWHEEL_HI_RES should report `120*value` and we should also keep
> the reporting of REL_WHEEL as it is currently.
> 
> Peter, I grepped in the hid code, and it seems hid-cypress.c is having
> the exact same issue. Sigh.

yeah, I found that too when grepping through it. seems to be the only other
one though and we can use Błażej's patch as boilerplate once it's done.

Cheers,
   Peter
