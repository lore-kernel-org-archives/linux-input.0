From: Timo Aaltonen <tjaalton@cc.hut.fi>
Subject: Re: support for Logitech Wave
Date: Tue, 12 Feb 2008 13:54:36 +0200 (EET)
Message-ID: <alpine.OSF.0.99.0802121353110.326334@replicant.hut.fi>
References: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi>
 <20080116110244.ZZRA012@mailhub.coreip.homeip.net> <20080116215824.GA3797@localhost>
 <Pine.LNX.4.64.0801162259350.15647@twin.jikos.cz>
 <alpine.OSF.0.99.0801170002240.326334@replicant.hut.fi>
 <alpine.OSF.0.99.0802120808070.326334@replicant.hut.fi>
 <Pine.LNX.4.64.0802121233081.7699@twin.jikos.cz>
 <alpine.OSF.0.99.0802121339120.326334@replicant.hut.fi>
 <Pine.LNX.4.64.0802121249000.7699@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-3.hut.fi ([130.233.228.93]:35422 "EHLO smtp-3.hut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbYBLLyy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Feb 2008 06:54:54 -0500
In-Reply-To: <Pine.LNX.4.64.0802121249000.7699@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-input@vger.kernel.org

On Tue, 12 Feb 2008, Jiri Kosina wrote:

> On Tue, 12 Feb 2008, Timo Aaltonen wrote:
>
>>> If all the events are seen by evtest, then everything is fine on the
>>> kernel side and you should just tweak your X configuration.
>> hmm, but X doesn't allow key-id's >255, so I can only wait until they support
>> more? (maybe in X.org R7.5..)
>
> You need to specify "evdev" as the keyboard driver in the xorg.conf input
> device section and the correct input device for your keyboard. Then you
> should be able to get all the keys working correctly in xorg.

Yes, evdev is what I'm using, but I still don't get any events with xev. 
I'll ask the Xorg dev's again about it. IIRC it was a limitation of XKB..

t
