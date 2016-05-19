From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: migor-ts - fix error for modular build
Date: Thu, 19 May 2016 09:34:35 -0700
Message-ID: <20160519163435.GE38800@dtor-ws>
References: <1463502759-14393-1-git-send-email-javier@osg.samsung.com>
 <1463502759-14393-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33786 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbcESQej (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 12:34:39 -0400
Content-Disposition: inline
In-Reply-To: <1463502759-14393-2-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-input@vger.kernel.org

On Tue, May 17, 2016 at 12:32:38PM -0400, Javier Martinez Canillas wrote:
> There is a typo in the driver for the I2C device table that is passed to
> the MODULE_DEVICE_TABLE() macro, this leads to the following build error:
> 
>   CC [M]  drivers/input/touchscreen//migor_ts.o
> drivers/input/touchscreen//migor_ts.c:233:21: error: 'migor_ts' undeclared here (not in a function)
>  MODULE_DEVICE_TABLE(i2c, migor_ts);
>                      ^
> drivers/input/touchscreen//migor_ts.c:233:31: error: '__mod_i2c__migor_ts_device_table' aliased to undefined symbol 'migor_ts'
>  MODULE_DEVICE_TABLE(i2c, migor_ts);
>                                ^
> scripts/Makefile.build:295: recipe for target 'drivers/input/touchscreen//migor_ts.o' failed
> make[1]: *** [drivers/input/touchscreen//migor_ts.o] Error 1
> Makefile:1446: recipe for target '_module_drivers/input/touchscreen/' failed
> make: *** [_module_drivers/input/touchscreen/] Error 2
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thank you.

> 
> ---
> 
>  drivers/input/touchscreen/migor_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/migor_ts.c b/drivers/input/touchscreen/migor_ts.c
> index c038db93e2c3..e4b92c4cae3b 100644
> --- a/drivers/input/touchscreen/migor_ts.c
> +++ b/drivers/input/touchscreen/migor_ts.c
> @@ -230,7 +230,7 @@ static const struct i2c_device_id migor_ts_id[] = {
>  	{ "migor_ts", 0 },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(i2c, migor_ts);
> +MODULE_DEVICE_TABLE(i2c, migor_ts_id);
>  
>  static struct i2c_driver migor_ts_driver = {
>  	.driver = {
> -- 
> 2.5.5
> 

-- 
Dmitry
