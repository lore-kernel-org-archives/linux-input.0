From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 0/4] Current ad7879 patches
Date: Wed, 30 Jun 2010 09:40:54 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E66DFF584@LIMKCMBX1.ad.analog.com>
References: <20100625081847.8617.31150.stgit@localhost.localdomain>
 <544AC56F16B56944AEC3BD4E3D5917712E66DFF408@LIMKCMBX1.ad.analog.com>
 <20100630080345.GC4154@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:23303 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487Ab0F3Ik6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 04:40:58 -0400
In-Reply-To: <20100630080345.GC4154@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>

Dmitry Torokhov wrote on 2010-06-30:
> On Tue, Jun 29, 2010 at 01:10:38PM +0100, Hennerich, Michael wrote:
>> Dmitry Torokhov wrote on 2010-06-25:
>>> Mike, Michael,
>>>
>>> I was looking through outstanding patches to ad7879 and here they are.
>>> Since I made some changes to the patches you wrote and there also some
>>> new code and I do not have the hardware I'd appreciate if you could
>>> try them out so they can be applied.
>>>
>>> Thank you.
>>>
>>
>> Hi Dmitry,
>>
>> I tested your ad7879 patch set -
>> A few issues see patch below.
>>
>> -Fix ad7879_probe() parameter passing. -Add missing input_set_drvdata()
>> -Avoid unbalanced irq enable warning: disable_irq() after request. -Fix
>> sysfs disable hook logic: the file is called disable so don't treat it
>> as enable.
>>
>
> Thanks for catching all the mistakes Michael. Regardgin disable_irq()
> - do you think it would be even better to call __ad7879_disable()
> there to make sure the chip is in low power mode?

Right - __ad7879_disable() is a good option here.

> And I guess we need
> to add matching enable_irq() in error handlig path and in
> ad7879_remove() in case we reload the driver...

I don't see a problem here. free_irq() will take care and unconditional
disable the irq for us. Both the error return as well as the module
remove path will call free_irq().

> BTW, I will be applying the other 2 patches you sent.
>

Thanks

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif

