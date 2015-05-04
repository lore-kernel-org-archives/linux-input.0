From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3 3/3] mfd: da9063: MFD support for OnKey driver
Date: Mon, 4 May 2015 09:46:43 +0200
Message-ID: <CAMuHMdW43GHj-iO1F9gjHsjYOvvycjrP6WPyCKSOvcpcwPsM-w@mail.gmail.com>
References: <cover.1430393194.git.stwiss.opensource@diasemi.com>
	<639fd177d5ddd4ce80df45f9d774cc971b286ef9.1430393194.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34338 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbEDHqo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 May 2015 03:46:44 -0400
In-Reply-To: <639fd177d5ddd4ce80df45f9d774cc971b286ef9.1430393194.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>

Hi Steve,

On Thu, Apr 30, 2015 at 1:26 PM, S Twiss <stwiss.opensource@diasemi.com> wrote:
> Add MFD support for the DA9063 OnKey driver

Thanks  for your patch!

> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -60,6 +60,7 @@ static struct resource da9063_rtc_resources[] = {
>
>  static struct resource da9063_onkey_resources[] = {
>         {
> +               .name   = "ONKEY",
>                 .start  = DA9063_IRQ_ONKEY,
>                 .end    = DA9063_IRQ_ONKEY,
>                 .flags  = IORESOURCE_IRQ,
> @@ -97,6 +98,7 @@ static const struct mfd_cell da9063_devs[] = {
>                 .name           = DA9063_DRVNAME_ONKEY,
>                 .num_resources  = ARRAY_SIZE(da9063_onkey_resources),
>                 .resources      = da9063_onkey_resources,
> +               .of_compatible = "dlg,da9063-onkey",
>         },
>         {
>                 .name           = DA9063_DRVNAME_RTC,
> @@ -109,12 +111,64 @@ static const struct mfd_cell da9063_devs[] = {
>         },
>  };
>
> +static int da9063_clear_fault_log(struct da9063 *da9063)
> +{
> +       int ret = 0;
> +       int fault_log = 0;
> +
> +       ret = regmap_read(da9063->regmap, DA9063_REG_FAULT_LOG, &fault_log);
> +       if (ret < 0) {
> +               dev_err(da9063->dev, "Cannot read FAULT_LOG.\n");
> +               return -EIO;
> +       }
> +
> +       if (fault_log) {
> +               if (fault_log & DA9063_TWD_ERROR)
> +                       dev_dbg(da9063->dev,
> +                               "Fault log entry detected: DA9063_TWD_ERROR\n");
> +               if (fault_log & DA9063_POR)
> +                       dev_dbg(da9063->dev,
> +                               "Fault log entry detected: DA9063_POR\n");
> +               if (fault_log & DA9063_VDD_FAULT)
> +                       dev_dbg(da9063->dev,
> +                               "Fault log entry detected: DA9063_VDD_FAULT\n");
> +               if (fault_log & DA9063_VDD_START)
> +                       dev_dbg(da9063->dev,
> +                               "Fault log entry detected: DA9063_VDD_START\n");
> +               if (fault_log & DA9063_TEMP_CRIT)
> +                       dev_dbg(da9063->dev,
> +                               "Fault log entry detected: DA9063_TEMP_CRIT\n");
> +               if (fault_log & DA9063_KEY_RESET)
> +                       dev_dbg(da9063->dev,
> +                               "Fault log entry detected: DA9063_KEY_RESET\n");
> +               if (fault_log & DA9063_NSHUTDOWN)
> +                       dev_dbg(da9063->dev,
> +                               "Fault log entry detected: DA9063_NSHUTDOWN\n");
> +               if (fault_log & DA9063_WAIT_SHUT)
> +                       dev_dbg(da9063->dev,
> +                               "Fault log entry detected: DA9063_WAIT_SHUT\n");
> +       }
> +
> +       ret = regmap_write(da9063->regmap,
> +                          DA9063_REG_FAULT_LOG,
> +                          fault_log);
> +       if (ret < 0)
> +               dev_err(da9063->dev,
> +                       "Cannot reset FAULT_LOG values %d\n", ret);
> +
> +       return ret;
> +}
> +
>  int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  {
>         struct da9063_pdata *pdata = da9063->dev->platform_data;
>         int model, variant_id, variant_code;
>         int ret;
>
> +       ret = da9063_clear_fault_log(da9063);
> +       if (ret < 0)
> +               dev_err(da9063->dev, "Cannot clear fault log\n");
> +
>         if (pdata) {
>                 da9063->flags = pdata->flags;
>                 da9063->irq_base = pdata->irq_base;

The code above doesn't seem to match the patch description.
Can you please explain why it is needed?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
