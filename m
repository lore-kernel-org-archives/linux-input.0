From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v3 1/1] input: add driver for Bosch Sensortec's BMA150
 accelerometer
Date: Thu, 14 Jul 2011 23:40:30 +0100
Message-ID: <20110714234030.30d6b455@lxorguk.ukuu.org.uk>
References: <1310680572-27410-1-git-send-email-eric.andersson@unixphere.com>
	<1310680572-27410-2-git-send-email-eric.andersson@unixphere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41693 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932371Ab1GNWho (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Jul 2011 18:37:44 -0400
In-Reply-To: <1310680572-27410-2-git-send-email-eric.andersson@unixphere.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Andersson <eric.andersson@unixphere.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zhengguang.guo@bosch-sensortec.com, stefan.nilsson@unixphere.com, Albert Zhang <xu.zhang@bosch-sensortec.com>

> +		values represent the range given as +/- G.
> +		Possible values are: 2, 4, 8.
> +
> +		Reading: returns the current acceleration range.
> +
> +		Writing: sets a new acceleration range.

Same comment as last time - these values are not discoverable so it
should set the nearest bigger range.

> +
> +
> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/bandwidth
> +Date:		May 2011
> +Contact:	Eric Andersson <eric.andersson@unixphere.com>
> +Description:	This is used to setup the digital filtering on ADC output data.
> +		The values represent the bandwidth given in Hz.
> +		Possible values are: 25, 50, 100, 190, 375, 750, 1500
> +
> +		Reading: returns the current bandwidth.
> +
> +		Writing: sets a new bandwidth.

Ditto


> +	for (i = 0, ret = 0; i < ARRAY_SIZE(bw_val); i++)
> +		ret += sprintf(buf + ret,
> +			(bw_val[i].reg == bw) ? "[%d] " : "%d ",
> +			bw_val[i].value);

sysfs nodes should really be single values

> +static const struct i2c_device_id bma150_id[] = {
> +	{ "bma150", 0 },
> +	{ "smb380", 0 },

bma023 ?

It also doesn't expose the thresholds or support interrupts which the
one I posted did.

So while its better it still seems incomplete - its certainly nowhere
near where it can replace the one I posted months ago and doesn't seem to
be making any headway.

Dmitry shall I repost the intel one - at this point I think it would be a
better starting point as it supports more features, interrupts and the
like although it's not perfect either.

Alan
