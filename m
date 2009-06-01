From: Jeremy Huddleston <jeremyhu@freedesktop.org>
Subject: Re: [PATCH] appletouch: Improved finger detection
Date: Mon, 1 Jun 2009 00:35:53 -0700
Message-ID: <A0EA7857-9F51-44DE-8A88-80733F6057A9@freedesktop.org>
References: <3AC3E247-D85C-4D8A-A73B-34677C32C2D5@freedesktop.org> <20090508025839.GC30616@dtor-d630.eng.vmware.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cloud.CS.Berkeley.EDU ([128.32.36.234]:49594 "EHLO
	mail.outersquare.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbZFAHfx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jun 2009 03:35:53 -0400
In-Reply-To: <20090508025839.GC30616@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, johannes@sipsolutions.net, jasonparekh@gmail.com


On May 7, 2009, at 19:59, Dmitry Torokhov wrote:

> HI Jeremy,
>
> On Tue, May 05, 2009 at 12:10:34PM -0700, Jeremy Huddleston wrote:
>> The appletouch driver is prone to reporting multiple fingers when  
>> only
>> one is
>> pressing.  The appletouch driver queries an array of pressure sensors
>> and
>> counts local maxima in pressure to determine the number of  
>> fingers.  It
>> just
>> does this on the raw values, so a data stream like:
>>
>> 0 100 250 300 299 300 250 100 0
>>
>> actually registers as 2 fingers.
>>
>> This patch updates the logic to ignore small dips in pressure that  
>> are
>> less
>> than the threshold.
>>
>
> Does it still detect 2 fingers as 2 fingers when they are held  
> together?

I just wanted to follow up on this patch[1], since I haven't seen any  
movement.  It's fairly trivial and I've been using it for the past  
month with great success (yes, it still detects 2 fingers properly).   
Is there hope that this change can get merged soon?

Thanks,
Jeremy

1: http://launchpadlibrarian.net/26305586/appletouch.patch

