From: "Henrik Rydberg" <rydberg@bitmath.se>
Subject: Re: [PATCH 09/19] Input: MT - Handle frame synchronization in core
Date: Mon, 20 Aug 2012 17:53:40 +0200
Message-ID: <20120820155340.GA655@polaris.bitmath.org>
References: <1344807757-2217-1-git-send-email-rydberg@euromail.se>
 <1344807757-2217-10-git-send-email-rydberg@euromail.se>
 <CAN+gG=G0P3m03WK8-fcsV5RFWLiXBQvxgaM7qMqHzB-C=tQQUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAN+gG=G0P3m03WK8-fcsV5RFWLiXBQvxgaM7qMqHzB-C=tQQUg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> > Collect common frame synchronization tasks in a new function,
> > input_mt_sync_frame(). Depending on the flags set, it drops
> > unseen contacts and performs pointer emulation.
> 
> I was really wondering why you needed to put in input-mt something
> that appeared only in hid-multitouch.... until I noted that you are
> going to use it for bcm5974.

True, you were only copied in on the patch specific to
hid-multitouch. The core changes will naturally be used for some other
drivers as well.

> Maybe you should add a comment on it (otherwise, it seams like you're
> just adding unused code). Maybe this would also help people
> understanding the *frame thing.

More comments on those plans, agreed. The "frame thing" is really only
an input core change; it can most likely be better explained as well,
but it really should not matter to drivers.

> > +void input_mt_sync_frame(struct input_dev *dev)
> > +{
> > +       struct input_mt *mt = dev->mt;
> > +       struct input_mt_slot *s;
> > +
> > +       if (!mt)
> > +               return;
> > +
> > +       if (mt->flags & INPUT_MT_DROP_UNUSED) {
> > +               for (s = mt->slots; s != mt->slots + mt->num_slots; s++) {
> > +                       if (s->frame == mt->frame)
> > +                               continue;
> > +                       input_mt_slot(dev, s - mt->slots);
> > +                       input_event(dev, EV_ABS, ABS_MT_TRACKING_ID, -1);
> 
> Shouldn't we rely on input_mt_report_slot_state instead of doing it by hand?

No, input_mt_report_slot_state() is a driver api function with side
effects which are not desired here.
 
> > +               }
> > +       }
> > +
> > +       if (mt->flags & INPUT_MT_POINTER)
> > +               input_mt_report_pointer_emulation(dev, true);
> > +
> > +       if (mt->flags & INPUT_MT_DIRECT)
> > +               input_mt_report_pointer_emulation(dev, false);
> 
> The function input_mt_report_pointer_emulation could be called twice
> if the driver has both INPUT_MT_POINTER and INPUT_MT_DIRECT flags. Are
> they mutual exclusive?

You are right, and they are not. Will fix.

Thanks,
Henrik
