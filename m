From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Input: add wm97xx accelerated driver for AVR32
	AT32AP700X microprocessors
Date: Tue, 3 Mar 2009 10:35:02 +0000
Message-ID: <20090303103501.GA19086@rakim.wolfsonmicro.main>
References: <1236000228-13025-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1236000228-13025-2-git-send-email-broonie@opensource.wolfsonmicro.com> <20090303091322.GA14557@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60001 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750901AbZCCKfG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Mar 2009 05:35:06 -0500
Content-Disposition: inline
In-Reply-To: <20090303091322.GA14557@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>

On Tue, Mar 03, 2009 at 01:13:23AM -0800, Dmitry Torokhov wrote:
> Hi Mark,

This is actually Hans-Christian's patch but here goes...

> > +		if (!pressure && source == WM97XX_ADCSEL_Y) {
> > +			input_report_abs(wm->input_dev, ABS_X, at32_wm97xx->x);
> > +			input_report_abs(wm->input_dev, ABS_Y, at32_wm97xx->y);
> > +			input_report_abs(wm->input_dev, ABS_PRESSURE, pen_down);

> Please do not report pressure (and don't advertise ABS_PRESSURE) if you don't
> actually read it. I have seen a follow-up patch that adds BTN_TOUCH that should
> work just fine here. The usage below is good since there you actually do provide
> true pressure readings. BTW, why would one not want pressure readings?

These parts are usually deployed in embedded systems where performance
is sufficiently tightly constrained that the additional work involved in
taking pressure measurements is noticable.  This is mostly the case
where PIO is used but users have reported problems even when using DMA
so idiomatically WM97xx drivers provide the option.
