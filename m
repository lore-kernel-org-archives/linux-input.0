From: "hyunhee.kim" <hyunhee.kim@samsung.com>
Subject: RE: [PATCH v2] Input: add regulator haptic driver
Date: Thu, 24 Oct 2013 18:26:30 +0900
Message-ID: <028401ced09b$1f6564d0$5e302e70$%kim@samsung.com>
References: <000a01cec629$3cf34de0$b6d9e9a0$%kim@samsung.com>
 <20131021155558.GA4255@core.coreip.homeip.net>
 <025101ced083$35f2a270$a1d7e750$%kim@samsung.com>
 <1382603886.1559.11.camel@linux-fkkt.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1382603886.1559.11.camel@linux-fkkt.site>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Oliver Neukum' <oneukum@suse.de>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@ti.com, wfp5p@virginia.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, kyungmin.park@samsung.com, 'Aristeu Sergio Rozanski Filho' <aris@ruivo.org>
List-Id: linux-input@vger.kernel.org

Hi, 

Thanks for your review.
I resent patch v3 after removing wrong wrapping.

I made one toggle function because enable/disable functions have redundant codes and another reviewer suggested it.
Is it better to separate it into two functions?

Thanks,
Hyunhee Kim.

-----Original Message-----
From: Oliver Neukum [mailto:oneukum@suse.de] 
Sent: Thursday, October 24, 2013 5:38 PM
To: hyunhee.kim
Cc: 'Dmitry Torokhov'; broonie@opensource.wolfsonmicro.com; peter.ujfalusi@ti.com; wfp5p@virginia.edu; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; akpm@linux-foundation.org; kyungmin.park@samsung.com; 'Aristeu Sergio Rozanski Filho'
Subject: Re: [PATCH v2] Input: add regulator haptic driver

On Thu, 2013-10-24 at 15:35 +0900, hyunhee.kim wrote:

Hi,

first of all your mail client mangled the patch.

> +static void regulator_haptic_toggle(struct regulator_haptic *haptic, bool
> enable)
> +{
> +	int ret;
> +
> +	mutex_lock(&haptic->mutex);
> +	if (enable && !haptic->enabled) {
> +		haptic->enabled = true;
> +		ret = regulator_enable(haptic->regulator);
> +		if (ret)
> +			dev_err(haptic->dev, "failed to enable
> regulator\n");
> +	} else if (!enable && haptic->enabled) {
> +		haptic->enabled = false;
> +		ret = regulator_disable(haptic->regulator);
> +		if (ret)
> +			dev_err(haptic->dev, "failed to disable
> regulator\n");
> +	}
> +	mutex_unlock(&haptic->mutex);
> +}
> +

Is there anything gained by the toggle parameter? Just code two
functions.

	Regards
		Oliver
