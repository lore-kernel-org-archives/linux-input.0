From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH] Input: Add tsc2046 touchscreen driver
Date: Sun, 30 May 2010 14:08:13 -0700 (PDT)
Message-ID: <885802.70948.qm@web180316.mail.gq1.yahoo.com>
References: <AANLkTike4Hu6xJ52fcC9TcKaeD4hLeWxHwUvA90tc3_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n12.bullet.mail.mud.yahoo.com ([209.191.125.209]:20497 "HELO
	n12.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753670Ab0E3VIO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 May 2010 17:08:14 -0400
In-Reply-To: <AANLkTike4Hu6xJ52fcC9TcKaeD4hLeWxHwUvA90tc3_Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Cory Maccarrone <darkstar6262@gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org

--- On Sun, 5/30/10, Cory Maccarrone <darkstar6262@gmail.com> wrote:

I don't see the point in having a separate driver
for this chip ... it's just an updated ADS7846,
and the ads7846 driver has handled it for quite
a few years now, as I recall.  There's no need for
 second driver.

> >> This driver differs from the ADS7846 in that it
> >> uses 16-bit commands instead of 8-bit,

The reason the ads7846 code uses 8-bit messaging
is portability ... it works with SPI controllers
which don't support 16-bit words.  The commands are
of necessity 16-bits.  Using 16-bit words means this
driver won't run on as many systems; folk will still
need to use the ads7846 driver with tsc2046 chips..
 


 and does not include
> temerature
> >> or voltage sensing capabilities.

Another reason not to have a separate driver: this
one is less capable (as well as less portable)


> >> additions that allow
> >> the injection of pointercal parameters from tslib through /sys. 

Something the ads7846 driver could benefit from
too ... again, two drivers is counterproductive.

- Dave

