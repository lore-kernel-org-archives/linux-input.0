From: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH/RFC]  Resolve 2 year old issue with different demands
	on EVIOCGRAB
Date: Mon, 25 Aug 2008 09:48:54 +1000
Message-ID: <18609.62310.72394.640097@notabene.brown>
References: <18596.58273.713075.332009@notabene.brown>
	<20080815022453.GA9438@anvil.corenet.prv>
	<18600.51093.613662.435395@notabene.brown>
	<20080818112609.ZZRA012@mailhub.coreip.homeip.net>
	<18604.45689.859491.192621@notabene.brown>
	<20080822160414.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:43875 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbYHXXtD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Aug 2008 19:49:03 -0400
In-Reply-To: message from Dmitry Torokhov on Friday August 22
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday August 22, dmitry.torokhov@gmail.com wrote:
> 
> Maybe openmoko could just patch mousedev to ignore touchscreens for
> now, until X is fixed?

Maybe.  And in fact it already is!
As I delved further in to this issue, I find that not only is there a
patch in tslib to use EVIOCGRAB, but there is also a patch in the
kernel to exclude the "ABS_X + ABS_Y + BTN_TOUCH" case from mousedev,
making the EVIOCGRAB patch pointless.
And there might even be another patch in the kdrive Xserver to use
EVIOCGRAB in a different context (which might not actually be being
used, I'm not sure).  A twisted maze of little passages, all
twisted. :-)

But I am firmly against carrying patches like this which cannot go
upstream.  They can lead to subtle incompatibilities and can be hard
to get rid of.  I much prefer a solution that can work for everyone,
and I currently think the BTN_TOUCH -> BTN_STYLUS change is that
solution.  It remains to be seen which I can push into the openmoko
source tree :-)

Thanks,
NeilBrown
