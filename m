From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: arizona-haptic - Don't assign input_dev parent
Date: Sun, 17 Apr 2016 05:21:30 -0700
Message-ID: <20160417122130.GB33215@dtor-ws>
References: <1460722549-31804-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33336 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbcDQMVd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Apr 2016 08:21:33 -0400
Received: by mail-pf0-f173.google.com with SMTP id 184so71828890pff.0
        for <linux-input@vger.kernel.org>; Sun, 17 Apr 2016 05:21:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460722549-31804-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Fri, Apr 15, 2016 at 01:15:49PM +0100, Charles Keepax wrote:
> We shouldn't assign the parent device of the input_dev to be the
> parent MFD device, because this will be used for devres which causes
> input_unregister_device to run after the haptics device has been
> removed, since it is itself a child of the MFD device. The default
> of using the haptics device itself as the parent is correct.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Applied, thank you.

> ---
>  drivers/input/misc/arizona-haptics.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
> index d5994a7..9829363 100644
> --- a/drivers/input/misc/arizona-haptics.c
> +++ b/drivers/input/misc/arizona-haptics.c
> @@ -178,7 +178,6 @@ static int arizona_haptics_probe(struct platform_device *pdev)
>  	input_set_drvdata(haptics->input_dev, haptics);
>  
>  	haptics->input_dev->name = "arizona:haptics";
> -	haptics->input_dev->dev.parent = pdev->dev.parent;
>  	haptics->input_dev->close = arizona_haptics_close;
>  	__set_bit(FF_RUMBLE, haptics->input_dev->ffbit);
>  
> -- 
> 2.1.4
> 

-- 
Dmitry
