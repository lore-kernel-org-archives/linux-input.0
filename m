From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH -next] Input: synaptics-rmi4 - fix error return code in
 rmi_probe_interrupts()
Date: Tue, 7 Feb 2017 16:00:37 +0100
Message-ID: <20170207150037.GB18493@mail.corp.redhat.com>
References: <20170207145225.31228-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753587AbdBGPAn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Feb 2017 10:00:43 -0500
Content-Disposition: inline
In-Reply-To: <20170207145225.31228-1-weiyj.lk@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andrew Duggan <aduggan@synaptics.com>, Nick Dyer <nick@shmanahar.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

On Feb 07 2017 or thereabouts, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return error code -ENOMEM from the devm_kzalloc() error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 6bd0dcfacf28 ("Input: synaptics-rmi4 - factor out functions
> from probe")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Good catch.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/input/rmi4/rmi_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index bf5c36e..0c54446 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -1049,7 +1049,7 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
>  	data->irq_memory = devm_kzalloc(dev, size * 4, GFP_KERNEL);
>  	if (!data->irq_memory) {
>  		dev_err(dev, "Failed to allocate memory for irq masks.\n");
> -		return retval;
> +		return -ENOMEM;
>  	}
>  
>  	data->irq_status	= data->irq_memory + size * 0;
> 
