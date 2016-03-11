From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Fri, 11 Mar 2016 22:07:42 +0000
Message-ID: <CA+V1LzoHQq71riUOciB2PTLm4-Xk5DO1DA49f2uF9SOk5x_rKA@mail.gmail.com>
References: <CA+V1Lzo4-EBWQcpg9T-BBcF5xqa31_JNOZj-ev56PWe=vuvqZQ@mail.gmail.com>
	<56E1EE3C.6010007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34200 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbcCKWHn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2016 17:07:43 -0500
Received: by mail-qk0-f182.google.com with SMTP id x1so53731166qkc.1
        for <linux-input@vger.kernel.org>; Fri, 11 Mar 2016 14:07:43 -0800 (PST)
In-Reply-To: <56E1EE3C.6010007@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Gregor,

"Perhaps there's more initialisation needed. Have a look at the _PS0/_PS3
methods in the DSDT. Those are usually meant for automatic power management
when the system exits/enters standby.
Perhaps the icn85 is still in sleep mode?"

I guess probably :( still yes not wake uped.
The key is - how to wake up?! I have provided link to specs
(unfortunately in Chines, but there is there also CN-EN google
translation in .odt)
https://gitlab.com/antruziliak/icn8528/tree/master/SPECS
Any ideas\information from community will be useful!

I see in https://github.com/bbelos/rk3188-kernel/blob/master/drivers/input/touchscreen/ICN8503/icn85xx.c
lines 49 - 55 for one of the platform variants of using kernel
consumer power regulator.

define CTP_POWER_ID ("sensor28")//("touchPannel_power")

tp_regulator = regulator_init(CTP_POWER_ID, CTP_POWER_MIN_VOL,
CTP_POWER_MAX_VOL); if ( !tp_regulator ) { // printk(KERN_ERR "icn85xx
tp init power failed"); err = -EINVAL; return err; }


The main question is - where to get regulator ID for linux baytrail?
In Android I see in sysfs 2 of them, will try to research trying both
later.

Dmitriy, Gregor:
regarding i2c bus address:
It is very strange but even in provided specs for example
https://gitlab.com/antruziliak/icn8528/blob/master/SPECS/Android%E5%B9%B3%E5%8F%B0%E4%B8%8BICN85XX%E9%A9%B1%E5%8A%A8%E7%A7%BB%E6%A4%8D%E8%AF%B4%E6%98%8E%E4%B9%A61.0.doc

is mentioned 0x40
but in https://gitlab.com/antruziliak/icn8528/blob/master/SPECS/ICNT88xx_Application%20note_CN_V1.0_20150330.pdf

is mentioned 0x48!

at the same time

https://github.com/bbelos/rk3188-kernel/blob/master/drivers/input/touchscreen/ICN850X/icn85xx.h

#define ICN85XX_PROG_IIC_ADDR (0x30)

at the same time
https://github.com/bbelos/rk3188-kernel/blob/master/drivers/input/touchscreen/ICN8503/icn85xx.c

static struct i2c_board_info tp_info = {
    .type    = CTP_NAME,
    .addr    =  0x48,
};


this makes me "crying crazy" = where is the chip located! Imagine that
I could not wake up it and not sure where is it located or should be
located! I have discovered that in Android it is resides on i2c-4,
0x48.
In Windows driver looks also 0x48 (not sure, trying to recheck,
unfortunately do not know at the moment how to inspect i2c bus under
windows 8).

In ACPI DSDT it is declared something regarding 0x30, but may be below
lines mean something other???


Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                {
                    Name (RBUF, ResourceTemplate ()
                    {
                        I2cSerialBus (0x0030, ControllerInitiated, 0x00061A80,
                            AddressingMode7Bit, "\\_SB.I2C4",
                            0x00, ResourceConsumer, ,
                            )

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


Regards,
                Serge Kolotylo.
