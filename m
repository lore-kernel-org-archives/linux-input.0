From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: Call device suspend callback before
 disabling irq
Date: Tue, 7 Jul 2015 16:34:32 -0400
Message-ID: <20150707203432.GL18484@mail.corp.redhat.com>
References: <1436299082-3526-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37161 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932713AbbGGUef (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jul 2015 16:34:35 -0400
Content-Disposition: inline
In-Reply-To: <1436299082-3526-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: jkosina@suse.cz, aduggan@synaptics.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jul 07 2015 or thereabouts, Gabriele Mazzotta wrote:
> The irq is most likely required by the suspend callback, so disable it
> only after the callback had been executed.
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---

Just in case Jiri missed it:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks!

Benjamin

>  drivers/hid/i2c-hid/i2c-hid.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index f77469d..9ed69b5 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1092,13 +1092,13 @@ static int i2c_hid_suspend(struct device *dev)
>  	struct hid_device *hid = ihid->hid;
>  	int ret = 0;
>  
> +	if (hid->driver && hid->driver->suspend)
> +		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
> +
>  	disable_irq(ihid->irq);
>  	if (device_may_wakeup(&client->dev))
>  		enable_irq_wake(ihid->irq);
>  
> -	if (hid->driver && hid->driver->suspend)
> -		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
> -
>  	/* Save some power */
>  	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
>  
> -- 
> 2.1.4
> 
