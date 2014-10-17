From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Touch processing on host CPU
Date: Fri, 17 Oct 2014 10:17:56 -0700
Message-ID: <20141017171756.GA22238@dtor-ws>
References: <5440F282.8040306@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5440F282.8040306@itdev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Greg KH <greg@kroah.com>, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Nick,

On Fri, Oct 17, 2014 at 11:42:10AM +0100, Nick Dyer wrote:
> Hi-
> 
> I'm trying to find out which subsystem maintainer I should be talking to -
> apologies if I'm addressing the wrong people.
> 
> There is a model for doing touch processing where the touch controller
> becomes a much simpler device which sends out raw acquisitions (over SPI 
> at up to 1Mbps + protocol overheads). All touch processing is then done in
> user space by the host CPU. An example of this is NVIDIA DirectTouch - see:
> http://blogs.nvidia.com/blog/2012/02/24/industry-adopts-nvidia-directtouch/
> 
> In the spirit of "upstream first", I'm trying to figure out how to get a
> driver accepted. Obviously it's not an input device in the normal sense. Is
> it acceptable just to send the raw touch data out via a char device? Is
> there another subsystem which is a good match (eg IIO)? Does the protocol
> (there is ancillary/control data as well) need to be documented?

I'd really think *long* and *hard* about this. Even if you will have the
touch process open source you have 2 options: route it back into the
kernel through uinput, thus adding latency (which might be OK, need to
measure and decide), or go back about 10 years where we had
device-specific drivers in XFree86 and re-create them again, and also do
the same for Wayland, Chrome, Android, etc.

If you will have touch processing in a binary blob, you'll also be going
to ages "Works with Ubuntu 12.04 on x86_32!" (and nothing else), or
"Android 5.1.2 on Tegra Blah (build 78912KT)" (and nothing else).

Thanks.

-- 
Dmitry
