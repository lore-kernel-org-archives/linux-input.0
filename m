From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH TRIVIAL] Input: logips2pp - Spelling s/reciver/receiver/
Date: Sun, 12 Jan 2014 11:09:05 -0800
Message-ID: <20140112190905.GA13131@core.coreip.homeip.net>
References: <1389531708-6095-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:42009 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaALTJL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jan 2014 14:09:11 -0500
Received: by mail-pb0-f43.google.com with SMTP id rq2so6476068pbb.2
        for <linux-input@vger.kernel.org>; Sun, 12 Jan 2014 11:09:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389531708-6095-1-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Kosina <trivial@kernel.org>, linux-input@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

On Sun, Jan 12, 2014 at 02:01:48PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Applied, thank you.

> ---
>  drivers/input/mouse/logips2pp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
> index 84de2fc6acc1..136e222e2a16 100644
> --- a/drivers/input/mouse/logips2pp.c
> +++ b/drivers/input/mouse/logips2pp.c
> @@ -220,7 +220,7 @@ static const struct ps2pp_info *get_model_info(unsigned char model)
>  		{ 61,	PS2PP_KIND_MX,					/* MX700 */
>  				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
>  				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },
> -		{ 66,	PS2PP_KIND_MX,					/* MX3100 reciver */
> +		{ 66,	PS2PP_KIND_MX,					/* MX3100 receiver */
>  				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
>  				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN | PS2PP_HWHEEL },
>  		{ 72,	PS2PP_KIND_TRACKMAN,	0 },			/* T-CH11: TrackMan Marble */
> -- 
> 1.7.9.5
> 

-- 
Dmitry
