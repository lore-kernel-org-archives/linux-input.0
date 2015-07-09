From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: i2c-HID: Delete unnecessary checks before the function call
 "gpiod_put"
Date: Thu, 9 Jul 2015 22:49:01 +0200
Message-ID: <559EDE3D.1030409@users.sourceforge.net>
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
 <5317A59D.4@users.sourceforge.net> <559D8874.7090407@users.sourceforge.net>
 <alpine.LNX.2.00.1507091431470.10183@pobox.suse.cz>
 <CAN+gG=EWxh3BzOucHwMrxNByy-yEJ8Xc_tW31aiq2rbeSAZ+Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:61416 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107AbbGIUtT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jul 2015 16:49:19 -0400
In-Reply-To: <CAN+gG=EWxh3BzOucHwMrxNByy-yEJ8Xc_tW31aiq2rbeSAZ+Rw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

>>> The gpiod_put() function performs also input parameter validation
>>> by forwarding its single input pointer to the gpiod_free() function.
>>> Thus the test around the calls is not needed.
>>>
>>> This issue was detected by using the Coccinelle software.
>>>
>>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>>
>> As Dan correctly pointed out, this is not as straightforward as it might
>> seem on a firsr sight, because there is a WARN_ON() that might start
>> triggering in case of !ihid->desc.
>>
>> Adding Benjamin. I am not applying this without his Ack.
>>
> 
> I think the gpiod case is the exception rather than the common rule
> (most i2c-hid device we saw until recently were using irqs, not
> gpios). So if I understand correctly, removing the check on ihid->desc
> would raise a warning for most devices. This is IMO not a good thing,
> so I would say NACK.
> 
> Mika might have a different opinion though.

The proposed update candidates are contained in the source
file "drivers/hid/i2c-hid/i2c-hid.c" from Linux next-20150708.

* i2c_hid_remove() function:
  Can it be tolerated here that the pointer "ihid->desc" might be eventually null?

* i2c_hid_probe() function:
  Is this implementation structured in such a way that a pointer for valid data
  will be usually passed for "ihid->desc" if the statements after the jump
  label "err" will be reached?

Regards,
Markus
