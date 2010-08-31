From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 4/6 v2] HID: magicmouse: remove axis data filtering
Date: Tue, 31 Aug 2010 23:06:19 +0200
Message-ID: <4C7D6ECB.2000308@euromail.se>
References: <1283280068-12285-1-git-send-email-chase.douglas@canonical.com>	 <1283280068-12285-4-git-send-email-chase.douglas@canonical.com>	 <4C7D6739.5000601@euromail.se> <1283288319.2255.103.camel@mini>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:54911 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753970Ab0HaVIL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 17:08:11 -0400
In-Reply-To: <1283288319.2255.103.camel@mini>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Michael Poole <mdpoole@troilus.org>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/31/2010 10:58 PM, Chase Douglas wrote:

> On Tue, 2010-08-31 at 22:34 +0200, Henrik Rydberg wrote:
>> On 08/31/2010 08:41 PM, Chase Douglas wrote:
>>
>>> The Magic Mouse device is very precise. No driver filtering of input
>>> data needs to be performed.
>>>
>>> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
>>> Acked-by: Michael Poole <mdpoole@troilus.org>
>>> ---
>>
>>
>> I am still not sure this is a good idea. Bandwidth from MT devices is a big
>> deal. A statement roughly how much data comes out of mtdev (which does the
>> filtering for type A devices) before and after this change would be reassuring.
> 
> As it is right now, hid-magicmouse doesn't support MT slots. I think all
> the fuzz code ends up comparing in the MT case is between one touch and
> another touch, not between one touch's current location and its previous
> location. If I'm correct, then it means a fuzz > 0 is incorrect for
> non-slotted MT devices.
> 
> In fact, the code in drivers/input/input.c around line 194 looks like it
> discards defuzzing in this case, so one could say this patch is making
> things more correct :).


For type A devices, the filtering is performed in userspace, in mtdev, in the
same manner as it would have been performed in the kernel in the MT slot case.
Therefore, knowing the amount of messages coming out of mtdev is a direct
measurement of the effect of filtering.

> Now a fuzz > 0 for the non-MT ABS axes may be useful, but this device
> exhibits no jitter, and we're not really worried about bandwidth in the
> single touch case.


The jitter is better measured by the actual amount of events.

Henrik
