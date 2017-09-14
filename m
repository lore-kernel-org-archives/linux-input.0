From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/gadget: stalls in dummy_timer
Date: Thu, 14 Sep 2017 19:58:06 +0200
Message-ID: <CAAeHK+z36d-Ks-FyRV38nFyscvxGzsjNPmmL+JF7e61hefj_rg@mail.gmail.com>
References: <CAAeHK+yCz++ShQW5qgVOxo7Cam4M7tAefHn+ZLySZeDiObJpYw@mail.gmail.com>
 <Pine.LNX.4.44L0.1709141242040.9284-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1709141242040.9284-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Peter Chen <peter.chen@nxp.com>, Yuyang Du <yuyang.du@intel.com>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 14, 2017 at 7:49 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 14 Sep 2017, Andrey Konovalov wrote:
>
>> Looked at this a little more.
>>
>> dummy_timer() stucks in an infinite loop. It calls
>> usb_hcd_giveback_urb(), which in turn calls usbtouch_irq(), which
>> calls usb_submit_urb(), which calls dummy_urb_enqueue() and puts urb
>> back into dummy urb queue. dummy_timer() then does goto restart, finds
>> the urb and calls usb_hcd_giveback_urb() again. And this process goes
>> on again and again. It seems that something should either process the
>> urb and set urb->status or it should just expire.
>
> There is some throttling code, but it applies only to bulk transfers.
> Probably because the bandwidth limits for other types are slightly
> different.  However, I don't think we need to worry about this level of
> detail, since the driver makes a number of other approximations anyway.
>
> Try the patch below; it should fix the problem.

Hi Alan,

Just tried your patch, my reproducer still hangs the kernel until all
memory is exhausted.

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
> @@ -1781,7 +1781,6 @@ restart:
>                 struct dummy_request    *req;
>                 u8                      address;
>                 struct dummy_ep         *ep = NULL;
> -               int                     type;
>                 int                     status = -EINPROGRESS;
>
>                 urb = urbp->urb;
> @@ -1789,14 +1788,10 @@ restart:
>                         goto return_urb;
>                 else if (dum_hcd->rh_state != DUMMY_RH_RUNNING)
>                         continue;
> -               type = usb_pipetype(urb->pipe);
>
> -               /* used up this frame's non-periodic bandwidth?
> -                * FIXME there's infinite bandwidth for control and
> -                * periodic transfers ... unrealistic.
> -                */
> -               if (total <= 0 && type == PIPE_BULK)
> -                       continue;
> +               /* Used up this frame's bandwidth? */
> +               if (total <= 0)
> +                       break;
>
>                 /* find the gadget's ep for this request (if configured) */
>                 address = usb_pipeendpoint (urb->pipe);
>
