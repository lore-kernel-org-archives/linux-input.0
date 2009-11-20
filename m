From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hx4700: fix hx4700 touchscreen pressure values
Date: Fri, 20 Nov 2009 19:24:05 +0100
Message-ID: <20091120182405.GA1378@ucw.cz>
References: <E1NAYJo-00016g-PW@pih-relay04.plus.net> <20091118172849.GD25150@elf.ucw.cz> <20091118173934.GA4458@core.coreip.homeip.net> <20091118174649.GB4458@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35113 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbZKTSYL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2009 13:24:11 -0500
Content-Disposition: inline
In-Reply-To: <20091118174649.GB4458@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Parsons <lost.distance@yahoo.com>, linux-input@vger.kernel.org, rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org, Dirk@Opfer-Online.de, arminlitzel@web.de, metan@ucw.cz, thommycheck@gmail.com, linux-arm-kernel@lists.infradead.org, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.y.miao@gmail.com, utx@penguin.cz


> > > Dmitry, those pressure values are reverted on more than one machine,
> > > and we do not have anyone reporting it works ok for them. Can we
> > > perhaps just.... fix it?
> > 
> > OK, so we have 4 instances where pressure is inverted and nobody wants
> > to come out with a non-inverted example... I'll queue for .33 then - .32
> > it too close to the release.
> > 
> 
> Btw, could you send me the latest version of your patch please?

Yep, resent in separate mail.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
