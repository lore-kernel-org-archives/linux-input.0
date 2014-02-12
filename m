From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH] input synaptics-rmi4: rmi_f01.c storage fix
Date: Tue, 11 Feb 2014 17:26:06 -0800
Message-ID: <20140212012606.GY1706@sonymobile.com>
References: <1392160380-8221-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:5690 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750978AbaBLBYX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Feb 2014 20:24:23 -0500
Content-Disposition: inline
In-Reply-To: <1392160380-8221-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Wed, Feb 12, 2014 at 12:13:00AM +0100, Christopher Heiny wrote:
> Correctly free driver related data when initialization fails.
> 
> Trivial: Clarify a diagnostic message.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Linux Walleij <linus.walleij@linaro.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> 
> ---
> 
>  drivers/input/rmi4/rmi_f01.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index 381ad60..e4a6df9 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -149,7 +149,7 @@ static int rmi_f01_alloc_memory(struct rmi_function *fn,
>  
>  	f01 = devm_kzalloc(&fn->dev, sizeof(struct f01_data), GFP_KERNEL);
>  	if (!f01) {
> -		dev_err(&fn->dev, "Failed to allocate fn_01_data.\n");
> +		dev_err(&fn->dev, "Failed to allocate f01_data.\n");

Just remove this printout, as it won't help any user in the case of OOM.
Additionally, there's already plenty of (more useful) information
printed out if kmalloc fails.

>  		return -ENOMEM;
>  	}
>  
> @@ -158,6 +158,7 @@ static int rmi_f01_alloc_memory(struct rmi_function *fn,
>  			GFP_KERNEL);
>  	if (!f01->device_control.interrupt_enable) {
>  		dev_err(&fn->dev, "Failed to allocate interrupt enable.\n");
> +		devm_kfree(&fn->dev, f01);

Unnecessary, devres_release_all() will release this, from:
	- really_probe() -> rmi_function_probe() -> rmi_f01_probe()
	- driver_probe_device()
	- __driver_attach()
	- driver_attach()
	- bus_add_driver()
	- driver_register()
	- __rmi_register_function_handler()

>  		return -ENOMEM;
>  	}
>  	fn->data = f01;
> @@ -381,7 +382,8 @@ static int rmi_f01_initialize(struct rmi_function *fn)
>  	return 0;
>  
>   error_exit:
> -	kfree(data);
> +	devm_kfree(&fn->dev, data->device_control.interrupt_enable);
> +	devm_kfree(&fn->dev, data);

Same as above for these two.

>  	return error;
>  }
>  

Generally devm_ release functions are unnecessary to call, as all
resources will get released on driver detach, whether abnormal or not.

-Courtney
