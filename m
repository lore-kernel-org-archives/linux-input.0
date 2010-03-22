From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Route kbd LEDs through the generic LEDs layer (5th
	version)
Date: Mon, 22 Mar 2010 09:39:02 +0100
Message-ID: <20100322083902.GB4917@atrey.karlin.mff.cuni.cz>
References: <20100307200250.GA9340@const.famille.thibault.fr> <20100310133004.GM5127@const.bordeaux.inria.fr> <20100321210938.GB2057@elf.ucw.cz> <20100321211653.GS12469@const.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:45300 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752350Ab0CVIjE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 04:39:04 -0400
Content-Disposition: inline
In-Reply-To: <20100321211653.GS12469@const.famille.thibault.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-found


> > root@amd:/sys/class/leds/input5::numl# echo heartbeat > trigger
> > 
> > did not do the trick on my thinkpad. It still acts as numlock led. Is
> > it driven by hw? input5::capsl works as expected.
> 
> If it is a laptop, it is likely, depending on the BIOS & such.
> On my laptop, doing this works fine.

Thinkpad x60. And yes, since it also changes behaviour of "jkl" keys,
it seems to be something strange with the hardware.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
