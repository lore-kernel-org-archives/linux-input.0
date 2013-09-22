From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V11 0/3] iio: input: ti_am335x_adc: Add continuous
 sampling support
Date: Sun, 22 Sep 2013 09:42:16 +0500
Message-ID: <20130922044214.GA2989@gmail.com>
References: <1379571876-12420-1-git-send-email-zubair.lutfullah@gmail.com>
 <523D7A65.5010303@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <523D7A65.5010303-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, Sep 21, 2013 at 11:52:21AM +0100, Jonathan Cameron wrote:
> Hi Zubair,
> 
> Thanks for persevering with this patch set.  Now this
> gets to be the example for dealing with hardware buffer
> equipped devices ;)
> 
> Applied to the togreg branch of
>  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Thank-you very much for the quick feedbacks and accepting these patches!
:)

Zubair

> 
> On 09/19/13 07:24, Zubair Lutfullah wrote:
> > Hi,
> > 
> > These apply to the togreg branch in iio.
> > 
> > Round 11
> > - Optimized memory usage based on list feedback
> > - Changed devm_*_irq to normal *_irq functions
> > 
> > Round 10 updates
> > - Removed devm_free as not needed
> > 
> > Round 9 updates
> > 
> > - Removed Trigger.
> > - Restructured everything for INDIO_BUFFERED_HARDWARE mode.
> > - Threaded IRQ with top/bottom halfs. Top half HW IRQ wakes
> > bottom half threaded worker that pushes samples to iio/userspace.
> > - Removed some of the patchwork to the driver that was irrelevant to the
> > continuous sampling patch.
> > 
> > Cleanup will be done separately once this goes through.
> > Hope these patches meet the mighty kernel standards :)
> > 
> > Zubair
> > 
> > Zubair Lutfullah (3):
> >   input: ti_am335x_tsc: Enable shared IRQ for TSC
> >   iio: ti_am335x_adc: optimize memory usage.
> >   iio: ti_am335x_adc: Add continuous sampling support
> > 
> >  drivers/iio/adc/ti_am335x_adc.c           |  217 ++++++++++++++++++++++++++++-
> >  drivers/input/touchscreen/ti_am335x_tsc.c |   12 +-
> >  include/linux/mfd/ti_am335x_tscadc.h      |    9 ++
> >  3 files changed, 228 insertions(+), 10 deletions(-)
> > 
