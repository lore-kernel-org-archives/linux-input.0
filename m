From: Crag Wang <crag0715@gmail.com>
Subject: Re: [PATCH] input: touchscreen: add delay time to device power on
Date: Wed, 10 Jul 2019 16:58:40 +0800
Message-ID: <CAP-8N0hTEXkK3iqGP=+gtuVVcqo-+KYHC_N6+8Q90ndf_UVJpA@mail.gmail.com>
References: <20190710025859.6025-1-crag0715@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710025859.6025-1-crag0715@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yjjung@melfas.com, jsj1012@melfas.com, leesh832@lgdisplay.com
Cc: Mario Limonciello <mario_limonciello@dell.com>, chrome.os.engineering@dell.com, "Crag.Wang" <crag.wang@dell.com>, Sangwon Jee <jeesw@melfas.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Adding more

On Wed, Jul 10, 2019 at 10:59 AM <crag0715@gmail.com> wrote:
>
> From: "Crag.Wang" <crag.wang@dell.com>
>
> Delay time for MELFAS MIP4 controller is required at power on stage
> regardless the existence of GPIO consumer lookup from devicetree or
> ACPI device table.
>
> There is an issue if GPIO ce is undefined in the ACPI results no delay
> time for deive power on, the controller ended up in an abnormal state.
>
> TEST=echo i2c-MLFS0000:00 > /sys/bus/i2c/drivers/mip4_ts/unbind
>      verify the touch function is off
>
>      echo i2c-MLFS0000:00 > /sys/bus/i2c/drivers/mip4_ts/bind
>      verify the touch function is on
>
> Signed-off-by: Crag.Wang <crag.wang@dell.com>
> ---
>  drivers/input/touchscreen/melfas_mip4.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
> index 430a2bc5f7ca..8e803658fb43 100644
> --- a/drivers/input/touchscreen/melfas_mip4.c
> +++ b/drivers/input/touchscreen/melfas_mip4.c
> @@ -374,12 +374,11 @@ static int mip4_query_device(struct mip4_ts *ts)
>
>  static int mip4_power_on(struct mip4_ts *ts)
>  {
> -       if (ts->gpio_ce) {
> +       if (ts->gpio_ce)
>                 gpiod_set_value_cansleep(ts->gpio_ce, 1);
>
> -               /* Booting delay : 200~300ms */
> -               usleep_range(200 * 1000, 300 * 1000);
> -       }
> +       /* Booting delay : 200~300ms */
> +       usleep_range(200 * 1000, 300 * 1000);
>
>         return 0;
>  }
> --
> 2.20.1
>
