From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: davinci_keyscan: Free memory occupied by davinci
 key scan device
Date: Tue, 14 Nov 2017 10:14:34 -0800
Message-ID: <20171114181434.lpwhojwemzdruet6@dtor-ws>
References: <9203eaebf020cbebf5224221d789a0163490d654.1510666872.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:50278 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbdKNSOh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 13:14:37 -0500
Content-Disposition: inline
In-Reply-To: <9203eaebf020cbebf5224221d789a0163490d654.1510666872.git.arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Nov 14, 2017 at 07:15:14PM +0530, Arvind Yadav wrote:
> Here, key_dev is NULL in input_free_device() and It will not free
> memory occupied by davinci key scan device. Move "key_dev = NULL"
> after input_free_device().

No, this is absolutely wrong. It is disallowed to call
input_free_device() after calling input_unregister_device(), because
input core will free the device once the last reference is dropped. That
is why we set "key_dev" to NULL to turn input_free_device() into a noop.

> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/input/keyboard/davinci_keyscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
> index b20a5d0..22cb8d2 100644
> --- a/drivers/input/keyboard/davinci_keyscan.c
> +++ b/drivers/input/keyboard/davinci_keyscan.c
> @@ -290,13 +290,13 @@ static int __init davinci_ks_probe(struct platform_device *pdev)
>  	free_irq(davinci_ks->irq, davinci_ks);
>  fail5:
>  	input_unregister_device(davinci_ks->input);
> -	key_dev = NULL;
>  fail4:
>  	iounmap(davinci_ks->base);
>  fail3:
>  	release_mem_region(davinci_ks->pbase, davinci_ks->base_size);
>  fail2:
>  	input_free_device(key_dev);
> +	key_dev = NULL;
>  fail1:
>  	kfree(davinci_ks);
>  
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
