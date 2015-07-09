From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] i2c-HID: Delete unnecessary checks before the function
 call "gpiod_put"
Date: Thu, 9 Jul 2015 14:38:40 -0400
Message-ID: <CAN+gG=EWxh3BzOucHwMrxNByy-yEJ8Xc_tW31aiq2rbeSAZ+Rw@mail.gmail.com>
References: <5307CAA2.8060406@users.sourceforge.net>
	<alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
	<530A086E.8010901@users.sourceforge.net>
	<alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
	<530A72AA.3000601@users.sourceforge.net>
	<alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
	<530B5FB6.6010207@users.sourceforge.net>
	<alpine.DEB.2.10.1402241710370.2074@hadrien>
	<530C5E18.1020800@users.sourceforge.net>
	<alpine.DEB.2.10.1402251014170.2080@hadrien>
	<530CD2C4.4050903@users.sourceforge.net>
	<alpine.DEB.2.10.1402251840450.7035@hadrien>
	<530CF8FF.8080600@users.sourceforge.net>
	<alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
	<530DD06F.4090703@users.sourceforge.net>
	<alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
	<5317A59D.4@users.sourceforge.net>
	<559D8874.7090407@users.sourceforge.net>
	<alpine.LNX.2.00.1507091431470.10183@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37844 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbbGISil (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2015 14:38:41 -0400
In-Reply-To: <alpine.LNX.2.00.1507091431470.10183@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, linux-input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, Jul 9, 2015 at 8:34 AM, Jiri Kosina <jkosina@suse.com> wrote:
> On Wed, 8 Jul 2015, SF Markus Elfring wrote:
>
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Wed, 8 Jul 2015 22:12:25 +0200
>>
>> The gpiod_put() function performs also input parameter validation
>> by forwarding its single input pointer to the gpiod_free() function.
>> Thus the test around the calls is not needed.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>
> As Dan correctly pointed out, this is not as straightforward as it might
> seem on a firsr sight, because there is a WARN_ON() that might start
> triggering in case of !ihid->desc.
>
> Adding Benjamin. I am not applying this without his Ack.
>

I think the gpiod case is the exception rather than the common rule
(most i2c-hid device we saw until recently were using irqs, not
gpios). So if I understand correctly, removing the check on ihid->desc
would raise a warning for most devices. This is IMO not a good thing,
so I would say NACK.

Mika might have a different opinion though.

Cheers,
Benjamin
