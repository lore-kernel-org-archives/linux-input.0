From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH V2] input synaptics-rmi4: Fix ms calculation in poll interval
Date: Mon, 09 Dec 2013 13:53:14 -0500
Message-ID: <52A6119A.4000703@redhat.com>
References: <1386288825-11837-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12116 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932605Ab3LIS4B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Dec 2013 13:56:01 -0500
In-Reply-To: <1386288825-11837-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

On 05/12/13 19:13, Christopher Heiny wrote:
> [Previous patch re-used an old template for the subject line.  Sorry about that]
> 
> This patch implements changes to the synaptics-rmi4 branch of
> Dmitry's input tree.  The base for the patch is commit
> 8ca01dc61a42b6f7bcba052a8c084000f7057a34.
> 
> Fix computation of poll interval milliseconds.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Joerie de Gram <j.de.gram@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/input/rmi4/rmi_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 9af297e..dffbfa0 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -934,7 +934,7 @@ static int rmi_driver_probe(struct device *dev)
>  	} else
>  		data->poll_interval = ktime_set(0,
>  			(pdata->poll_interval_ms ? pdata->poll_interval_ms :
> -			DEFAULT_POLL_INTERVAL_MS) * 1000);
> +			DEFAULT_POLL_INTERVAL_MS) * 1000 * 1000);
>  
>  	if (data->f01_container->dev.driver) {
>  		/* Driver already bound, so enable ATTN now. */
> 

