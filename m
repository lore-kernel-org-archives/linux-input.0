From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Fix resume issue on Raydium touchscreen device
Date: Thu, 4 Jan 2018 11:34:10 +0100
Message-ID: <CAO-hwJJ3n3YD1+pKvKRRoCX8y-5xZwemKLuLi7aqWSQT=J645A@mail.gmail.com>
References: <20180102173006.506-1-aaron.ma@canonical.com> <20180102173006.506-2-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180102173006.506-2-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Aaron,

On Tue, Jan 2, 2018 at 6:30 PM, Aaron Ma <aaron.ma@canonical.com> wrote:
> When Rayd touchscreen resumed from S3, it issues too many errors like:
> i2c_hid i2c-RAYD0001:00: i2c_hid_get_input: incomplete report (58/5442)
>
> And all the report data are corrupted, touchscreen is unresponsive.
>
> Fix this by re-sending report description command after resume.

Is this something the Windows driver does unconditionally?
I'd rather not add a quirk if the Windows driver does it all the time,
and hardware manufacturers start relying on it.

Otherwise, the patch looks good, I just want to be sure that we
actually need the quirk or if we should do it all the time.

Cheers,
Benjamin

> Add device ID as a quirk.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/hid/hid-ids.h         |  3 +++
>  drivers/hid/i2c-hid/i2c-hid.c | 13 +++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 5da3d6256d25..753cc10aa699 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -516,6 +516,9 @@
>  #define I2C_VENDOR_ID_HANTICK          0x0911
>  #define I2C_PRODUCT_ID_HANTICK_5288    0x5288
>
> +#define I2C_VENDOR_ID_RAYD             0x2386
> +#define I2C_PRODUCT_ID_RAYD_3118       0x3118
> +
>  #define USB_VENDOR_ID_HANWANG          0x0b57
>  #define USB_DEVICE_ID_HANWANG_TABLET_FIRST     0x5000
>  #define USB_DEVICE_ID_HANWANG_TABLET_LAST      0x8fff
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 09404ffdb08b..57a447a9d40e 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -47,6 +47,7 @@
>  /* quirks to control the device */
>  #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV       BIT(0)
>  #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET       BIT(1)
> +#define I2C_HID_QUIRK_RESEND_REPORT_DESCR      BIT(2)
>
>  /* flags */
>  #define I2C_HID_STARTED                0
> @@ -171,6 +172,8 @@ static const struct i2c_hid_quirks {
>                 I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
>         { I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
>                 I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
> +       { I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
> +               I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>         { 0, 0 }
>  };
>
> @@ -1211,6 +1214,16 @@ static int i2c_hid_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> +       /* RAYDIUM device (2386:3118) need to re-send report descr cmd
> +        * after resume, after this it will be back normal.
> +        * otherwise it issues too many incomplete reports.
> +        */
> +       if (ihid->quirks & I2C_HID_QUIRK_RESEND_REPORT_DESCR) {
> +               ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
> +               if (!ret)
> +                       return ret;
> +       }
> +
>         if (hid->driver && hid->driver->reset_resume) {
>                 ret = hid->driver->reset_resume(hid);
>                 return ret;
> --
> 2.14.3
>
