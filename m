From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] CHROMIUM: Input: synaptics - filter out the events with
 low z values
Date: Wed, 22 Feb 2012 12:04:59 +0100
Message-ID: <20120222110459.GA28126@polaris.bitmath.org>
References: <1329896503-28394-1-git-send-email-cywang@chromium.org>
 <20120222083858.GA26570@polaris.bitmath.org>
 <CAGS+omCU9f=DyC442+4HOF=sGhZYXne+E2ephFiOmuj-XKciMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:39291 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152Ab2BVLFM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Feb 2012 06:05:12 -0500
Content-Disposition: inline
In-Reply-To: <CAGS+omCU9f=DyC442+4HOF=sGhZYXne+E2ephFiOmuj-XKciMA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Chung-yih Wang <cywang@chromium.org>, Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Daniel,

> > So if num_fingers == 2 and only one of a and b returns
> > finger_touched() == true, we fall back to zero fingers?
> 
> Actually, yes.   In this case, we will have 2 x's and 2 y's, but not
> know which belong to a good finger and which belong to a too light
> finger....  sigh... synaptics... sigh...

I see the problem. However, ignoring it will just move the problem
forward to another bug report, will it not?  Hysteresis is a slam dunk
here.  In addition, since the low-pressure state is bound to be
transitional (soon to be followed by a real num_fingers==1 package),
simply skipping such packages might be a better option.

> > Why not introduce hysteresis for all fingers here? There is an example
> > implementation in bcm5974.c in the same directory.
> 
> Good idea, can it be in a different, follow-up patch?

Why should it be?

Thanks,
Henrik
