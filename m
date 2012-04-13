From: Tvrtko Ursulin <tvrtko.ursulin@onelan.co.uk>
Subject: Re: Baantoo multi-touch screen trouble
Date: Fri, 13 Apr 2012 10:33:00 +0100
Message-ID: <201204131033.00596.tvrtko.ursulin@onelan.co.uk>
References: <201204111629.59916.tvrtko.ursulin@onelan.co.uk> <201204130902.51885.tvrtko.ursulin@onelan.co.uk> <CAN+gG=HBTO4UvEQ1SVMS1sicHbBDaTP83E9cTUm1M3c9KSechA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claranet-outbound-smtp02.uk.clara.net ([195.8.89.35]:43843 "EHLO
	claranet-outbound-smtp02.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756787Ab2DMJdI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Apr 2012 05:33:08 -0400
In-Reply-To: <CAN+gG=HBTO4UvEQ1SVMS1sicHbBDaTP83E9cTUm1M3c9KSechA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Friday 13 Apr 2012 10:21:22 Benjamin Tissoires wrote:
> Hi,
> 
> Oops, I think I assumed that the features that will come in 3.4 are
> already in 3.3... sorry.
> 
> Once hid-multitouch is loaded, you have to manually tell him to handle
> your device:
> # echo 3 2453 0100 0 >
> /sys/module/hid_multitouch/drivers/hid\:hid-multitouch/new_id
> 
> That should do the trick.

Yep, that makes it work.

Thanks for your help!

If you would want to have any additional data about this panel just shout, I 
will have access to it for a couple of more days.

Tvrtko
