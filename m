From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 35022: hid-magicmouse broken
Date: Mon, 23 May 2011 11:04:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105231103460.28291@pobox.suse.cz>
References: <4DD26CB8.7070409@canonical.com> <alpine.LNX.2.00.1105171448230.28291@pobox.suse.cz> <4DD2C913.4000403@canonical.com> <alpine.LNX.2.00.1105191357350.28291@pobox.suse.cz> <4DD51763.1020209@canonical.com> <alpine.LNX.2.00.1105191648480.28291@pobox.suse.cz>
 <4DD539E8.8090301@canonical.com> <alpine.LNX.2.00.1105191801540.28291@pobox.suse.cz> <4DD55B55.3020306@canonical.com> <alpine.LNX.2.00.1105201028400.28291@pobox.suse.cz> <4DD666D4.8030802@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:48352 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab1EWJEK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2011 05:04:10 -0400
In-Reply-To: <4DD666D4.8030802@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input <linux-input@vger.kernel.org>, Michael Poole <mdpoole@troilus.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Ott <alan@signal11.us>

On Fri, 20 May 2011, Chase Douglas wrote:

> >> Seems to work for me :).
> > 
> > I have applied the patch with your Tested-by. Thanks,
> 
> Thanks Jiri!
> 
> Could you add 'Cc: stable@kernel.org' if it hasn't been merged yet? It
> looks like .39 was just released without this patch...

I will be sending this patch to stable once it's in Linus tree (I will be 
sending pull request likely today).

-- 
Jiri Kosina
SUSE Labs
