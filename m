From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] input: touchscreen: mxs-lradc: Make symbol
 mxs_lradc_ts_irq_names static
Date: Tue, 25 Apr 2017 10:05:32 -0700
Message-ID: <20170425170532.GA30843@dtor-ws>
References: <20170425062704.26222-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34265 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1431794AbdDYRFg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 13:05:36 -0400
Received: by mail-io0-f195.google.com with SMTP id h41so54489806ioi.1
        for <linux-input@vger.kernel.org>; Tue, 25 Apr 2017 10:05:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170425062704.26222-1-weiyj.lk@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Lee Jones <lee.jones@linaro.org>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

On Tue, Apr 25, 2017 at 06:27:04AM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> drivers/input/touchscreen/mxs-lradc-ts.c:33:12: warning:
>  symbol 'mxs_lradc_ts_irq_names' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/input/touchscreen/mxs-lradc-ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
> index 4b4aebf..603ac5a 100644
> --- a/drivers/input/touchscreen/mxs-lradc-ts.c
> +++ b/drivers/input/touchscreen/mxs-lradc-ts.c
> @@ -30,7 +30,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  
> -const char *mxs_lradc_ts_irq_names[] = {
> +static const char *mxs_lradc_ts_irq_names[] = {

FWIW checkpatch recommends "static const char * const".

>  	"mxs-lradc-touchscreen",
>  	"mxs-lradc-channel6",
>  	"mxs-lradc-channel7",
> 

-- 
Dmitry
