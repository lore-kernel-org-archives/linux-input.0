From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: new EVIOCGKEYF to get keystate and flush queues
Date: Wed, 27 Mar 2013 14:15:50 -0700
Message-ID: <2779019.So8V62lXvd@dtor-d630.eng.vmware.com>
References: <1357559903-1881-1-git-send-email-dh.herrmann@googlemail.com> <20130216211017.GB22044@core.coreip.homeip.net> <CANq1E4Sr_BBhWqYGbzQ5cejOTD-aB_A-wc=sjoycDQP_A0ittA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:53315 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab3C0VQE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Mar 2013 17:16:04 -0400
Received: by mail-pd0-f181.google.com with SMTP id q10so3721791pdj.40
        for <linux-input@vger.kernel.org>; Wed, 27 Mar 2013 14:16:03 -0700 (PDT)
In-Reply-To: <CANq1E4Sr_BBhWqYGbzQ5cejOTD-aB_A-wc=sjoycDQP_A0ittA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

On Wednesday, March 27, 2013 10:02:31 PM David Herrmann wrote:
> Hi Dmitry
> 
> On Sat, Feb 16, 2013 at 10:10 PM, Dmitry Torokhov
> 
> <dmitry.torokhov@gmail.com> wrote:
> > Hi David,
> > 
> > On Mon, Jan 07, 2013 at 12:58:23PM +0100, David Herrmann wrote:
> >> EVIOCGKEYF returns the current keystate similar to EVIOCGKEY but also
> >> flushes the outgoing evdev event queue. This allows user-space devices to
> >> reliably retrieve the current state without having old events still in
> >> the
> >> read()-queue.
> >> 
> >> Userspace libraries like XKB/xkbcommon use stacking key trackers, so they
> >> allow the kernel to map multiple keys to the same keycode. For instance
> >> if
> >> left-shift and right-shift map to the same keycode, xkbcommon allows the
> >> kernel to send key-down twice but also requires it to send key-up twice.
> >> A
> >> single input device doesn't support that, but this is very useful if you
> >> want multiple connected keyboards to have one shared modifier state:
> >> Pressing Shift on the one keyboard affects keys on the other keyboard.
> >> This is not the usual setup but it is supported and known to be used
> >> (for instance if you have external num-pads etc.).
> >> 
> >> When a program opens input devices, it can read the keystate via
> >> EVIOCGKEY
> >> to update its internal keyboard state. This allows to keep CTRL pressed
> >> while switching VTs and having both applications remember that CTRL is
> >> still pressed.
> >> However, if there are still outgoing events in the evdev queue, the
> >> application will update its internal keyboard state and then read the
> >> event again, even though it already processed it via EVIOCGKEY.
> >> 
> >> EVIOCGKEYF solves this race condition by flushing the evdev queue while
> >> returning the keystate. We cannot change EVIOCGKEY because we don't know
> >> whether userspace depends on a clean read() history and flushing the
> >> queue
> >> effectively drops events.
> >> 
> >> This race could be fixed in user-space by keeping an exact copy of the
> >> keystate array for each input device that we opened and ignoring
> >> double-events for a single keycode. However, if we, as mentioned, want a
> >> shared keyboard-state, it seems to be a waste of computing power and
> >> memory to keep another copy for each input device if we could just use
> >> something like EVIOCGKEYF.
> > 
> > I do not think we should introduce the new ioctl as I really doubt
> > anyone is using it and even if they do I really doubt they will have
> > problems if we flush the events.
> > 
> > But rather that flushing all events we should only flush the key events.
> > The relative, absolute, and other events should be kept in the queue.
> 
> (seems we have nearly the same delay for responses, sorry..)
> 
> I'm not entirely sure whether I understand you correctly. Do you
> propose to just fix EVIOCGKEY to flush the queues?

Yes, that is exactly what I mean, with the exception that flush should
be selective. I.e. getting key state should not flush relative or absolute
events and getting absolute state shoudl not flush key/bunnon events and
so on.

Thanks.

-- 
Dmitry
