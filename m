From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch 2.6.28-rc6-davinci1 5/6] dm355evm input driver
Date: Sun, 7 Dec 2008 22:21:29 +0200
Message-ID: <20081207202128.GA9629@frodo>
References: <200812071159.50267.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58151 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbYLGUVi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Dec 2008 15:21:38 -0500
Content-Disposition: inline
In-Reply-To: <200812071159.50267.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, Felipe Balbi <felipebalbi@users.sourceforge.net>

Hi Dave,

only one comment below.

On Sun, Dec 07, 2008 at 11:59:50AM -0800, David Brownell wrote:
> +static int __devinit dm355evm_keys_probe(struct platform_device *pdev)
> +{
> +	struct dm355evm_keys	*keys;
> +	int			status = -ENOMEM;
> +	struct input_dev	*input;
> +	int			i;
> +
> +	/* allocate instance struct */
> +	keys = kzalloc(sizeof *keys, GFP_KERNEL);
> +	if (!keys)
> +		goto fail0;
> +	platform_set_drvdata(pdev, keys);
> +	keys->pdev = pdev;

you could be holding only the device pointer.

	keys->dev = &pdev->dev;

then, if you really happen to need the pdev pointer you can use

to_platform_device(keys->dev);

-- 
balbi
