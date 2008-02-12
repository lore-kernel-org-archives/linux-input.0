From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: support for Logitech Wave
Date: Tue, 12 Feb 2008 12:34:18 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802121233081.7699@twin.jikos.cz>
References: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi>
 <20080116110244.ZZRA012@mailhub.coreip.homeip.net> <20080116215824.GA3797@localhost>
 <Pine.LNX.4.64.0801162259350.15647@twin.jikos.cz>
 <alpine.OSF.0.99.0801170002240.326334@replicant.hut.fi>
 <alpine.OSF.0.99.0802120808070.326334@replicant.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:48452 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760799AbYBLLe2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Feb 2008 06:34:28 -0500
In-Reply-To: <alpine.OSF.0.99.0802120808070.326334@replicant.hut.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Timo Aaltonen <tjaalton@cc.hut.fi>
Cc: linux-input@vger.kernel.org

On Tue, 12 Feb 2008, Timo Aaltonen wrote:

> > > yes. Could you please grab reasonably recent kernel 
> > > (2.6.24-rc<anything> would be ok), compile it with CONFIG_HID_DEBUG, 
> > > modprobe the 'hid' module with 'debug=1' parameter, and send me the 
> > > output from the time you connect the keyboard and from pressing the 
> > > non-working keys? It should be trivial to fix then.
> > Hi! I managed to get the event codes with evtest. Here's the output, 
> > followed by mappings to what the buttons really are. The ones that are 
> > mapped below 255 are working on X:
> Jiri, did you notice this post? Is there enough information for you to patch
> the driver?

No, sorry, I missed it, please don't drop me from To:/Cc:, otherwise I am 
likely to miss posts :)

If all the events are seen by evtest, then everything is fine on the 
kernel side and you should just tweak your X configuration.

-- 
Jiri Kosina
