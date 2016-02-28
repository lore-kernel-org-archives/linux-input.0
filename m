From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Sun, 28 Feb 2016 01:38:58 +0000
Message-ID: <CA+V1Lzqve1CiRy9=WhOqNG6S5qc0fnyzbwRnLH29rhJuMbdEdA@mail.gmail.com>
References: <CA+V1LzoXvWO1FROO2z7tFc-0zoM_Ur+B1iiar+EJ4uvn+DWGdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35668 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992634AbcB1Bi7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Feb 2016 20:38:59 -0500
Received: by mail-qg0-f41.google.com with SMTP id y89so92578074qge.2
        for <linux-input@vger.kernel.org>; Sat, 27 Feb 2016 17:38:59 -0800 (PST)
In-Reply-To: <CA+V1LzoXvWO1FROO2z7tFc-0zoM_Ur+B1iiar+EJ4uvn+DWGdQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,
Just would like to add the following:
There is driver for icn8318 in vanilla kernel.
On Chuwi Vi10 looks that INT/WAKE gpio pin is gpio393 (vanila 4.4.2 x86_64 krnl)
I have firmware for it from Windows driver (separate file).
I have some specs for Chipone ICN88xx (which is the same as 85xx).

:( I have stucked with understanding how to initialize this chip.
At the moment trying to do this via sysfs + i2c-tools.
In Android have read main registers data, when the chip is initialized.

There are also sources for Linux but arm-based platforms:

https://github.com/bbelos/rk3188-kernel/tree/master/drivers/input/touchscreen/ICN8503
http://dl.linux-sunxi.org/SDK/A80/A80_SDK_20140728_stripped/lichee/linux-3.4/drivers/input/touchscreen/icn83xx/

Will be happy if someone would like to help or join efforts of
building the driver for icn85xx on Linux vanilla kernel.
Regards,
                   Serge Kolotylo.


ACPI data:

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

Regards,
                Serge Kolotylo.

On Sun, Feb 14, 2016 at 11:03 PM, sergk sergk2mail
<sergk.admin@gmail.com> wrote:
> Hello All,
> Please advice whether it is supported touch screen icn85xx in anykind
> of x86 (baytrail interested in!) kernel?
>
> I have discovered in Vanilla chipone_icn8318.c  kernel driver from Hans de Goede
> but this driver in contrast to arm available icn83xx.c looks really
> strange, it is even excluded from Kconfig by default in 4.4.1: it has
> no firmware load while at the same time android driver
> https://android.googlesource.com/kernel/bcm/+/android-bcm-tetra-3.10-lollipop-wear-release/drivers/input/touchscreen/icn83xx.c
> has.
> Also for rtk3128 chip there is!  icn85xx driver:
> https://github.com/bbelos/rk3188-kernel/blob/master/drivers/input/touchscreen/ICN8503/icn85xx.c
>
> I am trying to make it working my touch on Chuwi Vi10 (Baytrail
> Z3536), Archlinux, custom 4.4.1 (from Vanilla) kernel.
> What I have discovered from Windows and Android: I2c address of TS is
> 0x48, in Android it is located under i2c-4 0x48
>
>>: cat /sys/bus/i2c/devices/i2c-4/4-0048/name
> chipone-icn85xx.
>
> Under windows 8.1 there is icnfirmware.sys for it. (;-) no need to
> grab it!), fw also present in .h file of rtk3128 github repo.
> GPIO pin I have guessing to enable TS is 393 (stupid looking over all
> gpios via sysfs and enabling each to 1).
>
> So my farther additional questions are:
>
> 2) Could be icn8318 by Hans de Goede be adopted for icn85xx?
> 3) Looks currently kernel is not supported ACPII for icn85xx
> 4) Please advice how to (if possible) having windows and android with
> working touch to grab all needed information for makes device working
> with kernel (gpio pins).
> 5) In Windows driver is myi2c.sys and reports that this is chipone ts,
> in Android is loaded atmel_mxt_ts module and the most strange thing
> afrer rmmod touch is working.
> dmesg under android shows: input: chipone-ts as /devices/virtual/input/input5.
> modalis: input:b0000v0000p0000-e0,1,3,k8b,9e,d9,ra2f,30,32,35,36,39,m1sfw
> how it is possible to use atmel_mxt_ts module for chipone? or what is the trick?
>
> Thanks in advance,
>       hope together we will make it working under x86!
> Regards,
>                  Serge Kolotylo.
