From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: [PATCH 3/3] input: gpio_keys: Make use of the device property API
Date: Mon, 29 Feb 2016 16:24:16 +0000
Message-ID: <CA+V1LzqX7_r1YuBCHSVLbjmp=6Ra=fi+mnVjNGzNhdvEDgXh2Q@mail.gmail.com>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
	<1455876982-6743-4-git-send-email-geert+renesas@glider.be>
	<20160222195815.GB28343@dtor-ws>
	<CA+V1Lzrag5QPAPjjhqp8R6uUG4NPb9sG7axiJoBGk4q=ozXV0w@mail.gmail.com>
	<20160229081723.GB1770@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35602 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbcB2QYR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Feb 2016 11:24:17 -0500
In-Reply-To: <20160229081723.GB1770@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org

>
> Both DT and ACPI provide means to assign GPIOs to devices. We can then
> use Linux APIs to query those. For example getting GPIO with name
> "reset" is done like:
>
>         struct gpio_desc *reset_desc;
>
>         reset_desc = gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>
> This will retrieve the GPIO using firmware description (ACPI, DT) if
> available. No need to deal with the GPIO numbers.

Hi Mika,
Thanks for reply,

But how then to obtain gpio name or if it is possible the list of all
available names?
For example decoded ACPI DSDT shows the following:
how to get gpio name for mentioned in your reply function?
Does it according below DSDT should be "GPO1" or "INT33FC" or something other?
Kind regards,
                       Serge Kolotylo.

 Device (TCS5)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "CHPN0001")  // _HID: Hardware ID
                Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus)
*/)  // _CID: Compatible ID
                Name (_S0W, Zero)  // _S0W: S0 Device Wake State
                Name (_DEP, Package (0x02)  // _DEP: Dependencies
                {
                    GPO1,
                    I2C5
                })
                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                }

                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    If ((^^^GPO1.AVBL == One))
                    {
                        ^^^GPO1.TCD3 = Zero
                    }

                    Sleep (0x05)
                    If ((^^^I2C5.PMI1.AVBG == One))
                    {
                        ^^^I2C5.PMI1.TCON = One
                    }

                    Sleep (0x1E)
                    If ((^^^GPO1.AVBL == One))
                    {
                        ^^^GPO1.TCD3 = One
                    }

                    Sleep (0x78)
                }

and GPO1 descr

  Device (GPO1)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_HID, "INT33FC" /* Intel Baytrail GPIO Controller
*/)  // _HID: Hardware ID
            Name (_CID, "INT33FC" /* Intel Baytrail GPIO Controller
*/)  // _CID: Compatible ID
            Name (_DDN, "ValleyView GPNCORE controller")  // _DDN: DOS
Device Name
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0xFED0D000,         // Address Base
                        0x00001000,         // Address Length
                        )
                    Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
                    {
                        0x00000030,
                    }
                })
                Return (RBUF) /* \_SB_.GPO1._CRS.RBUF */
            }

            Name (AVBL, Zero)
            Method (_REG, 2, NotSerialized)  // _REG: Region Availability
            {
                If ((Arg0 == 0x08))
                {
                    AVBL = Arg1
                }
            }

            OperationRegion (GPOP, GeneralPurposeIo, Zero, 0x0C)
            Field (GPOP, ByteAcc, NoLock, Preserve)
            {
                Connection (
                    GpioIo (Exclusive, PullDefault, 0x0000, 0x0000,
IoRestrictionOutputOnly,
                        "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x000F
                        }
                ),
                BST5,   1,
                Connection (
                    GpioIo (Exclusive, PullDefault, 0x0000, 0x0000,
IoRestrictionOutputOnly,
                        "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                        )
                        {   // Pin list
                            0x001A
                        }
                ),
                TCD3,   1
            }
