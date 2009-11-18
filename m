From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] hx4700: fix hx4700 touchscreen pressure values
Date: Wed, 18 Nov 2009 18:28:49 +0100
Message-ID: <20091118172849.GD25150@elf.ucw.cz>
References: <E1NAYJo-00016g-PW@pih-relay04.plus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40013 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757921AbZKRR3g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Nov 2009 12:29:36 -0500
Content-Disposition: inline
In-Reply-To: <E1NAYJo-00016g-PW@pih-relay04.plus.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>, dtor@mail.ru, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org, Dirk@Opfer-Online.de, arminlitzel@web.de, metan@ucw.cz, thommycheck@gmail.com, linux-arm-kernel@lists.infradead.org, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.y.miao@gmail.com, utx@penguin.cz

On Wed 2009-11-18 00:22:41, Paul Parsons wrote:
> > Does pressure actually work as expected -- that is not inverted?
> > Because I need this patch on spitz...  but it may break your
> > machine...
> 
> You are right, the pressure values were being inverted on my hx4700.
> Pressing hard generates somewhat lower Rt values than pressing lightly.
> 
> Since typical hx4700 Rt values are close to (pressure_max/2) anyway,
> the inverted and non-inverted values were not very different.
> For example:
> 
> Rt      ts->pressure_max-Rt
> 599     425
> 562     462
> 588     436
> 570     454
> 
> So by all means submit your ads7846.c patch; it will not break hx4700.

Dmitry, those pressure values are reverted on more than one machine,
and we do not have anyone reporting it works ok for them. Can we
perhaps just.... fix it?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
