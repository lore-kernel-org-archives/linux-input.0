From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: nspire-keypad - add missing
 clk_disable_unprepare() on error path
Date: Tue, 15 Oct 2013 23:55:10 -0700
Message-ID: <20131016065510.GB15710@core.coreip.homeip.net>
References: <CAPgLHd9f_4-mtxXKLcL+fiNJw8gdTjU8ZSJtJoSLTW2tSa-N_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:49941 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab3JPGzQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Oct 2013 02:55:16 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so415041pbb.10
        for <linux-input@vger.kernel.org>; Tue, 15 Oct 2013 23:55:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPgLHd9f_4-mtxXKLcL+fiNJw8gdTjU8ZSJtJoSLTW2tSa-N_Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: grant.likely@linaro.org, rob.herring@calxeda.com, dt.tangr@gmail.com, yongjun_wei@trendmicro.com.cn, Julia.Lawall@lip6.fr, viresh.kumar@linaro.org, linux-input@vger.kernel.org

On Sat, Oct 12, 2013 at 02:32:09PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing clk_disable_unprepare() before return
> from nspire_keypad_open() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thank you.

> ---
>  drivers/input/keyboard/nspire-keypad.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/nspire-keypad.c b/drivers/input/keyboard/nspire-keypad.c
> index b3e3eda..85e8d80 100644
> --- a/drivers/input/keyboard/nspire-keypad.c
> +++ b/drivers/input/keyboard/nspire-keypad.c
> @@ -143,8 +143,10 @@ static int nspire_keypad_open(struct input_dev *input)
>  		return error;
>  
>  	error = nspire_keypad_chip_init(keypad);
> -	if (error)
> +	if (error) {
> +		clk_disable_unprepare(keypad->clk);
>  		return error;
> +	}
>  
>  	return 0;
>  }
> 

-- 
Dmitry
