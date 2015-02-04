From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH v2 3/3] bfin_rotary: replace bfin specific MMR function
 with generic IO function
Date: Wed, 4 Feb 2015 15:23:33 +0800
Message-ID: <CAJxxZ0O9NEEkjruUXjJ_ZD_=8bZqdfwdKJgdpZGRgpkTjgGG8g@mail.gmail.com>
References: <1421225654-27872-1-git-send-email-sonic.adi@gmail.com>
	<1421225654-27872-3-git-send-email-sonic.adi@gmail.com>
	<20150204012423.GD23942@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:58819 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbBDHXe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 02:23:34 -0500
Received: by mail-oi0-f47.google.com with SMTP id a141so15466oig.6
        for <linux-input@vger.kernel.org>; Tue, 03 Feb 2015 23:23:33 -0800 (PST)
In-Reply-To: <20150204012423.GD23942@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

Hi Dmitry,

On Wed, Feb 4, 2015 at 9:24 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Jan 14, 2015 at 04:54:14PM +0800, Sonic Zhang wrote:
>> From: Sonic Zhang <sonic.zhang@analog.com>
>>
>> - use readw and writew to access rotary MMRs
>> - remap rotary register physical address into kernel space in probe
>>
>> v2-changes:
>> - replace kzalloc with devm_kzalloc
>> - replace request_irq with devm_request_irq
>> - remove memory free and irq free from the device remove function
>
> This needs to be split in 2 as these are 2 separate changes - using
> generic IO accessors and converting to use managed resources.
>
> By the way, you can also use devm_input_allocate_device() and not need
> free/unregister it.
>

OK. I will separate this patch and send out new ones.

Thanks,

Sonic
