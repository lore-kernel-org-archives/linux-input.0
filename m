From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Thu, 21 Mar 2019 12:08:24 +0800
Message-ID: <220FEDBD-9A71-4C14-A7D6-3850D515865F@canonical.com>
References: <LaQHUFs--3-1@tutanota.com>
 <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com>
 <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
 <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>, Stephen Boyd <swboyd@chromium.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Dmitry Torokhov <dtor@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

at 01:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Mar 20, 2019 at 6:55 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:
>>> On 3/20/19 3:37 PM, Benjamin Tissoires wrote:
>
>>> Benjamin, what I find interesting here is that the BOGUS_IRQ quirk
>>> is also used on Elan devices, I suspect that these Elan devices
>>> likely also need the I2C_HID_QUIRK_FORCE_TRIGGER_FALLING quirk
>>> and then they probably will no longer need the bogus IRQ flag,
>>> if you know about bugreports with an acpidump for any of the devices
>>> needing the bogus IRQ quirk, then I (or you) can check how the IRQ is
>>> declared there, I suspect it will be declared as level-low, just like
>>> with the laptop this patch was written for. And it probably need to
>>> be edge-falling instead of level-low just like this case.
>>
>> First, I’ve already tried using IRQF_TRIGGER_FALLING, unfortunately it
>> doesn’t solve the issue for me.
>>
>> I talked to Elan once, and they confirm the correct IRQ trigger is level
>> low. So forcing falling trigger may break other platforms.
>
> As far as I understood Vladislav the quirk he got from Elan as well.

Ok, then this is really weird.

>
>> Recently we found that Elan touchpad doesn’t like GpioInt() from its _CRS.
>> Once the Interrupt() is used instead, the issue goes away.
>
> IIRC i2c core tries to get interrupt from Interrupt() resource and
> then falls back to GpioInt().
> See i2c_acpi_get_info() and i2c_device_probe().

Here’s its ASL:

     Scope (\_SB.PCI0.I2C4)
     {
         Device (TPD0)
         {
             Name (_ADR, One)  // _ADR: Address
             Name (_HID, "DELL08AE")  // _HID: Hardware ID
             Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
             Name (_UID, One)  // _UID: Unique ID
             Name (_S0W, 0x04)  // _S0W: S0 Device Wake State
             Name (SBFB, ResourceTemplate ()
             {
                 I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
                     AddressingMode7Bit, "\\_SB.PCI0.I2C4",
                     0x00, ResourceConsumer, , Exclusive,
                     )
             })
             Name (SBFG, ResourceTemplate ()
             {
                 GpioInt (Level, ActiveLow, ExclusiveAndWake, PullUp, 0x0000,
                     "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                     )
                     {   // Pin list
                         0x0012
                     }
             })
             Name (SBFI, ResourceTemplate ()
             {
                 Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, )
                 {
                     0x0000003C,
                 }
             })
             Method (_INI, 0, NotSerialized)  // _INI: Initialize
             {
             }
             Method (_STA, 0, NotSerialized)  // _STA: Status
             {
                 If ((TCPD == One))
                 {
                     Return (0x0F)
                 }

                 Return (Zero)
             }
             Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
             {
                 If ((OSYS < 0x07DC))
                 {
                     Return (SBFI) /* \_SB_.PCI0.I2C4.TPD0.SBFI */
                 }

                 Return (ConcatenateResTemplate (SBFB, SBFG))
             }
             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
             {
                 If ((Arg0 == ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))
                 {
                     If ((Arg2 == Zero))
                     {
                         If ((Arg1 == One))
                         {
                             Return (Buffer (One)
                             {
                                  0x03                                             // .
                             })
                         }
                         Else
                         {
                             Return (Buffer (One)
                             {
                                  0x00                                             // .
                             })
                         }
                     }
                     ElseIf ((Arg2 == One))
                     {
                         Return (0x20)
                     }
                     Else
                     {
                         Return (Buffer (One)
                         {
                              0x00                                             // .
                         })
                     }
                 }
                 ElseIf ((Arg0 == ToUUID ("ef87eb82-f951-46da-84ec-14871ac6f84b")))
                 {
                     If ((Arg2 == Zero))
                     {
                         If ((Arg1 == One))
                         {
                             Return (Buffer (One)
                             {
                                  0x03                                             // .
                             })
                         }
                     }

                     If ((Arg2 == One))
                     {
                         Return (ConcatenateResTemplate (SBFB, SBFG))
                     }

                     Return (Buffer (One)
                     {
                          0x00                                             // .
                     })
                 }
                 }
                 Else
                 {
                     Return (Buffer (One)
                     {
                          0x00                                             // .
                     })
                 }
             }
         }
     }

Change SBFG to SBFI in its _CRS can workaround the issue.
Is ASL in this form possible to do the flow you described?

Kai-Heng

>
>> But I am not sure how to patch its DSDT/SSDT in i2c-hid.
>
> -- 
> With Best Regards,
> Andy Shevchenko
