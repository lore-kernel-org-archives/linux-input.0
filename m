From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: uhid: Fix sending events with invalid data
Date: Fri, 20 Jul 2012 09:57:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1207200957330.21929@pobox.suse.cz>
References: <1342303165-28708-1-git-send-email-vinicius.gomes@openbossa.org> <CANq1E4RO4r0Cx=j9oR=mgHd0CwcQd5LtUiGNvgEyS1BtTP5Pxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53095 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753146Ab2GTH5u (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jul 2012 03:57:50 -0400
In-Reply-To: <CANq1E4RO4r0Cx=j9oR=mgHd0CwcQd5LtUiGNvgEyS1BtTP5Pxg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>, linux-input@vger.kernel.org

On Sun, 15 Jul 2012, David Herrmann wrote:

> Hi Vinicius
> 
> CC'ing Jiri

Thanks guys. Applied to uhid branch.

> 
> On Sat, Jul 14, 2012 at 11:59 PM, Vinicius Costa Gomes
> <vinicius.gomes@openbossa.org> wrote:
> > This was detected because events with invalid types were arriving
> > to userspace.
> >
> > The code before this patch would only work for the first event in the
> > queue (when uhid->tail is 0).
> >
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> > David,
> >
> > Do you have any clue why it took so long for us to detect this issue?
> 
> Ugh! Thanks for spotting this! I actually have no idea why this wasn't
> detected earlier. I always run the sample file in ./samples/uhid/ and
> they worked fine. Could it be that this only occurs when the queue
> runs full? That is, there is more than one event in the queue? This
> would explain why I never saw this bug. Or maybe the first event is
> just repeated all the time instead of reporting the new events which
> would explain why the example in ./samples/uhid works fine.
> 
> It definitely has to do with the late transition from a fixed array to
> a dynamically allocated pointer-array so all the early tests from the
> bluez guys worked fine. This is probably also the reason why we all
> didn't encounter this in the early tests.
> 
> I just recompiled the example with the old code and it still works
> fine. I occasionally see the "invalid event" warnings now, but only 1
> or 2 times. Maybe it's just dropping all except the 32'th package
> (buffer-size) so I cannot see it and the mouse-emulation still works
> smoothly (but at 1/32th of the original speed). Anyway, the patch
> looks good, thanks!
> 
> Reviewed-by: David Herrmann <dh.herrmann@googlemail.com>
> Thanks!
> 
> David
> 
> > Cheers,
> >
> >
> >  drivers/hid/uhid.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> > index 119b7e6..714cd8c 100644
> > --- a/drivers/hid/uhid.c
> > +++ b/drivers/hid/uhid.c
> > @@ -465,7 +465,7 @@ try_again:
> >                 goto try_again;
> >         } else {
> >                 len = min(count, sizeof(**uhid->outq));
> > -               if (copy_to_user(buffer, &uhid->outq[uhid->tail], len)) {
> > +               if (copy_to_user(buffer, uhid->outq[uhid->tail], len)) {
> >                         ret = -EFAULT;
> >                 } else {
> >                         kfree(uhid->outq[uhid->tail]);
> > --
> > 1.7.10.4
> 

-- 
Jiri Kosina
SUSE Labs
