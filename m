From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys - swtich to dev_pm_ops
Date: Tue, 21 Jul 2009 08:48:48 -0700
Message-ID: <20090721154848.GB4352@dtor-d630.eng.vmware.com>
References: <1248184750-22274-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:21405 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519AbZGUPsz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2009 11:48:55 -0400
Received: by rv-out-0506.google.com with SMTP id f6so866423rvb.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2009 08:48:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1248184750-22274-1-git-send-email-mike@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-input@vger.kernel.org

Hi Mike,

On Tue, Jul 21, 2009 at 04:59:10PM +0300, Mike Rapoport wrote:
> +
> +static struct dev_pm_ops gpio_keys_pm_ops = {
> +	.suspend	= gpio_keys_suspend,
> +	.resume		= gpio_keys_resume,
> +};
>  

This is not 100% equivalent conversion since we are now only handling
s2r, not s2d.. My question though is whether we care or not...

>  static struct platform_driver gpio_keys_device_driver = {
>  	.probe		= gpio_keys_probe,
> -	.remove		= __devexit_p(gpio_keys_remove),
> -	.suspend	= gpio_keys_suspend,
>  	.resume		= gpio_keys_resume,
>  	.driver		= {
>  		.name	= "gpio-keys",
>  		.owner	= THIS_MODULE,
> +		.pm	= &gpio_keys_pm_ops,
>  	}
>  };
>  

-- 
Dmitry
