From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] mod_devicetable: helper macro for declaring oftree
 module device table
Date: Fri, 19 Apr 2019 07:40:21 +0000
Message-ID: <20190419074021.tigbyfezmt4erjms@penguin>
References: <1555444645-15156-1-git-send-email-info@metux.net>
 <1555444645-15156-2-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555444645-15156-2-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Enrico,

On Tue, Apr 16, 2019 at 09:57:22PM +0200, Enrico Weigelt, metux IT consult wrote:
> Little helper macro that declares an oftree module device table,
> if CONFIG_OF is enabled. Otherwise it's just noop.
> 
> This is also helpful if some drivers can be built w/ or w/o
> oftree support.

This should go to OF folks, please.

> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  include/linux/mod_devicetable.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 448621c..853e301 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -245,6 +245,15 @@ struct of_device_id {
>  	const void *data;
>  };
>  
> +/*
> + * macro for adding the of module device table only if CONFIG_OF enabled
> + */
> +#ifdef CONFIG_OF
> +#define MODULE_DEVICE_TABLE_OF(name)	MODULE_DEVICE_TABLE(of,name)
> +#else
> +#define MODULE_DEVICE_TABLE_OF(name)
> +#endif /* CONFIG_OF */
> +
>  /* VIO */
>  struct vio_device_id {
>  	char type[32];
> -- 
> 1.9.1
> 

-- 
Dmitry
