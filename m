From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] input: sirfsoc-onkey - set the capability of reporting KEY_POWER
Date: Thu, 27 Mar 2014 15:35:46 +0800
Message-ID: <CAGsJ_4wda0XnP9ML4e35_sjz8M5Qese-2yaeBVYBsW7gHEczxg@mail.gmail.com>
References: <1393335375-1870-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:32774 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753406AbaC0HgH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Mar 2014 03:36:07 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so2984873pdj.18
        for <linux-input@vger.kernel.org>; Thu, 27 Mar 2014 00:36:06 -0700 (PDT)
In-Reply-To: <1393335375-1870-1-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Baohua.Song@csr.com>

2014-02-25 21:36 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> From: Xianglong Du <Xianglong.Du@csr.com>
>
> commit a1a7521064428fc1cf8 moved to report EV_KEY event(KEY_POWER) instead of
> reporting EV_PWR event(KEY_SUSPEND), but it didn't enable the capability, so
> the KEY_POWER will not be reported to userspace by input core. this patch fixes
> the issue.
>
> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---

Dmitry, i guess you missed this one, this one should be in 3.15,
otherwise, onkey is broken.


>  drivers/input/misc/sirfsoc-onkey.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
> index 4d66c72..e4104f9 100644
> --- a/drivers/input/misc/sirfsoc-onkey.c
> +++ b/drivers/input/misc/sirfsoc-onkey.c
> @@ -136,6 +136,7 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
>         pwrcdrv->input->name = "sirfsoc pwrckey";
>         pwrcdrv->input->phys = "pwrc/input0";
>         pwrcdrv->input->evbit[0] = BIT_MASK(EV_KEY);
> +       input_set_capability(pwrcdrv->input, EV_KEY, KEY_POWER);
>
>         INIT_DELAYED_WORK(&pwrcdrv->work, sirfsoc_pwrc_report_event);
>
> --
> 1.7.9.5
>

-barry
