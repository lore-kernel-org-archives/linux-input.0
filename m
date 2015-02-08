From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCHv2] input: rotary encoder: Add wake up support
Date: Sun, 8 Feb 2015 12:07:16 +0800
Message-ID: <20150208040716.GA544@localhost>
References: <1422529818-6140-1-git-send-email-sylvain.rochet@finsecur.com>
 <1422529818-6140-2-git-send-email-sylvain.rochet@finsecur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:46451 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbbBHEFU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Feb 2015 23:05:20 -0500
Received: by pdjz10 with SMTP id z10so23460642pdj.13
        for <linux-input@vger.kernel.org>; Sat, 07 Feb 2015 20:05:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1422529818-6140-2-git-send-email-sylvain.rochet@finsecur.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sylvain Rochet <sylvain.rochet@finsecur.com>
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, Jan 29, 2015 at 12:10:18PM +0100, Sylvain Rochet wrote:
> This patch add wake up support for rotary encoders.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>

> @@ -306,6 +311,8 @@ static int rotary_encoder_remove(struct platform_device *pdev)
>  	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
>  	const struct rotary_encoder_platform_data *pdata = encoder->pdata;
>  
> +	device_init_wakeup(&pdev->dev, 0);
> +

Perhaps you should use false rather than 0 here for consistency. 

Looks good otherwise, so feel free to add my

Reviewed-by: Johan Hovold <johan@kernel.org>

If you resend, you could split the device-tree binding documentation in
a separate patch that you CC the devicetree list in order to get an ack
for the property name.

Johan
