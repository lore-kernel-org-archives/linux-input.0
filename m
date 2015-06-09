From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 09:40:07 -0700
Message-ID: <20150609164007.GC6338@dtor-ws>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20150609105421.GA15814@amd>
 <20150609111242.GA21235@amd>
 <20150609112634.GA22539@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35714 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbbFIQkO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 12:40:14 -0400
Content-Disposition: inline
In-Reply-To: <20150609112634.GA22539@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Jun 09, 2015 at 01:26:34PM +0200, Pavel Machek wrote:
> On Tue 2015-06-09 13:12:42, Pavel Machek wrote:
> > On Tue 2015-06-09 12:54:21, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > I finally was able to spend some time looking over Samuel's patch set
> > > > switching input LEDs from custom implementation over to standard LED class
> > > > devices and I think this is the shape I am reasonably happy with. The
> > > > changes:
> > > 
> > > Thanks!
> > > 
> > > > Please take a look and see if you see any holes.
> > > 
> > > Tested on thinkpad t40p. Started X, but then I went to text console
> > > for testing.
> > > 
> > > 1) input4::caps-lock -- default trigger was not set, so caps lock did
> > > not control the LED. That's bug, right?
> > 
> > Strange, on next reboot default triggers were set.
> 
> Even more strange... setting brightness to zero resets the trigger,
> setting it to one does not. Oh well, that is problem with other LEDs,
> too.

That is current led core behavior. See
drivers/led/led-class.c::brightness_store():

	if (state == LED_OFF)
		led_trigger_remove(led_cdev);
	led_set_brightness(led_cdev, state);

Thanks.

-- 
Dmitry
