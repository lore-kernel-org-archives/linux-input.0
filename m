From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] rotary_encoder: fix relative axis support
Date: Thu, 1 Oct 2009 11:25:48 +0200
Message-ID: <20091001092548.GH9361@buzzloop.caiaq.de>
References: <BD79186B4FD85F4B8E60E381CAEE190901D42CBE@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:54846 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371AbZJAJZs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2009 05:25:48 -0400
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901D42CBE@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: linux-input@vger.kernel.org

On Wed, Sep 30, 2009 at 08:33:26PM -0400, H Hartley Sweeten wrote:
> When the rotart_encoder driver is used to report relative axis
> information the "steps" in the platform data could be missing
> since it's not relevant.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Daniel Mack <daniel@caiaq.de>

Acked-by: Daniel Mack <daniel@caiaq.de>

Thanks!

> ---
> 
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index c806fbf..3b9f588 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -106,8 +106,8 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>  	struct input_dev *input;
>  	int err;
>  
> -	if (!pdata || !pdata->steps) {
> -		dev_err(&pdev->dev, "invalid platform data\n");
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "missing platform data\n");
>  		return -ENOENT;
>  	}
>   
