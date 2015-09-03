From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cyttsp - Remove unnecessary MODULE_ALIAS()
Date: Thu, 3 Sep 2015 10:48:02 -0700
Message-ID: <20150903174802.GB19537@dtor-ws>
References: <1440810324-14382-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34067 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbbICRsH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 13:48:07 -0400
Content-Disposition: inline
In-Reply-To: <1440810324-14382-1-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Ferruh Yigit <fery@cypress.com>, linux-input@vger.kernel.org

On Sat, Aug 29, 2015 at 03:05:24AM +0200, Javier Martinez Canillas wrote:
> The drivers have a I2C device ID table that is used to create the module
> aliases and also "cyttsp" and "cyttsp4" are not supported I2C device IDs
> so these module aliases are never used.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thank you.

> 
> ---
> 
>  drivers/input/touchscreen/cyttsp4_i2c.c | 1 -
>  drivers/input/touchscreen/cyttsp_i2c.c  | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/cyttsp4_i2c.c b/drivers/input/touchscreen/cyttsp4_i2c.c
> index 9a323dd915de..a9f95c7d3c00 100644
> --- a/drivers/input/touchscreen/cyttsp4_i2c.c
> +++ b/drivers/input/touchscreen/cyttsp4_i2c.c
> @@ -86,4 +86,3 @@ module_i2c_driver(cyttsp4_i2c_driver);
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) I2C driver");
>  MODULE_AUTHOR("Cypress");
> -MODULE_ALIAS("i2c:cyttsp4");
> diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
> index 519e2de2f8df..eee51b3f2e3f 100644
> --- a/drivers/input/touchscreen/cyttsp_i2c.c
> +++ b/drivers/input/touchscreen/cyttsp_i2c.c
> @@ -86,4 +86,3 @@ module_i2c_driver(cyttsp_i2c_driver);
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Cypress TrueTouch(R) Standard Product (TTSP) I2C driver");
>  MODULE_AUTHOR("Cypress");
> -MODULE_ALIAS("i2c:cyttsp");
> -- 
> 2.4.3
> 

-- 
Dmitry
