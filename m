From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: stmfts - mark all PM functions as __maybe_unused
Date: Fri, 9 Jun 2017 09:58:32 -0700
Message-ID: <20170609165832.GA3539@dtor-ws>
References: <20170609103328.3130682-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35531 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdFIQ6g (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Jun 2017 12:58:36 -0400
Content-Disposition: inline
In-Reply-To: <20170609103328.3130682-1-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 09, 2017 at 12:32:48PM +0200, Arnd Bergmann wrote:
> We get a harmless warning when CONFIG_RUNTIME_PM is disabled:
> 
> drivers/input/touchscreen/stmfts.c:760:12: error: 'stmfts_runtime_resume' defined but not used [-Werror=unused-function]
>  static int stmfts_runtime_resume(struct device *dev)
> drivers/input/touchscreen/stmfts.c:748:12: error: 'stmfts_runtime_suspend' defined but not used [-Werror=unused-function]
>  static int stmfts_runtime_suspend(struct device *dev)
> 
> The regular PM functions are already marked as __maybe_unused, so let's
> do the same for the runtime-PM as well.
> 
> Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/stmfts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
> index 802d0e82d034..157fdb4bb2e8 100644
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c
> @@ -745,7 +745,7 @@ static int stmfts_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static int stmfts_runtime_suspend(struct device *dev)
> +static int __maybe_unused stmfts_runtime_suspend(struct device *dev)
>  {
>  	struct stmfts_data *sdata = dev_get_drvdata(dev);
>  	int ret;
> @@ -757,7 +757,7 @@ static int stmfts_runtime_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int stmfts_runtime_resume(struct device *dev)
> +static int __maybe_unused stmfts_runtime_resume(struct device *dev)
>  {
>  	struct stmfts_data *sdata = dev_get_drvdata(dev);
>  	int ret;
> -- 
> 2.9.0
> 

-- 
Dmitry
