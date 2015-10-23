From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 06/19] input: tegra-kbc: enable support for the standard
 "wakeup-source" property
Date: Thu, 22 Oct 2015 23:39:46 -0700
Message-ID: <20151023063946.GA38047@dtor-ws>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-7-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445422216-29375-7-git-send-email-sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 21, 2015 at 11:10:03AM +0100, Sudeep Holla wrote:
> Though the mmc core driver should/will continue to support the legacy
> "nvidia,wakeup-source" property to enable SDIO as the wakeup source, we
> need to add support for the new standard property "wakeup-source".
> 
> This patch adds support for "wakeup-source" property in addition to the
> existing "nvidia,wakeup-source" property.
> 
> Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>

Applied, thank you.

> ---
>  drivers/input/keyboard/tegra-kbc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index f97c73bd14f8..f80c72d4ac8f 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -517,7 +517,8 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
>  	if (of_find_property(np, "nvidia,needs-ghost-filter", NULL))
>  		kbc->use_ghost_filter = true;
>  
> -	if (of_find_property(np, "nvidia,wakeup-source", NULL))
> +	if (of_property_read_bool(np, "wakeup-source") ||
> +	    of_property_read_bool(np, "nvidia,wakeup-source")) /* legacy */
>  		kbc->wakeup = true;
>  
>  	if (!of_get_property(np, "nvidia,kbc-row-pins", &proplen)) {
> -- 
> 1.9.1
> 

-- 
Dmitry
