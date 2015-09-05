From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042 - Lower log level for "no controller"
 message
Date: Sat, 5 Sep 2015 10:29:39 -0700
Message-ID: <20150905172939.GA18006@dtor-ws>
References: <1441361242-15138-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34636 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbbIER3n (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2015 13:29:43 -0400
Content-Disposition: inline
In-Reply-To: <1441361242-15138-1-git-send-email-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Sep 04, 2015 at 12:07:22PM +0200, Takashi Iwai wrote:
> Nowadays the machines without i8042 controller is popular, and no need
> to print "No controller found" message in the error log level, which
> annoys at booting in quiet mode.  Let's lower it info level.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied, thank you.

> ---
>  drivers/input/serio/i8042.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> index cb5ece77fd7d..b8cde6912d93 100644
> --- a/drivers/input/serio/i8042.c
> +++ b/drivers/input/serio/i8042.c
> @@ -871,7 +871,7 @@ static int __init i8042_check_aux(void)
>  static int i8042_controller_check(void)
>  {
>  	if (i8042_flush()) {
> -		pr_err("No controller found\n");
> +		pr_info("No controller found\n");
>  		return -ENODEV;
>  	}
>  
> -- 
> 2.5.1
> 

-- 
Dmitry
