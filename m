From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: tegra-kbc - assume CONFIG_OF, remove platform data
Date: Fri, 15 Feb 2013 14:42:03 -0800
Message-ID: <20130215224203.GB15811@core.coreip.homeip.net>
References: <1360965506-19641-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360965506-19641-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Stephen,

On Fri, Feb 15, 2013 at 02:58:26PM -0700, Stephen Warren wrote:
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> +	kbc->irq = platform_get_irq(pdev, 0);
> +	if (kbc->irq < 0) {
>  		dev_err(&pdev->dev, "failed to get keyboard IRQ\n");
>  		return -ENXIO;
>  	}

ikbc->irq is unsigned int so this change is not correct.

I am also getting rejects when I try to apply this, am I missing some
other patch?

Thanks.

-- 
Dmitry
