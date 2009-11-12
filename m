From: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: keyboard leds not restored after s2ram in 2.6.32-rc6-00166-g799dd75
Date: Thu, 12 Nov 2009 00:08:39 -0800 (PST)
Message-ID: <282630.26689.qm@web58403.mail.re3.yahoo.com>
References: <761296.29412.qm@web58402.mail.re3.yahoo.com> <20091111095218.GA3654@core.coreip.homeip.net> <800885.42568.qm@web58401.mail.re3.yahoo.com> <20091111215029.GA13390@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from web58403.mail.re3.yahoo.com ([68.142.236.171]:33528 "HELO
	web58403.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751081AbZKLIId (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Nov 2009 03:08:33 -0500
In-Reply-To: <20091111215029.GA13390@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> > I did some tests suspending with the caps lock actually on, and it seems that
> > in that case the user might still be confused (caps lock is on but led is 
> off).
> > At least on this machine this patch doesn't affect this theoretical problem
> > either way (2.6.31 behaves similarly), so it is ok.
> > 
> 
> Umm... so you are saying that even with .31 if you suspend with capslock
> on it is off when you resume? Does it happen only in X or in console as
> well?

It seems I judged a bit too early.
In console, both 2.6.31 and .32-rc6+your patch:
- suspending both with capslock on and off works as expected (same state in mode
and led after resume)

In X, both  2.6.31 and .32-rc6+your patch:
- suspending both with capslock on and off works; after resume same state
(typing procudes capital letters if capslock was on) and led shows the caplock
state
- if the capslock is on after resume, and I press shift before capslock key, the led
turns off but typing still produces capital letters. This, I think, is strange. This did
not happen in console, neither does pressing shift usually turn off the led.

So, apart from the minor nuisance of the shift key turning off the capslock led in X
even if typing still produces capital letters, everything seems to work as expected.


Mikko


> 
> -- 
> Dmitry



      
