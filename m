From: Andrey Utkin <andrey_utkin@fastmail.com>
Subject: Re: [Kernel] Mainlining of Pyra nub joystick driver
Date: Thu, 16 Jun 2016 22:51:06 +0300
Message-ID: <20160616195106.GG4820@zver>
References: <20160614114523.GC4820@zver>
 <20160614170206.GE4820@zver>
 <DAA6B14A-062E-45E9-97DD-18D55480F0A8@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33097 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751931AbcFPTvM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2016 15:51:12 -0400
Content-Disposition: inline
In-Reply-To: <DAA6B14A-062E-45E9-97DD-18D55480F0A8@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: linux-input@vger.kernel.org, devel@driverdev.osuosl.org, kernel-mentors@selenic.com, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Daniel Hung-yu Wu <hywu@google.com>, Moritz Fischer <moritz.fischer@ettus.com>, Geert Uytterhoeven <geert@linux-m68k.org>, S Twiss <stwiss.opensource@diasemi.com>, Rob Herring <robh@kernel.org>, Grant Grundler <grundler@chromium.org>

On Tue, Jun 14, 2016 at 07:09:50PM +0200, H. Nikolaus Schaller wrote:
> 
> > Am 14.06.2016 um 19:02 schrieb Andrey Utkin <andrey_utkin@fastmail.com>:
> > Update: found drivers/input/joystick/as5011.c in mainline kernel,
> > will look how it works with as5013 hardware.
> 
> Before you spend too much time on it, they have not much in
> common except the manufacturer and the as501x designation.
> 
> Register models (data sheet) are very different.

Thanks for this hint, Nikolaus!

But still, apart from register models I guess as5011 driver is a good
starting point for a fork. I am considering this because
 - as5011 driver has support for button push event, and as5013 doesn't;
 - as5011 driver conforms to mainline standards much better than
   existing out-of-tree as5013 driver. It also conforms to what
   reviewers expect to see: anyway as5013 won't pass review unless all
   tricky modes are dropped. This is according to Arnd reply; Pyra dev
   team member aTc also votes for userspace input management daemon.

I am considering forking instead of adding conditional logic to as5011
because I don't have a chance to test as5011 hardware, so I could break
it unintentionally and never know about that. This is serious because
I'm going to add support of all power modes and other parameters
eventually.

There is one thing which both as5011 and as5013 existing drivers do:
expose a header file in include/linux/input/, with some "struct
blah_blah_platform_data" declaration. This header file is not included
anywhere except for corresponding driver's .c file. So I think this
header file is not needed, and all its contents should be inlined into
single driver's source file. From asking on #kernelnewbies IRC chat, I
gained some confidence that there's no subtleties regarding this.

I guess "struct drivername_platform_data" is something deprecated by
now, as long as there are devicetree files and of_...() API, so I should
port vsense_dt_init() logic from existing as5013 driver?

Also info about GPIO pin for button push interrupt should be added to
devicetree files. Or please indicate that it's not going to have its
GPIO pin for button interrupt - then driver should check button status
at once with periodic position check.
