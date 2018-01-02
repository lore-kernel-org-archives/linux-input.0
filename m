From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: misc: Kconfig: fixed a spelling mistake
Date: Mon, 1 Jan 2018 22:53:12 -0800
Message-ID: <20180102065312.awdqxivp4e23dcjh@dtor-ws>
References: <20171228083050.6475-1-lizhuohua1994@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36521 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeABGxP (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 01:53:15 -0500
Content-Disposition: inline
In-Reply-To: <20171228083050.6475-1-lizhuohua1994@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhuohua Li <lizhuohua1994@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 28, 2017 at 04:30:50PM +0800, Zhuohua Li wrote:
> fixed a spelling mistake: buttong -> button
> 
> Signed-off-by: Zhuohua Li <lizhuohua1994@gmail.com>

Applied, thank you.

> ---
>  drivers/input/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 9f082a388388..509ba8ef1464 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -468,7 +468,7 @@ config INPUT_TPS65218_PWRBUTTON
>  	tristate "TPS65218 Power button driver"
>  	depends on (MFD_TPS65217 || MFD_TPS65218)
>  	help
> -	  Say Y here if you want to enable power buttong reporting for
> +	  Say Y here if you want to enable power button reporting for
>  	  TPS65217 and TPS65218 Power Management IC devices.
>  
>  	  To compile this driver as a module, choose M here. The module will
> -- 
> 2.13.6
> 

-- 
Dmitry
