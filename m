From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
Date: Sun, 24 Mar 2019 19:37:51 +0100
Message-ID: <57257ed9-0242-07cc-893e-13e9cef0f822@redhat.com>
References: <LaQHUFs--3-1@tutanota.com> <LaUpAlT--3-1@tutanota.com>
 <LaeGPSe--3-1@tutanota.com> <3c8a3903-4eb4-6160-bb31-6aa4aea68ebb@redhat.com>
 <LakgsCJ--3-1@tutanota.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <LakgsCJ--3-1@tutanota.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: hotwater438@tutanota.com
Cc: Jikos <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Kai Heng Feng <kai.heng.feng@canonical.com>, Swboyd <swboyd@chromium.org>, Bigeasy <bigeasy@linutronix.de>, Dtor <dtor@chromium.org>, Linux Input <linux-input@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 24-03-19 18:15, hotwater438@tutanota.com wrote:
> Hi,
> 
> Sorry, I forgot to put the description.
> 
> goto err_foo stuff changes were requested by Benjamin. Please tell if you think something is wrong.
> 
> Regards, Vladislav.
> 
> Here's the final patch:
> 
>  From 80576dd7ac193548ba747d287b5ab5606f642d00 Mon Sep 17 00:00:00 2001
> From: h0tw4t3r <hotwater438@tutanota.com <mailto:hotwater438@tutanota.com>>
> Date: Wed, 24 Mar 2019 19:14:22 +0200
> Subject: [PATCH] ELAN touchpad i2c_hid bugs fix
> 
> Description: The ELAN1200:04F3:303E touchpad exposes several issues, all caused by
> an error setting the correct IRQ_TRIGGER flag:
>      - i2c_hid incoplete error flood in journalctl;
>      - Five finger tap kill's module so you have to restart it;
>      - Two finger scoll is working incorrect and sometimes even when you raised one of two finger still thinks that you are scrolling
> 
> Fix all of these with a new quirk that corrects the trigger flag
> announced by the ACPI tables. (edge-falling).
> 
> Reason behind moving i2c_hid_init_irq section described below:
>      i2c_hid_init_irq now checks for a quirk, so we must setup the quirks before we init the irq, and we cannot setup the quirk earlier, so we must init the irq later.

Some lines in your commit messages are longer then 75 chars, please
add an enter after aprox. 75 chars so that you have no lines longer
then 75 chars.


> Signed-off-by: Vladislav Dalechyn <hotwater438@tutanota.com <mailto:hotwater438@tutanota.com>>
> ---
> drivers/hid/hid-ids.h              |  1 +
> drivers/hid/i2c-hid/i2c-hid-core.c | 25 +++++++++++++++----------
> 2 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b6d93f4ad037..660b4e0e912e 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -389,6 +389,7 @@
> #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W 0x0401
> #define USB_DEVICE_ID_HP_X2 0x074d
> #define USB_DEVICE_ID_HP_X2_10_COVER 0x0755
> +#define I2C_DEVICE_ID_ELAN_TOUCHPAD 0x303e
> 
> #define USB_VENDOR_ID_ELECOM 0x056e
> #define USB_DEVICE_ID_ELECOM_BM084 0x0061
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 90164fed08d3..9b417914411f 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -51,6 +51,7 @@
> #define I2C_HID_QUIRK_NO_RUNTIME_PM BIT(2)
> #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP BIT(3)
> #define I2C_HID_QUIRK_BOGUS_IRQ BIT(4)
> +#define I2C_HID_QUIRK_FORCE_TRIGGER_FALLING BIT(5)
> 
> /* flags */
> #define I2C_HID_STARTED 0
> @@ -182,8 +183,10 @@ static const struct i2c_hid_quirks {
> I2C_HID_QUIRK_NO_RUNTIME_PM },
> { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
> I2C_HID_QUIRK_NO_RUNTIME_PM },
> + { USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ELAN_TOUCHPAD,
> + I2C_HID_QUIRK_BOGUS_IRQ | I2C_HID_QUIRK_FORCE_TRIGGER_FALLING },
> { USB_VENDOR_ID_ELAN, HID_ANY_ID,
> - I2C_HID_QUIRK_BOGUS_IRQ },
> + I2C_HID_QUIRK_BOGUS_IRQ },
> { 0, 0 }
> };
> 
> @@ -854,6 +857,8 @@ static int i2c_hid_init_irq(struct i2c_client *client)
> 
> if (!irq_get_trigger_type(client->irq))
> irqflags = IRQF_TRIGGER_LOW;
> + if (ihid->quirks & I2C_HID_QUIRK_FORCE_TRIGGER_FALLING)
> + irqflags = IRQF_TRIGGER_FALLING;

The patch has been completely mangled by your mail client, please
use "git send-email" to send a new version of the patch without
it getting mangled by your email client.

Regards,

Hans
