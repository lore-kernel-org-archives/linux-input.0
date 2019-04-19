From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: synaptics-rmi4: fix possible double free
Date: Fri, 19 Apr 2019 07:39:23 +0000
Message-ID: <20190419073923.6ojzx4ic5ylq3n3m@penguin>
References: <1555552715-34820-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555552715-34820-1-git-send-email-bianpan2016@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, Nick Dyer <nick@shmanahar.org>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Apr 18, 2019 at 09:58:35AM +0800, Pan Bian wrote:
> The RMI4 function structure has been released in rmi_register_function
> if error occurs. However, it will be released again in the function
> rmi_create_function, which may result in a double-free bug.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Applied, thank you.

> ---
>  drivers/input/rmi4/rmi_driver.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index fc3ab93..7fb358f 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -860,7 +860,7 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>  
>  	error = rmi_register_function(fn);
>  	if (error)
> -		goto err_put_fn;
> +		return error;
>  
>  	if (pdt->function_number == 0x01)
>  		data->f01_container = fn;
> @@ -870,10 +870,6 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
>  	list_add_tail(&fn->node, &data->function_list);
>  
>  	return RMI_SCAN_CONTINUE;
> -
> -err_put_fn:
> -	put_device(&fn->dev);
> -	return error;
>  }
>  
>  void rmi_enable_irq(struct rmi_device *rmi_dev, bool clear_wake)
> -- 
> 2.7.4
> 
> 

-- 
Dmitry
