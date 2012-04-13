From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Baantoo multi-touch screen trouble
Date: Fri, 13 Apr 2012 14:42:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204131442050.16373@pobox.suse.cz>
References: <201204111629.59916.tvrtko.ursulin@onelan.co.uk> <201204130902.51885.tvrtko.ursulin@onelan.co.uk> <CAN+gG=HBTO4UvEQ1SVMS1sicHbBDaTP83E9cTUm1M3c9KSechA@mail.gmail.com> <201204131033.00596.tvrtko.ursulin@onelan.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40471 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755571Ab2DMMm0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Apr 2012 08:42:26 -0400
In-Reply-To: <201204131033.00596.tvrtko.ursulin@onelan.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

On Fri, 13 Apr 2012, Tvrtko Ursulin wrote:

> > Oops, I think I assumed that the features that will come in 3.4 are
> > already in 3.3... sorry.
> > 
> > Once hid-multitouch is loaded, you have to manually tell him to handle
> > your device:
> > # echo 3 2453 0100 0 >
> > /sys/module/hid_multitouch/drivers/hid\:hid-multitouch/new_id
> > 
> > That should do the trick.
> 
> Yep, that makes it work.
> 
> Thanks for your help!
> 
> If you would want to have any additional data about this panel just shout, I 
> will have access to it for a couple of more days.

Guys, who of you is going to send me patch adding the device ID into 
in-kernel list?

Thanks,

-- 
Jiri Kosina
SUSE Labs
