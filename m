From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2]-V2 Add touch screen input driver for TPS6507x family of multi-function chips.
Date: Wed, 07 Apr 2010 09:24:24 -0700
Message-ID: <87ljczdydj.fsf@deeprootsystems.com>
References: <1270511593-4785-1-git-send-email-todd.fischer@ridgerun.com>
	<20100407084644.GB2962@sortiz.org>
	<874ojnfdlt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:49147 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932621Ab0DGQYc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Apr 2010 12:24:32 -0400
Received: by bwz1 with SMTP id 1so995145bwz.21
        for <linux-input@vger.kernel.org>; Wed, 07 Apr 2010 09:24:31 -0700 (PDT)
In-Reply-To: <874ojnfdlt.fsf@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 07 Apr 2010 09\:10\:06 -0700")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Todd Fischer <todd.fischer@ridgerun.com>, davinci-linux-open-source@linux.davincidsp.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, linux-input@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Samuel Ortiz <sameo@linux.intel.com> writes:
>
>> Hi Todd, hi Kevin,
>>
>> On Mon, Apr 05, 2010 at 05:53:11PM -0600, Todd Fischer wrote:
>>> 
>>> This is the second posting of the TPS6507x touch screen driver. I have
>>> incorporated Kevin Hilman's request to split the board specific changes
>>> into a separate patch.

[...]

>>
>> I've applied patch #1 of this patchset. Kevin, would you please take patch #2?
>
> Thanks.  Yes, patch #2 will be queued for linux-next and 2.6.35.

After trying to apply this, I ran into some snags

The other series '[PATCH 0/4]-V3 TPS6507x MFD driver' also had some
board file changes mixed in that I did not catch, and patch #2 of this
series depends on those.

So either we split those out and merge them via my tree, or you can
just merge patch #2 of this series via your tree as well.

I'm OK with either option, but just merging patch #2 of this series
via your tree seems like the least amount of hassle at this time.

If you merge via your tree, please add:

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Kevin
