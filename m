From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 13:12:42 +0200
Message-ID: <20150609111242.GA21235@amd>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20150609105421.GA15814@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150609105421.GA15814@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

On Tue 2015-06-09 12:54:21, Pavel Machek wrote:
> Hi!
> 
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

Strange, on next reboot default triggers were set.

> I did echo kbd-capslock > trigger, but still no luck. (That might be
> bug in Debian, IIRC?)

I tried rebooting with stock Debian kernel, and the bug is there, too.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
