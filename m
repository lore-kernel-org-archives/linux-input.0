From: Nicola Alessi <nialessi@gmx.com>
Subject: Re: Elantech touchpad detected as Logitech PS2 Wheel Mouse
Date: Sun, 20 May 2012 22:18:40 +0200
Message-ID: <4FB951A0.6020102@gmx.com>
References: <4FB939B5.4000309@gmx.com> <20120520192052.GA3959@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-eu.gmx.com ([213.165.64.42]:40250 "HELO
	mailout-eu.gmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752400Ab2ETUSp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 May 2012 16:18:45 -0400
In-Reply-To: <20120520192052.GA3959@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: linux-input@vger.kernel.org, jj_ding@emc.com.tw

I applied the patch. Now my kernel (3.3.6) log says:

[    6.734445] psmouse serio4: elantech: unexpected magic knock result
0x3c, 0x03, 0x3c.

I hope this can help.

Nicola

Il 20/05/12 21:20, Jonathan Nieder ha scritto:
> Can you get a log with the following patch applied?
> 
> Thanks,
> Jonathan
> 
> diff --git i/drivers/input/mouse/elantech.c w/drivers/input/mouse/elantech.c
> index d2c0db159b18..a1d59e11e2d3 100644
> --- i/drivers/input/mouse/elantech.c
> +++ w/drivers/input/mouse/elantech.c
> @@ -10,6 +10,7 @@
>   * Trademarks are the property of their respective owners.
>   */
>  
> +#define DEBUG
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>

