From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: twl6040_vibra - remove unneeded check for CONFIG_OF
Date: Sat, 4 Jan 2014 11:30:24 +0100
Message-ID: <CANq1E4RV-x4VD3yzpf74sU4nYxmu915Fc=JwuBGh11Z-Q6zV+Q@mail.gmail.com>
References: <20140104081142.GA3987@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140104081142.GA3987@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi

On Sat, Jan 4, 2014 at 9:11 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Since the driver requires DT now we do not need to check if CONFIG_OF is
> defined.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/twl6040-vibra.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
> index 89bca76..77dc23b 100644
> --- a/drivers/input/misc/twl6040-vibra.c
> +++ b/drivers/input/misc/twl6040-vibra.c
> @@ -258,17 +258,14 @@ static SIMPLE_DEV_PM_OPS(twl6040_vibra_pm_ops, twl6040_vibra_suspend, NULL);
>  static int twl6040_vibra_probe(struct platform_device *pdev)
>  {
>         struct device *twl6040_core_dev = pdev->dev.parent;
> -       struct device_node *twl6040_core_node = NULL;
> +       struct device_node *twl6040_core_node;
>         struct vibra_info *info;
>         int vddvibl_uV = 0;
>         int vddvibr_uV = 0;
>         int ret;
>
> -#ifdef CONFIG_OF
>         twl6040_core_node = of_find_node_by_name(twl6040_core_dev->of_node,
>                                                  "vibra");

If CONFIG_OF=n, of_find_node_by_name() always returns NULL. See
include/linux/of.h. So no need to depend on DT.

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

> -#endif
> -
>         if (!twl6040_core_node) {
>                 dev_err(&pdev->dev, "parent of node is missing?\n");
>                 return -EINVAL;
> --
> 1.8.4.2
>
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
