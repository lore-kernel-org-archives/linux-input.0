From: Clement Calmels <clement.calmels@free.fr>
Subject: Re: [PATCH v2] Input: xpad - remove spurious events of wireless
 xpad 360 controller
Date: Wed, 9 Dec 2015 18:32:04 +0100
Message-ID: <20151209183204.65a94d86@gromit>
References: <1448210139-6144-1-git-send-email-clement.calmels@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:61853 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbbLIRcI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Dec 2015 12:32:08 -0500
In-Reply-To: <1448210139-6144-1-git-send-email-clement.calmels@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Sun, 22 Nov 2015 17:35:39 +0100
clement.calmels@free.fr wrote:

> From: Clement Calmels <clement.calmels@free.fr>
> 
> When powering up a wireless xbox 360 controller, some wrong joystick
> events are generated. It is annoying because, for example, it makes
> unwanted moves in Steam big picture mode's menu.
> 
> When my controller is powering up, this packet is received by the
> driver:
> 00000000: 00 0f 00 f0 00 cc ff cf 8b e0 86 6a 68 f0 00
> 20  ...........jh.. 00000010: 13 e3 20 1d 30 03 40 01 50 01 ff
> ff              .. .0.@.P...
> 
> According to xboxdrv userspace driver source code, this packet is only
> dumping a serial id and should not be interpreted as joystick events.
> This issue can be easily seen with jstest:
> $ jstest --event /dev/input/js0
> 
> This patch only adds a way to filter out this "serial" packet and as a
> result it removes the spurous events.
> 
> Signed-off-by: Clement Calmels <clement.calmels@free.fr>
> ---
>  drivers/input/joystick/xpad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/joystick/xpad.c
> b/drivers/input/joystick/xpad.c index fd4100d..c44cbd4 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -527,7 +527,7 @@ static void xpad360w_process_packet(struct
> usb_xpad *xpad, u16 cmd, unsigned cha }
>  
>  	/* Valid pad data */
> -	if (!(data[1] & 0x1))
> +	if (data[1] != 0x1)
>  		return;
>  
>  	xpad360_process_packet(xpad, cmd, &data[4]);

Hi,

This patch is waiting for a review since 30 days:
http://marc.info/?l=linux-input&m=144821014611458&w=2
Please have a look.

Best regards,
Clement
