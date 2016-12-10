From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042-x86ia64io.h - Comment else/endif of
 CONFIG_PNP
Date: Fri, 9 Dec 2016 18:00:33 -0800
Message-ID: <20161210020033.GA15829@dtor-ws>
References: <20161209235518.14465-1-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33480 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbcLJCAh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2016 21:00:37 -0500
Content-Disposition: inline
In-Reply-To: <20161209235518.14465-1-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: Patrick Scheuring <patrick.scheuring.dev@gmail.com>, =?iso-8859-1?Q?Aur=E9lien?= Francillon <aurelien@francillon.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 09, 2016 at 09:55:09PM -0200, Marcos Paulo de Souza wrote:
> As this define check if huge, this makes easier to read the code.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Applied, thank you.

> ---
>  While reviewing patches from Dmitry about presence of 8042, it makes it
>  much easier to understand the ifdefs...
> 
>  drivers/input/serio/i8042-x86ia64io.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 073246c..ddd3132 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -1131,10 +1131,10 @@ static int __init i8042_pnp_init(void)
>  	return 0;
>  }
>  
> -#else
> +#else  /* !CONFIG_PNP */
>  static inline int i8042_pnp_init(void) { return 0; }
>  static inline void i8042_pnp_exit(void) { }
> -#endif
> +#endif /* CONFIG_PNP */
>  
>  static int __init i8042_platform_init(void)
>  {
> -- 
> 2.9.3
> 

-- 
Dmitry
