From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: constify device_type structures
Date: Tue, 24 Jan 2017 10:35:11 -0800
Message-ID: <20170124183511.GF27969@dtor-ws>
References: <1485198067-14284-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485198067-14284-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 24, 2017 at 12:31:07AM +0530, Bhumika Goyal wrote:
> Declare device_type structures as const as they are only stored in the
> type field of a device structure. This field is of type const, so add
> const to declaration of device_type structures.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>   17184	   1344	     80	  18608	   48b0	drivers/input/input.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>   17248	   1280	     80	  18608	   48b0	drivers/input/input.o
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    2355	    384	      8	   2747	    abb	drivers/input/rmi4/rmi_bus.o
> 
> File size after:
>    text	   data	    bss	    dec	    hex	filename
>    2483	    264	      8	   2755	    ac3	drivers/input/rmi4/rmi_bus.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied, thank you.

> ---
>  drivers/input/input.c        | 2 +-
>  drivers/input/rmi4/rmi_bus.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index d95c34e..6a75bb0 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1749,7 +1749,7 @@ static int input_dev_poweroff(struct device *dev)
>  };
>  #endif /* CONFIG_PM */
>  
> -static struct device_type input_dev_type = {
> +static const struct device_type input_dev_type = {
>  	.groups		= input_dev_attr_groups,
>  	.release	= input_dev_release,
>  	.uevent		= input_dev_uevent,
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index 1c40d94..213e318 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -55,7 +55,7 @@ static void rmi_release_device(struct device *dev)
>  	kfree(rmi_dev);
>  }
>  
> -static struct device_type rmi_device_type = {
> +static const struct device_type rmi_device_type = {
>  	.name		= "rmi4_sensor",
>  	.release	= rmi_release_device,
>  };
> @@ -134,7 +134,7 @@ static void rmi_release_function(struct device *dev)
>  	kfree(fn);
>  }
>  
> -static struct device_type rmi_function_type = {
> +static const struct device_type rmi_function_type = {
>  	.name		= "rmi4_function",
>  	.release	= rmi_release_function,
>  };
> -- 
> 1.9.1
> 

-- 
Dmitry
