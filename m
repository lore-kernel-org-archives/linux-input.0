From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: How to use ACPI for touchscreen
Date: Sun, 28 Feb 2016 22:30:21 +0000
Message-ID: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36461 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbcB1WaW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Feb 2016 17:30:22 -0500
Received: by mail-qg0-f50.google.com with SMTP id y9so104641822qgd.3
        for <linux-input@vger.kernel.org>; Sun, 28 Feb 2016 14:30:21 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi ALL,
Please help or reference with the following:

Howto use ACPI for touchscreen:

  1) is it possible to detect via ACPI GPIO pin to INT/WAKE Touch?
   2) If yes how to find out equivalent of this gpio pin in
/sys/class/gpio? (to have userspace interface to it via export
gpioPINNUMBER> /sys/class/gpio/export
3) From the bellow DSDT table touch is dependant from I2C5  while
i2c-dev creates devices i2c-0...i2c-4. Does this mean that in ACPI
base is 1 and I2C5 is identical to i2c-4 dev ?


As input additional info - I have decoded under 4.4.2 vanilla kernel
x86_64 the following DSDT:
touch related area: (chipone icn 8528).

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

                Method (_CRS, 0, NotSerialized)  // _CRS: Current
Resource Settings
                {
                    Name (RBUF, ResourceTemplate ()
                    {
                        I2cSerialBus (0x0030, ControllerInitiated, 0x00061A80,
                            AddressingMode7Bit, "\\_SB.I2C4",
                            0x00, ResourceConsumer, ,
                            )
                        Interrupt (ResourceConsumer, Level,
ActiveHigh, Exclusive, ,, )
                        {
                            0x00000044,
                        }
                        GpioIo (Exclusive, PullDefault, 0x0000,
0x0000, IoRestrictionOutputOnly,
                            "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                            )
                            {   // Pin list
                                0x001A
                            }
                    })
                    Return (RBUF) /* \_SB_.I2C4.TCS5._CRS.RBUF */
                }

                Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
                {
                    Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
                    Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                    Debug = "Method _DSM begin"
                    If ((Arg0 == ToUUID
("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))
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
                                             0x03
                       /* . */
                                        })
                                    }
                                    Else
                                    {
                                        Return (Buffer (One)
                                        {
                                             0x00
                       /* . */
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
                             0x00
       /* . */
                        })
                    }
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If ((OSSL & 0x80))
                    {
                        Return (Zero)
                    }

                    If ((OSYS == 0x07DD))
                    {
                        Return (0x0F)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }
            }
        }


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

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }
        }

Kind regards,
                     Serge Kolotylo.
