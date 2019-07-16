From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: psmouse - Fix build error of multiple definition
Date: Tue, 16 Jul 2019 20:19:04 +0200
Message-ID: <20190716181904.GB1140@penguin>
References: <20190716065411.56780-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190716065411.56780-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: allison@lohutok.net, tglx@linutronix.de, info@metux.net, dilinger@debian.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 16, 2019 at 02:54:11PM +0800, YueHaibing wrote:
> trackpoint_detect() should be static inline while
> CONFIG_MOUSE_PS2_TRACKPOINT is not set. otherwire,we
> got building fails:
> 
> drivers/input/mouse/alps.o: In function `trackpoint_detect':
> alps.c:(.text+0x8e00): multiple definition of `trackpoint_detect'
> drivers/input/mouse/psmouse-base.o:psmouse-base.c:(.text+0x1b50): first defined here
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 55e3d9224b60 ("Input: psmouse - allow disabing certain protocol extensions")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thank you.

> ---
>  drivers/input/mouse/trackpoint.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
> index 0afffe8..77110f3 100644
> --- a/drivers/input/mouse/trackpoint.h
> +++ b/drivers/input/mouse/trackpoint.h
> @@ -158,7 +158,8 @@ struct trackpoint_data {
>  #ifdef CONFIG_MOUSE_PS2_TRACKPOINT
>  int trackpoint_detect(struct psmouse *psmouse, bool set_properties);
>  #else
> -inline int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
> +static inline int trackpoint_detect(struct psmouse *psmouse,
> +				    bool set_properties)
>  {
>  	return -ENOSYS;
>  }
> -- 
> 2.7.4
> 
> 

-- 
Dmitry
