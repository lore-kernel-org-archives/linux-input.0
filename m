From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 4/6] input: sparcspkr: Fix module autoload for OF
 platform drivers
Date: Thu, 3 Sep 2015 10:51:30 -0700
Message-ID: <20150903175130.GF19537@dtor-ws>
References: <20150829104814.GA20863@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36482 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbbICRvd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 13:51:33 -0400
Content-Disposition: inline
In-Reply-To: <20150829104814.GA20863@goodgumbo.baconseed.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On Sat, Aug 29, 2015 at 12:48:14PM +0200, Luis de Bethencourt wrote:
> These platform drivers have a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>


Applied, thank you.

> ---
>  drivers/input/misc/sparcspkr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
> index 54116e5..0ca34d1 100644
> --- a/drivers/input/misc/sparcspkr.c
> +++ b/drivers/input/misc/sparcspkr.c
> @@ -253,6 +253,7 @@ static const struct of_device_id bbc_beep_match[] = {
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(bbc_beep_match);
>  
>  static struct platform_driver bbc_beep_driver = {
>  	.driver = {
> @@ -332,6 +333,7 @@ static const struct of_device_id grover_beep_match[] = {
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, grover_beep_match);
>  
>  static struct platform_driver grover_beep_driver = {
>  	.driver = {
> -- 
> 2.4.6
> 

-- 
Dmitry
