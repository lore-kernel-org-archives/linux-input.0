From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mouse: alps: print small buffers via %*ph
Date: Tue, 30 Oct 2012 22:55:18 -0700
Message-ID: <20121031055518.GD31983@core.coreip.homeip.net>
References: <1351258978-18656-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63911 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab2JaFzW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 01:55:22 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so715192pad.19
        for <linux-input@vger.kernel.org>; Tue, 30 Oct 2012 22:55:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351258978-18656-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Fri, Oct 26, 2012 at 04:42:58PM +0300, Andy Shevchenko wrote:
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied, thank you Andy.
 
> ---
>  drivers/input/mouse/alps.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index cf5af1f..b4a3faf 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -766,10 +766,9 @@ static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
>  		      psmouse->packet[4] |
>  		      psmouse->packet[5]) & 0x80) ||
>  		    (!alps_is_valid_first_byte(priv->i, psmouse->packet[6]))) {
> -			psmouse_dbg(psmouse,
> -				    "refusing packet %x %x %x %x (suspected interleaved ps/2)\n",
> -				    psmouse->packet[3], psmouse->packet[4],
> -				    psmouse->packet[5], psmouse->packet[6]);
> +			psmouse_dbg(psmouse, "refusing packet %4ph "
> +				    "(suspected interleaved ps/2)\n",
> +				    psmouse->packet + 3);
>  			return PSMOUSE_BAD_DATA;
>  		}
>  
> @@ -830,10 +829,9 @@ static void alps_flush_packet(unsigned long data)
>  		if ((psmouse->packet[3] |
>  		     psmouse->packet[4] |
>  		     psmouse->packet[5]) & 0x80) {
> -			psmouse_dbg(psmouse,
> -				    "refusing packet %x %x %x (suspected interleaved ps/2)\n",
> -				    psmouse->packet[3], psmouse->packet[4],
> -				    psmouse->packet[5]);
> +			psmouse_dbg(psmouse, "refusing packet %3ph "
> +				    "(suspected interleaved ps/2)\n",
> +				    psmouse->packet + 3);
>  		} else {
>  			alps_process_packet(psmouse);
>  		}
> -- 
> 1.7.10.4
> 

-- 
Dmitry
