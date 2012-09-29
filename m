From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 0/5] Support for TSC/ADC MFD driver
Date: Sat, 29 Sep 2012 10:06:29 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E9582F0@DBDE01.ent.ti.com>
References: <1348636814-14129-1-git-send-email-rachna@ti.com>
 <5066C29D.7040009@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5066C29D.7040009-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 29, 2012 at 15:12:53, Jonathan Cameron wrote:
> On 09/26/2012 06:20 AM, Patil, Rachna wrote:
> > This patch set adds a MFD core driver which registers touchscreen and 
> > ADC as its client drivers.
> > The existing touchscreen has been modified to work as a MFD client 
> > driver and a new ADC driver has been added in the IIO subsystem.
> > 
> > There are 8 analog input lines, which can be used as:
> > 1. 8 general purpose ADC channels
> > 2. 4 wire TS, with 4 general purpose ADC channels 3. 5 wire TS, with 3 
> > general purpose ADC channels
> > 
> > This patch set has been tested on AM335x EVM.
> > 
> > These set of patches are based on top of Touchscreen patch set 
> > submitted.
> > Subject: [PATCH 0/4] input: TSC: ti_tscadc: TI Touchscreen driver 
> > updates [1]
> > 
> > [1] http://www.spinics.net/lists/linux-input/msg22107.html
> which tree have these merged in?

This patch set includes some changes in the touchscreen driver.
They have not been acked as yet. I am waiting for a reply from Dmitry.

Regards,
Rachna

> 
> I'll assume the rest of this is going through the same tree and ack rather than signing off and taking it through IIO.
> 
> Note that patch 1 does not appear to apply to linux-next which implies some issues somewhere or that the above series has been picked up for any trees feeding linux-next as yet.
> > 
> > Changes in v2:
> > 	Dropped one patch send in the last version after
> > 	receiving internal comments. I have merged the changes
> > 	into existing patches.
> > 	Also added a new patch to support suspend/resume feature.
> > 	Fixed review comments by Matthias Kaehlcke.
> > 
> > Changes in v3:
> > 	Addressed review comments by Jonathan Cameron.
> > 	Improved ADC driver with more readable labels,
> > 	spaces and comments.
> > 
> > Changes in v4:
> > 	Renamed the drivers from ti_xxx to ti_am335x_xxx.
> > 	For consistency with other drivers renamed idev to indio_dev
> > 	in IIO ADC driver.
> > 	Replaced suspend/resume callbacks with dev_pm_ops.
> > 
> > Patil, Rachna (5):
> >   input: TSC: ti_tscadc: Rename the existing touchscreen driver
> >   MFD: ti_tscadc: Add support for TI's TSC/ADC MFDevice
> >   input: TSC: ti_tsc: Convert TSC into a MFDevice
> >   IIO : ADC: tiadc: Add support of TI's ADC driver
> >   MFD: ti_tscadc: add suspend/resume functionality
> > 
> >  drivers/iio/adc/Kconfig                            |    7 +
> >  drivers/iio/adc/Makefile                           |    1 +
> >  drivers/iio/adc/ti_am335x_adc.c                    |  258 ++++++++++++++++
> >  drivers/input/touchscreen/Kconfig                  |    4 +-
> >  drivers/input/touchscreen/Makefile                 |    2 +-
> >  .../touchscreen/{ti_tscadc.c => ti_am335x_tsc.c}   |  319 ++++++--------------
> >  drivers/mfd/Kconfig                                |    9 +
> >  drivers/mfd/Makefile                               |    1 +
> >  drivers/mfd/ti_am335x_tscadc.c                     |  259 ++++++++++++++++
> >  .../linux/input/{ti_tscadc.h => ti_am335x_tsc.h}   |    4 +-
> >  include/linux/mfd/ti_am335x_tscadc.h               |  151 +++++++++
> >  include/linux/platform_data/ti_am335x_adc.h        |   14 +
> >  12 files changed, 801 insertions(+), 228 deletions(-)  create mode 
> > 100644 drivers/iio/adc/ti_am335x_adc.c  rename 
> > drivers/input/touchscreen/{ti_tscadc.c => ti_am335x_tsc.c} (55%)  
> > create mode 100644 drivers/mfd/ti_am335x_tscadc.c  rename 
> > include/linux/input/{ti_tscadc.h => ti_am335x_tsc.h} (88%)  create 
> > mode 100644 include/linux/mfd/ti_am335x_tscadc.h
> >  create mode 100644 include/linux/platform_data/ti_am335x_adc.h
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" 
> > in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
