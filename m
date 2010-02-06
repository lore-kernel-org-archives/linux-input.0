From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] HID: Major update to N-Trig touchscreen
Date: Fri, 05 Feb 2010 19:50:20 -0500
Message-ID: <4B6CBCCC.8010500@seas.upenn.edu>
References: <1265341963-5315-1-git-send-email-rafi@seas.upenn.edu> <20100205055302.GA17121@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:40599 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab0BFAug (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2010 19:50:36 -0500
In-Reply-To: <20100205055302.GA17121@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr, evilynux@gmail.com

> OK, this kind code just makes me want to poke my eyes with a fork... 5
> times...

Terribly sorry about the ensuing spillage of guts, I guess I owe you a pair of glasses.

> Seriously, either factor it out into a nice function, or say "screw it"
> to the 80 columt limit, or maybe both. Anything but this.

I fully agree with your sentiment and am shamed for not reading it carefully after passing it 
through the Lindent script.

Unfortunately I had my editor configured for a tab width of 3 for C, though I'm not even sure why. 
And thus failed to notice the silly degree of indentation in the code.



Anyway, if you're still capable of reading this and the patch, I would appreciate more feedback now 
that I've refactored it a bit.

Rafi
