From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: add wm97xx accelerated driver for AVR32
	AT32AP700X microprocessors
Date: Tue, 3 Mar 2009 01:13:23 -0800
Message-ID: <20090303091322.GA14557@dtor-d630.eng.vmware.com>
References: <1236000228-13025-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1236000228-13025-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:55885 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbZCCJNf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 04:13:35 -0500
Content-Disposition: inline
In-Reply-To: <1236000228-13025-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>

Hi Mark,

On Mon, Mar 02, 2009 at 01:23:48PM +0000, Mark Brown wrote:
> +
> +		if (!pressure && source == WM97XX_ADCSEL_Y) {
> +			input_report_abs(wm->input_dev, ABS_X, at32_wm97xx->x);
> +			input_report_abs(wm->input_dev, ABS_Y, at32_wm97xx->y);
> +			input_report_abs(wm->input_dev, ABS_PRESSURE, pen_down);

Please do not report pressure (and don't advertise ABS_PRESSURE) if you don't
actually read it. I have seen a follow-up patch that adds BTN_TOUCH that should
work just fine here. The usage below is good since there you actually do provide
true pressure readings. BTW, why would one not want pressure readings?

> +			input_sync(wm->input_dev);
> +		} else if (pressure && source == WM97XX_ADCSEL_PRES) {
> +			input_report_abs(wm->input_dev, ABS_X, at32_wm97xx->x);
> +			input_report_abs(wm->input_dev, ABS_Y, at32_wm97xx->y);
> +			input_report_abs(wm->input_dev, ABS_PRESSURE, value);
> +			input_sync(wm->input_dev);

Thanks.

-- 
Dmitry
