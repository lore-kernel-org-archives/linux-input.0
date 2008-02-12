From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: support for Logitech Wave
Date: Tue, 12 Feb 2008 12:49:36 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802121249000.7699@twin.jikos.cz>
References: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi>
 <20080116110244.ZZRA012@mailhub.coreip.homeip.net> <20080116215824.GA3797@localhost>
 <Pine.LNX.4.64.0801162259350.15647@twin.jikos.cz>
 <alpine.OSF.0.99.0801170002240.326334@replicant.hut.fi>
 <alpine.OSF.0.99.0802120808070.326334@replicant.hut.fi>
 <Pine.LNX.4.64.0802121233081.7699@twin.jikos.cz>
 <alpine.OSF.0.99.0802121339120.326334@replicant.hut.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:49775 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbYBLLtk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Feb 2008 06:49:40 -0500
In-Reply-To: <alpine.OSF.0.99.0802121339120.326334@replicant.hut.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Timo Aaltonen <tjaalton@cc.hut.fi>
Cc: linux-input@vger.kernel.org

On Tue, 12 Feb 2008, Timo Aaltonen wrote:

> > If all the events are seen by evtest, then everything is fine on the
> > kernel side and you should just tweak your X configuration.
> hmm, but X doesn't allow key-id's >255, so I can only wait until they support
> more? (maybe in X.org R7.5..)

You need to specify "evdev" as the keyboard driver in the xorg.conf input 
device section and the correct input device for your keyboard. Then you 
should be able to get all the keys working correctly in xorg.

-- 
Jiri Kosina
