From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC 0/8] HID: Transport Driver Cleanup
Date: Wed, 31 Jul 2013 10:57:36 +0200
Message-ID: <CANq1E4TTKgVtCp0t3h0SKhHqyfGePBxz_B3NZpD+FDjLgmbpEQ@mail.gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
	<alpine.LNX.2.00.1307311035320.18809@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:57163 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759418Ab3GaI5h (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Jul 2013 04:57:37 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so964163oag.28
        for <linux-input@vger.kernel.org>; Wed, 31 Jul 2013 01:57:36 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1307311035320.18809@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

Hi Jiri

On Wed, Jul 31, 2013 at 10:38 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 15 Jul 2013, David Herrmann wrote:
>
>> This series provides some cleanups for HID transport drivers:
>
> Hi David,
>
> thanks a lot for your work, again.
>
> I have now applied all the patches from the series, except for:
>
> - 3/8, waiting for v2

Ugh, patches 4-6 use the generic helper from 3 implicitly. So with the
current tree, they will not be able to send any LED events. I think my
conclusion in the discussion on #3 was wrong. I cannot rebase it on
the end of the series. Sorry, I missed that.

For v2, as mentioned in the thread, I cannot write a generic fallback
for hid_hw_request() without patch #8. That's because the transport
drivers handle the raw reports differently. #8 fixes that.

So imho we should apply #3 as it is now. If we ever have a generic
hid_hw_request(), we can just move the code from the LED handler to
hid_hw_request_generic().

> - 7/8, waiting for v2 as well, plus haven't finished reviewing it fully
> - 8/8, still thinking about it and reviewing

They're both RFC so no hurry. Especially Patch #8 depends highly on
the ideas in #7 which will change according to Benjamin's comments in
v2.

Thanks for applying the first few fixes. Sorry for the confusion in
#3. I'd vote for applying it directly, Benjamin, what do you think?
I was busy the last few weeks, but I will have time to work on this
again starting next week.

Regards
David
