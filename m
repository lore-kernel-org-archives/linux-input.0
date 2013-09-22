From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] iio: ti_am335x_adc: Add continuous sampling support
Date: Sun, 22 Sep 2013 09:46:18 +0500
Message-ID: <20130922044616.GB2989@gmail.com>
References: <1379571876-12420-1-git-send-email-zubair.lutfullah@gmail.com>
 <1379571876-12420-4-git-send-email-zubair.lutfullah@gmail.com>
 <523DE550.4070107@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <523DE550.4070107-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, Sep 21, 2013 at 07:28:32PM +0100, Jonathan Cameron wrote:
> On 09/19/13 07:24, Zubair Lutfullah wrote:
> > Previously the driver had only one-shot reading functionality.
> > This patch adds continuous sampling support to the driver.
...
> I've added a SELECT IIO_KFIFO_BUF after the autobuilders picked
> up that was missing.
> 
Thank-you.

> One other thing I'd missed until I was reviewing the updated patch.
> Do you still need the trigger headers?  I can't immediately see why.
> If not, could you post a follow up patch to drop them?
> 

Sure.

Zubair

> Thanks,
> 
> Jonathan
> > ---
> >  drivers/iio/adc/ti_am335x_adc.c      |  213 +++++++++++++++++++++++++++++++++-
> >  include/linux/mfd/ti_am335x_tscadc.h |    9 ++
