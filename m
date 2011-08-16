From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: [PATCH 0/8 v3] Synaptics image sensor support
Date: Tue, 16 Aug 2011 15:20:44 -0700
Message-ID: <4E4AED3C.7080902@gmail.com>
References: <1313169407-4358-1-git-send-email-djkurtz@chromium.org> <4E4AABC8.4090107@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34005 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab1HPWUu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 18:20:50 -0400
In-Reply-To: <4E4AABC8.4090107@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, olofj@chromium.org, chris@cnpbagwell.com

On 08/16/2011 10:41 AM, Chase Douglas wrote:
> On 08/12/2011 10:16 AM, Daniel Kurtz wrote:
>> Hello,
>>
>> ----
>> For v3:
>>   Merged Patch 5 & 6:
>>      BTN_TOOL_*TAP always reports correct number of fingers.
>>      During certain ambiguous number-of-finger-transitions, there may be less
>>      than 2 valid MT-B slots, even if the BTN_TOOL_*TAP value indicates two or
>>      more fingers are present on the pad.
> 
> I am happy with the patch series. I'm not sure if anyone will actually
> use the MT slots because of all the caveats :), but this driver appears
> to do the best thing I can think of with the data from the device. It
> looks like it was a lot of work to figure it out, so cheers to Daniel!
> 
> At this time I see Henrik has provided two replies and Daniel has
> followed up. The first reply set will cause a small amount of axis
> handling changes, and the second reply about the amount of code changes
> and implementation details of the tracking ids has been rebuffed. If
> this is the end result, you can add my Acked-by to all the patches:
> 
> Acked-by: Chase Douglas <chase.douglas@canonical.com>

I forgot about the change in protocol aspect of this. We still need
documentation stating that when BTN_TOOL_*TAP > max mt slots, the
BTN_TOOL_*TAP events should be used to get the current number of active
touches instead of the number of open MT slots. Would you be able to
send a separate patch for that?

(I'm trying to coerce you into updating the docs partly because you're
touching this area and partly because I'm a bit weary of writing input
protocol docs myself :).

Thanks!

-- Chase
