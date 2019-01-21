From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v3] HID: i2c-hid: Ignore input report if there's no data
 present on Elan touchpanels
Date: Mon, 21 Jan 2019 11:29:54 +0800
Message-ID: <D7C6B90F-641A-495B-9E05-78BF4F56B552@canonical.com>
References: <20190107072429.23828-1-kai.heng.feng@canonical.com>
 <CAO-hwJKo=EaPoXJLGUvjq3QRng1V1NkO7A5zYGojbPyxxyJYHA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJKo=EaPoXJLGUvjq3QRng1V1NkO7A5zYGojbPyxxyJYHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> On Jan 18, 2019, at 23:50, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> Hi Kai-Heng,
> 
> On Mon, Jan 7, 2019 at 8:24 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> While using Elan touchpads, the message floods:
>> [  136.138487] i2c_hid i2c-DELL08D6:00: i2c_hid_get_input: incomplete report (14/65535)
>> 
>> Though the message flood is annoying, the device it self works without
>> any issue. I suspect that the device in question takes too much time to
>> pull the IRQ back to high after I2C host has done reading its data.
>> 
>> Since the host receives all useful data, let's ignore the input report
>> when there's no data.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Thanks for the v3.
> 
> This patch has just been brought to my attention, and I have one
> question before applying it:
> are those messages (without your patch) occurring all the time, or
> just after resume?

All the time.

The touchpad works fine though. The entire report is 0xff, so it can be
safely ignored.

> 
> I wonder if the pm_suspend delay we talked about in the other thread
> would fix that issue in a cleaner way.

I’ve replied in another thread, unfortunately it can’t.

We can introduce msleep() between each commands though, but I don’t
think it’s good either.

Kai-Heng

> 
> Cheers,
> Benjamin
> 
>> ---
>> v3:
>> Fix compiler error/warnings.
>> 
>> v2:
>> Use dev_warn_once() to warn the user about the situation.
>> 
>> drivers/hid/i2c-hid/i2c-hid-core.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>> 
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>> index 8555ce7e737b..2f940c1de616 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>> @@ -50,6 +50,7 @@
>> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET       BIT(1)
>> #define I2C_HID_QUIRK_NO_RUNTIME_PM            BIT(2)
>> #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP                BIT(3)
>> +#define I2C_HID_QUIRK_BOGUS_IRQ                        BIT(4)
>> 
>> /* flags */
>> #define I2C_HID_STARTED                0
>> @@ -179,6 +180,8 @@ static const struct i2c_hid_quirks {
>>                I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
>>        { USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
>>                I2C_HID_QUIRK_NO_RUNTIME_PM },
>> +       { USB_VENDOR_ID_ELAN, HID_ANY_ID,
>> +                I2C_HID_QUIRK_BOGUS_IRQ },
>>        { 0, 0 }
>> };
>> 
>> @@ -503,6 +506,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
>>                return;
>>        }
>> 
>> +       if (ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ && ret_size == 0xffff) {
>> +               dev_warn_once(&ihid->client->dev, "%s: IRQ triggered but "
>> +                             "there's no data\n", __func__);
>> +               return;
>> +       }
>> +
>>        if ((ret_size > size) || (ret_size < 2)) {
>>                dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
>>                        __func__, size, ret_size);
>> --
>> 2.17.1
>> 
