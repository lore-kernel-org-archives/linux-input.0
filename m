From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] Input: soc_button_array - remove duplicated
 include from soc_button_array.c
Date: Thu, 16 Apr 2015 13:39:19 -0700
Message-ID: <20150416203919.GB21887@dtor-ws>
References: <1429189920-24334-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36410 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbbDPUjY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2015 16:39:24 -0400
Received: by iebrs15 with SMTP id rs15so61009536ieb.3
        for <linux-input@vger.kernel.org>; Thu, 16 Apr 2015 13:39:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1429189920-24334-1-git-send-email-weiyj_lk@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: weiyj_lk@163.com
Cc: Sachin Kamat <sachin.kamat@linaro.org>, Jin Yao <yao.jin@linux.intel.com>, Lejun Zhu <lejun.zhu@linux.intel.com>, Pramod Gurav <pramod.gurav@smartplayin.com>, Alexandre Courbot <acourbot@nvidia.com>, Bastien Nocera <hadess@hadess.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-input@vger.kernel.org

On Thu, Apr 16, 2015 at 09:12:00PM +0800, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thank you.

> ---
>  drivers/input/misc/soc_button_array.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index e8e010a..c14b827 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -18,7 +18,6 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/platform_device.h>
> -#include <linux/acpi.h>
>  
>  /*
>   * Definition of buttons on the tablet. The ACPI index of each button
> 

-- 
Dmitry
