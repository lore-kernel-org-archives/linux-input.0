From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/i8042: Fix typo from i8042_aux_close to
 i8042_port_close
Date: Tue, 22 Nov 2016 18:03:49 -0800
Message-ID: <20161123020349.GH21078@dtor-ws>
References: <1479436024-22869-1-git-send-email-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35326 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756101AbcKWCEW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Nov 2016 21:04:22 -0500
Received: by mail-pg0-f65.google.com with SMTP id p66so3553293pga.2
        for <linux-input@vger.kernel.org>; Tue, 22 Nov 2016 18:03:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1479436024-22869-1-git-send-email-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Nov 18, 2016 at 12:27:04AM -0200, Marcos Paulo de Souza wrote:
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Applied, thank you.

> ---
>  drivers/input/serio/i8042.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index 89abfdb..62685a7 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -387,7 +387,7 @@ static int i8042_aux_write(struct serio *serio, unsigned char c)
>  
>  
>  /*
> - * i8042_aux_close attempts to clear AUX or KBD port state by disabling
> + * i8042_port_close attempts to clear AUX or KBD port state by disabling
>   * and then re-enabling it.
>   */
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
