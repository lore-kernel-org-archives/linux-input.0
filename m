From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] pxa: Fix some issues with pxa27x_keypad driver v2
Date: Wed, 28 May 2008 17:11:14 +0200
Message-ID: <20080528171114.ed177b63.ospite@studenti.unina.it>
References: <20080528162539.6d7a2158.ospite@studenti.unina.it>
	<20080528103004.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vsmtp21.tin.it ([212.216.176.109]:64362 "EHLO vsmtp21.tin.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbYE1PLa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2008 11:11:30 -0400
In-Reply-To: <20080528103004.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, eric miao <eric.y.miao@gmail.com>

On Wed, 28 May 2008 10:31:25 -0400
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Antonio,
> 
> On Wed, May 28, 2008 at 04:25:39PM +0200, Antonio Ospite wrote:
> >  
> > -	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP) |
> > -		BIT_MASK(EV_REL);
> > +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> > +	if (keypad->pdata->rotary0_rel_code || keypad->pdata->rotary1_rel_code)
> > +		input_dev->evbit[0] |= BIT_MASK(EV_REL);
> 
> Shouldn't this also check pdata->enable_rotaryX?
>

Yes, maybe.
Do you prefer a check like this?

if ((keypad->pdata->enable_rotary0 && keypad->pdata->rotary0_rel_code) ||
	(keypad->pdata->enable_rotary1 && keypad->pdata->rotary1_rel_code))
	input_dev->evbit[0] |= BIT_MASK(EV_REL);

Just confirm that and I'll resend a fixed version of the patch.

Thanks,
   Antonio
