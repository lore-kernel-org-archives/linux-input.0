From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 6/6] Input: add IOC3 serio driver
Date: Mon, 8 Apr 2019 21:08:42 +0200
Message-ID: <20190408190842.GS7480@piout.net>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
 <20190408142100.27618-7-tbogendoerfer@suse.de>
 <20190408190218.GA200740@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190408190218.GA200740@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 08/04/2019 12:02:18-0700, Dmitry Torokhov wrote:
> > +MODULE_AUTHOR("Stanislaw Skowronek <skylark@unaligned.org>");
> > +MODULE_DESCRIPTION("SGI IOC3 serio driver");
> > +MODULE_LICENSE("GPL");
> 
> "GPL v2" to match SPDX header?
> 

I've been told this is not true:

https://lore.kernel.org/linux-rtc/371999940784dbd281669122c3027805ab0ecfd9.camel@perches.com/


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
