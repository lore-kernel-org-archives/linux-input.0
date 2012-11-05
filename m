From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RESEND 0/8] TI Touchscreen driver updates and Support for
 TSC/ADC MFD driver
Date: Mon, 5 Nov 2012 23:55:24 +0100
Message-ID: <20121105225524.GE7965@sortiz-mobl>
References: <1350372345-27108-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1350372345-27108-1-git-send-email-rachna-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Rachna,

On Tue, Oct 16, 2012 at 12:55:37PM +0530, Patil, Rachna wrote:
> This patch set is a cumulative set of [1] and [2] sent earlier.
> I have merged the patch set so that the MFD patches apply without
> any issues.
> 
> Also Note that there are no code changes in either of the patch set,
> only rebased on top of linux-next to make sure that all the patches
> apply without any conflicts.
> 
> This patch set has been tested on AM335x EVM.
> 
> [1] "[PATCH 0/4] input: TSC: ti_tscadc: TI Touchscreen driver updates"
> (http://www.spinics.net/lists/linux-input/msg22107.html)
> 
> [2] "[PATCH v5 0/4] Support for TSC/ADC MFD driver"
> (http://www.spinics.net/lists/linux-input/msg22832.html)
> 
> Patil, Rachna (8):
>   input: TSC: ti_tscadc: Correct register usage
>   input: TSC: ti_tscadc: Add Step configuration as platform data
>   input: TSC: ti_tscadc: set FIFO0 threshold Interrupt
>   input: TSC: ti_tscadc: Remove definition of End Of Interrupt register
>   input: TSC: ti_tscadc: Rename the existing touchscreen driver
>   MFD: ti_tscadc: Add support for TI's TSC/ADC MFDevice
>   input: TSC: ti_tsc: Convert TSC into a MFDevice
>   IIO : ADC: tiadc: Add support of TI's ADC driver
All patches applied now, thanks a lot.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
