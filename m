From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Input: tsc200x - Report proper input_dev name
Date: Wed, 20 Jul 2016 09:48:51 +0200
Message-ID: <20160720074851.GA9577@amd>
References: <20160720014424.GI19250@dtor-ws>
 <1468986592-4973-1-git-send-email-mwelling@ieee.org>
 <20160720063106.GB3792@amd>
 <20160720065024.GA8428@deathstar>
 <20160720065405.GD3792@amd>
 <20160720070617.GA8911@deathstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57993 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbcGTHsy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 03:48:54 -0400
Content-Disposition: inline
In-Reply-To: <20160720070617.GA8911@deathstar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Wed 2016-07-20 02:06:17, Michael Welling wrote:
> On Wed, Jul 20, 2016 at 08:54:05AM +0200, Pavel Machek wrote:
> > > By same logic we shouldn't change from TSC200X back to TSC2005 because of
> > > people's possibly new setup in the last 9 months.
> > 
> > That's your, broken logic.
> > 
> > TSC200X->TSC2005 needs to be fixed, because people seen the TSC2005
> > for past few years.
> > 
> > TSC200X->TSC2004 is just introducing regression, because noone ever
> > seen TSC2004, AFAICT.
> 
> I am pretty sure no one cares. Escpecially me.

Dunno. Lets do the right thing: TSC2005 for 2005, TSC200X for everyone
else. Interface issues are tricky to handle once created, so its best
to be careful.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
