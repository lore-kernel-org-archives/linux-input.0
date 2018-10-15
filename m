From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Add a small delay after sleep command
 for Raydium touchpanel
Date: Mon, 15 Oct 2018 11:33:38 +0800
Message-ID: <E080F790-05ED-461F-90A0-947FA359E697@canonical.com>
References: <20181005044629.26286-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005044629.26286-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jiri and Benjamin,

> On Oct 5, 2018, at 12:46, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Raydium touchpanel (2386:4B33) sometimes does not work in desktop session
> although it works in display manager.
> 
> During user logging, the display manager exits, close the HID device,
> then the device gets runtime suspended and powered off. The desktop
> session begins shortly after, opens the HID device, then the device gets
> runtime resumed and powered on.
> 
> If the trasition from display manager to desktop sesesion is fast, the
> touchpanel cannot switch from powered off to powered on in short
> timeframe. So add a small delay to workaround the issue.

Please review my patch and let me know if the approach is okay, thanks!

Kai-Heng

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - Use quirk to only match affected touchpanel
> - Only delay the next power on if the time hasn't elapsed
> 
> drivers/hid/hid-ids.h              |  3 +++
> drivers/hid/i2c-hid/i2c-hid-core.c | 19 +++++++++++++++++++
> 2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 16342188df19..c1b5f03eb630 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -926,6 +926,9 @@
> #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003		0x3003
> #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008		0x3008
> 
> +#define I2C_VENDOR_ID_RAYDIUM		0x2386
> +#define I2C_PRODUCT_ID_RAYDIUM_4B33	0x4b33
> +
> #define USB_VENDOR_ID_RAZER            0x1532
> #define USB_DEVICE_ID_RAZER_BLADE_14   0x011D
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 4aab96cf0818..3cde7c1b9c33 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -49,6 +49,7 @@
> #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
> #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
> +#define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
> 
> /* flags */
> #define I2C_HID_STARTED		0
> @@ -158,6 +159,8 @@ struct i2c_hid {
> 
> 	bool			irq_wake_enabled;
> 	struct mutex		reset_lock;
> +
> +	unsigned long		sleep_delay;
> };
> 
> static const struct i2c_hid_quirks {
> @@ -172,6 +175,8 @@ static const struct i2c_hid_quirks {
> 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
> 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET |
> 		I2C_HID_QUIRK_NO_RUNTIME_PM },
> +	{ I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_4B33,
> +		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
> 	{ 0, 0 }
> };
> 
> @@ -387,6 +392,7 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
> {
> 	struct i2c_hid *ihid = i2c_get_clientdata(client);
> 	int ret;
> +	unsigned long now, delay;
> 
> 	i2c_hid_dbg(ihid, "%s\n", __func__);
> 
> @@ -404,9 +410,22 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
> 			goto set_pwr_exit;
> 	}
> 
> +	if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
> +	    power_state == I2C_HID_PWR_ON) {
> +		now = jiffies;
> +		if (time_after(ihid->sleep_delay, now)) {
> +			delay = jiffies_to_usecs(ihid->sleep_delay - now);
> +			usleep_range(delay, delay + 1);
> +		}
> +	}
> +
> 	ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
> 		0, NULL, 0, NULL, 0);
> 
> +	if (ihid->quirks & I2C_HID_QUIRK_DELAY_AFTER_SLEEP &&
> +	    power_state == I2C_HID_PWR_SLEEP)
> +		ihid->sleep_delay = jiffies + msecs_to_jiffies(20);
> +
> 	if (ret)
> 		dev_err(&client->dev, "failed to change power setting.\n");
> 
> -- 
> 2.17.1
> 
