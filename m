From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: wacom - missed the last bit of expresskey for
 DTU-1031
Date: Sat, 19 Apr 2014 22:34:43 -0700
Message-ID: <20140420053443.GD12454@core.coreip.homeip.net>
References: <1397244742-20012-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:53937 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaDTFeq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Apr 2014 01:34:46 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so2663146pdj.20
        for <linux-input@vger.kernel.org>; Sat, 19 Apr 2014 22:34:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397244742-20012-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Fri, Apr 11, 2014 at 12:32:22PM -0700, Ping Cheng wrote:
> Signed-off-by: Ping Cheng <pingc@wacom.com>

Applied, thank you.

> ---
>  drivers/input/tablet/wacom_wac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 05f371d..3d094c9 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1838,7 +1838,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
>  	case DTU:
>  		if (features->type == DTUS) {
>  			input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
> -			for (i = 0; i < 3; i++)
> +			for (i = 0; i < 4; i++)
>  				__set_bit(BTN_0 + i, input_dev->keybit);
>  		}
>  		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
> -- 
> 1.8.3.2
> 

-- 
Dmitry
