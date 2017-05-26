From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: silead: Disable interrupt during suspend
Date: Fri, 26 May 2017 16:10:31 -0700
Message-ID: <20170526231031.GC40877@dtor-ws>
References: <20170519140642.31800-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34321 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948829AbdEZXKf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 May 2017 19:10:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so5724567pfk.1
        for <linux-input@vger.kernel.org>; Fri, 26 May 2017 16:10:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170519140642.31800-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

On Fri, May 19, 2017 at 04:06:42PM +0200, Hans de Goede wrote:
> When we put the touchscreen controller in low-power mode the irq
> pin may trigger (float) and if we then try to read a data packet we
> get the following error in dmesg:
> 
> [  478.801017] silead_ts i2c-MSSL1680:00: Data read error -121
> 
> This commit disables the irq during suspend/resume fixing this error.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/silead.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index 9b36f2750b9f..52c878a20a92 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -536,6 +536,7 @@ static int __maybe_unused silead_ts_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  
> +	disable_irq(client->irq);
>  	silead_ts_set_power(client, SILEAD_POWER_OFF);
>  	return 0;
>  }
> @@ -561,6 +562,8 @@ static int __maybe_unused silead_ts_resume(struct device *dev)
>  		return -ENODEV;
>  	}
>  
> +	enable_irq(client->irq);
> +
>  	return 0;
>  }
>  
> -- 
> 2.12.2
> 

-- 
Dmitry
