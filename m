From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2] Touchscreen driver for FT5x06 based EDT displays
Date: Fri, 2 Dec 2011 14:51:46 +0100
Message-ID: <20111202145146.33d5b8be@wker>
References: <1317311577-29742-1-git-send-email-simon.budig@kernelconcepts.de>
	<1317311577-29742-2-git-send-email-simon.budig@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:60798 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756634Ab1LBNvu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Dec 2011 08:51:50 -0500
In-Reply-To: <1317311577-29742-2-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hi Simon,

there is a number of issues with this patch. Please check it
using 'scripts/checkpatch.pl' and fix them before posting next
patch version. Thanks! Please see a comment below.

On Thu, 29 Sep 2011 17:52:57 +0200
Simon Budig <simon.budig@kernelconcepts.de> wrote:
...
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> new file mode 100644
> index 0000000..1c4725d
> --- /dev/null
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
...
> +static int edt_ft5x06_i2c_ts_probe(struct i2c_client *client,
> +                                   const struct i2c_device_id *id)
> +{
...
> +
> +	dev_set_drvdata(&client->dev, tsdata);
> +	tsdata->client = client;
> +	pdata = client->dev.platform_data;
> +
> +	tsdata->reset_pin = pdata->reset_pin;

passing platform data for specifying reset_pin should be optional,
I think. There are hardware configurations without wired gpio for
/RST controlling, /RST is controlled by HW-circuitry. The driver
should be usable with such configurations, too. Can you please
change the driver so that controlling reset pin becomes optional?

Thanks,
Anatolij
