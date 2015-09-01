From: Yuasa Yoichi <yuasa@linux-mips.org>
Subject: Re: [PATCH v5] input: Add ROHM BU21023/24 Dual touch support
 resistive touchscreens
Date: Tue, 1 Sep 2015 23:15:34 +0900
Message-ID: <CACBHAezcMF06URzd0PiJYaJx15r7bTyCRgan=GGO5W9PuMfEFw@mail.gmail.com>
References: <20141205181739.3f3da16b1573c891cf49ba68@linux-mips.org>
	<20150115013558.GA37437@dtor-ws>
	<CACBHAeywdgzS=SbyXmR--VZop9fANeS4JRTRbDg0hKj6xV6SZw@mail.gmail.com>
	<20150807180614.279d6d9104c5a5110d8071dd@linux-mips.org>
	<20150829004556.GD8298@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36662 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbbIAOPe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Sep 2015 10:15:34 -0400
Received: by oibi136 with SMTP id i136so58028oib.3
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2015 07:15:34 -0700 (PDT)
In-Reply-To: <20150829004556.GD8298@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Yoichi Yuasa <yuasa@linux-mips.org>

Hi Dmitry,

2015-08-29 9:45 GMT+09:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Yoichi,
>
> On Fri, Aug 07, 2015 at 06:06:14PM +0900, Yoichi Yuasa wrote:
>> v5 Changes:
>> - contact count variables move to array
>> - remove unneeded u16 casts in #define
>> - remove module parameters
>> - handle "no fingers" as same as others
>> - move devm_request_thread_irq() from open() to probe()
>> - move "power off" from remove() to close()
>
> You must have sent me some interim version because it could not have
> worked for you. For example, you pass 'ts' pointer to
> devm_request_theraded_irq() before allocating memory for ts, you also
> treat sysfs attributes as if they were attached to input device
> structure while you are creating them (as you should) at i2c dveice
> level.

I'm sorry, I sent the wrong version.

> Also, handling of sysfs attributes is racy with regard to open/close. I
> tried correcting these issues (and also made some stylistic changes,
> please see an incremental patch below). If you could integrate it with
> your work and test to make sure it actually works with the hardware that
> would be great.

I'll check your patch and I'll update my patch soon.

Thanks a lot,

Yoichi
