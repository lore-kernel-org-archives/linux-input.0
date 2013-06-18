From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] input: stmpe: Fix the touchscreen interrupt handling
Date: Tue, 18 Jun 2013 10:50:36 +0200
Message-ID: <20130618085035.GD7161@zurbaran>
References: <1366585565-13046-1-git-send-email-marex@denx.de>
 <20130516221745.GW22822@zurbaran>
 <201305170125.11552.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37098 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754759Ab3FRIvX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Jun 2013 04:51:23 -0400
Content-Disposition: inline
In-Reply-To: <201305170125.11552.marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>, Bill Pemberton <wfp5p@virginia.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi Marek,

On Fri, May 17, 2013 at 01:25:11AM +0200, Marek Vasut wrote:
> Dear Samuel Ortiz,
> 
> > Hi Marek,
> > 
> > On Mon, Apr 22, 2013 at 01:06:05AM +0200, Marek Vasut wrote:
> > > The touchscreen interrupt handling in the STMPE touchscreen driver
> > > doesn't seem to work correctly. It relies on FIFO_TH to be asserted
> > > instead of TOUCH_DET interrupt for touchscreen detection.
> > > 
> > > The FIFO_TH is usually asserted but is asserted independently of the
> > > touchscreen controller operation. Because the bits in the interrupt
> > > status register are not entirely cleaned, the interrupt handler is
> > > triggered even if FIFO_TH is not yet set. Make sure that all bits in
> > > the interrupt status register are cleared early.
> > > 
> > > Rework the touchscreen interrupt handling so it waits for TOUCH_DET
> > > interrupt to happen. Upon first TOUCH_DET interrupt, worker thread
> > > is started which polls the touchscreen controller for location data
> > > until no touch is detected. Touch is determined by checking the X
> > > and Y coordinates, if they are zero, no touch happens.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > > Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > Cc: Bill Pemberton <wfp5p@virginia.edu>
> > > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > > ---
> > > 
> > >  drivers/input/touchscreen/stmpe-ts.c |  111
> > >  ++++++++++++++-------------------- drivers/mfd/stmpe.c                 
> > >  |   10 +--
> > >  2 files changed, 50 insertions(+), 71 deletions(-)
> > 
> > Could you please split this patch in 2, the MFD part is independent from
> > the input one and could be applied separately.
> 
> I'd vote for applying this as one single patch, since this fixes one single 
> problem (touchscreen not working properly). Or is that a big issue for you?
I am fine as long as we get feedback from Dmitry and the ST folks about
it.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
