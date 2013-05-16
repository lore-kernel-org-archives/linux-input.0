From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] input: stmpe: Fix the touchscreen interrupt handling
Date: Fri, 17 May 2013 00:17:45 +0200
Message-ID: <20130516221745.GW22822@zurbaran>
References: <1366585565-13046-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49241 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754982Ab3EPWSK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 May 2013 18:18:10 -0400
Content-Disposition: inline
In-Reply-To: <1366585565-13046-1-git-send-email-marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bill Pemberton <wfp5p@virginia.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Marek,

On Mon, Apr 22, 2013 at 01:06:05AM +0200, Marek Vasut wrote:
> The touchscreen interrupt handling in the STMPE touchscreen driver
> doesn't seem to work correctly. It relies on FIFO_TH to be asserted
> instead of TOUCH_DET interrupt for touchscreen detection.
> 
> The FIFO_TH is usually asserted but is asserted independently of the
> touchscreen controller operation. Because the bits in the interrupt
> status register are not entirely cleaned, the interrupt handler is
> triggered even if FIFO_TH is not yet set. Make sure that all bits in
> the interrupt status register are cleared early.
> 
> Rework the touchscreen interrupt handling so it waits for TOUCH_DET
> interrupt to happen. Upon first TOUCH_DET interrupt, worker thread
> is started which polls the touchscreen controller for location data
> until no touch is detected. Touch is determined by checking the X
> and Y coordinates, if they are zero, no touch happens.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/input/touchscreen/stmpe-ts.c |  111 ++++++++++++++--------------------
>  drivers/mfd/stmpe.c                  |   10 +--
>  2 files changed, 50 insertions(+), 71 deletions(-)
Could you please split this patch in 2, the MFD part is independent from the
input one and could be applied separately.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
