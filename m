From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 09:32:59 -0700
Message-ID: <20150609163259.GA6338@dtor-ws>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20150609105421.GA15814@amd>
 <20150609161818.GA20942@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f193.google.com ([209.85.223.193]:36095 "EHLO
	mail-ie0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460AbbFIQdE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 12:33:04 -0400
Content-Disposition: inline
In-Reply-To: <20150609161818.GA20942@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Pavel,

On Tue, Jun 09, 2015 at 06:18:18PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > I finally was able to spend some time looking over Samuel's patch set
> > > switching input LEDs from custom implementation over to standard LED class
> > > devices and I think this is the shape I am reasonably happy with. The
> > > changes:
> > 
> > Thanks!
> > 
> > > Please take a look and see if you see any holes.
> > 
> > Tested on thinkpad t40p. Started X, but then I went to text console
> > for testing.
> > 
> > 1) input4::caps-lock -- default trigger was not set, so caps lock did
> > not control the LED. That's bug, right?
> 
> max_brightness for caps-lock led is 255. I believe that should be 1,
> as keyboard LEDs can not do PWM.

Yes, you are right, I'll change max_brightness to 1 in the next
revision.

Thanks.

-- 
Dmitry
