From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: usb/gadget: stalls in dummy_timer
Date: Fri, 15 Sep 2017 14:57:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709151452090.26654-100000@netrider.rowland.org>
References: <CAAeHK+z36d-Ks-FyRV38nFyscvxGzsjNPmmL+JF7e61hefj_rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+z36d-Ks-FyRV38nFyscvxGzsjNPmmL+JF7e61hefj_rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Peter Chen <peter.chen@nxp.com>, Yuyang Du <yuyang.du@intel.com>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Thu, 14 Sep 2017, Andrey Konovalov wrote:

> On Thu, Sep 14, 2017 at 7:49 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Thu, 14 Sep 2017, Andrey Konovalov wrote:
> >
> >> Looked at this a little more.
> >>
> >> dummy_timer() stucks in an infinite loop. It calls
> >> usb_hcd_giveback_urb(), which in turn calls usbtouch_irq(), which
> >> calls usb_submit_urb(), which calls dummy_urb_enqueue() and puts urb
> >> back into dummy urb queue. dummy_timer() then does goto restart, finds
> >> the urb and calls usb_hcd_giveback_urb() again. And this process goes
> >> on again and again. It seems that something should either process the
> >> urb and set urb->status or it should just expire.
> >
> > There is some throttling code, but it applies only to bulk transfers.
> > Probably because the bandwidth limits for other types are slightly
> > different.  However, I don't think we need to worry about this level of
> > detail, since the driver makes a number of other approximations anyway.
> >
> > Try the patch below; it should fix the problem.
> 
> Hi Alan,
> 
> Just tried your patch, my reproducer still hangs the kernel until all
> memory is exhausted.
> 
> Thanks!

Hmmm.  Your reproducer doesn't run on my system.  The mmap system call
fails, perhaps because this laptop has a 32-bit kernel.  So I can't
tell what's going on.

Can you collect a usbmon trace that shows what happens while the 
reproducer runs?  If it turns out to be extremely large, just post an 
initial portion of it.

Alan Stern
