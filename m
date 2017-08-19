From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Add antoher Lenovo ACPI ID for Yoga310
 Add ELAN0602 in ACPI mapping table to support Yoga310's ELAN touchpad
 Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Date: Fri, 18 Aug 2017 17:01:11 -0700
Message-ID: <20170819000111.GB17326@dtor-ws>
References: <1501160243-4156-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33787 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdHSABO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 18 Aug 2017 20:01:14 -0400
Content-Disposition: inline
In-Reply-To: <1501160243-4156-1-git-send-email-kt.liao@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: KT Liao <kt.liao@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw

On Thu, Jul 27, 2017 at 08:57:23PM +0800, KT Liao wrote:
> ---

Applied, thank you.

>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 3b616cb..88fc0f8 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1247,6 +1247,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0000", 0 },
>  	{ "ELAN0100", 0 },
>  	{ "ELAN0600", 0 },
> +	{ "ELAN0602", 0 },
>  	{ "ELAN0605", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
> -- 
> 2.7.4
> 

-- 
Dmitry
