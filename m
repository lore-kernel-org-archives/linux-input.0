From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 18:18:18 +0200
Message-ID: <20150609161818.GA20942@amd>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20150609105421.GA15814@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42759 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbbFIQSV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 12:18:21 -0400
Content-Disposition: inline
In-Reply-To: <20150609105421.GA15814@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi!

> > I finally was able to spend some time looking over Samuel's patch set
> > switching input LEDs from custom implementation over to standard LED class
> > devices and I think this is the shape I am reasonably happy with. The
> > changes:
> 
> Thanks!
> 
> > Please take a look and see if you see any holes.
> 
> Tested on thinkpad t40p. Started X, but then I went to text console
> for testing.
> 
> 1) input4::caps-lock -- default trigger was not set, so caps lock did
> not control the LED. That's bug, right?

max_brightness for caps-lock led is 255. I believe that should be 1,
as keyboard LEDs can not do PWM.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
