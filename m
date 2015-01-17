From: Antonio Ospite <ao2@ao2.it>
Subject: About Goodix-TS on Bay Trail, and ACPI and interrupts
Date: Sat, 17 Jan 2015 01:03:06 +0100
Message-ID: <20150117010306.7e32b72524e4c0cf8296bbac@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mathias Nyman <mathias.nyman@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi,

I am trying to make the Goodix driver (drivers/input/touchscreen/goodix.c)
working with a Teclast X98 Air 3G, a tablet based on Intel Bay Trail,
but I am new to ACPI and I could use some help.

I am working with a 3.19-rc4 kernel compiled for x86_64.

This is the DSDT section in the UEFI firmware:

            Device (TCS0)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "GODX0911")  // _HID: Hardware ID
                Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
                Name (_S0W, Zero)  // _S0W: S0 Device Wake State
                Name (_DEP, Package (0x02)  // _DEP: Dependencies
                {
                    GPO1, 
                    I2C5
                })
                Method (_PS3, 0, Serialized)  // _PS3: Power State 3
                {
                    If ((^^^I2C5.PMIC.AVBG == One)) {}
                }

                Method (_PS0, 0, Serialized)  // _PS0: Power State 0
                {
                    If ((^^^GPO1.AVBL == One))
                    {
                        ^^^GPO1.TCD3 = Zero
                    }

                    Sleep (0x05)
                    If ((^^^I2C5.PMIC.AVBG == One)) {}
                    Sleep (0x1E)
                    If ((^^^GPO1.AVBL == One))
                    {
                        ^^^GPO1.TCD3 = One
                    }

                    Sleep (0x78)
                }

                Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, ResourceTemplate ()
                    {
                        I2cSerialBus (0x0014, ControllerInitiated, 0x0019F0A0,
                            AddressingMode7Bit, "\\_SB.I2C4",
                            0x00, ResourceConsumer, ,
                            )
                        GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionInputOnly,
                            "\\_SB.GPO2", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0044
                            }
                    })
                    Name (ABUF, ResourceTemplate ()
                    {
                        I2cSerialBus (0x0014, ControllerInitiated, 0x0019F0A0,
                            AddressingMode7Bit, "\\_SB.I2C4",
                            0x00, ResourceConsumer, ,
                            )
                        GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionInputOnly,
                            "\\_SB.GPO2", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x0044
                            }
                        GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
                            "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x001A
                            }
                    })
                    If ((OSSL && 0x80))
                    {
                        Return (ABUF) /* \_SB_.I2C4.TCS0._CRS.ABUF */
                    }
                    Else
                    {
                        Return (RBUF) /* \_SB_.I2C4.TCS0._CRS.RBUF */
                    }
                }

                Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
                {
                    Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
                    Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                    Debug = "Method _DSM begin"
                    If ((Arg0 == ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))
                    {
                        While (One)
                        {
                            _T_0 = ToInteger (Arg2)
                            If ((_T_0 == Zero))
                            {
                                While (One)
                                {
                                    _T_1 = ToInteger (Arg1)
                                    If ((_T_1 == One))
                                    {
                                        Debug = "Method _DSM Function Query"
                                        Return (Buffer (One)
                                        {
                                             0x03                                             /* . */
                                        })
                                    }
                                    Else
                                    {
                                        Return (Buffer (One)
                                        {
                                             0x00                                             /* . */
                                        })
                                    }

                                    Break
                                }
                            }
                            Else
                            {
                                If ((_T_0 == One))
                                {
                                    Debug = "Method _DSM Function HID"
                                    Return (Zero)
                                }
                                Else
                                {
                                    Return (Zero)
                                }
                            }

                            Break
                        }
                    }
                    Else
                    {
                        Return (Buffer (One)
                        {
                             0x00                                             /* . */
                        })
                    }
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((OSSL == 0x83))
                    {
                        Return (Zero)
                    }

                    Return (0x0F)
                }
            }

BTW in the DSDT there are two TCS0 entries, but the one above should be
the one referring to the actual hardware on my unit, and it's the one
picked up by linux anyway.

Full DSDT here: http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/dsdt.dsl

I added the new ACPI _HID to the Goodix-TS driver and the driver gets
loaded.

I2C communication seems to work fine as I can read the product id, but
the driver probing fails to complete because it cannot request the IRQ.

Here is the full dmesg:
http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/dmesg_Teclast-X98-Air-3G_mainline.log

Grepping for GODX0911 also shows that the i2c-hid driver tries to do
something because of the _DSM method (also _CID == "PNP0C50").

Comparing with Bastien's DSDT I noticed that there is no ACPI Interrupt
resource listed above, and so I thought that linux couldn't get the irq
number from ACPI.

However the Android driver works with IRQs, not in polling mode:
<6>[    7.585262] Goodix_TS 4-0014: GTP I2C Address: 0x14
<6>[    7.585354] Goodix_TS 4-0014: INT gpio 133 to irq 389

Here is the full Android dmesg:
http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/dmesg_Teclast-X98-Air-3G_Android.log

They could have worked around the missing ACPI resource in the code, but
Windows also works on this tablet (I do not have it installed tho).
All the vendor firmwares I found use the same DSDT.

The pinctrl-baytrail driver used for the gpio setup _seems_ to be fine,
i.e. input from other gpios works.

Any ideas?

I tried retrieving the gpio number with devm_gpiod_get_index() from the
GpioIo resource but I am not sure whether this is OK, is that resource
meant to indicate the same "touch" irq which I would have expected in an
Interrupt resource, or are those GpioIo for power/reset?

Patch is here, anyway:
http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/0001-XXX-goodix-add-support-for-GODX0911.patch

Anyhow, even if this approach was OK, or we wanted to use the GpioIo to
control power explicitly, I'd notice that the pin number is 0x44 (hex)
on GPO2 (the third bank), but GPO2 has max 44 (decimal) pins, so it would
be still invalid. 

Obviously I am still missing something.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
