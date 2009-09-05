From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input - keyboard: fix theoretical race on vt switch
Date: Sat, 5 Sep 2009 00:09:17 -0700
Message-ID: <20090905074222.122C8526EC9@mailhub.coreip.homeip.net>
References: <4A9FE929.8030804@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:42019 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbZIEHJU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2009 03:09:20 -0400
Received: by pxi32 with SMTP id 32so1377611pxi.25
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2009 00:09:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A9FE929.8030804@tuffmail.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux-input@vger.kernel.org

On Thu, Sep 03, 2009 at 05:04:57PM +0100, Alan Jenkins wrote:
> Switching virtual consoles could change fg_console between
> 
> 	vc = vc_cons[fg_console].d
> and
> 	kbd = kbd_table + fg_console
> 
> Replace the second instance of fg_console with vc->vc_num.
> 
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> ---
>  drivers/char/keyboard.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
> index 737be95..4b564c5 100644
> --- a/drivers/char/keyboard.c
> +++ b/drivers/char/keyboard.c
> @@ -1157,7 +1157,7 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
>  		tty->driver_data = vc;
>  	}
>  
> -	kbd = kbd_table + fg_console;
> +	kbd = kbd_table + vc->vc_num;

Hmm, I see more such cases there...

-- 
Dmitry
