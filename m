From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/4] iio: input: ti_am335x_adc: Add continuous sampling
 support round 5
Date: Wed, 14 Aug 2013 19:57:12 +0100
Message-ID: <520BD308.7030709@kernel.org>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Cc: jic23@cam.ac.uk, dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, gregkh@linuxfoundation.org, Russ.Dill@ti.com
List-Id: linux-input@vger.kernel.org

I'll actually look at these later, but please do put a version number
in your cover letter patch subject.
[PATCH V5 0/4] is pretty much the convention to reduce the chance of anyone
looking at the wrong version.

Thanks,

Jonathan

On 08/13/13 21:04, Zubair Lutfullah wrote:
> Round 5 updates. Fixed the define order in the header as guided by Lee.
> 
> Round 4 updates below.
> 
> Note: These apply to the fixes-togreg branch in IIO because of
> a fix on the adc side in there.
> 
> The first few are for input which tweak the TSC driver to
> allow ADC in continuous mode with irqs to work nicely together.
> 
> The last one is for iio which adds continuous mode to the adc side.
> 
> Received feedback on previous series.
> 1. What if IRQs occur together?
> This is handled now. Even if both assert.
> They both work.
> 
> 2. IIO error handling wrong.
> Fixed now.
> 
> 3. Headers wierd in IIO.
> Fixed.
> 
> Apart from that, found a few bugs in continuous mode
> here and there. And squashed them into the same patch.
> 
> Thanks
> Zubair Lutfullah
> 
> Zubair Lutfullah (4):
>   input: ti_am335x_tsc: correct step mask update after IRQ
>   input: ti_am335x_tsc: Increase sequencer delay time
>   input: ti_am335x_tsc: Enable shared IRQ for TSC, add overrun and
>     underflow checks
>   iio: ti_am335x_adc: Add continuous sampling and trigger support
> 
>  drivers/iio/adc/ti_am335x_adc.c           |  353 ++++++++++++++++++++++++-----
>  drivers/input/touchscreen/ti_am335x_tsc.c |   45 +++-
>  include/linux/mfd/ti_am335x_tscadc.h      |   14 ++
>  3 files changed, 342 insertions(+), 70 deletions(-)
> 
