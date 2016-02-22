From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: stmpe: kerneldoc
Date: Mon, 22 Feb 2016 11:38:05 -0800
Message-ID: <20160222193805.GB26177@dtor-ws>
References: <1455456681-18846-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34615 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbcBVTiI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2016 14:38:08 -0500
Received: by mail-pf0-f178.google.com with SMTP id x65so97628444pfb.1
        for <linux-input@vger.kernel.org>; Mon, 22 Feb 2016 11:38:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455456681-18846-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org

On Sun, Feb 14, 2016 at 02:31:21PM +0100, Linus Walleij wrote:
> commit e4b88e19897f1039fd83f1630517becafc0dd163
> "Input: stmpe-ts - enforce device tree only mode"
> removed platform data but accidentally stripped away useful
> kerneldoc, so reintroduce it.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/stmpe-ts.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
> index e414d43e5159..2a78e27b4495 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -63,6 +63,37 @@
>  #define STMPE_TS_NAME			"stmpe-ts"
>  #define XY_MASK				0xfff
>  
> +/**
> + * struct stmpe_touch - stmpe811 touch screen controller state
> + * @stmpe: pointer back to STMPE MFD container
> + * @idev: registered input device
> + * @work: a work item used to scan the device
> + * @dev: a pointer back to the MFD cell struct device*
> + * @sample_time: ADC converstion time in number of clock.
> + * (0 -> 36 clocks, 1 -> 44 clocks, 2 -> 56 clocks, 3 -> 64 clocks,
> + * 4 -> 80 clocks, 5 -> 96 clocks, 6 -> 144 clocks),
> + * recommended is 4.
> + * @mod_12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
> + * @ref_sel: ADC reference source
> + * (0 -> internal reference, 1 -> external reference)
> + * @adc_freq: ADC Clock speed
> + * (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
> + * @ave_ctrl: Sample average control
> + * (0 -> 1 sample, 1 -> 2 samples, 2 -> 4 samples, 3 -> 8 samples)
> + * @touch_det_delay: Touch detect interrupt delay
> + * (0 -> 10 us, 1 -> 50 us, 2 -> 100 us, 3 -> 500 us,
> + * 4-> 1 ms, 5 -> 5 ms, 6 -> 10 ms, 7 -> 50 ms)
> + * recommended is 3
> + * @settling: Panel driver settling time
> + * (0 -> 10 us, 1 -> 100 us, 2 -> 500 us, 3 -> 1 ms,
> + * 4 -> 5 ms, 5 -> 10 ms, 6 for 50 ms, 7 -> 100 ms)
> + * recommended is 2
> + * @fraction_z: Length of the fractional part in z
> + * (fraction_z ([0..7]) = Count of the fractional part)
> + * recommended is 7
> + * @i_drive: current limit value of the touchscreen drivers
> + * (0 -> 20 mA typical 35 mA max, 1 -> 50 mA typical 80 mA max)
> + */
>  struct stmpe_touch {
>  	struct stmpe *stmpe;
>  	struct input_dev *idev;
> -- 
> 2.4.3
> 

-- 
Dmitry
