From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] input: ambakmi: Fix system PM by converting to modern callbacks
Date: Fri, 22 May 2015 16:37:12 +0200
Message-ID: <CAPDyKFrhC1MCmOfoweztNtzk-Spwhj1uj7-sz3UtJhT_bHDQ+g@mail.gmail.com>
References: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:34707 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127AbbEVOhN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 10:37:13 -0400
Received: by qctt3 with SMTP id t3so8826560qct.1
        for <linux-input@vger.kernel.org>; Fri, 22 May 2015 07:37:12 -0700 (PDT)
In-Reply-To: <1429008108-29295-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 14 April 2015 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The legacy system PM support has long time ago been dropped from the
> AMBA bus. Align to that by converting to the modern system PM
> callbacks.
>
> Fixes: 26825cfd90f9 (ARM: 7914/1: amba: Drop legacy PM support ...)
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

What happened with this one? Can we queue it for 4.2?

Kind regards
Uffe

> ---
>  drivers/input/serio/ambakmi.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
> index 8b748d9..058e1d8 100644
> --- a/drivers/input/serio/ambakmi.c
> +++ b/drivers/input/serio/ambakmi.c
> @@ -175,15 +175,19 @@ static int amba_kmi_remove(struct amba_device *dev)
>         return 0;
>  }
>
> -static int amba_kmi_resume(struct amba_device *dev)
> +#ifdef CONFIG_PM_SLEEP
> +static int amba_kmi_resume(struct device *dev)
>  {
> -       struct amba_kmi_port *kmi = amba_get_drvdata(dev);
> +       struct amba_kmi_port *kmi = dev_get_drvdata(dev);
>
>         /* kick the serio layer to rescan this port */
>         serio_reconnect(kmi->io);
>
>         return 0;
>  }
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(amba_kmi_dev_pm_ops, NULL, amba_kmi_resume);
>
>  static struct amba_id amba_kmi_idtable[] = {
>         {
> @@ -199,11 +203,11 @@ static struct amba_driver ambakmi_driver = {
>         .drv            = {
>                 .name   = "kmi-pl050",
>                 .owner  = THIS_MODULE,
> +               .pm     = &amba_kmi_dev_pm_ops,
>         },
>         .id_table       = amba_kmi_idtable,
>         .probe          = amba_kmi_probe,
>         .remove         = amba_kmi_remove,
> -       .resume         = amba_kmi_resume,
>  };
>
>  module_amba_driver(ambakmi_driver);
> --
> 1.9.1
>
