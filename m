From: Charles Mooney <charliemooney@chromium.org>
Subject: Re: [PATCH] Input: elants_i2c - zero-extend hardware ID in firmware name
Date: Mon, 20 Apr 2015 10:02:12 -0700
Message-ID: <CAJ34Pp7sufWV9J9SSGcy0NrhdWosXHHu1Dk7GCCboV9SmBhEWA@mail.gmail.com>
References: <20150418034336.GA31454@dtor-ws>
Reply-To: charliemooney@chromium.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150418034336.GA31454@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Scott Liu <scott.liu@emc.com.tw>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 17, 2015 at 8:43 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Let's zero-extend hardware id number when forming firmware file name,
> to avoid kernel requesting firmware like "elants_i2c_   0.bin", which
> is quite unexpected.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/elants_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index 43b3c9c..0efd766 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -699,7 +699,7 @@ static int elants_i2c_fw_update(struct elants_data *ts)
>         char *fw_name;
>         int error;
>
> -       fw_name = kasprintf(GFP_KERNEL, "elants_i2c_%4x.bin", ts->hw_version);
> +       fw_name = kasprintf(GFP_KERNEL, "elants_i2c_%04x.bin", ts->hw_version);
>         if (!fw_name)
>                 return -ENOMEM;
>
> --
> 2.2.0.rc0.207.ga3a616c
>
>
> --
> Dmitry

Looks good to me.

Acked-by: Charlie Mooney<charliemooney@chromium.org>
