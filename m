From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Don't reset device upon system resume
Date: Thu, 6 Sep 2018 09:07:18 +0200
Message-ID: <CAO-hwJJTjDv0gj=3KkZDBz3cXejx-N+f_Jd2Bxk1xhogyxHMLg@mail.gmail.com>
References: <20180906025518.30191-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906025518.30191-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Aaron Ma <aaron.ma@canonical.com>, AceLan Kao <acelan.kao@canonical.com>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 6, 2018 at 4:55 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Raydium touchscreen triggers interrupt storm after system-wide suspend:
> [ 179.085033] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete
> report (58/65535)
>
> According to Raydium, Windows driver does not reset the device after
> system resume.
>
> The HID over I2C spec does specify a reset should be used at
> intialization, but it doesn't specify if reset is required for system
> suspend.
>
> Tested this patch on other i2c-hid touchpanels I have and those
> touchpanels do work after S3 without doing reset. If any regression
> happens to other touchpanel vendors, we can use quirk for Raydium
> devices.
>
> There's still one device uses I2C_HID_QUIRK_RESEND_REPORT_DESCR so keep
> it there.
>
> Cc: Aaron Ma <aaron.ma@canonical.com>
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Jiri, note that this will replace https://patchwork.kernel.org/patch/10583481/

Cheers,
Benjamin

> ---
> v2:
>  Remove Raydium devices' ID and quirk.
>  Rewording.
>
>  drivers/hid/hid-ids.h         |  4 ----
>  drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++------
>  2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 7da93d789080..e254ae802688 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -530,10 +530,6 @@
>  #define I2C_VENDOR_ID_HANTICK          0x0911
>  #define I2C_PRODUCT_ID_HANTICK_5288    0x5288
>
> -#define I2C_VENDOR_ID_RAYD             0x2386
> -#define I2C_PRODUCT_ID_RAYD_3118       0x3118
> -#define I2C_PRODUCT_ID_RAYD_4B33       0x4B33
> -
>  #define USB_VENDOR_ID_HANWANG          0x0b57
>  #define USB_DEVICE_ID_HANWANG_TABLET_FIRST     0x5000
>  #define USB_DEVICE_ID_HANWANG_TABLET_LAST      0x8fff
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 57126f6837bb..f3076659361a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -170,12 +170,8 @@ static const struct i2c_hid_quirks {
>                 I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
>         { I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
>                 I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
> -       { I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
> -               I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>         { USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
>                 I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> -       { I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
> -               I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>         { 0, 0 }
>  };
>
> @@ -1237,11 +1233,16 @@ static int i2c_hid_resume(struct device *dev)
>         pm_runtime_enable(dev);
>
>         enable_irq(client->irq);
> -       ret = i2c_hid_hwreset(client);
> +
> +       /* Instead of resetting device, simply powers the device on. This
> +        * solves "incomplete reports" on Raydium devices 2386:3118 and
> +        * 2386:4B33
> +        */
> +       ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
>         if (ret)
>                 return ret;
>
> -       /* RAYDIUM device (2386:3118) need to re-send report descr cmd
> +       /* Some devices need to re-send report descr cmd
>          * after resume, after this it will be back normal.
>          * otherwise it issues too many incomplete reports.
>          */
> --
> 2.17.1
>
