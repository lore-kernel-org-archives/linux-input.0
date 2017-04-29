From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v5] Input: psxpad-spi - Add PSX (Play Station 1/2) pad
 SPI driver
Date: Sat, 29 Apr 2017 23:10:30 +0200
Message-ID: <1493500230.22420.6.camel@hadess.net>
References: <20170429094053.26870-1-sylph23k@gmail.com>
         <20170429181604.GA5562@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170429181604.GA5562@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tomohiro Yoshidomi <typesylph@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, sylph23k@gmail.com
List-Id: linux-input@vger.kernel.org

Hey,

On Sat, 2017-04-29 at 11:16 -0700, Dmitry Torokhov wrote:
> "Say Y here if you wish to connect PSX (PS1/2) pad via SPI
> interface."

It should say "PlayStation 1/2 joypads". Using "Play Station" is
incorrect, PSX is a code name so you could mention it in between
brackets. Saying "pads" is also possibly confusing, Wacom tablets have
"pads", they're "joypads".

> Let's call it "PSX gamepad force feedback (rumble) support"

This should probably mention that it's force feedback support for the
PlayStation joypads when connected via SPI. Maybe it could be
automatically enabled if both the above driver is enabled and force
feedback is as well? That would save having to describe it too
verbosely.

A code comment: how does the output of this device compare to the
output of USB PlayStation adapters? It would be interesting to double-
check that what comes out of the kernel when connected either way is
the same.

Maybe Benjamin has captures for those adapters?

Cheers
