From: Karl Dahlke <eklhad@comcast.net>
Subject: [PATCH] input/speaker: additional clicks and tones for future...
Date: Wed, 03 Dec 2014 16:02:58 -0500
Message-ID: <20141103160258.eklhad@comcast.net>
References: <20141102001740.eklhad@comcast.net> <20141203195811.GB16951@dtor-ws>
Reply-To: Karl Dahlke <eklhad@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:48326 "EHLO
	resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750840AbaLCVLK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Dec 2014 16:11:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: vojtech@ucw.cz, linux-input@vger.kernel.org

Thank you for your thoughtful reply.

> I do not think it is a good idea to add SND_PULSE as it can be easily
> implemented by SND_TONE.

It isn't that simple.
Example: if a tone is playing for any reason the clicks do not interrupt
the tone. (It would sound terrible, I've tried it).
Clicks and tones are different in spirit and in implementation,
almost orthogonal, and my code manages all this.

> Also, what if you want clicks to go through sound card and not the speaker

But you see, in my world, I precisely don't want that to happen,
because sometimes the sound card isn't working.
There are lots of reasons a sound card might not work,
alsa and modules and pulseaudio are more finicky than you might think,
not to mention the speech adapters that sit on top of them.
If any link in this chain is broken, I get no speech, period.
If I then don't get the clicks or tones either, I'm really lost at sea.
Thus the modules that I write,
and that other people write as well,
specifically send small diagnostics through the pc speaker,
because that just might be all the feedback we have.
Here is a good example, grub, or maybe it's grub2,
can't reasonably be expected to work through a sound card,
so it can actually generate morse code at the pc speaker to help us load
the desired OS.
It's just a different philosophy that we have I guess.
So instead of reinventing these routines over and over I thought it might be
useful to have some of this common functionality in the pcspkr driver
in the kernel.
I mean it's already halfway there, this is just the other half.
All managed just like tones are managed today.
It's just the icing on the cake.

Respectfully,

Karl Dahlke
