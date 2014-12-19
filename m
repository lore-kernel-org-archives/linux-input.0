From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/3] HID: logitech-{dj,hidpp}: check report length
Date: Fri, 19 Dec 2014 11:48:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1412191147100.1680@pobox.suse.cz>
References: <1418691016-30681-1-git-send-email-peter@lekensteyn.nl> <1418691016-30681-3-git-send-email-peter@lekensteyn.nl> <CAN+gG=HWqpy6MUfWvwBavk+EkmwbBiCCN0L1_i8H61WYRU0yGw@mail.gmail.com> <9001812.kk9brShn75@al>
 <CAN+gG=EL0kYim=_uaS4yj7c_XC8rKa1eELxpVXaOuvnWgT_eQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57298 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbaLSKsp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Dec 2014 05:48:45 -0500
In-Reply-To: <CAN+gG=EL0kYim=_uaS4yj7c_XC8rKa1eELxpVXaOuvnWgT_eQw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Peter Wu <peter@lekensteyn.nl>, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 16 Dec 2014, Benjamin Tissoires wrote:

> This is my personal opinion and Jiri can say something different. I
> tend not to send big patches while there is a window opened. Sometimes
> Jiri has the time to get through them, sometime he does not.
> In this case, I think the patches you sent should be in the bugs fixes
> categories, and, IMO should make into 3.19-rc1 or 3.19-rc2 (especially
> the length check which could lead to CVEs if not tackled soon enough).
> For these kind of things there is no timing, and the sooner the
> better.
> That being said, make sure that you keep track of those patches in
> case they get lost for obvious reasons and be prepared to remind about
> them if they do not make their way in Jiri's tree.
> 
> Jiri, comments?

I don't mind patches being sent during a merge window, it doesn't disturb 
my workflow.

But it's always good to explicitly mark patches which are bugfixes and 
should go to -rc, so that I bump up the priority for reviewing them.

Thanks,

-- 
Jiri Kosina
SUSE Labs
