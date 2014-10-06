From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.17-rc5: kernel oops when exiting X under heavy load
Date: Mon, 6 Oct 2014 22:45:26 +0200
Message-ID: <20141006204526.GA28905@amd>
References: <20141003231109.GA4530@amd>
 <20141006181202.GA22781@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141006181202.GA22781@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi!

> > From the backtrace, it looks evdev related...?
> 
> Hmm, looks like it...

I don't think I can repeat that. I was doing crazy stuff at that
moment. (Typo fixes suggested below).

Thanks,
								Pavel

Input: evdev - fix EVIOCG{type} ioctl

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

The 'max' size passed into the function is measured in number of bits
(KEY_MAX, LED_MAX, etc) so we nedd to convert it accoidingly before tyring

###                           need               accordingly(?)     trying

to copy the data out, otherwise we will try copying too much and end up
with up with a page fault.

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
