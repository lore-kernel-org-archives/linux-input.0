From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [git pull] Input updates for v5.2-rc0
Date: Tue, 14 May 2019 18:30:47 +0200
Message-ID: <20190514163047.xurqbqbnrme5r4hq@wunner.de>
References: <20190513201235.GA87488@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190513201235.GA87488@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, May 13, 2019 at 01:12:35PM -0700, Dmitry Torokhov wrote:
> Please pull from:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> 
> to receive updates for the input subsystem. You will get a few new
> drivers:
> 
> - driver for Azoteq IQS550/572/525 touch controllers
> - driver for Microchip AT42QT1050 keys
> - driver for GPIO controllable vibrators
> - support for GT5663 in Goodix driver

This is missing the driver to support the keyboard and trackpad
on 2015+ MacBooks and MacBook Pros / Airs.  Those machines make up
a large segment of the laptop market and are pretty much unusable
on Linux without the driver:

https://www.spinics.net/lists/dri-devel/msg207174.html

The patches have gone through 7 iterations, have been reviewed
extensively, all review comments were addressed properly and
the code is now in excellent shape.  The last iteration was
posted to the list 1 month ago, well in time to make it into
this merge window.  So I don't understand why it's not part
of this pull request.

Please consider submitting a second pull request for the ongoing
merge window with that driver.

Thanks,

Lukas
