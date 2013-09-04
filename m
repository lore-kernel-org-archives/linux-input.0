From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 11/14] HID: multitouch: validate feature report details
Date: Wed, 4 Sep 2013 11:57:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309041155460.3684@pobox.suse.cz>
References: <alpine.LNX.2.00.1308282221440.22181@pobox.suse.cz> <521F0D5F.7040108@redhat.com> <CAGXu5jKkzWmMZeckmO6BeKnJs-AjrFuZvqWNxDa6Rjb7UzAeyw@mail.gmail.com> <CAN+gG=EvuO4R2d=bj=_9aWo1e96ee_i0sqSDJNd=3h+dVf=oWQ@mail.gmail.com>
 <CAGXu5jKAob5s1vs5s974QsJWdje2rQgyz=PVACxW3aWiJWiEEA@mail.gmail.com> <CAN+gG=Fx5bjcPndRSBBJTvZFC2GOegigkzL3De8iK7vauiPq1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47924 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934478Ab3IDJ51 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 05:57:27 -0400
In-Reply-To: <CAN+gG=Fx5bjcPndRSBBJTvZFC2GOegigkzL3De8iK7vauiPq1g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

On Mon, 2 Sep 2013, Benjamin Tissoires wrote:

> > Given the 12 flaws, what do you see as the best way forward?
> 
> If Jiri thinks we can wait one more week for some of these patches (I
> know that the most critical one, 1/14 is already on its way to Linus),
> then I can handle the v2, but not before Friday. Again, I think the
> current patch series is perfectly fine for distributions as they can
> add/remove things more easily than we can do in master.

I agree.

1/14 will go to Linus shortly. The rest is public, and distributions are 
taking it depending on their requirements, but I'd like to have the 
patchset polished before pushing it to Linus.

Therefore putting the rest on hold now, and waiting for v2.

Thanks a lot to both of you,

-- 
Jiri Kosina
SUSE Labs
