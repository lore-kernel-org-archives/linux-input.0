From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ad7879 - Convert I2C to dev_pm_ops
Date: Wed, 5 Jan 2011 14:14:32 -0800
Message-ID: <20110105221432.GA6086@core.coreip.homeip.net>
References: <1294254095-25844-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44213 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1AEWOk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jan 2011 17:14:40 -0500
Received: by yxt3 with SMTP id 3so6197100yxt.19
        for <linux-input@vger.kernel.org>; Wed, 05 Jan 2011 14:14:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294254095-25844-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

Hi Mark,

On Wed, Jan 05, 2011 at 07:01:35PM +0000, Mark Brown wrote:
> +# define ad7879_i2c_pm NULL
>  #endif
>  
>  /* All registers are word-sized.
> @@ -117,11 +121,10 @@ static struct i2c_driver ad7879_i2c_driver = {
>  	.driver = {
>  		.name	= "ad7879",
>  		.owner	= THIS_MODULE,
> +		.pm	= &ad7879_i2c_pm,

I do not think you tested it with !CONFIG_PM since &NULL is not valid
expression (& requires an lvalue for operand).

Please change to guard .pm = &ad7879_i2c_pm with #ifdef.

Thanks.

-- 
Dmitry
