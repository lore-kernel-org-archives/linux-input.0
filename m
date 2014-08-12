From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCHES] HID: huion: Fix "doing dma on the stack"
Date: Tue, 12 Aug 2014 13:05:39 +0300
Message-ID: <53E9E6F3.3040005@gmail.com>
References: <1407779132-26749-1-git-send-email-spbnick@gmail.com> <alpine.LNX.2.00.1408121126560.15220@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:33353 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbaHLKFm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 06:05:42 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so9818883wev.12
        for <linux-input@vger.kernel.org>; Tue, 12 Aug 2014 03:05:41 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1408121126560.15220@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 08/12/2014 12:27 PM, Jiri Kosina wrote:
> On Mon, 11 Aug 2014, Nikolai Kondrashov wrote:
>
>> Hi everyone,
>>
>> These two patches work towards fixing the "doing dma on the stack" reported by
>> a static analyzer (I'm not sure which one) for my recent changes to hid-huion
>> driver.
>>
>> The first one is easier to read with whitespace changes ingored (-w).
>>
>> Both patches were tested by me with a Huion H610N tablet.
>>
>> Nick
>
> Nikolai,
>
> thanks, I will be reviewing the patches soon and queuing for 3.17 still
> eventually.

Thanks, Jiri.

> They seem to be missing your signoff though ... is that on purpose?

No, I forgot it, sorry. Would you like me to re-send them with my signoff?

Otherwise:

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>

Nick
