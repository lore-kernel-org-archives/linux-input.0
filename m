From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: cros_ec_keyb: Report wakeup events
Date: Sat, 1 Apr 2017 10:12:37 -0700
Message-ID: <20170401171237.GH17130@dtor-ws>
References: <1490867450-31765-1-git-send-email-jeffy.chen@rock-chips.com>
 <1490867450-31765-2-git-send-email-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35030 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbdDARMl (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 13:12:41 -0400
Content-Disposition: inline
In-Reply-To: <1490867450-31765-2-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, dbasehore@google.com, dianders@chromium.org, Gwendal Grignou <gwendal@chromium.org>, Vic Yang <victoryang@google.com>, linux-input@vger.kernel.org, Enric Balletbo Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

Hi Jeffy,

On Thu, Mar 30, 2017 at 05:50:49PM +0800, Jeffy Chen wrote:
> Report wakeup events when process events.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 6a250d6..a93d55f 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -286,6 +286,9 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  		return NOTIFY_DONE;
>  	}
>  
> +	if (device_may_wakeup(ckdev->dev))
> +		pm_wakeup_event(ckdev->dev, 0);
> +
>  	return NOTIFY_OK;
>  }
>  
> @@ -632,6 +635,12 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> +	err = device_init_wakeup(dev, 1);

In the other patch you are adding "wakeup-source" to the DT binding, but
here you mark all EC deices as wakeup sources. You need to use
device_property_read_bool(dev, "wakeup-source") and use the result in
call to device_init_wakeup().

> +	if (err) {
> +		dev_err(dev, "cannot init wakeup: %d\n", err);
> +		return err;
> +	}
> +
>  	return 0;
>  }
>  

Thanks.

-- 
Dmitry
