From: Josh Cartwright <joshc@codeaurora.org>
Subject: Re: [PATCH] Input: pmic8xxx-pwrkey - Set sane default for debounce
 time
Date: Mon, 31 Mar 2014 13:23:42 -0500
Message-ID: <20140331182342.GD28265@joshc.qualcomm.com>
References: <1396289664-31893-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1396289664-31893-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 31, 2014 at 11:14:24AM -0700, Stephen Boyd wrote:
> If the debounce time is 0 our usage of ilog2() later on in this
> driver will cause undefined behavior. If CONFIG_OF=n this fact is
> evident to the compiler, and it emits a call to ____ilog2_NaN()
> which doesn't exist. Fix this by setting a sane default for
> debounce.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/input/misc/pmic8xxx-pwrkey.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
> index 1cb8fda7a166..27add04676e1 100644
> --- a/drivers/input/misc/pmic8xxx-pwrkey.c
> +++ b/drivers/input/misc/pmic8xxx-pwrkey.c
> @@ -92,7 +92,7 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
>  	bool pull_up;
>  
>  	if (of_property_read_u32(pdev->dev.of_node, "debounce", &kpd_delay))
> -		kpd_delay = 0;
> +		kpd_delay = 15625;

Should "debounce" even be optional?  I'm wondering if we should just
make it required...

At the very least this default value should be documented in the DT
binding.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
