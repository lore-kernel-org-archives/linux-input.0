From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH 1/3] HID: google: whiskers: more robust tablet mode detection
Date: Mon, 16 Sep 2019 11:26:16 +0800
Message-ID: <CANMq1KALGLdZmOgcrrOROU5BXjwnXWSfq6fr85jfRn079JympQ@mail.gmail.com>
References: <20190913220317.58289-1-dtor@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190913220317.58289-1-dtor@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 14, 2019 at 6:03 AM Dmitry Torokhov <dtor@chromium.org> wrote:
>
> The USB interface may get detected before the platform/EC one, so let's
> note the state of the base (if we receive event) and use it to correctly
> initialize the tablet mode switch state.
>
> Also let's start the HID interface immediately when probing, this will
> ensure that we correctly process "base folded" events that may be sent
> as we initialize the base. Note that this requires us to add a release()

s/release/remove/ ?

> function where we stop and close the hardware and switch the LED
> registration away from devm interface as we need to make sure that we
> destroy the LED instance before we stop the hardware.
>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  drivers/hid/hid-google-hammer.c | 71 ++++++++++++++++++++++++++-------
>  1 file changed, 56 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index 84f8c127ebdc..4f64f93ddfcb 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -208,7 +209,14 @@ static int __cbas_ec_probe(struct platform_device *pdev)
>                 return error;
>         }
>
> -       input_report_switch(input, SW_TABLET_MODE, !cbas_ec.base_present);
> +       if (!cbas_ec.base_present)
> +               cbas_ec.base_folded = false;

I'm not sure to see why this is necessary? The folded base state
should be in bss and false anyway, and even if it was true, it would
not change the result of the expression below (!cbas_ec.base_present
|| cbas_ec.base_folded).

> +
> +       dev_dbg(&pdev->dev, "%s: base: %d, folded: %d\n", __func__,
> +               cbas_ec.base_present, cbas_ec.base_folded);
> +
> +       input_report_switch(input, SW_TABLET_MODE,
> +                           !cbas_ec.base_present || cbas_ec.base_folded);
>
>         cbas_ec_set_input(input);
>
