From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: pwm-beeper: suppress error message on
 probe defer
Date: Sat, 14 Jan 2017 11:17:12 -0800
Message-ID: <20170114191712.GB31309@dtor-ws>
References: <1484164921-30587-1-git-send-email-david@lechnology.com>
 <1484164921-30587-2-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484164921-30587-2-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 11, 2017 at 02:01:59PM -0600, David Lechner wrote:
> This suppress printing an error message when pwm_get returns -EPROBE_DEFER.
> Otherwise you get a bunch of noise in the kernel log.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/input/misc/pwm-beeper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> index ce6eec4..30ac227 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -104,9 +104,10 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	beeper->pwm = devm_pwm_get(dev, NULL);
> -	if (IS_ERR(beeper->pwm)) {
> -		error = PTR_ERR(beeper->pwm);
> -		dev_err(dev, "Failed to request pwm device: %d\n", error);
> +	error = PTR_ERR_OR_ZERO(beeper->pwm);
> +	if (error) {

I do not find it in any way clearer than

	if (IS_ERR()) {
		...

I prefer PTR_ERR_OR_ZERO be used when you need to return value without
acting on it.

I can adjust locally, no need to resubmit.

> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request pwm device\n");
>  		return error;
>  	}
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
