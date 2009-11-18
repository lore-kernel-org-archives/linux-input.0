From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hx4700: fix hx4700 touchscreen pressure values
Date: Wed, 18 Nov 2009 09:46:49 -0800
Message-ID: <20091118174649.GB4458@core.coreip.homeip.net>
References: <E1NAYJo-00016g-PW@pih-relay04.plus.net> <20091118172849.GD25150@elf.ucw.cz> <20091118173934.GA4458@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:57294 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756972AbZKRRqu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Nov 2009 12:46:50 -0500
Content-Disposition: inline
In-Reply-To: <20091118173934.GA4458@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Paul Parsons <lost.distance@yahoo.com>, linux-input@vger.kernel.org, rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org, Dirk@Opfer-Online.de, arminlitzel@web.de, metan@ucw.cz, thommycheck@gmail.com, linux-arm-kernel@lists.infradead.org, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.y.miao@gmail.com, utx@penguin.cz

On Wed, Nov 18, 2009 at 09:39:34AM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 18, 2009 at 06:28:49PM +0100, Pavel Machek wrote:
> > On Wed 2009-11-18 00:22:41, Paul Parsons wrote:
> > > > Does pressure actually work as expected -- that is not inverted?
> > > > Because I need this patch on spitz...  but it may break your
> > > > machine...
> > > 
> > > You are right, the pressure values were being inverted on my hx4700.
> > > Pressing hard generates somewhat lower Rt values than pressing lightly.
> > > 
> > > Since typical hx4700 Rt values are close to (pressure_max/2) anyway,
> > > the inverted and non-inverted values were not very different.
> > > For example:
> > > 
> > > Rt      ts->pressure_max-Rt
> > > 599     425
> > > 562     462
> > > 588     436
> > > 570     454
> > > 
> > > So by all means submit your ads7846.c patch; it will not break hx4700.
> > 
> > Dmitry, those pressure values are reverted on more than one machine,
> > and we do not have anyone reporting it works ok for them. Can we
> > perhaps just.... fix it?
> 
> OK, so we have 4 instances where pressure is inverted and nobody wants
> to come out with a non-inverted example... I'll queue for .33 then - .32
> it too close to the release.
> 

Btw, could you send me the latest version of your patch please?

-- 
Dmitry
