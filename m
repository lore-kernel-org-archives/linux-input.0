From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] Input: db9 - use setup_timer
Date: Mon, 10 Apr 2017 20:39:05 -0700
Message-ID: <20170411033905.GC4346@dtor-ws>
References: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34001 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbdDKDjJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 23:39:09 -0400
Content-Disposition: inline
In-Reply-To: <f1804ee67d021aa15a44a5e62ed5277c2eab50b5.1490951519.git.geliangtang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>
Cc: Joe Perches <joe@perches.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Apr 09, 2017 at 09:39:35AM +0800, Geliang Tang wrote:
> Use setup_timer() instead of init_timer() to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Applied the lot, thank you.

> ---
>  drivers/input/joystick/db9.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
> index da32609..f4ad83e 100644
> --- a/drivers/input/joystick/db9.c
> +++ b/drivers/input/joystick/db9.c
> @@ -609,9 +609,7 @@ static void db9_attach(struct parport *pp)
>  	db9->pd = pd;
>  	db9->mode = mode;
>  	db9->parportno = pp->number;
> -	init_timer(&db9->timer);
> -	db9->timer.data = (long) db9;
> -	db9->timer.function = db9_timer;
> +	setup_timer(&db9->timer, db9_timer, (long)db9);
>  
>  	for (i = 0; i < (min(db9_mode->n_pads, DB9_MAX_DEVICES)); i++) {
>  
> -- 
> 2.9.3
> 

-- 
Dmitry
