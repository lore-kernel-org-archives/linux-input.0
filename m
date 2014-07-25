From: Sachin Kamat <spk.linux@gmail.com>
Subject: Re: [PATCH] Input: soc_button_array: Remove kfree on data allocated
 with devm_zalloc
Date: Fri, 25 Jul 2014 13:59:37 +0530
Message-ID: <CAK5sBcFMxKzB8KgSDTtfsGV173TV6Ji3VFNETVqgpGeHPS7LEg@mail.gmail.com>
References: <1406272180-25101-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406272180-25101-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pramod.gurav.etc@gmail.com
Cc: linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Pramod Gurav <pramod.gurav@smartplayin.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lejun Zhu <lejun.zhu@linux.intel.com>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 25, 2014 at 12:39 PM,  <pramod.gurav.etc@gmail.com> wrote:
> From: Pramod Gurav <pramod.gurav@smartplayin.com>
>
> This patch does below:
> - Removes kfree done on data allocated with devm_zalloc in probe
>   path of the driver.
> - Adds a check on return value from devm_kzalloc which was missing
>   and renames a lable from err_free_mem to err_mem.
> - Adds couple of dev_err on failure to allocate memory
>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> CC: Lejun Zhu <lejun.zhu@linux.intel.com>
> CC: Sachin Kamat <sachin.kamat@linaro.org>
>
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> ---
>  drivers/input/misc/soc_button_array.c |   19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index 5a6334b..ac82971 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -83,6 +83,13 @@ soc_button_device_create(struct pnp_dev *pdev,
>                                        sizeof(*gpio_keys_pdata) +
>                                         sizeof(*gpio_keys) * MAX_NBUTTONS,
>                                        GFP_KERNEL);
> +       if (!gpio_keys_pdata) {
> +               dev_err(&pdev->dev,
> +                       "Can't allocate memory for gpio_keys_platform_data\n");

OOM message is not needed as memory subsystem will take care of it.

> +               error = -ENOMEM;
> +               goto err_mem;

Return directly from here.

> +       }
> +
>         gpio_keys = (void *)(gpio_keys_pdata + 1);
>
>         for (info = button_info; info->name; info++) {
> @@ -104,7 +111,7 @@ soc_button_device_create(struct pnp_dev *pdev,
>
>         if (n_buttons == 0) {
>                 error = -ENODEV;
> -               goto err_free_mem;
> +               goto err_mem;

ditto

>         }
>
>         gpio_keys_pdata->buttons = gpio_keys;
> @@ -114,7 +121,7 @@ soc_button_device_create(struct pnp_dev *pdev,
>         pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
>         if (!pd) {
>                 error = -ENOMEM;
> -               goto err_free_mem;
> +               goto err_mem;

ditto

>         }
>
>         error = platform_device_add_data(pd, gpio_keys_pdata,
> @@ -130,8 +137,7 @@ soc_button_device_create(struct pnp_dev *pdev,
>
>  err_free_pdev:
>         platform_device_put(pd);
> -err_free_mem:
> -       devm_kfree(&pdev->dev, gpio_keys_pdata);
> +err_mem:

This label would not be required once returned directly from above.

>         return ERR_PTR(error);
>  }
>
> @@ -155,8 +161,11 @@ static int soc_button_pnp_probe(struct pnp_dev *pdev,
>         int error;
>
>         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -       if (!priv)
> +       if (!priv) {
> +               dev_err(&pdev->dev,
> +                       "Can't allocate memory for soc_button_data\n");

OOM message is not needed as memory subsystem will take care of it.


-- 
Regards,
Sachin.
