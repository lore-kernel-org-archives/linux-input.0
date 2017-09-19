From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/gadget: stalls in dummy_timer
Date: Tue, 19 Sep 2017 19:29:39 +0200
Message-ID: <CAAeHK+y5Amq5tJfkywMbPZiGnsUgfifkFUEXTzf8H5GfxCuzLw@mail.gmail.com>
References: <CAAeHK+ww_=YHBpCTf1kisLADR2DPNoE7OGNs4N9L_aee9X-MpQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1709191312260.1353-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1709191312260.1353-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Peter Chen <peter.chen@nxp.com>, Yuyang Du <yuyang.du@intel.com>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 19, 2017 at 7:17 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 19 Sep 2017, Andrey Konovalov wrote:
>
>> On Fri, Sep 15, 2017 at 8:57 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> > On Thu, 14 Sep 2017, Andrey Konovalov wrote:
>> >
>> >> On Thu, Sep 14, 2017 at 7:49 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> >> > On Thu, 14 Sep 2017, Andrey Konovalov wrote:
>> >> >
>> >> >> Looked at this a little more.
>> >> >>
>> >> >> dummy_timer() stucks in an infinite loop. It calls
>> >> >> usb_hcd_giveback_urb(), which in turn calls usbtouch_irq(), which
>> >> >> calls usb_submit_urb(), which calls dummy_urb_enqueue() and puts urb
>> >> >> back into dummy urb queue. dummy_timer() then does goto restart, finds
>> >> >> the urb and calls usb_hcd_giveback_urb() again. And this process goes
>> >> >> on again and again. It seems that something should either process the
>> >> >> urb and set urb->status or it should just expire.
>> >> >
>> >> > There is some throttling code, but it applies only to bulk transfers.
>> >> > Probably because the bandwidth limits for other types are slightly
>> >> > different.  However, I don't think we need to worry about this level of
>> >> > detail, since the driver makes a number of other approximations anyway.
>> >> >
>> >> > Try the patch below; it should fix the problem.
>> >>
>> >> Hi Alan,
>> >>
>> >> Just tried your patch, my reproducer still hangs the kernel until all
>> >> memory is exhausted.
>> >>
>> >> Thanks!
>> >
>> > Hmmm.  Your reproducer doesn't run on my system.  The mmap system call
>> > fails, perhaps because this laptop has a 32-bit kernel.  So I can't
>> > tell what's going on.
>> >
>> > Can you collect a usbmon trace that shows what happens while the
>> > reproducer runs?  If it turns out to be extremely large, just post an
>> > initial portion of it.
>>
>> I've attached the usbmon trace. It's actually quite short, probably
>> due to the fact that the kernel enters infinite loop.
>>
>> I've also attached a reproducer that should compile on a 32 bit
>> system, however I haven't tested whether it reproduces the issue.
>
> Got it, thanks.  Can you test the patch below in place of (or in
> addition to) the earlier patch?

With this patch (just this one, without the other one) the reproducer
no longer hangs the kernel :)

Tested-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!

>
> Alan Stern
>
>
>
> Index: usb-4.x/drivers/usb/gadget/udc/dummy_hcd.c
> ===================================================================
> --- usb-4.x.orig/drivers/usb/gadget/udc/dummy_hcd.c
> +++ usb-4.x/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -237,6 +237,8 @@ struct dummy_hcd {
>
>         struct usb_device               *udev;
>         struct list_head                urbp_list;
> +       struct urbp                     *next_frame_urbp;
> +
>         u32                             stream_en_ep;
>         u8                              num_stream[30 / 2];
>
> @@ -1252,6 +1254,8 @@ static int dummy_urb_enqueue(
>
>         list_add_tail(&urbp->urbp_list, &dum_hcd->urbp_list);
>         urb->hcpriv = urbp;
> +       if (!dum_hcd->next_frame_urbp)
> +               dum_hcd->next_frame_urbp = urbp;
>         if (usb_pipetype(urb->pipe) == PIPE_CONTROL)
>                 urb->error_count = 1;           /* mark as a new urb */
>
> @@ -1768,6 +1772,7 @@ static void dummy_timer(unsigned long _d
>                 spin_unlock_irqrestore(&dum->lock, flags);
>                 return;
>         }
> +       dum_hcd->next_frame_urbp = NULL;
>
>         for (i = 0; i < DUMMY_ENDPOINTS; i++) {
>                 if (!ep_info[i].name)
> @@ -1784,6 +1789,10 @@ restart:
>                 int                     type;
>                 int                     status = -EINPROGRESS;
>
> +               /* stop when we reach URBs queued after the timer interrupt */
> +               if (urbp == dum_hcd->next_frame_urbp)
> +                       break;
> +
>                 urb = urbp->urb;
>                 if (urb->unlinked)
>                         goto return_urb;
>
