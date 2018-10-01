From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: Add a small delay after powering on/off the device
Date: Mon, 1 Oct 2018 09:00:52 +0200
Message-ID: <CAO-hwJKhyVjfNsiEK-a16KGPdtfgrtnQ0XgxLyBqUhHVaS8AOA@mail.gmail.com>
References: <20181001035313.21453-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001035313.21453-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 1, 2018 at 5:53 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Raydium touchpanel (2386:4B33) sometimes does not workin desktop session
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

I think you want something similar to
https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git/commit/?h=for-next&id=807588ac92018bde88a1958f546438e840eb0158

>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index f3076659361a..ff5682cc1bce 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -409,6 +409,8 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>
>         if (ret)
>                 dev_err(&client->dev, "failed to change power setting.\n");
> +       else
> +               msleep(20);

We shouldn't have this error in the first place, so adding a timeout
will just add a band-aid on top of an other issue.

I really think the solution from Anisse would work in your case and
will be nicer.

Cheers,
Benjamin

>
>  set_pwr_exit:
>         return ret;
> --
> 2.17.1
>
