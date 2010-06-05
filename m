From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [patch] input: off by one in pcf8574_kp_irq_handler()
Date: Sat, 5 Jun 2010 08:50:02 +0200
Message-ID: <20100605085002.064a6888@hyperion.delvare>
References: <20100604231939.GJ5483@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from poutre.nerim.net ([62.4.16.124]:59256 "EHLO poutre.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754452Ab0FEGuH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 5 Jun 2010 02:50:07 -0400
In-Reply-To: <20100604231939.GJ5483@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Greg Kroah-Hartman <gregkh@suse.de>, Richard Purdie <rpurdie@linux.intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Dan,

On Sat, 5 Jun 2010 01:19:39 +0200, Dan Carpenter wrote:
> If nextstate == ARRAY_SIZE(lp->btncode), then we read one past the end of
> the array on the next line.
> 
> This fixes a smatch warning:
> drivers/input/misc/pcf8574_keypad.c +74 pcf8574_kp_irq_handler(8)
> 	error: buffer overflow 'lp->btncode' 17 <= 17
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
> index 0ac47d2..4b42ffc 100644
> --- a/drivers/input/misc/pcf8574_keypad.c
> +++ b/drivers/input/misc/pcf8574_keypad.c
> @@ -69,7 +69,7 @@ static irqreturn_t pcf8574_kp_irq_handler(int irq, void *dev_id)
>  	unsigned char nextstate = read_state(lp);
>  
>  	if (lp->laststate != nextstate) {
> -		int key_down = nextstate <= ARRAY_SIZE(lp->btncode);
> +		int key_down = nextstate < ARRAY_SIZE(lp->btncode);
>  		unsigned short keycode = key_down ?
>  			lp->btncode[nextstate] : lp->btncode[lp->laststate];
>  

Good catch.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
