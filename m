From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 2/5] hid: huion: Invert in-range on specific product
Date: Wed, 23 Jul 2014 17:40:16 +0300
Message-ID: <53CFC950.90703@gmail.com>
References: <1406119378-24551-1-git-send-email-spbnick@gmail.com>	<1406119378-24551-3-git-send-email-spbnick@gmail.com> <CAN+gG=F3ddT4kgHPMhvMgOFNf0Z29utAPJWsnVWuB98xbZ0gKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:38018 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964AbaGWOkU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 10:40:20 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so1291194wgh.5
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 07:40:19 -0700 (PDT)
In-Reply-To: <CAN+gG=F3ddT4kgHPMhvMgOFNf0Z29utAPJWsnVWuB98xbZ0gKA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 07/23/2014 05:34 PM, Benjamin Tissoires wrote:
> On Wed, Jul 23, 2014 at 8:42 AM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
>> Limit inverting the in-range bit in raw reports to tablet product ID
>> only. This will make adding handling of other, non-tablet products,
>> easier.
>>
>> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
>> ---
>
> I am not particularly a big fan of this one. You are here adding a
> test which will be called at each raw_event but currently only tablet
> products are bound to hid-huion. Even in the rest of the series, you
> add another VID/PID, but it still has the same PID.
>
> So I would say that this will be nice to have when we really have the
> problem, not now.
>
> But if you tell me that you already have the need for it, I am fine
> with it. It's just that this commit message + the rest of the patch
> series makes me feel like this is just a superflous test.
>
> So, in its current state:
> NACK

I had doubts about this one myself, but left it in just for consistency with
some other drivers. I'll drop it in the next version then.

Thank you.

Nick
