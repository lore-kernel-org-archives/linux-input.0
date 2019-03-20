From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Thu, 21 Mar 2019 00:53:39 +0800
Message-ID: <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
References: <LaQHUFs--3-1@tutanota.com>
 <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9151d116-958c-9298-9427-fe803a163e9f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>, Stephen Boyd <swboyd@chromium.org>, bigeasy@linutronix.de, Dmitry Torokhov <dtor@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Hans,

at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:

> H,
>
> On 3/20/19 3:37 PM, Benjamin Tissoires wrote:
>
> <snip>
>
>>> The reason why i2c_hid_init_irq was moved is told by Hans De Goede
>>> <hdegoede@redhat.com>:
>>> i2c_hid_init_irq now checks for a quirk, so we must setup the quirks  
>>> before we init the irq, and we cannot setup the quirk earlier, so we  
>>> must init the irq later.
>> I am pretty sure you can paraphrase Hans in your commit message
>> without having to formally quote him (Hans, please shout if you
>> disagree).
>
> Right, it is fine to explain why the irq init is moved without
> quoting or even referring to me.
>
>>> --- a/drivers/hid/hid-ids.h
>>> +++ b/drivers/hid/hid-ids.h
>>> @@ -389,6 +389,7 @@
>>> #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W 0x0401
>>> #define USB_DEVICE_ID_HP_X2 0x074d
>>> #define USB_DEVICE_ID_HP_X2_10_COVER 0x0755
>>> +#define USB_DEVICE_ID_ELAN_TOUCHPAD 0x303e
>> I know Hans wanted you to use USB here, but I'd think we should have a
>> I2C_DEVICE_ID_*
>> There is no guarantees that this same PID will be used in a different
>> chip over USB.
>> We tend to not car about USB/I2C for the vendor IDs: the vendors
>> decided to reuse their USB VID, which makes our life easier.
>
> Ok, no objection from me to use an I2C_DEVICE_ID prefix, here it
> is after all an I2C device.
>
>>> #define USB_VENDOR_ID_ELECOM 0x056e
>>> #define USB_DEVICE_ID_ELECOM_BM084 0x0061
>>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c  
>>> b/drivers/hid/i2c-hid/i2c-hid-core.c
>>> index 90164fed08d3..16b55c45e2e8 100644
>>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>>> @@ -50,7 +50,8 @@
>>> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET BIT(1)
>>> #define I2C_HID_QUIRK_NO_RUNTIME_PM BIT(2)
>>> #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP BIT(3)
>>> -#define I2C_HID_QUIRK_BOGUS_IRQ BIT(4)
>>> +#define I2C_HID_QUIRK_BOGUS_IRQ BIT(4)
>>> +#define I2C_HID_QUIRK_FORCE_TRIGGER_FALLING BIT(5)
>>>
>>> /* flags */
>>> #define I2C_HID_STARTED 0
>>> @@ -182,8 +183,10 @@ static const struct i2c_hid_quirks {
>>> I2C_HID_QUIRK_NO_RUNTIME_PM },
>>> { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
>>> I2C_HID_QUIRK_NO_RUNTIME_PM },
>>> + { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHPAD,
>>> + I2C_HID_QUIRK_BOGUS_IRQ | I2C_HID_QUIRK_FORCE_TRIGGER_FALLING },
>>> { USB_VENDOR_ID_ELAN, HID_ANY_ID,
>>> - I2C_HID_QUIRK_BOGUS_IRQ },
>>> + I2C_HID_QUIRK_BOGUS_IRQ },
>
> Benjamin, what I find interesting here is that the BOGUS_IRQ quirk
> is also used on Elan devices, I suspect that these Elan devices
> likely also need the I2C_HID_QUIRK_FORCE_TRIGGER_FALLING quirk
> and then they probably will no longer need the bogus IRQ flag,
> if you know about bugreports with an acpidump for any of the devices
> needing the bogus IRQ quirk, then I (or you) can check how the IRQ is
> declared there, I suspect it will be declared as level-low, just like
> with the laptop this patch was written for. And it probably need to
> be edge-falling instead of level-low just like this case.

First, I’ve already tried using IRQF_TRIGGER_FALLING, unfortunately it  
doesn’t solve the issue for me.

I talked to Elan once, and they confirm the correct IRQ trigger is level  
low. So forcing falling trigger may break other platforms.

Recently we found that Elan touchpad doesn’t like GpioInt() from its _CRS.  
Once the Interrupt() is used instead, the issue goes away.

But I am not sure how to patch its DSDT/SSDT in i2c-hid.

Kai-Heng

>
> Regards,
>
> Hans
