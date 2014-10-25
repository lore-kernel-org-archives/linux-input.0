From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: wm97xx: adapt parameters to tosa touchscreen.
Date: Fri, 24 Oct 2014 17:28:15 -0700
Message-ID: <20141025002815.GH19933@dtor-ws>
References: <1414171086-18330-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48167 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111AbaJYA2U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Oct 2014 20:28:20 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so2294040pde.8
        for <linux-input@vger.kernel.org>; Fri, 24 Oct 2014 17:28:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1414171086-18330-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>

On Fri, Oct 24, 2014 at 09:18:06PM +0400, Dmitry Eremin-Solenikov wrote:
> From: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> 
> Sharp SL-6000 (tosa) touchscreen needs wider limits to properly map all
> points on the screen. Expand ranges in abs_x and abs_y arrays according
> to the touchscreen area.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/wm97xx-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
> index d0ef91f..b1ae779 100644
> --- a/drivers/input/touchscreen/wm97xx-core.c
> +++ b/drivers/input/touchscreen/wm97xx-core.c
> @@ -70,11 +70,11 @@
>   * Documentation/input/input-programming.txt for more details.
>   */
>  
> -static int abs_x[3] = {350, 3900, 5};
> +static int abs_x[3] = {150, 4000, 5};
>  module_param_array(abs_x, int, NULL, 0);
>  MODULE_PARM_DESC(abs_x, "Touchscreen absolute X min, max, fuzz");
>  
> -static int abs_y[3] = {320, 3750, 40};
> +static int abs_y[3] = {200, 4000, 40};
>  module_param_array(abs_y, int, NULL, 0);
>  MODULE_PARM_DESC(abs_y, "Touchscreen absolute Y min, max, fuzz");
>  
> -- 
> 2.1.1
> 

-- 
Dmitry
