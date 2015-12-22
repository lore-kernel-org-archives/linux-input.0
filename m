From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [PATCH] HID: sensor-hub: Add quirk for Lenovo Yoga 900 with ITE Chips
Date: Tue, 22 Dec 2015 07:50:57 -0800
Message-ID: <CAOhV88PeREu=ywVz4M38=_B200Ztu6moHSjA5Scqc44-v-mhbA@mail.gmail.com>
References: <1450463680-10400-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<alpine.LNX.2.00.1512221427230.9922@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34314 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787AbbLVPu5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Dec 2015 10:50:57 -0500
Received: by mail-yk0-f180.google.com with SMTP id p130so167619278yka.1
        for <linux-input@vger.kernel.org>; Tue, 22 Dec 2015 07:50:57 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1512221427230.9922@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org

On Tue, Dec 22, 2015 at 5:27 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Fri, 18 Dec 2015, Srinivas Pandruvada wrote:
>
>> This needs same quirk as applied to other YOGA sensor hubs.
>> Refer to
>> 47eeca8a48 (" HID: sensor-hub: Add in quirk for Lenovo Yogas with ITE")
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Tested-by: Nishanth Aravamudan <nish.aravamudan@gmail.com>
>
> I got a bit lost here ... what's the status of this patch? Nishanth later
> reported that the patch actually doesn't fix the issue for him, so?
That's my fault. It does seem like the patch is necessary. It's
possible there is some other issue whereby the sensors aren't always
in the proper state. I'm still debugging that. But without Srinivas'
patch, it never works and with it, it at least sometimes does.

-Nish
