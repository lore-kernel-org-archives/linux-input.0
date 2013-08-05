From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] input: ti_tsc: Enable shared IRQ for TSC
Date: Mon, 5 Aug 2013 20:21:14 +0100
Message-ID: <20130805192113.GA7041@gmail.com>
References: <1374882674-18403-1-git-send-email-zubair.lutfullah@gmail.com>
 <1374882674-18403-2-git-send-email-zubair.lutfullah@gmail.com>
 <51FE361B.5030900@kernel.org>
 <20130805161256.GA8794@core.coreip.homeip.net>
 <20130805170201.GA4310@gmail.com>
 <20130805174031.GA20093@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130805174031.GA20093-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 05, 2013 at 10:40:31AM -0700, Dmitry Torokhov wrote:
> > 
> > FIFO 1 used only by ADC and FIFO1THRES handler is inside the iio/adc driver
> > FIFO 0 used only by TSC and FIFO0THRES handler is inside the input/touchscreen
> > 
> > Note: These are level interrupts.
> > 
> > I would like some input on how to handle such a situation. 
> 
> It looks like you need to have smart demultiplexing in MFD core of your
> driver instead of relying on shared interrupt handler.
> 
> Another option would be to check "your" bits, handle the data, clear the
> status and then check bits again and return IRQ_NONE instead of
> IRQ_HANDLED if other guys bits are set, but it is way too ugly.
> 
> Thanks.
> 
> -- 
> Dmitry

That is going to make a lot of changes in mfd, input and iio
And should require a separate patch series.

Is it possible to accept the current patches to add continuous mode 
to the ADC side as is before the next merge window?

This issue doesn't disturb each side individually..

I'll look into fixing the IRQs after settling continuous mode.

Thanks
Zubair Lutfullah
