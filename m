From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Route kbd LEDs through the generic LEDs layer (5th
 version)
Date: Sun, 21 Mar 2010 22:09:38 +0100
Message-ID: <20100321210938.GB2057@elf.ucw.cz>
References: <20100307200250.GA9340@const.famille.thibault.fr>
 <20100310133004.GM5127@const.bordeaux.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:56492 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753470Ab0CUVJt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Mar 2010 17:09:49 -0400
Content-Disposition: inline
In-Reply-To: <20100310133004.GM5127@const.bordeaux.inria.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-found

Hi!

> Route keyboard LEDs through the generic LEDs layer.
> 
> This permits to reassign keyboard LEDs to something else than keyboard "leds"
> state, by adding keyboard led and modifier triggers connected to a series
> of global input LEDs, themselves connected to global input triggers, which
> per-input device LEDs use by default.  Userland can thus easily change the LED
> behavior of (a priori) all input devices, or of particular input devices.
> 
> This also permits to fix #7063 from userland by using a modifier to implement
> proper CapsLock behavior and have the keyboard caps lock led show that modifier
> state.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

I like it.

Tested-by: Pavel Machek <pavel@ucw.cz>

Now, minor comments:

sometimes it uses "numl" (led name), sometimes it uses "numlock"
trigger name.

root@amd:/sys/class/leds/input5::numl# echo heartbeat > trigger

did not do the trick on my thinkpad. It still acts as numlock led. Is
it driven by hw? input5::capsl works as expected.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
