From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 4/9] input: goodix: add ACPI IDs for GT911 and GT9271
Date: Thu, 04 Jun 2015 14:51:00 +0200
Message-ID: <1433422260.5346.15.camel@hadess.net>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
	 <1432817265-23891-5-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35039 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbFDMvF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Jun 2015 08:51:05 -0400
In-Reply-To: <1432817265-23891-5-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2015-05-28 at 15:47 +0300, Irina Tirdea wrote:
> Add ACPI IDs to support Goodix GT911 and GT9271
> touchscreens.

Those devices are present on which systems which you would have tested
this on?

> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> ---
>  drivers/input/touchscreen/goodix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c 
> b/drivers/input/touchscreen/goodix.c
> index 9561396..9e7d215 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -392,6 +392,8 @@ static const struct i2c_device_id goodix_ts_id[] 
> = {
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id goodix_acpi_match[] = {
>       { "GDIX1001", 0 },
> +     { "GDIX0911", 0 },
> +     { "GDIX9271", 0 },
>       { }
>  };
>  MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
