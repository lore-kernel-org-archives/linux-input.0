From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3] HID: i2c-hid: Ignore input report if there's no data
 present on Elan touchpanels
Date: Fri, 18 Jan 2019 16:50:32 +0100
Message-ID: <CAO-hwJKo=EaPoXJLGUvjq3QRng1V1NkO7A5zYGojbPyxxyJYHA@mail.gmail.com>
References: <20190107072429.23828-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107072429.23828-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Kai-Heng,

On Mon, Jan 7, 2019 at 8:24 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> While using Elan touchpads, the message floods:
> [  136.138487] i2c_hid i2c-DELL08D6:00: i2c_hid_get_input: incomplete report (14/65535)
>
> Though the message flood is annoying, the device it self works without
> any issue. I suspect that the device in question takes too much time to
> pull the IRQ back to high after I2C host has done reading its data.
>
> Since the host receives all useful data, let's ignore the input report
> when there's no data.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks for the v3.

This patch has just been brought to my attention, and I have one
question before applying it:
are those messages (without your patch) occurring all the time, or
just after resume?

I wonder if the pm_suspend delay we talked about in the other thread
would fix that issue in a cleaner way.

Cheers,
Benjamin

> ---
> v3:
> Fix compiler error/warnings.
>
> v2:
> Use dev_warn_once() to warn the user about the situation.
>
>  drivers/hid/i2c-hid/i2c-hid-core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 8555ce7e737b..2f940c1de616 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -50,6 +50,7 @@
>  #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET       BIT(1)
>  #define I2C_HID_QUIRK_NO_RUNTIME_PM            BIT(2)
>  #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP                BIT(3)
> +#define I2C_HID_QUIRK_BOGUS_IRQ                        BIT(4)
>
>  /* flags */
>  #define I2C_HID_STARTED                0
> @@ -179,6 +180,8 @@ static const struct i2c_hid_quirks {
>                 I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
>         { USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
>                 I2C_HID_QUIRK_NO_RUNTIME_PM },
> +       { USB_VENDOR_ID_ELAN, HID_ANY_ID,
> +                I2C_HID_QUIRK_BOGUS_IRQ },
>         { 0, 0 }
>  };
>
> @@ -503,6 +506,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
>                 return;
>         }
>
> +       if (ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ && ret_size == 0xffff) {
> +               dev_warn_once(&ihid->client->dev, "%s: IRQ triggered but "
> +                             "there's no data\n", __func__);
> +               return;
> +       }
> +
>         if ((ret_size > size) || (ret_size < 2)) {
>                 dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
>                         __func__, size, ret_size);
> --
> 2.17.1
>
