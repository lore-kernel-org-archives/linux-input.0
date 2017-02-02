From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the GPIO
 when using ACPI pm
Date: Thu, 2 Feb 2017 13:50:58 +0100
Message-ID: <d4a9ad28-d6a8-5714-ddae-510c1f61f3c6@redhat.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
 <20170122222015.GA31009@dtor-ws>
 <8a23b7b2-a7aa-d62d-947d-31301a0c92cc@redhat.com>
 <20170201174257.GE40045@dtor-ws> <20170202104130.GJ2053@lahna.fi.intel.com>
 <8e91084e-e0ea-b055-5c62-67a4e0e56df4@redhat.com>
 <20170202121018.GN2053@lahna.fi.intel.com>
 <20170202123206.GP2053@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbdBBMvC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Feb 2017 07:51:02 -0500
In-Reply-To: <20170202123206.GP2053@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Hi,

On 02-02-17 13:32, Mika Westerberg wrote:
> On Thu, Feb 02, 2017 at 02:10:18PM +0200, Mika Westerberg wrote:
>> I do not have a copy of the patch in this thread but sounds like
>> something that might work.
>
> Actually, I seem have a copy of that patch.
>
> So you are saying that the device has a power GPIO in ACPI _CRS but it
> should not be used for some reason?

Yes, it should not be used as it is controlled by the _PS0 and _PS3
functions. It is reserved for firmware use by setting a special
bit indicating this in the gpio pin's control register in the intel
cherrytrail gpio controller. So arguably it should not be in _CRS
at all, since the OS is supposed to not touch it, yet it is there:

             Device (TCS4)
             {
                 Name (_ADR, Zero)  // _ADR: Address
                 Name (_HID, "MSSL1680")  // _HID: Hardware ID
                 Name (_CID, "PNP1680")  // _CID: Compatible ID
                 Name (_S0W, Zero)  // _S0W: S0 Device Wake State
                 Name (_DDN, "MSSL1680")  // _DDN: DOS Device Name

<snip>

                 Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                 {
                     If (^^^^GPO1.AVBL == One)
                     {
                         ^^^^GPO1.TCTL = One
                     }

                     Sleep (0x78)
                 }

                 Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                 {
                     If (^^^^GPO1.AVBL == One)
                     {
                         ^^^^GPO1.TCTL = One
                     }

                     Sleep (0x05)
                     If (^^^^GPO1.AVBL == One)
                     {
                         ^^^^GPO1.TCTL = Zero
                     }

                     Sleep (0x1E)
                     If (^^^^GPO1.AVBL == One)
                     {
                         ^^^^GPO1.TCTL = Zero
                     }

                     Sleep (0x78)
                 }

                 Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Setti
                 {
                     Name (WBUF, ResourceTemplate ()
                     {
                         I2cSerialBusV2 (0x0040, ControllerInitiated, 0x00061A80,
                             AddressingMode7Bit, "\\_SB.PCI0.I2C6",
                             0x00, ResourceConsumer, , Exclusive,
                             )
                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestri
                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                             )
                             {   // Pin list
                                 0x0019
                             }
                         GpioInt (Edge, ActiveHigh, Shared, PullDefault, 0x0000,
                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                             )
                             {   // Pin list
                                 0x0013
                             }
                     })
                     Return (WBUF) /* \_SB_.PCI0.I2C6.TCS4._CRS.WBUF */
                 }

The setting of the special bit in the gpio control register leads to
drivers/pinctrl/intel/pinctrl-cherryview.c chv_gpio_request_enable()
returning -EBUSY, which in return makes gpiod_get_optional
return -EBUSY for this pin, rather then NULL (as we would like).

Regards,

Hans


