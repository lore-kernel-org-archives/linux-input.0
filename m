From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] Input - synaptics: pin 3 touches when the firmware
 reports 3 fingers
Date: Thu, 23 Apr 2015 14:48:26 -0400
Message-ID: <20150423184825.GB10937@mail.corp.redhat.com>
References: <1429717509-27396-1-git-send-email-benjamin.tissoires@redhat.com>
 <1429717509-27396-3-git-send-email-benjamin.tissoires@redhat.com>
 <20150423163818.GC34808@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150423163818.GC34808@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Apr 23 2015 or thereabouts, Dmitry Torokhov wrote:
> On Wed, Apr 22, 2015 at 11:45:09AM -0400, Benjamin Tissoires wrote:
> > Synaptics PS/2 touchpad can send only 2 touches in a report. They can
> > detect 4 or 5 and this information is valuable.
> > 
> > In commit 63c4fda3c0bb ("Input: synaptics - allocate 3 slots to keep
> > stability in image sensors"), we allocate 3 slots, but we still continue
> > to report the 2 available fingers. That means that the client sees 2 used
> > slots while there is a total of 3 fingers advertised by BTN_TOOL_TRIPLETAP.
> > 
> > For old kernels this is not a problem because max_slots was 2 and libinput/
> > xorg-synaptics knew how to deal with that. Now that max_slot is 3, the
> > clients ignore BTN_TOOL_TRIPLETAP and count the actual used slots (so 2).
> > It then gets confused when receiving the BTN_TOOL_TRIPLETAP and DOUBLETAP
> > information, and goes wild.
> > 
> > We can pin the 3 slots until we get a total number of fingers below 2.
> > 
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1212230
> 
> Benjamin, I do not quite like it. It seems that original patch was not
> quite right and we are adding more workarounds.

Agree. And I am starting to hate more and more the synaptics PS/2 and all
the PS/2 drivers to be honest :) - trying to fit a heavy load data like
multitouch in a simple and lightweight protocol like PS/2 is insane...

We are internally trying to figure out if we can finally take advantage
of the SMBus/RMI4 protocol, but we tried for one year without much
success.

> 
> Synaptics can only track 2 contacts, correct? Why 2 slots to track them
> is not enough?

IIRC, the problem was that upon a third finger down, with only 2 slots,
the fingers were silently inverted in most cases. The thing is that the
firmware forwards 2 fingers, but not necessarily the two first. So you
generally get fingers 1+3 so the slot 2 needs to be removed. And that
means the kernel tracking has to track 3 fingers upon transitions.

This may be completely bullshit and we might not need to use 3 slots at
all. I'll need to do further experiments to validate which one is best
then.

I am perfectly fine holding this one up for a little bit more testings
and then we can decide which one needs to be done (revert or an other
band-aid).

Cheers,
Benjamin

> 
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/input/mouse/synaptics.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> > index 630af73..c69b308 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -935,6 +935,14 @@ static void synaptics_report_mt_data(struct psmouse *psmouse,
> >  		input_report_abs(dev, ABS_MT_PRESSURE, hw[i]->z);
> >  	}
> >  
> > +	/* keep (slot count <= num_fingers) by pinning all slots */
> > +	if (num_fingers >= 3) {
> > +		for (i = 0; i < 3; i++) {
> > +			input_mt_slot(dev, i);
> > +			input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
> > +		}
> > +	}
> > +
> >  	input_mt_drop_unused(dev);
> >  
> >  	/* Don't use active slot count to generate BTN_TOOL events. */
> > -- 
> > 2.1.0
> > 
> 
> -- 
> Dmitry
