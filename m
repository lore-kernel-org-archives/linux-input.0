From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 4/8] input: goodix: reset device at init
Date: Tue, 9 Jun 2015 10:57:56 -0700
Message-ID: <20150609175756.GI6338@dtor-ws>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
 <1433774273-23103-5-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f194.google.com ([209.85.223.194]:34070 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbbFIR6R (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 13:58:17 -0400
Content-Disposition: inline
In-Reply-To: <1433774273-23103-5-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Bastien Nocera <hadess@hadess.net>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Octavian Purdila <octavian.purdila@intel.com>

Hi Irina,

On Mon, Jun 08, 2015 at 05:37:49PM +0300, Irina Tirdea wrote:
> +static int goodix_get_gpio_config(struct goodix_ts_data *ts)
> +{
> +	struct device *dev;
> +	struct gpio_desc *gpiod;
> +	int ret;
> +
> +	if (!ts->client)
> +		return -EINVAL;
> +	dev = &ts->client->dev;
> +
> +	/* Get interrupt GPIO pin number */
> +	gpiod = devm_gpiod_get(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
> +	if (IS_ERR(gpiod)) {
> +		ret = PTR_ERR(gpiod);
> +		dev_err(dev, "Failed to get %s GPIO: %d\n",
> +			GOODIX_GPIO_INT_NAME, ret);

You need to handle -EPROBE_DEFER (suppress error) and especially -ENOENT error
codes, otherwise, as Bastien mentioned, you will break existing DTS.

Thanks.

-- 
Dmitry
