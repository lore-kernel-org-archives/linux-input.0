From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Regression in dtor/input.git/next - flush pending events on
 clock type change
Date: Thu, 5 Feb 2015 17:53:26 -0800
Message-ID: <20150206015326.GC21288@dtor-ws>
References: <20150205230629.GC21618@mail.corp.redhat.com>
 <20150205235816.GA21288@dtor-ws>
 <CAN+gG=HG+f66TosBowTWKnh-sMqVobEx18DK0AoPX_7OCfBDsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:59979 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbbBFBxb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 20:53:31 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so4133105igk.1
        for <linux-input@vger.kernel.org>; Thu, 05 Feb 2015 17:53:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAN+gG=HG+f66TosBowTWKnh-sMqVobEx18DK0AoPX_7OCfBDsg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, Anshul Garg <anshul.g@samsung.com>

On Thu, Feb 05, 2015 at 08:28:28PM -0500, Benjamin Tissoires wrote:
> On Feb 5, 2015 7:04 PM, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Benjamin,
> >
> > On Thu, Feb 05, 2015 at 06:06:29PM -0500, Benjamin Tissoires wrote:
> > > Hi Anshul,
> > >
> > > The commit 0c3e99437a66e4c869c60c2398449e6d98f3a988 in
> dtor/input.git/next
> > > tree introduce an interesting regression in libinput. The tests fail :)
> > >
> > > Actually, evemu-record and libinput switch the clock to monotonic when
> > > opening an input node, and the first thing that gets queued is a
> > > SYN_DROPPED event.
> > >
> > > However, in the libinput test suite, events are the bare minimum, and
> > > most of the tests contain only one event set (one EV_SYN).
> > > When seeing the SYN_DROPPED, the clients are supposed to drain the
> events
> > > until the next EV_SYN, and so they are losing the events that came long
> > > after the ioctl call.
> > > And in the end, the test suite does not receive any events.
> > >
> > > Removing the evdev_queue_syn_dropped() call in the ioctl handling fixes
> > > the test suite, and Peter suggested that maybe we should queue a
> > > SYN_DROPPED event iff there are events in the queue.
> >
> > Does the following patch fixe it? But I would like to see libinput
> > tests more robust.
> 
> It does. Thanks for the quick fix.
> 
> Regarding libinput tests, I am not sure we could make them more robust in
> this situation. The tests rely on uinput to create predetermined kernel
> devices, with a known set of events. Usually, we test one feature/previous
> bug we already seen in the past per device per test. The mentioned commit
> changed the kernel behavior and I think there is no automatic way to detect
> that the problem lies in the kernel rather than in the libinput event
> processing.
> 
> For example, the simplest test creates one mouse, waits for libinput to
> open it, sends REL_X, EV_SYN, and ensures that libinput gets the REL_X
> event. Without this fix, the event is not seen, so the test fails. Which is
> right, because that means that any libinput client will see the first
> events dropped. This is not something we want for our users, especially for
> keyboards, when the first thing you do is typing your password for example.

OK, fair enough. I'll queue the patch with your tested-by then.

Thanks.

-- 
Dmitry
