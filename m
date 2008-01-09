From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: evdev soft lockup 2.6.24-rc5-mm1
Date: Wed, 09 Jan 2008 11:30:08 +0100
Message-ID: <4784A230.8080906@gmail.com>
References: <47848CF5.8000107@gmail.com> <Pine.LNX.4.64.0801091107200.25041@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:32687 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbYAIKaM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jan 2008 05:30:12 -0500
Received: by fg-out-1718.google.com with SMTP id e21so209521fga.17
        for <linux-input@vger.kernel.org>; Wed, 09 Jan 2008 02:30:11 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801091107200.25041@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: Dmitry Torokhov <dtor@mail.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org

On 01/09/2008 11:11 AM, Jiri Kosina wrote:
> On Wed, 9 Jan 2008, Jiri Slaby wrote:
> 
>> BUG: soft lockup - CPU#1 stuck for 11s! [X:2887]
> [ ... ]
>> Call Trace:
>>  [<ffffffff804e7648>] __mutex_lock_slowpath+0x38/0xd0
>>  [<ffffffff804e747e>] mutex_lock+0x1e/0x30
>>  [<ffffffff8040c497>] input_release_device+0x27/0x50
>>  [<ffffffff804102aa>] evdev_ungrab+0x3a/0x50
>>  [<ffffffff804103eb>] evdev_release+0xcb/0xd0
>>  [<ffffffff80293460>] __fput+0xc0/0x230
>>  [<ffffffff802938a6>] fput+0x16/0x20
>>  [<ffffffff80290296>] filp_close+0x56/0x90
>>  [<ffffffff80291afa>] sys_close+0x9a/0xf0
>>  [<ffffffff8020ba4e>] system_call+0x7e/0x83
>> I was not able to use sysrq keys, the keyboard is obviously defunct. If 
>> this is not known, I'll try to turn lockdep on and maybe connect through 
>> ssh next time it happens.
> 
> Is this reproducible on your side? 

not 100%, it happens occasionally.

> Running with lockdep would be really helpful, so that we possibly know who 
> is holding the other instance of dev->mutex.

I'll try my best.
