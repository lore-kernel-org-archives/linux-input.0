From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Add a small delay after sleep command
 for Raydium touchpanel
Date: Tue, 16 Oct 2018 16:41:36 +0800
Message-ID: <742ABBBD-BA86-47CB-B8D2-36CB2979F5F3@canonical.com>
References: <20181005044629.26286-1-kai.heng.feng@canonical.com>
 <CAO-hwJJACzB4MmPxeyT1ERLyifeC06tg_DU+1PZwOruBf-42TQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJJACzB4MmPxeyT1ERLyifeC06tg_DU+1PZwOruBf-42TQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> On Oct 15, 2018, at 16:04, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> On Fri, Oct 5, 2018 at 6:46 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> 
>> Raydium touchpanel (2386:4B33) sometimes does not work in desktop session
>> although it works in display manager.
>> 
>> During user logging, the display manager exits, close the HID device,
>> then the device gets runtime suspended and powered off. The desktop
>> session begins shortly after, opens the HID device, then the device gets
>> runtime resumed and powered on.
>> 
>> If the trasition from display manager to desktop sesesion is fast, the
>> touchpanel cannot switch from powered off to powered on in short
>> timeframe. So add a small delay to workaround the issue.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2:
>> - Use quirk to only match affected touchpanel
>> - Only delay the next power on if the time hasn't elapsed
> 
> Hi,
> 
> I like the patch much better. And I even would be tempted to have this
> unconditionally enabled now that the general path doesn't have the
> msleep in the middle.
> 
> So how about we merge this patch now, and if in the long run we see
> more devices that require this quirk, then we can probably remove the
> specific quirk and make it mandatory?

Of course, that’s totally makes sense.

Thanks for the review.

Kai-Heng

> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Cheers,
> Benjamin
> 
>> 
>> drivers/hid/hid-ids.h              |  3 +++
>> drivers/hid/i2c-hid/i2c-hid-core.c | 19 +++++++++++++++++++
>> 2 files changed, 22 insertions(+)
>> 
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 16342188df19..c1b5f03eb630 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -926,6 +926,9 @@
>> #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003                0x3003
>> #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008                0x3008
>> 
>> +#define I2C_VENDOR_ID_RAYDIUM          0x2386
>> +#define I2C_PRODUCT_ID_RAYDIUM_4B33    0x4b33
>> +
>> #define USB_VENDOR_ID_RAZER            0x1532
>> #define USB_DEVICE_ID_RAZER_BLADE_14   0x011D
>> 
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>> index 4aab96cf0818..3cde7c1b9c33 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>> @@ -49,6 +49,7 @@
>> #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV       BIT(0)
>> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET       BIT(1)
>> #define I2C_HID_QUIRK_NO_RUNTIME_PM            BIT(2)
>> +#define I2C_HID_QUIRK_DELAY_AFTER_SLEEP                BIT(3)
>> 
>> /* flags */
>> #define I2C_HID_STARTED                0
>> @@ -158,6 +159,8 @@ struct i2c_hid {
>> 
>>        bool                    irq_wake_enabled;
>>        struct mutex            reset_lock;
>> +
>> +       unsigned long           sleep_delay;
>> };
>> 
>> static const struct i2c_hid_quirks {
>> @@ -172,6 +175,8 @@ static const struct i2c_hid_quirks {
>>        { I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
>>                I2C_HID_QUIRK_NO_IRQ_AFTER_RESET |
>>                I2C_HID_QUIRK_NO_RUNTIME_PM },
>> +       { I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_4B33,
>> +               I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
>>        { 0, 0 }
>> };
>> 
>> @@ -387,6 +392,7 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>> {
>>        struct i2c_hid *ihid = i2c_get_clientdata(client);
>>        int ret;
>> +       unsigned long now, delay;
>> 
>>        i2c_hid_dbg(ihid, "%s\n", __func__);
>> 
>> @@ -404,9 +410,22 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>>                        goto set_pwr_exit;
>>        }
>> 
>> +       if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
>> +           power_state == I2C_HID_PWR_ON) {
>> +               now = jiffies;
>> +               if (time_after(ihid->sleep_delay, now)) {
>> +                       delay = jiffies_to_usecs(ihid->sleep_delay - now);
>> +                       usleep_range(delay, delay + 1);
>> +               }
>> +       }
>> +
>>        ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
>>                0, NULL, 0, NULL, 0);
>> 
>> +       if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
>> +           power_state == I2C_HID_PWR_SLEEP)
>> +               ihid->sleep_delay = jiffies + msecs_to_jiffies(20);
>> +
>>        if (ret)
>>                dev_err(&client->dev, "failed to change power setting.\n");
>> 
>> --
>> 2.17.1
