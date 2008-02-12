From: Timo Aaltonen <tjaalton@cc.hut.fi>
Subject: Re: support for Logitech Wave
Date: Tue, 12 Feb 2008 13:42:40 +0200 (EET)
Message-ID: <alpine.OSF.0.99.0802121339120.326334@replicant.hut.fi>
References: <alpine.OSF.0.99.0801151541290.326334@replicant.hut.fi>
 <20080116110244.ZZRA012@mailhub.coreip.homeip.net> <20080116215824.GA3797@localhost>
 <Pine.LNX.4.64.0801162259350.15647@twin.jikos.cz>
 <alpine.OSF.0.99.0801170002240.326334@replicant.hut.fi>
 <alpine.OSF.0.99.0802120808070.326334@replicant.hut.fi>
 <Pine.LNX.4.64.0802121233081.7699@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-3.hut.fi ([130.233.228.93]:33985 "EHLO smtp-3.hut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762907AbYBLLnB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Feb 2008 06:43:01 -0500
In-Reply-To: <Pine.LNX.4.64.0802121233081.7699@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-input@vger.kernel.org

On Tue, 12 Feb 2008, Jiri Kosina wrote:

> On Tue, 12 Feb 2008, Timo Aaltonen wrote:
>
>>>> yes. Could you please grab reasonably recent kernel
>>>> (2.6.24-rc<anything> would be ok), compile it with CONFIG_HID_DEBUG,
>>>> modprobe the 'hid' module with 'debug=1' parameter, and send me the
>>>> output from the time you connect the keyboard and from pressing the
>>>> non-working keys? It should be trivial to fix then.
>>> Hi! I managed to get the event codes with evtest. Here's the output,
>>> followed by mappings to what the buttons really are. The ones that are
>>> mapped below 255 are working on X:
>> Jiri, did you notice this post? Is there enough information for you to patch
>> the driver?
>
> No, sorry, I missed it, please don't drop me from To:/Cc:, otherwise I am
> likely to miss posts :)

Ah ok, sorry about that :)

> If all the events are seen by evtest, then everything is fine on the
> kernel side and you should just tweak your X configuration.

hmm, but X doesn't allow key-id's >255, so I can only wait until they 
support more? (maybe in X.org R7.5..)

t
