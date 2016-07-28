From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input - elantech: fix debug dump of the current packet
Date: Thu, 28 Jul 2016 11:22:28 -0700
Message-ID: <20160728182228.GC16852@dtor-ws>
References: <1469699935-23056-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36717 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbcG1SWc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2016 14:22:32 -0400
Content-Disposition: inline
In-Reply-To: <1469699935-23056-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 28, 2016 at 11:58:55AM +0200, Benjamin Tissoires wrote:
> The use of mixed psmouse_printk() and printk creates 2 lines in the log,
> while the use of %*ph solves everything.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 615d23e..3461d04 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -222,12 +222,8 @@ static int elantech_write_reg(struct psmouse *psmouse, unsigned char reg,
>   */
>  static void elantech_packet_dump(struct psmouse *psmouse)
>  {
> -	int	i;
> -
> -	psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [");
> -	for (i = 0; i < psmouse->pktsize; i++)
> -		printk("%s0x%02x ", i ? ", " : " ", psmouse->packet[i]);
> -	printk("]\n");
> +	psmouse_printk(KERN_DEBUG, psmouse, "PS/2 packet [%*ph]",
> +		       psmouse->pktsize, psmouse->packet);
>  }
>  
>  /*
> -- 
> 2.5.5
> 

-- 
Dmitry
