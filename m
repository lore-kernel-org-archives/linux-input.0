From: Sebastien Bourdeauducq <sb@m-labs.hk>
Subject: Re: "i2c_hid: Could not register for interrupt, irq = -1" on Thinkpad
 Tablet 10
Date: Sun, 01 Feb 2015 11:27:09 +0800
Message-ID: <54CD9D0D.20402@m-labs.hk>
References: <54CCEE3D.9040306@m-labs.hk> <CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([88.198.40.39]:56669 "EHLO
	ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbBAD1S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2015 22:27:18 -0500
In-Reply-To: <CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi,

On Sunday, February 01, 2015 04:39 AM, Benjamin Tissoires wrote:
> Mika sent a patch recently which should solve your problem.
> Can you give a try to the following patch?
> https://patchwork.kernel.org/patch/5709961/

With this patch and IRQF_TRIGGER_LOW | IRQF_ONESHOT, I get an interrupt 
flood and the kernel disables the interrupt line. I have reverted it to 
IRQF_TRIGGER_FALLING | IRQF_ONESHOT, and the i2c_hid initialization 
completes successfully.

The next problem is that the tablet has product ID 0x0114 and this is 
not recognized by the wacom_wac driver. I have added those entries in it:

static const struct wacom_features wacom_features_0x114 =
	{ "Wacom ISDv4 114", 26202, 16325, 255, 0,
	  TABLETPCE, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
...
#define ANY_DEVICE_WACOM(prod)						\
	HID_DEVICE(HID_BUS_ANY, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
	.driver_data = (kernel_ulong_t)&wacom_features_##prod
...
{ ANY_DEVICE_WACOM(0x114) },

I am just guessing here and copied the existing entry for product ID 
0x116. I don't know if those numbers are correct - also, should I have 
used the existing USB_DEVICE_WACOM macro instead of defining 
ANY_DEVICE_WACOM?

After those changes, I'm able to move the mouse pointer only once (and 
to the correct position) using the stylus, after which the digitizer 
crashes and becomes inoperable until a reboot. Unloading and reloading 
i2c_hid results in a "failed to reset device" message.

I have copied my DSDT entry below.

Thanks,
Sebastien

Device (DIGI)
{
     Name (_ADR, Zero)  // _ADR: Address
     Name (_HID, "WCOM0008")  // _HID: Hardware ID
     Name (_CID, "PNP0C50")  // _CID: Compatible ID
     Name (_DDN, "Digitizer")  // _DDN: DOS Device Name
     Name (_UID, One)  // _UID: Unique ID
     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
     {
         Name (RBUF, ResourceTemplate ()
         {
             I2cSerialBus (0x0009, ControllerInitiated, 0x00061A80,
                 AddressingMode7Bit, "\\_SB.I2C3",
                 0x00, ResourceConsumer, ,
                 )
             GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
                 "\\_SB.GPO0", 0x00, ResourceConsumer, ,
                 )
                 {   // Pin list
                     0x0038
                 }
         })
         Return (RBUF)
     }

     Method (_STA, 0, NotSerialized)  // _STA: Status
     {
         If (LEqual (And (COMP, 0x04), 0x04))
         {
             Return (0x0F)
         }
         Else
         {
             Return (Zero)
         }
     }

     Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
     {
         Store ("Method _DSM begin", Debug)
         While (One)
         {
             Name (_T_0, Buffer (One)  // _T_x: Emitted by ASL Compiler
             {
                  0x00
             })
             CopyObject (ToBuffer (Arg0), _T_0)
             If (LEqual (_T_0, Buffer (0x10)
                     {
                         /* 0000 */   0xF7, 0xF6, 0xDF, 0x3C, 0x67, 
0x42, 0x55, 0x45,
                         /* 0008 */   0xAD, 0x05, 0xB3, 0x0A, 0x3D, 
0x89, 0x38, 0xDE
                     }))
             {
                 While (One)
                 {
                     Name (_T_1, Zero)  // _T_x: Emitted by ASL Compiler
                     Store (ToInteger (Arg2), _T_1)
                     If (LEqual (_T_1, Zero))
                     {
                         While (One)
                         {
                             Name (_T_2, Zero)  // _T_x: Emitted by ASL 
Compiler
                             Store (ToInteger (Arg1), _T_2)
                             If (LEqual (_T_2, One))
                             {
                                 Store ("Method _DSM Function Query", Debug)
                                 Return (Buffer (One)
                                 {
                                      0x03
                                 })
                             }
                             Else
                             {
                                 Return (Buffer (One)
                                 {
                                      0x00
                                 })
                             }

                             Break
                         }
                     }
                     Else
                     {
                         If (LEqual (_T_1, One))
                         {
                             Store ("Method _DSM Function HID", Debug)
                             Return (One)
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
                 })
             }

             Break
         }
     }
}
