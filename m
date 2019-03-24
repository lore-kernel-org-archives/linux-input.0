From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Sun, 24 Mar 2019 13:27:01 +0100
Message-ID: <3c8a3903-4eb4-6160-bb31-6aa4aea68ebb@redhat.com>
References: <LaQHUFs--3-1@tutanota.com> <LaUpAlT--3-1@tutanota.com>
 <LaeGPSe--3-1@tutanota.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <LaeGPSe--3-1@tutanota.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: hotwater438@tutanota.com, Jikos <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Kai Heng Feng <kai.heng.feng@canonical.com>, Swboyd <swboyd@chromium.org>, Bigeasy <bigeasy@linutronix.de>, Dtor <dtor@chromium.org>, Linux Input <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 23-03-19 12:18, hotwater438@tutanota.com wrote:
> Guys, I am a little bit confused. Do you mean that it is not kernel related issue, and it's the issue of ASUS BIOS?

Technically this is a BIOS bug, the BIOS should properly declare the IRQ as
edge-falling and then everything would just work.

But BIOS bugs is what quirks are for (unfortunately)

> And why do you think that triggering edge-falling quirk for this exactly this touchpad and exactly ELAN vendor can somehow break other systems?

I'm not seeing anything about breaking other systems in the discussion
(but I may have missed this) what we were discussing is also applying
the quirk to other systems with an Elan touchpad to see if it also
helps with issues on other systems.

Summarizing: Your patch is fine (minus the style issues and the goto error_foo stuff)
please fix those issues and submit a new version.

Regards,

Hans




> 
> Regards,
> Vladislav
> 
> Mar 21, 2019, 12:38 PM by hotwater438@tutanota.com:
> 
>     Hello! Thank you for an answer and for helping me with the patch. It is my very first contribution.
> 
>     About some indent problems: I am sorry, it was mainly caused by my .vimrc, and I will edit these errors and send a new patch. Though, there is one typo:
> 
>                 +#define I2C_HID_QUIRK_FORCE_TRIGGER_FALLING BIT(5)
> 
>                 /* flags */
>                 #define I2C_HID_STARTED 0
>                 @@ -182,8 +183,10 @@ static const struct i2c_hid_quirks {
>                 I2C_HID_QUIRK_NO_RUNTIME_PM },
>                 { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
>                 I2C_HID_QUIRK_NO_RUNTIME_PM },
>                 + { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHPAD,
>                 + I2C_HID_QUIRK_BOGUS_IRQ | I2C_HID_QUIRK_FORCE_TRIGGER_FALLING },
>                 { USB_VENDOR_ID_ELAN, HID_ANY_ID,
>                 - I2C_HID_QUIRK_BOGUS_IRQ },
>                 + I2C_HID_QUIRK_BOGUS_IRQ },
> 
> 
>             same here, this line should not be changed.
> 
>     If you take a look at original file, you can notice extra space there.
> 
>         In your case, if you do not have any Elantech engineer who agreed to
>         sign off the patch, you can definitively mention them this way.
> 
>     I don't have any.
> 
>             ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
>             irqflags | IRQF_ONESHOT, client->name, ihid);
>             @@ -1123,10 +1128,6 @@ static int i2c_hid_probe(struct i2c_client *client,
>             if (ret < 0)
>             goto err_pm;
> 
>             - ret = i2c_hid_init_irq(client);
>             - if (ret < 0)
>             - goto err_pm;
>             -
>             hid = hid_allocate_device();
>             if (IS_ERR(hid)) {
>             ret = PTR_ERR(hid);
> 
> 
>         the next call is "goto err_irq", which should be changed to "goto err_pm"
> 
>             @@ -1149,6 +1150,10 @@ static int i2c_hid_probe(struct i2c_client *client,
> 
>             ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
> 
>             + ret = i2c_hid_init_irq(client);
>             + if (ret < 0)
>             + goto err_pm;
> 
> 
>         this should be "err_mem_free"
> 
>             +
>             ret = hid_add_device(hid);
>             if (ret) {
>             if (ret != -ENODEV)
> 
> 
>         next one should be "err_irq"
> 
>         and the err_irq and err_mem_free should be inverted at the end of probe.
> 
>     I tried to understand this as hard as I could, but there may be some errors, so please review my latest patch:
> 
>      From 80576dd7ac193548ba747d287b5ab5606f642d00 Mon Sep 17 00:00:00 2001
>     From: h0tw4t3r <hotwater438@tutanota.com <mailto:hotwater438@tutanota.com>>
>     Date: Wed, 20 Mar 2019 00:41:22 +0200
>     Subject: [PATCH] ELAN touchpad i2c_hid bugs fix
> 
>     Description: The ELAN1200:04F3:303E touchpad exposes several issues, all caused by
>     an error setting the correct IRQ_TRIGGER flag:
>          - i2c_hid incoplete error flood in journalctl;
>          - Five finger tap kill's module so you have to restart it;
>     - Two finger scoll is working incorrect and sometimes even when you raised one of two finger still thinks that you are scrolling
> 
>     Fix all of these with a new quirk that corrects the trigger flag
>     announced by the ACPI tables. (edge-falling).
> 
>     Reason behind moving i2c_hid_init_irq section described below:
>          i2c_hid_init_irq now checks for a quirk, so we must setup the quirks before we init the irq, and we cannot setup the quirk earlier, so we must init the irq later.
> 
>     Signed-off-by: Vladislav Dalechyn <hotwater438@tutanota.com <mailto:hotwater438@tutanota.com>>
>     ---
>     drivers/hid/hid-ids.h              |  1 +
>     drivers/hid/i2c-hid/i2c-hid-core.c | 25 +++++++++++++++----------
>     2 files changed, 16 insertions(+), 10 deletions(-)
> 
>     diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>     index b6d93f4ad037..660b4e0e912e 100644
>     --- a/drivers/hid/hid-ids.h
>     +++ b/drivers/hid/hid-ids.h
>     @@ -389,6 +389,7 @@
>     #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W 0x0401
>     #define USB_DEVICE_ID_HP_X2 0x074d
>     #define USB_DEVICE_ID_HP_X2_10_COVER 0x0755
>     +#define I2C_DEVICE_ID_ELAN_TOUCHPAD 0x303e
> 
>     #define USB_VENDOR_ID_ELECOM 0x056e
>     #define USB_DEVICE_ID_ELECOM_BM084 0x0061
>     diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>     index 90164fed08d3..9b417914411f 100644
>     --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>     +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>     @@ -51,6 +51,7 @@
>     #define I2C_HID_QUIRK_NO_RUNTIME_PM BIT(2)
>     #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP BIT(3)
>     #define I2C_HID_QUIRK_BOGUS_IRQ BIT(4)
>     +#define I2C_HID_QUIRK_FORCE_TRIGGER_FALLING BIT(5)
> 
>     /* flags */
>     #define I2C_HID_STARTED 0
>     @@ -182,8 +183,10 @@ static const struct i2c_hid_quirks {
>     I2C_HID_QUIRK_NO_RUNTIME_PM },
>     { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
>     I2C_HID_QUIRK_NO_RUNTIME_PM },
>     + { USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ELAN_TOUCHPAD,
>     + I2C_HID_QUIRK_BOGUS_IRQ | I2C_HID_QUIRK_FORCE_TRIGGER_FALLING },
>     { USB_VENDOR_ID_ELAN, HID_ANY_ID,
>     - I2C_HID_QUIRK_BOGUS_IRQ },
>     + I2C_HID_QUIRK_BOGUS_IRQ },
>     { 0, 0 }
>     };
> 
>     @@ -854,6 +857,8 @@ static int i2c_hid_init_irq(struct i2c_client *client)
> 
>     if (!irq_get_trigger_type(client->irq))
>     irqflags = IRQF_TRIGGER_LOW;
>     + if (ihid->quirks & I2C_HID_QUIRK_FORCE_TRIGGER_FALLING)
>     + irqflags = IRQF_TRIGGER_FALLING;
> 
>     ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
>         irqflags | IRQF_ONESHOT, client->name, ihid);
>     @@ -1123,14 +1128,10 @@ static int i2c_hid_probe(struct i2c_client *client,
>     if (ret < 0)
>     goto err_pm;
> 
>     - ret = i2c_hid_init_irq(client);
>     - if (ret < 0)
>     - goto err_pm;
>     -
>     hid = hid_allocate_device();
>     if (IS_ERR(hid)) {
>     ret = PTR_ERR(hid);
>     - goto err_irq;
>     + goto err_pm;
>     }
> 
>     ihid->hid = hid;
>     @@ -1149,11 +1150,15 @@ static int i2c_hid_probe(struct i2c_client *client,
> 
>     ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
> 
>     + ret = i2c_hid_init_irq(client);
>     + if (ret < 0)
>     + goto err_mem_free;
>     +
>     ret = hid_add_device(hid);
>     if (ret) {
>     if (ret != -ENODEV)
>     hid_err(client, "can't add hid device: %d\n", ret);
>     - goto err_mem_free;
>     + goto err_irq;
>     }
> 
>     if (!(ihid->quirks & I2C_HID_QUIRK_NO_RUNTIME_PM))
>     @@ -1161,12 +1166,12 @@ static int i2c_hid_probe(struct i2c_client *client,
> 
>     return 0;
> 
>     +err_irq:
>     +    free_irq(client->irq, ihid);
>     +
>     err_mem_free:
>     hid_destroy_device(hid);
> 
>     -err_irq:
>     - free_irq(client->irq, ihid);
>     -
>     err_pm:
>     pm_runtime_put_noidle(&client->dev);
>     pm_runtime_disable(&client->dev);
>     --
>     2.20.1
> 
>     Regards,
>     Vladislav.
> 
> 
