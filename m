Return-Path: <SRS0=Maqc=YL=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FDCCA9ED0
	for <linux-input@archiver.kernel.org>; Fri, 18 Oct 2019 04:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AC22070B
	for <linux-input@archiver.kernel.org>; Fri, 18 Oct 2019 04:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/SfQlwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395031AbfJRE4U (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 18 Oct 2019 00:56:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34914 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfJRE4T (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 18 Oct 2019 00:56:19 -0400
Received: by mail-io1-f65.google.com with SMTP id t18so1790066iog.2
        for <linux-input@vger.kernel.org>; Thu, 17 Oct 2019 21:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zENMsCD8dx7TXInXG1c8zW/Hg/QaJI92iPuy+e/kV6E=;
        b=W/SfQlwIceHYRgJXK7o3/l/lkWGdnSVrFfem2LS5AoOoZT7g6Q6t6pDrBEZ9+07t+M
         +Ti1hPL13mqCsIyQKq/AFE6C6lU+7LWFud86PSQDcCzlLOF/AJU7QWZGHjpr9KoU6M49
         nF6/6KbZeepbruq+UcDfkmHak9ysobHGjX46g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zENMsCD8dx7TXInXG1c8zW/Hg/QaJI92iPuy+e/kV6E=;
        b=L4zF2e9/Sq2w9Sq0CMZY/lBO5oWU3+Bj8UDfgs9WXndLE69cf4HfnZ2o2oGVH4c9+p
         KUH7fIxYxUsNzgymf8W5fuKgTMB773Yc0Ljww652ElWZLMUE/JIu54jn3qsvxy/svsI4
         J5rGoHB2cp5eXLU+UIn+FsQurBs+UrMxoRXja0Vg4i4Oou85KwXClN0KLxJat3efJ9+/
         rdzICXa2bgB6cgVZaNPH3q5pHyVg7xVF8A70s9Y0qXY8V52EaqfCaZwCHrUVVgeI9BAO
         qrrgEfd3JqY9WIhgp10+hVVAVJNqYC8kAA2AcAiBcl7/sZ1xC8nKpitH7o2kVsb3AnJ2
         04Ew==
X-Gm-Message-State: APjAAAU+i26Vnbd5Rg/lv8eq7hugdt348pOiA8d31kZwX+xz8ZE9eud8
        RGuqet0aQQzEB6lcvyGJ+W0MH8Iss6M8EF5KGhp7aq9y1AY=
X-Google-Smtp-Source: APXvYqwbU0rnTOMgSlBPq6asT4KTn47yVp25SmbpyYC2P+M0FWHZyEbDR4vduuE8vfeSHRbH2LfGtdyPTN5PaOcgFL4=
X-Received: by 2002:a63:2049:: with SMTP id r9mr7827967pgm.257.1571368471920;
 Thu, 17 Oct 2019 20:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191005101444.146554-1-ikjn@chromium.org>
In-Reply-To: <20191005101444.146554-1-ikjn@chromium.org>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 18 Oct 2019 11:14:21 +0800
Message-ID: <CAATdQgBRiNpwgy403jThUbgxSZA-Z8bYCQnc_rVB+nu4LwtMrA@mail.gmail.com>
Subject: Re: [PATCH 2/3] HID: google: Add of_match table to Whiskers switch device.
To:     jikos@kernel.org, Dmitry Torokhov <dtor@chromium.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

A gentle ping on adding DT binding for Hammer (2/2).

On Sat, Oct 5, 2019 at 6:14 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Add a device tree match table.
>
> Change-Id: Iaee68311073cefa4b99cde182bd37d1a67c94ea6
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---
>  drivers/hid/hid-google-hammer.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index 31e4a39946f5..bf2b6c6c9787 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -17,6 +17,7 @@
>  #include <linux/hid.h>
>  #include <linux/leds.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/platform_device.h>
> @@ -272,12 +273,21 @@ static const struct acpi_device_id cbas_ec_acpi_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, cbas_ec_acpi_ids);
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id cbas_ec_of_match[] = {
> +       { .compatible = "google,cros-cbas" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, cbas_ec_of_match);
> +#endif
> +
>  static struct platform_driver cbas_ec_driver = {
>         .probe = cbas_ec_probe,
>         .remove = cbas_ec_remove,
>         .driver = {
>                 .name = "cbas_ec",
>                 .acpi_match_table = ACPI_PTR(cbas_ec_acpi_ids),
> +               .of_match_table = of_match_ptr(cbas_ec_of_match),
>                 .pm = &cbas_ec_pm_ops,
>         },
>  };
> --
> 2.23.0.581.g78d2f28ef7-goog
>
