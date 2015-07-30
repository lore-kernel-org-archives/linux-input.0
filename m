From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: hid-input: Fix accessing freed memory during driver
 unbind
Date: Wed, 29 Jul 2015 17:10:26 -0700
Message-ID: <20150730001026.GH23178@dtor-ws>
References: <1438042590-17719-1-git-send-email-k.kozlowski@samsung.com>
 <alpine.LNX.2.00.1507291506500.925@pobox.suse.cz>
 <20150729174619.GC23178@dtor-ws>
 <CAJKOXPcsHAj7_pggVw9eeU-C1_zKuZJA7oUodtXp=ZJH4AWg9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33441 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbbG3AKb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 20:10:31 -0400
Content-Disposition: inline
In-Reply-To: <CAJKOXPcsHAj7_pggVw9eeU-C1_zKuZJA7oUodtXp=ZJH4AWg9w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jiri Kosina <jkosina@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux-pm@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>, stable@vger.kernel.org

On Thu, Jul 30, 2015 at 08:42:12AM +0900, Krzysztof Kozlowski wrote:
> 2015-07-30 2:46 GMT+09:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > On Wed, Jul 29, 2015 at 03:07:04PM +0200, Jiri Kosina wrote:
> >> On Tue, 28 Jul 2015, Krzysztof Kozlowski wrote:
> >>
> >> > During unbinding the driver was dereferencing a pointer to memory
> >> > already freed by power_supply_unregister().
> >> >
> >> > Driver was freeing its internal description of battery through pointers
> >> > stored in power_supply structure. However, because the core owns the
> >> > power supply instance, after calling power_supply_unregister() the
> >> > driver cannot access these members.
> >> >
> >> > Fix this by using resource-managed allocations so internal data will be
> >> > freed by pointers stored in resource-managed core.
> >> >
> >> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> > Reported-by: H.J. Lu <hjl.tools@gmail.com>
> >> > Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
> >> > Cc: <stable@vger.kernel.org>
> >>
> >> Applied to for-4.2/upstream-fixes, thanks.
> >
> > Wait, what guarantees do we have that this is only called in probe()
> > paths? Don't we allow hid_hw_start() be deferred to open() calls?
> 
> Indeed, this may be called in other contexts. But this should not
> introduce errors except not reclaimable memory (till remove()
> happens).
> 
> > In general we need to be careful with devm* conversions in core code.
> >
> 
> Another and less intrusive fix would be:
> 
>     char *name = dev->battery->desc->name;
>     struct power_supply_desc *psy_desc = dev->battery->desc;
>     power_supply_unregister(dev->battery);
>     kfree(name);
>     kfree(psy_desc);

I would much rather prefer this to the other version as it does not
leave memory hanging around, potentially indefinitely, but ultimately it
is up to Jiri. I only hope that power supply code does not reference
power_supply_desc pointer past unregister (since the device structure
itself may live past the point where power_supply_unregister() returns).

By the way, you do not need name temp, you can do

	kfree(psy_desc->name);
	kfree(psy_desc);

Thanks.

-- 
Dmitry
