From: Johan Hovold <johan@kernel.org>
Subject: Re: rotary encoder linux driver
Date: Tue, 14 Oct 2014 10:48:15 +0200
Message-ID: <20141014084815.GC7958@localhost>
References: <1413163743.39490.YahooMailNeo@web160203.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413163743.39490.YahooMailNeo@web160203.mail.bf1.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tecfacet <tecfacet@yahoo.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Oct 12, 2014 at 06:29:03PM -0700, tecfacet wrote:
> Hello.
> 
> I am interested in the rotary encoder kernel driver.  I am very new to
> this linux kernel driver thing.  
> 
> How do I pass the gpio and interrupt stuff to the kernel module.. I
> think it is thru the rotary_encoder.h file.. am I correct?

That should be done through the device tree these days. The binding is
documented in

	Documentation/devicetree/bindings/input/rotary-encoder.txt

in the kernel source tree.

> How does the information about encoder position etc get back to my
> user space program?  How is debounce handled?
> I am a little confused.  Is there an example of a complete working
> implementation?  I need to figure this out for school.

Have a look at the evtest program for an example:

	http://cgit.freedesktop.org/~whot/evtest

Good luck,
Johan
