From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko.stuebner@bq.com>
Subject: Re: [PATCH -next] Input: zforce - remove duplicated include from zforce_ts.c
Date: Thu, 16 Apr 2015 15:44:16 +0200
Message-ID: <1841566.UX5WXlFsPC@diego>
References: <1429189899-24255-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:56811 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932401AbbDPNon (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2015 09:44:43 -0400
In-Reply-To: <1429189899-24255-1-git-send-email-weiyj_lk@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: weiyj_lk@163.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Jingoo Han <jg1.han@samsung.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-input@vger.kernel.org

Am Donnerstag, 16. April 2015, 21:11:39 schrieb weiyj_lk@163.com:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks for finding this

Reviewed-by: Heiko Stuebner <heiko.stuebner@bq.com>


Heiko

> ---
>  drivers/input/touchscreen/zforce_ts.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/zforce_ts.c
> b/drivers/input/touchscreen/zforce_ts.c index 19880c7..f58a196 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -30,7 +30,6 @@
>  #include <linux/input/mt.h>
>  #include <linux/platform_data/zforce_ts.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/delay.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>

