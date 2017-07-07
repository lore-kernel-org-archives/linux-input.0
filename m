From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] input: tegra-kbc: add NULL check on of_match_device()
 return value
Date: Fri, 7 Jul 2017 08:42:32 +0100
Message-ID: <ec9b399b-ad14-21eb-9a2e-649f0dd1d489@nvidia.com>
References: <20170707062758.GA17584@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170707062758.GA17584@embeddedgus>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gustavo A. R. Silva" <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>, Rakesh Iyer <riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


On 07/07/17 07:27, Gustavo A. R. Silva wrote:
> Check return value from call to of_match_device()
> in order to prevent a NULL pointer dereference.
> 
> In case of NULL print error message and return -ENODEV
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org>
> ---
>  drivers/input/keyboard/tegra-kbc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index 0c07e10..742c5ac 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -617,6 +617,10 @@ static int tegra_kbc_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  
>  	match = of_match_device(tegra_kbc_of_match, &pdev->dev);
> +	if (!match) {
> +		dev_err(&pdev->dev, "failed to match device\n");
> +		return -ENODEV;
> +	}

Given that Tegra always uses device-tree, I believe that this cannot
happen and so this additional check is not needed.

Jon

-- 
nvpublic
