From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [RFC PATCH 01/06] input/rmi4: Public header and documentation
Date: Tue, 23 Oct 2012 15:10:20 -0700
Message-ID: <508715CC.1000600@synaptics.com>
References: <1349496603-20775-1-git-send-email-cheiny@synaptics.com> <1349496603-20775-2-git-send-email-cheiny@synaptics.com> <CACRpkdZb+LOk8v0aNZuPhATjS5jv-h1JJCejoh_9eFZ_fdiZQA@mail.gmail.com> <20121009082719.GC8237@opensource.wolfsonmicro.com> <BFABBC009FBA1C43B207B15FD485ABD922C22BE7@USW-MAIL1.synaptics-inc.local> <20121012051558.GK11726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx3.synaptics.com ([12.239.217.85]:24350 "EHLO
	us-mx3.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab2JWWKW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Oct 2012 18:10:22 -0400
In-Reply-To: <20121012051558.GK11726@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>

On 10/11/2012 10:16 PM, Mark Brown wrote:
> On Thu, Oct 11, 2012 at 03:56:22AM +0000, Christopher Heiny wrote:
>
> Fix your mailer to word wrap within paragraphs.

Sorry - I was on the road and had to use a web interface.  It looked OK 
during composition.  Is this better?


>> >If this feature is a deal-breaker, we can take it out.  In the absence
>> >of a generic GPIO implementation for CS, though, I'd much rather leave
>> >it in.  Once generic GPIO CS arrives, we'll remove it pretty quickly.
 >
> Why not just implement this at an appropriate level in the SPI
> subsystem?  One of the great things about Linux is that you can change
> the core code...

At the moment, we're trying to keep our work focused on just the core 
RMI4 driver.  It's evident that we've still got a bit to learn, and I'd 
be more comfortable keeping our learning experiences confined as they 
are now.

However, a general capability in SPI core is a fine idea for future 
work, once we get the RMI4 driver ironed out.  Can we agree to defer 
that for now?

					Thanks,
						Chris


