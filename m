From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: altera_ps2 - write to correct register when
 disabling interrupts
Date: Fri, 31 Oct 2014 09:52:55 -0700
Message-ID: <20141031165255.GD32331@dtor-ws>
References: <1414759291-23164-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:62106 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756650AbaJaQxA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 12:53:00 -0400
Received: by mail-ie0-f170.google.com with SMTP id tp5so1715698ieb.1
        for <linux-input@vger.kernel.org>; Fri, 31 Oct 2014 09:52:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1414759291-23164-1-git-send-email-tklauser@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-input@vger.kernel.org

On Fri, Oct 31, 2014 at 01:41:29PM +0100, Tobias Klauser wrote:
> In altera_ps2_close, the data register (offset 0) is written instead of
> the control register (offset 4), leading to the RX interrupt not being
> disabled. Fix this by calling writel() with the offset for the proper
> register.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied the first 2 and queued 3rd for 3.19. Thanks Tobias.

> ---
>  drivers/input/serio/altera_ps2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
> index cce69d6..e0371e1 100644
> --- a/drivers/input/serio/altera_ps2.c
> +++ b/drivers/input/serio/altera_ps2.c
> @@ -74,7 +74,7 @@ static void altera_ps2_close(struct serio *io)
>  {
>  	struct ps2if *ps2if = io->port_data;
>  
> -	writel(0, ps2if->base); /* disable rx irq */
> +	writel(0, ps2if->base + 4); /* disable rx irq */
>  }
>  
>  /*
> -- 
> 2.0.1
> 
> 

-- 
Dmitry
