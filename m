From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/3] Input - soc_button_array: use gpio_is_valid()
Date: Tue, 10 May 2016 12:56:18 -0300
Message-ID: <CAOMZO5Avvy1BicUD-SwvUofpLtcEVyZHoceXSibq9wd1i7fX5A@mail.gmail.com>
References: <1462894673-26560-1-git-send-email-benjamin.tissoires@redhat.com>
	<1462894673-26560-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:34060 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbcEJP4T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 May 2016 11:56:19 -0400
In-Reply-To: <1462894673-26560-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>, Alexandre Courbot <acourbot@nvidia.com>, Lejun Zhu <lejun.zhu@linux.intel.com>

On Tue, May 10, 2016 at 12:37 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:

> @@ -92,7 +93,7 @@ soc_button_device_create(struct platform_device *pdev,
>                         continue;
>
>                 gpio = soc_button_lookup_gpio(&pdev->dev, info->acpi_index);
> -               if (gpio < 0)
> +               if (gpio_is_valid(gpio))

Shouldn't it be "if (!gpio_is_valid(gpio))" ?
