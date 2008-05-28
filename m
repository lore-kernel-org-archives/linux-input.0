From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] pxa: Fix some issues with pxa27x_keypad driver v2
Date: Wed, 28 May 2008 11:15:36 -0400
Message-ID: <20080528111503.ZZRA012@mailhub.coreip.homeip.net>
References: <20080528162539.6d7a2158.ospite@studenti.unina.it> <20080528103004.ZZRA012@mailhub.coreip.homeip.net> <20080528171114.ed177b63.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:65457 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbYE1PPl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2008 11:15:41 -0400
Received: by an-out-0708.google.com with SMTP id d40so645277and.103
        for <linux-input@vger.kernel.org>; Wed, 28 May 2008 08:15:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080528171114.ed177b63.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, eric miao <eric.y.miao@gmail.com>

On Wed, May 28, 2008 at 05:11:14PM +0200, Antonio Ospite wrote:
> On Wed, 28 May 2008 10:31:25 -0400
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Antonio,
> > 
> > On Wed, May 28, 2008 at 04:25:39PM +0200, Antonio Ospite wrote:
> > >  
> > > -	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> > > -		BIT_MASK(EV_REL);
> > > +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> > > +	if (keypad->pdata->rotary0_rel_code || keypad->pdata->rotary1_rel_code)
> > > +		input_dev->evbit[0] |= BIT_MASK(EV_REL);
> > 
> > Shouldn't this also check pdata->enable_rotaryX?
> >
> 
> Yes, maybe.
> Do you prefer a check like this?
> 
> if ((keypad->pdata->enable_rotary0 && keypad->pdata->rotary0_rel_code) ||
> 	(keypad->pdata->enable_rotary1 && keypad->pdata->rotary1_rel_code))
> 	input_dev->evbit[0] |= BIT_MASK(EV_REL);
> 
> Just confirm that and I'll resend a fixed version of the patch.
> 

Yep, that should work, thanks.

-- 
Dmitry
