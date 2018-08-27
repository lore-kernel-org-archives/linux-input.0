From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: Fix flooded incomplete report after S3 on
 Rayd touchscreen
Date: Mon, 27 Aug 2018 14:30:53 +0200
Message-ID: <CAO-hwJJAfDvgRqWxFS=0Ga2SbhA3LbttjiG79vzZKTiZQizYoA@mail.gmail.com>
References: <20180821085513.13739-1-acelan.kao@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821085513.13739-1-acelan.kao@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acelan.kao@canonical.com
Cc: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dtor@chromium.org>, Aaron Ma <aaron.ma@canonical.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 21, 2018 at 10:55 AM AceLan Kao <acelan.kao@canonical.com> wrote:
>
> The incomplete report flooded after S3 and touchscreen becomes
> malfunctioned.
> [ 1367.646244] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/18785)
> [ 1367.649471] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/28743)
> [ 1367.651092] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/26757)
> [ 1367.652658] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/52280)
> [ 1367.654287] i2c_hid i2c-CUST0000:00: i2c_hid_get_input: incomplete report (58/56059)
>
> Adding device ID, 04F3:30CC, to the quirk to re-send report description
> after resume.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>

Looks good:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/hid-ids.h         | 1 +
>  drivers/hid/i2c-hid/i2c-hid.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index c7981ddd8776..e80bcd71fe1e 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -528,6 +528,7 @@
>
>  #define I2C_VENDOR_ID_RAYD             0x2386
>  #define I2C_PRODUCT_ID_RAYD_3118       0x3118
> +#define I2C_PRODUCT_ID_RAYD_4B33       0x4B33
>
>  #define USB_VENDOR_ID_HANWANG          0x0b57
>  #define USB_DEVICE_ID_HANWANG_TABLET_FIRST     0x5000
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index eae0cb3ddec6..5fd1159fc095 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -174,6 +174,8 @@ static const struct i2c_hid_quirks {
>                 I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>         { USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
>                 I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> +       { I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
> +               I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>         { 0, 0 }
>  };
>
> --
> 2.17.1
>
