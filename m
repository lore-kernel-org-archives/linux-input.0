From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: tegra-kbc: fix inverted reset logic
Date: Mon, 22 Aug 2016 14:20:06 -0700
Message-ID: <20160822212006.GF12277@dtor-ws>
References: <1471316363-19378-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471316363-19378-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-input@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Rakesh Iyer <riyer@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 16, 2016 at 11:59:23AM +0900, Masahiro Yamada wrote:
> Commit fe6b0dfaba68 ("Input: tegra-kbc - use reset framework")
> accidentally converted _deassert to _assert, so there is no code
> to wake up this hardware.
> 
> Fixes: fe6b0dfaba68 ("Input: tegra-kbc - use reset framework")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied, thank you.

> ---
> 
>  drivers/input/keyboard/tegra-kbc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index 7d61439..0c07e10 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -376,7 +376,7 @@ static int tegra_kbc_start(struct tegra_kbc *kbc)
>  	/* Reset the KBC controller to clear all previous status.*/
>  	reset_control_assert(kbc->rst);
>  	udelay(100);
> -	reset_control_assert(kbc->rst);
> +	reset_control_deassert(kbc->rst);
>  	udelay(100);
>  
>  	tegra_kbc_config_pins(kbc);
> -- 
> 1.9.1
> 

-- 
Dmitry
