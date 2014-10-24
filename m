From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: stmpe: fix valid key line bitmask
Date: Fri, 24 Oct 2014 14:37:38 -0700
Message-ID: <20141024213738.GF19933@dtor-ws>
References: <1413636729-2985-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:52436 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaJXVhm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Oct 2014 17:37:42 -0400
Received: by mail-pd0-f174.google.com with SMTP id p10so2131013pdj.5
        for <linux-input@vger.kernel.org>; Fri, 24 Oct 2014 14:37:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413636729-2985-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org

On Sat, Oct 18, 2014 at 02:52:09PM +0200, Linus Walleij wrote:
> The bitmask comment says it will enable GPIO 8-14 and 16-20
> for keypad use, but it actually enables GPIO 8-11 and 13-20
> due to a bit error.
> 
> Instead of masking of the "hole" at GPIO 12 (which is used
> for keypad output 4) mask of the proper "hole" at GPIO 15.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Dmitry, this is for fixes I think.

Applied, thank you.

> ---
>  drivers/input/keyboard/stmpe-keypad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
> index c6727dda68f2..ef5e67fb567e 100644
> --- a/drivers/input/keyboard/stmpe-keypad.c
> +++ b/drivers/input/keyboard/stmpe-keypad.c
> @@ -86,7 +86,7 @@ static const struct stmpe_keypad_variant stmpe_keypad_variants[] = {
>  		.max_cols		= 8,
>  		.max_rows		= 12,
>  		.col_gpios		= 0x0000ff,	/* GPIO 0 - 7*/
> -		.row_gpios		= 0x1fef00,	/* GPIO 8-14, 16-20 */
> +		.row_gpios		= 0x1f7f00,	/* GPIO 8-14, 16-20 */
>  	},
>  	[STMPE2403] = {
>  		.auto_increment		= true,
> -- 
> 1.9.3
> 

-- 
Dmitry
