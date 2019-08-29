From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 09/11] Input: alps - remove unlikely() from IS_ERR*()
 condition
Date: Thu, 29 Aug 2019 10:50:39 -0700
Message-ID: <20190829175039.GA187474@dtor-ws>
References: <20190829165025.15750-1-efremov@linux.com>
 <20190829165025.15750-9-efremov@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190829165025.15750-9-efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Denis Efremov <efremov@linux.com>
Cc: linux-kernel@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Aug 29, 2019 at 07:50:23PM +0300, Denis Efremov wrote:
> "unlikely(IS_ERR_OR_NULL(x))" is excessive. IS_ERR_OR_NULL() already uses
> unlikely() internally.

The keyword here is _internally_.

https://lore.kernel.org/lkml/20190821174857.GD76194@dtor-ws/

So please no.

> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> Cc: "Pali Rohár" <pali.rohar@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-input@vger.kernel.org
> ---
>  drivers/input/mouse/alps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 34700eda0429..ed1661434899 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -1476,7 +1476,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
>  		/* On V2 devices the DualPoint Stick reports bare packets */
>  		dev = priv->dev2;
>  		dev2 = psmouse->dev;
> -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
>  		/* Register dev3 mouse if we received PS/2 packet first time */
>  		if (!IS_ERR(priv->dev3))
>  			psmouse_queue_work(psmouse, &priv->dev3_register_work,
> -- 
> 2.21.0
> 

-- 
Dmitry
