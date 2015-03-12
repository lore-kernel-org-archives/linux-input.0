From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: pwm-beeper: remove useless call to
 pwm_config()
Date: Thu, 12 Mar 2015 14:47:52 -0700
Message-ID: <20150312214752.GB4720@dtor-ws>
References: <1426165770-11130-1-git-send-email-olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426165770-11130-1-git-send-email-olivier@sobrie.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Mar 12, 2015 at 02:09:30PM +0100, Olivier Sobrie wrote:
> Calling pwm_config() with a period equal to zero always results in
> error (-EINVAL) and pwm chip config method is never called.
> 
> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>

Applied, thank you.

> ---
>  drivers/input/misc/pwm-beeper.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> index a28ee70..2a23643 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -50,7 +50,6 @@ static int pwm_beeper_event(struct input_dev *input,
>  	}
>  
>  	if (value == 0) {
> -		pwm_config(beeper->pwm, 0, 0);
>  		pwm_disable(beeper->pwm);
>  	} else {
>  		period = HZ_TO_NANOSECONDS(value);
> -- 
> 1.9.1
> 

-- 
Dmitry
