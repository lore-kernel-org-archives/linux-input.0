From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 10:04:52 -0700
Message-ID: <20171024170452.og7l6ulgyq4duzjy@dtor-ws>
References: <20171024141845.GA78031@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:57056 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbdJXRE4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Oct 2017 13:04:56 -0400
Content-Disposition: inline
In-Reply-To: <20171024141845.GA78031@beast>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@gmx.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 24, 2017 at 07:18:45AM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thank you.

> ---
>  drivers/input/serio/hp_sdc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
> index 8eef6849d066..1d7c7d81a5ef 100644
> --- a/drivers/input/serio/hp_sdc.c
> +++ b/drivers/input/serio/hp_sdc.c
> @@ -794,7 +794,7 @@ int hp_sdc_release_cooked_irq(hp_sdc_irqhook *callback)
>  
>  /************************* Keepalive timer task *********************/
>  
> -static void hp_sdc_kicker(unsigned long data)
> +static void hp_sdc_kicker(struct timer_list *unused)
>  {
>  	tasklet_schedule(&hp_sdc.task);
>  	/* Re-insert the periodic task. */
> @@ -909,9 +909,8 @@ static int __init hp_sdc_init(void)
>  	down(&s_sync); /* Wait for t_sync to complete */
>  
>  	/* Create the keepalive task */
> -	init_timer(&hp_sdc.kicker);
> +	timer_setup(&hp_sdc.kicker, hp_sdc_kicker, 0);
>  	hp_sdc.kicker.expires = jiffies + HZ;
> -	hp_sdc.kicker.function = &hp_sdc_kicker;
>  	add_timer(&hp_sdc.kicker);
>  
>  	hp_sdc.dev_err = 0;
> -- 
> 2.7.4
> 
> 
> -- 
> Kees Cook
> Pixel Security

-- 
Dmitry
