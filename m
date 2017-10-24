From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Serio/hil_mlc: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 10:05:03 -0700
Message-ID: <20171024170503.vgh3jqlewdrdc36j@dtor-ws>
References: <20171024141851.GA78046@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:48676 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbdJXRFH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Oct 2017 13:05:07 -0400
Content-Disposition: inline
In-Reply-To: <20171024141851.GA78046@beast>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Oct 24, 2017 at 07:18:51AM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thank you.

> ---
>  drivers/input/serio/hil_mlc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
> index 65605e4ef3cf..d66d01c5373b 100644
> --- a/drivers/input/serio/hil_mlc.c
> +++ b/drivers/input/serio/hil_mlc.c
> @@ -784,7 +784,7 @@ static void hil_mlcs_process(unsigned long unused)
>  
>  /************************* Keepalive timer task *********************/
>  
> -static void hil_mlcs_timer(unsigned long data)
> +static void hil_mlcs_timer(struct timer_list *unused)
>  {
>  	hil_mlcs_probe = 1;
>  	tasklet_schedule(&hil_mlcs_tasklet);
> @@ -998,7 +998,7 @@ int hil_mlc_unregister(hil_mlc *mlc)
>  
>  static int __init hil_mlc_init(void)
>  {
> -	setup_timer(&hil_mlcs_kicker, &hil_mlcs_timer, 0);
> +	timer_setup(&hil_mlcs_kicker, &hil_mlcs_timer, 0);
>  	mod_timer(&hil_mlcs_kicker, jiffies + HZ);
>  
>  	tasklet_enable(&hil_mlcs_tasklet);
> -- 
> 2.7.4
> 
> 
> -- 
> Kees Cook
> Pixel Security

-- 
Dmitry
