From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: About Goodix-TS on Bay Trail, and ACPI and interrupts
Date: Mon, 19 Jan 2015 10:37:58 -0500
Message-ID: <20150119153758.GA18115@mail.corp.redhat.com>
References: <20150117010306.7e32b72524e4c0cf8296bbac@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45446 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbbASPiI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Jan 2015 10:38:08 -0500
Content-Disposition: inline
In-Reply-To: <20150117010306.7e32b72524e4c0cf8296bbac@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@intel.com>

Hi Antonio,

[adding Mika in CC, he implemented most of the ACPI and GPIO for
i2c-hid]

On Jan 17 2015 or thereabouts, Antonio Ospite wrote:
> Hi,
> 
> I am trying to make the Goodix driver (drivers/input/touchscreen/goodix.c)
> working with a Teclast X98 Air 3G, a tablet based on Intel Bay Trail,
> but I am new to ACPI and I could use some help.
> 
> I am working with a 3.19-rc4 kernel compiled for x86_64.
> 
> This is the DSDT section in the UEFI firmware:
> 
>             Device (TCS0)
>             {
>                 Name (_ADR, Zero)  // _ADR: Address
>                 Name (_HID, "GODX0911")  // _HID: Hardware ID
>                 Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID

urgh, this is bad. It declares itself as i2c-hid, but it is not :(
Anyway, according to your logs, i2c-hid probe() just fails, so it's not
a big problem.

>                 Name (_S0W, Zero)  // _S0W: S0 Device Wake State
>                 Name (_DEP, Package (0x02)  // _DEP: Dependencies
>                 {
>                     GPO1, 
>                     I2C5
>                 })
>                 Method (_PS3, 0, Serialized)  // _PS3: Power State 3
>                 {
>                     If ((^^^I2C5.PMIC.AVBG == One)) {}
>                 }
> 
>                 Method (_PS0, 0, Serialized)  // _PS0: Power State 0
>                 {
>                     If ((^^^GPO1.AVBL == One))
>                     {
>                         ^^^GPO1.TCD3 = Zero
>                     }
> 
>                     Sleep (0x05)
>                     If ((^^^I2C5.PMIC.AVBG == One)) {}
>                     Sleep (0x1E)
>                     If ((^^^GPO1.AVBL == One))
>                     {
>                         ^^^GPO1.TCD3 = One
>                     }
> 
>                     Sleep (0x78)
>                 }
> 
>                 Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>                 {
>                     Name (RBUF, ResourceTemplate ()
>                     {
>                         I2cSerialBus (0x0014, ControllerInitiated, 0x0019F0A0,
>                             AddressingMode7Bit, "\\_SB.I2C4",
>                             0x00, ResourceConsumer, ,
>                             )
>                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionInputOnly,
>                             "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>                             )
>                             {   // Pin list
>                                 0x0044
>                             }
>                     })
>                     Name (ABUF, ResourceTemplate ()
>                     {
>                         I2cSerialBus (0x0014, ControllerInitiated, 0x0019F0A0,
>                             AddressingMode7Bit, "\\_SB.I2C4",
>                             0x00, ResourceConsumer, ,
>                             )
>                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionInputOnly,
>                             "\\_SB.GPO2", 0x00, ResourceConsumer, ,
>                             )
>                             {   // Pin list
>                                 0x0044
>                             }
>                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                             )
>                             {   // Pin list
>                                 0x001A
>                             }
>                     })

It looks like the GPIOs are correctly declared. The ACPI code should set
the client->irq auto-magically. It's not the case, so I guess Mika
should be able to tell us more on that.


>                     If ((OSSL && 0x80))
>                     {
>                         Return (ABUF) /* \_SB_.I2C4.TCS0._CRS.ABUF */
>                     }
>                     Else
>                     {
>                         Return (RBUF) /* \_SB_.I2C4.TCS0._CRS.RBUF */
>                     }
>                 }
> 
>                 Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>                 {
>                     Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
>                     Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
>                     Debug = "Method _DSM begin"
>                     If ((Arg0 == ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))
>                     {
>                         While (One)
>                         {
>                             _T_0 = ToInteger (Arg2)
>                             If ((_T_0 == Zero))
>                             {
>                                 While (One)
>                                 {
>                                     _T_1 = ToInteger (Arg1)
>                                     If ((_T_1 == One))
>                                     {
>                                         Debug = "Method _DSM Function Query"
>                                         Return (Buffer (One)
>                                         {
>                                              0x03                                             /* . */
>                                         })
>                                     }
>                                     Else
>                                     {
>                                         Return (Buffer (One)
>                                         {
>                                              0x00                                             /* . */
>                                         })
>                                     }
> 
>                                     Break
>                                 }
>                             }
>                             Else
>                             {
>                                 If ((_T_0 == One))
>                                 {
>                                     Debug = "Method _DSM Function HID"
>                                     Return (Zero)
>                                 }
>                                 Else
>                                 {
>                                     Return (Zero)
>                                 }
>                             }
> 
>                             Break
>                         }
>                     }
>                     Else
>                     {
>                         Return (Buffer (One)
>                         {
>                              0x00                                             /* . */
>                         })
>                     }
>                 }
> 
>                 Method (_STA, 0, NotSerialized)  // _STA: Status
>                 {
>                     If ((OSSL == 0x83))
>                     {
>                         Return (Zero)
>                     }
> 
>                     Return (0x0F)
>                 }
>             }
> 
> BTW in the DSDT there are two TCS0 entries, but the one above should be
> the one referring to the actual hardware on my unit, and it's the one
> picked up by linux anyway.
> 
> Full DSDT here: http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/dsdt.dsl
> 
> I added the new ACPI _HID to the Goodix-TS driver and the driver gets
> loaded.
> 
> I2C communication seems to work fine as I can read the product id, but
> the driver probing fails to complete because it cannot request the IRQ.
> 
> Here is the full dmesg:
> http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/dmesg_Teclast-X98-Air-3G_mainline.log
> 
> Grepping for GODX0911 also shows that the i2c-hid driver tries to do
> something because of the _DSM method (also _CID == "PNP0C50").

Yeah. Actually, it should bail out earlier because client->irq is -1.
I guess we should change the first test to be "if (client->irq <= 0) {
goto err;}".

> 
> Comparing with Bastien's DSDT I noticed that there is no ACPI Interrupt
> resource listed above, and so I thought that linux couldn't get the irq
> number from ACPI.
> 
> However the Android driver works with IRQs, not in polling mode:
> <6>[    7.585262] Goodix_TS 4-0014: GTP I2C Address: 0x14
> <6>[    7.585354] Goodix_TS 4-0014: INT gpio 133 to irq 389

IIRC, the ACPI generic code would bind the first GPIO as the interrupt
resource. It does not, so either something is wrong in the DSDT, or
something is wrong in the GPIO/IRQ association.

> 
> Here is the full Android dmesg:
> http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/dmesg_Teclast-X98-Air-3G_Android.log
> 
> They could have worked around the missing ACPI resource in the code, but
> Windows also works on this tablet (I do not have it installed tho).
> All the vendor firmwares I found use the same DSDT.
> 
> The pinctrl-baytrail driver used for the gpio setup _seems_ to be fine,
> i.e. input from other gpios works.
> 
> Any ideas?
> 
> I tried retrieving the gpio number with devm_gpiod_get_index() from the
> GpioIo resource but I am not sure whether this is OK, is that resource
> meant to indicate the same "touch" irq which I would have expected in an
> Interrupt resource, or are those GpioIo for power/reset?
> 
> Patch is here, anyway:
> http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/0001-XXX-goodix-add-support-for-GODX0911.patch
> 
> Anyhow, even if this approach was OK, or we wanted to use the GpioIo to
> control power explicitly, I'd notice that the pin number is 0x44 (hex)
> on GPO2 (the third bank), but GPO2 has max 44 (decimal) pins, so it would
> be still invalid. 
> 
> Obviously I am still missing something.
> 

I hope Mika will be more helpful than I can be. This whole ACPI parsing
and setting is too deep in acpica for me, unfortunately.

Cheers,
Benjamin

