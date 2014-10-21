From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Touch processing on host CPU
Date: Tue, 21 Oct 2014 13:01:20 +0200
Message-ID: <20141021110120.GD23161@amd>
References: <5440F282.8040306@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5440F282.8040306@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <greg@kroah.com>, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi!


> I'm trying to find out which subsystem maintainer I should be talking to -
> apologies if I'm addressing the wrong people.
> 
> There is a model for doing touch processing where the touch controller
> becomes a much simpler device which sends out raw acquisitions (over SPI 
> at up to 1Mbps + protocol overheads). All touch processing is then done in
> user space by the host CPU. An example of this is NVIDIA DirectTouch - see:
> http://blogs.nvidia.com/blog/2012/02/24/industry-adopts-nvidia-directtouch/

Would it be possible to do processing in kernel space?

> In the spirit of "upstream first", I'm trying to figure out how to get a
> driver accepted. Obviously it's not an input device in the normal sense. Is
> it acceptable just to send the raw touch data out via a char device?
> Is

Char device would be best option if not.

> there another subsystem which is a good match (eg IIO)? Does the protocol
> (there is ancillary/control data as well) need to be documented?

It really depends. If you have driver for serial port, you don't need
to describe what goes over the serial port. But documentation would be
nice.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
