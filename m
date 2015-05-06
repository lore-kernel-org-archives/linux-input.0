From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/5] hid: sony: Add support for the Sony Motion Controller
Date: Wed, 6 May 2015 11:31:04 +0200
Message-ID: <20150506093104.GA5153@amd>
References: <1430793272-11545-1-git-send-email-frank.praznik@oh.rr.com>
 <1430793272-11545-3-git-send-email-frank.praznik@oh.rr.com>
 <20150505211640.GA10272@amd>
 <20150505213606.GB15218@amd>
 <20150505214736.GA16332@amd>
 <5549543E.2030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41470 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbbEFJbG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 May 2015 05:31:06 -0400
Content-Disposition: inline
In-Reply-To: <5549543E.2030101@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org, jkosina@suse.cz

On Tue 2015-05-05 19:37:34, Frank Praznik wrote:
> On 5/5/2015 17:47, Pavel Machek wrote:
> >If it has just one motor, should it say so in the description? Not
> >advertising both heavy and light motor.
> >
> 
> The FF_RUMBLE flag exposes two motors by default and there doesn't seem to
> be a way to change it.
> 
> This is how the Wiimote with a single motor works (FF_RUMBLE and treating
> the strong/weak motors as one).  Would one of the other effects be more
> suitable?

I don't know enough about the force feedback subsystem, sorry. I guess
it is okay as it is, then... Thanks for all the work!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
