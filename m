From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 00/13] Input/HID: Bits and Pieces
Date: Mon, 4 Nov 2013 14:04:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311041403300.2779@pobox.suse.cz>
References: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47798 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751970Ab3KDNEV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Nov 2013 08:04:21 -0500
In-Reply-To: <1383336984-26601-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Fri, 1 Nov 2013, David Herrmann wrote:

> My backlog kept growing and most of the stuff depends on the ABS_* fixes, so I
> gave it another try. The first 2 patches introduce EVIOC[GS]ABS2 and friends.
> The rest is wiimote stuff that was laying around for some time and just needs
> new ABS bits. So once the ABS stuff is in, I see no reason to delay the wiimote
> patches (as they're even tested already). Hence, I put it all in a single
> series.
> 
> Jiri, Dmitry, feel free to bribe me to split / not split the series so the
> other one has to take it through their tree. Highest bid wins!

I am fine with the HID changes, but Dmitry definitely needs to Ack the 
ABS_MAX2 stuff.

After that is done, I can either take the series through my tree with his 
Ack, or vice versa, I don't really have strong opinion there.

> And I am still running tests, so please don't merge, yet. I will report back my
> results. Besides, it's probably too late for 3.13, anyway and we should put it
> into -next for 3.14 for some while.

Thanks,

-- 
Jiri Kosina
SUSE Labs
