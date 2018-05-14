From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: check if device is there before really probing
Date: Mon, 14 May 2018 10:29:56 +0200
Message-ID: <CAO-hwJKp74oC5M1EWf5YS42G7fM2disWrW0mfOSnVi-PGH_ryA@mail.gmail.com>
References: <20180509191215.77406-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509191215.77406-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

On Wed, May 9, 2018 at 9:12 PM, Dmitry Torokhov <dtor@google.com> wrote:
> From: Dmitry Torokhov <dtor@chromium.org>
>
> On many Chromebooks touch devices are multi-sourced; the components are
> electrically compatible and one can be freely swapped for another without
> changing the OS image or firmware.
>
> To avoid bunch of scary messages when device is not actually present in the
> system let's try testing basic communication with it and if there is no
> response terminate probe early with -ENXIO.
>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---

Looks good. Tested on a Dell XPS with an i2c-hid touchpad:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/i2c-hid/i2c-hid.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 7230243b94d30..a59d483ff316a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1048,6 +1048,14 @@ static int i2c_hid_probe(struct i2c_client *client,
>         pm_runtime_enable(&client->dev);
>         device_enable_async_suspend(&client->dev);
>
> +       /* Make sure there is something at this address */
> +       ret = i2c_smbus_read_byte(client);
> +       if (ret < 0) {
> +               dev_dbg(&client->dev, "nothing at this address: %d\n", ret);
> +               ret = -ENXIO;
> +               goto err_pm;
> +       }
> +
>         ret = i2c_hid_fetch_hid_descriptor(ihid);
>         if (ret < 0)
>                 goto err_pm;
> --
> 2.17.0.441.gb46fe60e1d-goog
>
