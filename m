From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH] hid: huion: Fix sparse warnings
Date: Tue, 29 Jul 2014 16:24:08 +0300
Message-ID: <53D7A078.8050206@gmail.com>
References: <alpine.LNX.2.00.1407291121530.16390@pobox.suse.cz> <1406638206-6108-1-git-send-email-spbnick@gmail.com> <alpine.LNX.2.00.1407291504370.16390@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:51700 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaG2NYP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 09:24:15 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so9033165wes.31
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 06:24:14 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1407291504370.16390@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On 07/29/2014 04:06 PM, Jiri Kosina wrote:
> On Tue, 29 Jul 2014, Nikolai Kondrashov wrote:
>
>> Fix sparse warnings in hid-huion.c by using correct buffer type for
>> retrieved string descriptor.
>>
>> The warnings in question were:
>>
>>      drivers/hid/hid-huion.c:144:44: sparse: cast to restricted __le16
>>      drivers/hid/hid-huion.c:145:44: sparse: cast to restricted __le16
>>      drivers/hid/hid-huion.c:146:51: sparse: cast to restricted __le16
>>      drivers/hid/hid-huion.c:147:30: sparse: cast to restricted __le16
>
> Interestingly enough, my sparse doesn't seem to report this problem
> (running sparse is part of my machinery before pushing anything out).

The above only appears with CF=-D__CHECK_ENDIAN__.

>> If you wouldn't like adding a tiny patch like this, I can send another version
>> of the original patches. Otherwise, please feel free to just fixup my "Switch
>> to generating report descriptor" commit with this one.
>
> Yup, I'll be applying this on top of your previous one.

Thanks!

Nick
