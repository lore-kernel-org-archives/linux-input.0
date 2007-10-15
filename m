From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Generic, platform independent matrix keyboard support
Date: Sun, 14 Oct 2007 17:18:07 -0700
Message-ID: <200710141718.08136.david-b@pacbell.net>
References: <200709021228.58354.ppisa4lists@pikron.com> <d120d5000710100610n50d7c62cuf365ad0d2ded5916@mail.gmail.com> <200710142257.03872.ppisa4lists@pikron.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710142257.03872.ppisa4lists@pikron.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pavel Pisa <ppisa4lists@pikron.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Sascha Hauer <s.hauer@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-input@vger.kernel.org

On Sunday 14 October 2007, Pavel Pisa wrote:
> I would be much more happy, if such pressure for generality would
> be pushed into directions where such universality makes more sense.
> GPIO is an example. It would be great if there would be support to test
> if pin can become input, output, has pull-up and or OC support
> and if these options could be controlled portable way.

Test if it can be an input or output by calling the function to
set the direction, and seeing if it fails.  Simple, portable.

Pullups/pulldowns are platform-specific pin mux issues, along
with configuring pins as GPIOs.  That is, it needs a separate
programming interface.  See the note in Documentation/gpio.txt
talking about the range of platform variation there ... that
isn't very amenable to a cross-platform interface.

I don't know what you mean by "OC support".  OverCurrent?
"Open Collector" would be TTL-specific, and TTL isn't used
much with VLSI.  "Obstetric Cholestasis" is what Google
suggested, but I rather doubt that's what you mean.  ;)


> These things 
> are common on most of todays chips (even on 8-bit MCUs) and
> pull-ups are required to prevent extraordinary power consumption
> caused by floating input pins.

True but irrelevant.  That is a *PIN* specific interface, and
the fact that some platforms can route a given GPIO to multiple
pins illustrates exactly why it needs a separate interface (not
a GPIO interface).  Plus, whether or not an on-chip pullup should
be used (vs external ones) is a *BOARD* specific decision.

- Dave
