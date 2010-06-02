From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: bcm5974 turn wellspring mode off if failed to
 start traffic
Date: Wed, 2 Jun 2010 00:35:13 -0700
Message-ID: <20100602073513.GG3713@core.coreip.homeip.net>
References: <1275421559-7980-1-git-send-email-sunmoon1997@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37845 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab0FBHfS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 03:35:18 -0400
Received: by pvg11 with SMTP id 11so2190595pvg.19
        for <linux-input@vger.kernel.org>; Wed, 02 Jun 2010 00:35:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275421559-7980-1-git-send-email-sunmoon1997@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luo Jinghua <sunmoon1997@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

Hi Luo,

On Wed, Jun 02, 2010 at 03:45:59AM +0800, Luo Jinghua wrote:
> The bcm5974 driver doesn't work on my MacbookPro6,2 for some reason. It
> failed to start traffic and left the wellsprint mode on. As a result,
> the keyboard is slow to response and become unusable.
> 
> Signed-off-by: Luo Jinghua <sunmoon1997@gmail.com>
> ---
>  drivers/input/mouse/bcm5974.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index 6dedded..5518089 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -595,6 +595,7 @@ static int bcm5974_start_traffic(struct bcm5974 *dev)
>  
>  err_kill_bt:
>  	usb_kill_urb(dev->bt_urb);
> +	bcm5974_wellspring_mode(dev, false);
>  error:
>  	return -EIO;
>  }

Could you see what URB it failed to submit and what error code was
returned? Maybe it will give us idea what went wrong.

-- 
Dmitry
