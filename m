From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] Input: i8042 - add Gigabyte P57 to the keyboard reset table
Date: Thu, 17 Aug 2017 17:56:35 +0800
Message-ID: <CAAd53p5O=xztHfD=1r8LwWDAyLHVZQfvYhYs2RbX686Oqh+5mg@mail.gmail.com>
References: <20170712033953.16318-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:37754 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbdHQJ4h (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 05:56:37 -0400
Received: by mail-ua0-f180.google.com with SMTP id f9so22853005uaf.4
        for <linux-input@vger.kernel.org>; Thu, 17 Aug 2017 02:56:36 -0700 (PDT)
In-Reply-To: <20170712033953.16318-1-kai.heng.feng@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>

On Wed, Jul 12, 2017 at 11:39 AM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> Similar to other Gigabyte laptops, the touchpad on P57 requires a
> keyboard reset to detect Elantech touchpad correctly.
>
> BugLink: https://bugs.launchpad.net/bugs/1594214
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 09720d950686..1c6a49b5b93d 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -833,6 +833,13 @@ static const struct dmi_system_id __initconst i8042_dmi_kbdreset_table[] = {
>                 },
>         },
>         {
> +               /* Gigabyte P57 - Elantech touchpad */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "P57"),
> +               },
> +       },
> +       {
>                 /* Schenker XMG C504 - Elantech touchpad */
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "XMG"),
> --
> 2.13.2
>

Hi Dimitry,

Can you also take a look at this patch I sent in Jun? I guess this one
got slipped through :)

Thanks!
