From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] [input] add mc13783 touchscreen driver
Date: Wed, 12 Aug 2009 09:04:38 -0700
Message-ID: <20090812163521.75631526EC9@mailhub.coreip.homeip.net>
References: <1250089531-10399-1-git-send-email-s.hauer@pengutronix.de> <1250089531-10399-2-git-send-email-s.hauer@pengutronix.de> <1250089531-10399-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754135AbZHLQEs@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1250089531-10399-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 12, 2009 at 05:05:28PM +0200, Sascha Hauer wrote:
> This driver provides support for the touchscreen interface
> integrated into the Freescale MC13783.
> 
> changes since v1:
> 
> - remove unused functions
> - use queue_delayed_work instead of queue_work
> - report pen events as BTN_TOUCH instead of ABS_PRESSURE
> - handle interrupt registration in open/close functions
> - do not call input_free_device() on already registered
>   input_device
> - use platform_driver_probe instead of platform_driver_register

BTW, if you are using platform_driver_probe() then __init is OK for
.probe() because all probes will only be run once, when driver loads.
IIRC the ability to discard probe() code was the main reason for
introducing platform_driver_probe().

> +
> +	/* unmask the ts wakeup interrupt */
> +	mc13783_set_bits(priv->mc13783, MC13783_REG_INTERRUPT_MASK_0,
> +			MC13783_INT_MASK_TSM, 0);
> +
> +	mc13783_adc_set_ts_status(priv->mc13783, 1);
> +

I actually expected these bits to go into ->open(); not the request IRQ
stuff...

-- 
Dmitry
