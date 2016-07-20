From: Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH] Input: tsc200x - Report proper input_dev name
Date: Wed, 20 Jul 2016 02:06:17 -0500
Message-ID: <20160720070617.GA8911@deathstar>
References: <20160720014424.GI19250@dtor-ws>
 <1468986592-4973-1-git-send-email-mwelling@ieee.org>
 <20160720063106.GB3792@amd>
 <20160720065024.GA8428@deathstar>
 <20160720065405.GD3792@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33358 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbcGTHG2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 03:06:28 -0400
Content-Disposition: inline
In-Reply-To: <20160720065405.GD3792@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Wed, Jul 20, 2016 at 08:54:05AM +0200, Pavel Machek wrote:
> > By same logic we shouldn't change from TSC200X back to TSC2005 because of
> > people's possibly new setup in the last 9 months.
> 
> That's your, broken logic.
> 
> TSC200X->TSC2005 needs to be fixed, because people seen the TSC2005
> for past few years.
> 
> TSC200X->TSC2004 is just introducing regression, because noone ever
> seen TSC2004, AFAICT.

I am pretty sure no one cares. Escpecially me.

> 
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
