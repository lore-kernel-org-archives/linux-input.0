From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: pxa27x_keypad: fix typo "debpunce" -> "debounce"
Date: Tue, 25 Oct 2016 09:35:55 -0700
Message-ID: <20161025163555.GB10979@dtor-ws>
References: <20161025110312.7505-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35979 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933162AbcJYQsC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Oct 2016 12:48:02 -0400
Content-Disposition: inline
In-Reply-To: <20161025110312.7505-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 25, 2016 at 12:03:12PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to typo in dev_err message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/pxa27x_keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index fcef5d1..e244433 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -316,7 +316,7 @@ static int pxa27x_keypad_build_keycode_from_dt(struct pxa27x_keypad *keypad)
>  	error = of_property_read_u32(np, "marvell,debounce-interval",
>  				     &pdata->debounce_interval);
>  	if (error) {
> -		dev_err(dev, "failed to parse debpunce-interval\n");
> +		dev_err(dev, "failed to parse debounce-interval\n");
>  		return error;
>  	}
>  
> -- 
> 2.9.3
> 

-- 
Dmitry
