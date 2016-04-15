From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2 v2] device-tree: nexus7-flo: Remove power gpio key
 entry and use pmic8xxx-pwrkey
Date: Fri, 15 Apr 2016 15:01:06 -0700
Message-ID: <20160415220106.GZ391@tuxbot>
References: <1460668031-12384-1-git-send-email-john.stultz@linaro.org>
 <20160415172212.GW391@tuxbot>
 <20160415185927.GN14441@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160415185927.GN14441@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <stephen.boyd@linaro.org>, lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Andy Gross <agross@codeaurora.org>, Vinay Simha BN <simhavcs@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri 15 Apr 11:59 PDT 2016, Stephen Boyd wrote:

[..]

> ----8<-----
> From: Stephen Boyd <sboyd@codeaurora.org>
> Subject: [PATCH] Input: pmic8xxx-pwrkey: Fix algorithm for converting trigger
>  delay
> 
> The trigger delay algorithm that converts from microseconds to
> the register value looks incorrect. According to most of the PMIC
> documentation, the equation is
> 
> 	delay (Seconds) = (1 / 1024) * 2 ^ (x + 4)
> 
> except for one case where the documentation looks to have a
> formatting issue and the equation looks like
> 
> 	delay (Seconds) = (1 / 1024) * 2 x + 4
> 
> Most likely this driver was written with the improper
> documentation to begin with. According to the downstream sources
> the valid delays are from 2 seconds to 1/64 second, and the
> latter equation just doesn't make sense for that. Let's fix the
> algorithm and the range check to match the documentation and the
> downstream sources.
> 
> Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Cc: John Stultz <john.stultz@linaro.org>
> Fixes: 92d57a73e410 ("input: Add support for Qualcomm PMIC8XXX power key")
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/input/misc/pmic8xxx-pwrkey.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
> index 3f02e0e03d12..67aab86048ad 100644
> --- a/drivers/input/misc/pmic8xxx-pwrkey.c
> +++ b/drivers/input/misc/pmic8xxx-pwrkey.c
> @@ -353,7 +353,8 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(pdev->dev.of_node, "debounce", &kpd_delay))
>  		kpd_delay = 15625;
>  
> -	if (kpd_delay > 62500 || kpd_delay == 0) {
> +	/* Valid range of pwr key trigger delay is 1/64 sec to 2 seconds. */
> +	if (kpd_delay > USEC_PER_SEC * 2 || kpd_delay < USEC_PER_SEC / 64) {
>  		dev_err(&pdev->dev, "invalid power key trigger delay\n");
>  		return -EINVAL;
>  	}
> @@ -385,8 +386,8 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
>  	pwr->name = "pmic8xxx_pwrkey";
>  	pwr->phys = "pmic8xxx_pwrkey/input0";
>  
> -	delay = (kpd_delay << 10) / USEC_PER_SEC;
> -	delay = 1 + ilog2(delay);
> +	delay = (kpd_delay << 6) / USEC_PER_SEC;
> +	delay = ilog2(delay);

Regards,
Bjorn
