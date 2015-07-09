From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: i2c-HID: Delete unnecessary checks before the function call "gpiod_put"
Date: Thu, 9 Jul 2015 17:21:54 -0400
Message-ID: <CAN+gG=GWeMY67Z0YKWyAQUBGGCrGv=_fNiZko_TD7Bh6t2Ntow@mail.gmail.com>
References: <5307CAA2.8060406@users.sourceforge.net>
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
	<CAN+gG=EWxh3BzOucHwMrxNByy-yEJ8Xc_tW31aiq2rbeSAZ+Rw@mail.gmail.com>
	<559EDE3D.1030409@users.sourceforge.net>
	<CAN+gG=G9xiFUDML6i44mKodW4tiQPgGQ0Ft7oV8RA1JpuuQ1KQ@mail.gmail.com>
	<559EE338.4060107@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <559EE338.4060107@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Jiri Kosina <jkosina@suse.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

On Thu, Jul 9, 2015 at 5:10 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>> The proposed update candidates are contained in the source
>>> file "drivers/hid/i2c-hid/i2c-hid.c" from Linux next-20150708.
>>>
>>> * i2c_hid_remove() function:
>>>   Can it be tolerated here that the pointer "ihid->desc" might be eventually null?
>>>
>>> * i2c_hid_probe() function:
>>>   Is this implementation structured in such a way that a pointer for valid data
>>>   will be usually passed for "ihid->desc" if the statements after the jump
>>>   label "err" will be reached?
>>>
>>
>> Again, in both case it is completely normal to have "ihid->desc ==
>> NULL" given that this field is only retrieved in case of an ACPI
>> device which does not declares an IRQ but a GPIO. Most ACPI devices I
>> saw are using a simple IRQ, and the OF instantiations of the driver
>> will definitively have ihid->desc null. So I do not want to have a
>> warning for most of i2c-hid devices out there (because I will have to
>> explain that this is completely normal again and again).
>
> Would it make sense to annotate checks before such function calls
> as "unlikely" then?
>

I don't see the benefits of this right now. These calls are not time
critical and it's not because today they are few devices with GPIOs
rather than IRQs that it will be the case all the time.
You can always submit a patch preventing coccinelle to raise this
warning, but maybe a simple comment in the code would be enough.

Cheers,
Benjamin
