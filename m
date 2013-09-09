From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] input: ti_am335x_tsc: Enable shared IRQ for TSC
Date: Mon, 9 Sep 2013 09:12:30 -0700
Message-ID: <20130909161230.GA25107@core.coreip.homeip.net>
References: <1378034277-26728-1-git-send-email-zubair.lutfullah@gmail.com>
 <1378034277-26728-2-git-send-email-zubair.lutfullah@gmail.com>
 <522C5F96.20001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <522C5F96.20001-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Sep 08, 2013 at 12:29:26PM +0100, Jonathan Cameron wrote:
> On 09/01/13 12:17, Zubair Lutfullah wrote:
> > Enable shared IRQ to allow ADC to share IRQ line from
> > parent MFD core. Only FIFO0 IRQs are for TSC and handled
> > on the TSC side.
> > 
> > Step mask would be updated from cached variable only previously.
> > In rare cases when both TSC and ADC are used, the cached
> > variable gets mixed up.
> > The step mask is written with the required mask every time.
> > 
> > Rachna Patil (TI) laid ground work for shared IRQ.
> > 
> > Signed-off-by: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Whilst I would have prefered an mfd under these drivers and elegant handling
> of the interrupts, I guess if this works it is at least not terribly invasive.
> 
> However, this does need an Ack from Dmitry before I can take it (or for
> Dmitry to take it himself?)

I completely agree with Jonathan, more elegant handling would be nice
but current one will do for now.

Since most of the work on the driver is going through IIO tree I think
it would make sense for this patch to go through it as well.

Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Thanks.

-- 
Dmitry
