From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: ads7846 Remove redundant
 regulator_disable call
Date: Fri, 19 Aug 2016 10:15:04 -0700
Message-ID: <20160819171504.GF20499@dtor-ws>
References: <f97e51ae-3e09-091e-ac2a-a3f6beda2ffc@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35635 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753916AbcHSRPH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Aug 2016 13:15:07 -0400
Received: by mail-pf0-f193.google.com with SMTP id h186so1737199pfg.2
        for <linux-input@vger.kernel.org>; Fri, 19 Aug 2016 10:15:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f97e51ae-3e09-091e-ac2a-a3f6beda2ffc@tul.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: linux-input@vger.kernel.org

On Wed, Aug 17, 2016 at 12:35:17PM +0200, Petr Cvek wrote:
> ADS7846 regulator is disabled twice in a row in ads7846_remove(). Valid
> one is in ads7846_disable().
> 
> Removing the ads7846 module causes warning about unbalanced disables.
> 
>   ...
>   WARNING: CPU: 0 PID: 29269 at drivers/regulator/core.c:2251 _regulator_disable+0xf8/0x130
>   unbalanced disables for vads7846
>   CPU: 0 PID: 29269 Comm: rmmod Tainted: G      D W       4.7.0+ #3
>   Hardware name: HTC Magician
>   ...
>     show_stack+0x10/0x14
>     __warn+0xd8/0x100
>     warn_slowpath_fmt+0x38/0x48
>     _regulator_disable+0xf8/0x130
>     regulator_disable+0x34/0x60
>     ads7846_remove+0x58/0xd4 [ads7846]
>     spi_drv_remove+0x1c/0x34
>     __device_release_driver+0x84/0x114
>     driver_detach+0x8c/0x90
>     bus_remove_driver+0x5c/0xc8
>     SyS_delete_module+0x1a0/0x238
>     ret_fast_syscall+0x0/0x38
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

Applied, thank you.

> ---
>  drivers/input/touchscreen/ads7846.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index a61b215..1ce3ecb 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -1473,7 +1473,6 @@ static int ads7846_remove(struct spi_device *spi)
>  
>  	ads784x_hwmon_unregister(spi, ts);
>  
> -	regulator_disable(ts->reg);
>  	regulator_put(ts->reg);
>  
>  	if (!ts->get_pendown_state) {
> -- 
> 2.9.2
> 

-- 
Dmitry
