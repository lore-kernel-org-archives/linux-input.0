From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] leds-alix2: add support for button connected to J15
Date: Sun, 18 Oct 2009 11:56:52 +0100
Message-ID: <1255863412.27878.136.camel@ted>
References: <20091016130315.GT28832@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753394AbZJRK5M@vger.kernel.org>
In-Reply-To: <20091016130315.GT28832@buzzloop.caiaq.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Constantin Baranov <const@mimas.ru>
List-Id: linux-input@vger.kernel.org

Hi,

On Fri, 2009-10-16 at 15:03 +0200, Daniel Mack wrote:
> for a project I was working on, we used the J15 connector of the ALIX.2D
> board (which is connected to a GPIO of the CS5536 Geode companion chip)
> for an external button switch.
> 
> I thought it might be worth sharing this piece of code, so others can do
> the same.
> 
> There is, however, a small hardware modification is necessary as the pin
> is also shared as buzzer output. I noted that in the Kconfig entry.
> 
> The patch should go thru Richard's led-2.6.git as it depends on another
> one that has been queued there already.

How common is this modification? I'm just trying to get a feel for the
number of users out there of this feature...

Cheers,

Richard

-- 
Richard Purdie
Intel Open Source Technology Centre
