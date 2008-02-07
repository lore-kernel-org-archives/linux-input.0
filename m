From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/6] Core driver for WM97xx touchscreens
Date: Thu, 7 Feb 2008 17:07:23 -0500
Message-ID: <20080207170112.ZZRA012@mailhub.coreip.homeip.net>
References: <20080126151820.GA13899@sirena.org.uk> <1201368516-3513-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762233AbYBGWHn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1201368516-3513-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Dmitry Baryshkov <dbaryshkov@gmail.com>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>, Mike Arthur <mike.arthur@wolfsonmicro.com>, Stanley Cai <stanley.cai@intel.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, Ian Molton <spyro@f2s.com>, Vincent Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>
List-Id: linux-input@vger.kernel.org

Hi Mark,

On Sat, Jan 26, 2008 at 05:28:31PM +0000, Mark Brown wrote:
> +
> +	/* register our battery device */
> +	wm->battery_dev = platform_device_alloc("wm97xx-battery", 0);
> +	if (!wm->battery_dev)
> +		goto batt_err;
...
> + batt_err:
> +	input_unregister_device(wm->input_dev);
> +	kfree(wm);
> +	return ret;
> +}

The probe error handling is not quite correct. When we reach the fragment
above ret variable is 0 so if platfrom_device_alloc() fails we will return
0 and the device will be considered bound but in half-dead state. Please
make sure that proper error is returned in all cases. Also please do not
mix out of line and in-line error unwinding (input_free_device() should
be called in the error path and if you are concerned about double-free
after input_unregister_device() just set wm->input_dev to NULL there).

Thanks.

-- 
Dmitry
