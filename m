From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] input: off by one in pcf8574_kp_irq_handler()
Date: Sat, 5 Jun 2010 00:36:00 -0700
Message-ID: <20100605073559.GA29303@core.coreip.homeip.net>
References: <20100604231939.GJ5483@bicker>
 <20100605085002.064a6888@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:43932 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab0FEHgG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Jun 2010 03:36:06 -0400
Content-Disposition: inline
In-Reply-To: <20100605085002.064a6888@hyperion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Dan Carpenter <error27@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Greg Kroah-Hartman <gregkh@suse.de>, Richard Purdie <rpurdie@linux.intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sat, Jun 05, 2010 at 08:50:02AM +0200, Jean Delvare wrote:
> Hi Dan,
> 
> On Sat, 5 Jun 2010 01:19:39 +0200, Dan Carpenter wrote:
> > If nextstate == ARRAY_SIZE(lp->btncode), then we read one past the end of
> > the array on the next line.
> > 
> > This fixes a smatch warning:
> > drivers/input/misc/pcf8574_keypad.c +74 pcf8574_kp_irq_handler(8)
> > 	error: buffer overflow 'lp->btncode' 17 <= 17
> > 
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > 
> > diff --git a/drivers/input/misc/pcf8574_keypad.c b/drivers/input/misc/pcf8574_keypad.c
> > index 0ac47d2..4b42ffc 100644
> > --- a/drivers/input/misc/pcf8574_keypad.c
> > +++ b/drivers/input/misc/pcf8574_keypad.c
> > @@ -69,7 +69,7 @@ static irqreturn_t pcf8574_kp_irq_handler(int irq, void *dev_id)
> >  	unsigned char nextstate = read_state(lp);
> >  
> >  	if (lp->laststate != nextstate) {
> > -		int key_down = nextstate <= ARRAY_SIZE(lp->btncode);
> > +		int key_down = nextstate < ARRAY_SIZE(lp->btncode);
> >  		unsigned short keycode = key_down ?
> >  			lp->btncode[nextstate] : lp->btncode[lp->laststate];
> >  
> 
> Good catch.
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 

Applied to 'for-linus', thanks Dan.

-- 
Dmitry
