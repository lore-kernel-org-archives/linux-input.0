From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 0/2] Cleanup and fix touch_down implementation
Date: Fri, 27 Feb 2015 12:32:12 -0800
Message-ID: <CAF8JNhJ8FRRYgWYypEo8DYy94JAo3t7H6m4UJywP95gu3ny9HQ@mail.gmail.com>
References: <1424471119-4628-1-git-send-email-pingc@wacom.com>
	<alpine.LNX.2.00.1502270838120.19920@pobox.suse.cz>
	<CAF8JNhLmYCM3LmAeDoM+Hg9Wts5xmYpWAFzZGzBD3qOUWostFg@mail.gmail.com>
	<alpine.LNX.2.00.1502272118290.19920@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:64004 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbbB0UcN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 15:32:13 -0500
Received: by mail-vc0-f181.google.com with SMTP id le20so452156vcb.12
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2015 12:32:12 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1502272118290.19920@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

On Fri, Feb 27, 2015 at 12:18 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 27 Feb 2015, Ping Cheng wrote:
>
>> >> before sending pen events. This idea has been implemented for
>> >> Tablet PCs. But other tablets that support both pen and touch are
>> >> not fully considered.
>> >>
>> >> Ping Cheng (2):
>> >>   HID: wacom: do not send pen events before touch is up/forced out
>> >>   HID: wacom: rely on actual touch down count to decide touch_down
>> >
>> > Ping, looking at the code, I think this both should go into 4.0 still
>> > (i.e. not postponed for the next merge window), as it's purely fixes.
>> >
>> > Could you please confirm that for me?
>>
>> Sure, they can go to 4.0.
>
> The question rather is "do they absolutely have to?" :)

I patched them under for-3.20/upstream-fixes in hope of merging them
sooner. Sounds like getting in 4.0 is quicker.

Anyway, the sooner we can get them merged upstream, the better, since
they are bug fixes.

Cheers,

PIng
