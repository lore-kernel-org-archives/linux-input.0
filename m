From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Report correct device resolution when using
 the wireless adapater
Date: Mon, 10 Aug 2015 23:54:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508102353110.27871@pobox.suse.cz>
References: <1438814693-12051-1-git-send-email-killertofu@gmail.com> <alpine.LNX.2.00.1508101045010.27871@pobox.suse.cz> <55C8E724.3030906@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43118 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933350AbbHJVyi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2015 17:54:38 -0400
In-Reply-To: <55C8E724.3030906@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 10 Aug 2015, Jason Gerecke wrote:

> This bug was exposed by an update to libinput which makes it more
> reliant on accurate resolution values. It is a regression in our code,
> but one which has gone unnoticed for quite some time. I've tracked its
> introduction to somewhere between 3.11 and 3.13, and having looked at
> the commits in that range believe that 401d7d1 (merged in 3.12) is
> likely the culprit. That commit replaced a function which calculated the
> resolution as part of the input device registration process with one
> that calculates it as part of the probe process after the HID descriptor
> is read (which doesn't do us any good in the wireless case).
> 
> Fixing this in 4.2 ensures that this bug doesn't tickle libinput any
> longer than necessary. It would also be nice to backport this patch to
> stable, but I'm not sure if it quite meets the necessary severity standards.

Thanks for elaborting on this, Jason. I will be looking into this a little 
bit more, but am applying to for-4.2/upstream-fixes-devm-fixed in any 
case (my current plan is to send this to Linus this week due to devm 
memory corruption fix, and let this patch piggy-back on it).

-- 
Jiri Kosina
SUSE Labs

