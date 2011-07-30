From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 1/1] input: add driver for Bosch Sensortec's BMA150
 accelerometer
Date: Sat, 30 Jul 2011 12:17:26 -0700
Message-ID: <20110730191726.GG5686@core.coreip.homeip.net>
References: <1311800027-25982-1-git-send-email-eric.andersson@unixphere.com>
 <1311800027-25982-2-git-send-email-eric.andersson@unixphere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35012 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1G3TRd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Jul 2011 15:17:33 -0400
Content-Disposition: inline
In-Reply-To: <1311800027-25982-2-git-send-email-eric.andersson@unixphere.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Andersson <eric.andersson@unixphere.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zhengguang.guo@bosch-sensortec.com, stefan.nilsson@unixphere.com, alan@lxorguk.ukuu.org.uk, jic23@cam.ac.uk, Albert Zhang <xu.zhang@bosch-sensortec.com>

Hi Eric,

On Wed, Jul 27, 2011 at 10:53:47PM +0200, Eric Andersson wrote:
> +
> +static int bma150_open(struct bma150_data *bma150)
> +{
> +	int ret;
> +
> +	ret = pm_runtime_set_active(&bma150->client->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	pm_runtime_enable(&bma150->client->dev);

I am pretty sure you want to call pm_runtime_enable() in bma150_probe()
so that parent controller can be suspended until somebody calls
bma150_open() and we mark the device as active (which, in turn, should
wake up its parent).

> +
> +	return bma150_set_mode(bma150->client, BMA150_MODE_NORMAL);
> +}
> +
> +static void bma150_close(struct bma150_data *bma150)
> +{
> +	pm_runtime_disable(&bma150->client->dev);

And disable should go into bma150_remove() unless I misunderstand
runtime PM framework.

> +	pm_runtime_set_suspended(&bma150->client->dev);
> +	bma150_set_mode(bma150->client, BMA150_MODE_SLEEP);

I think you want to call bma150_set_mode() first and then mark device as
suspended so that parent can go to sleep as well.

Thanks.

-- 
Dmitry
