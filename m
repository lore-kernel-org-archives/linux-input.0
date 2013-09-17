From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/4] Input: cobalt_btns - Remove redundant dev_set_drvdata
Date: Tue, 17 Sep 2013 14:41:08 +0530
Message-ID: <CAK9yfHyo4oypRTKh_=Z+jWprWaHJyufevBcGPtyrLMaOQ4nwmQ@mail.gmail.com>
References: <1378490888-5083-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:65177 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab3IQJLJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Sep 2013 05:11:09 -0400
Received: by mail-ob0-f172.google.com with SMTP id gq1so5019047obb.31
        for <linux-input@vger.kernel.org>; Tue, 17 Sep 2013 02:11:08 -0700 (PDT)
In-Reply-To: <1378490888-5083-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sachin Kamat <sachin.kamat@linaro.org>

Hi Dmitry,

Now that the merge window is closed, a gentle ping on this series :)

On 6 September 2013 23:38, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Driver core sets the data to NULL upon release or probe
> failure. Hence explicit setting is not necessary.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Yoichi Yuasa <yuasa@linux-mips.org>
> ---
>  drivers/input/misc/cobalt_btns.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/misc/cobalt_btns.c b/drivers/input/misc/cobalt_btns.c
> index 4f77f87..b5d71d2 100644
> --- a/drivers/input/misc/cobalt_btns.c
> +++ b/drivers/input/misc/cobalt_btns.c
> @@ -131,7 +131,6 @@ static int cobalt_buttons_probe(struct platform_device *pdev)
>   err_free_mem:
>         input_free_polled_device(poll_dev);
>         kfree(bdev);
> -       dev_set_drvdata(&pdev->dev, NULL);
>         return error;
>  }
>
> @@ -144,7 +143,6 @@ static int cobalt_buttons_remove(struct platform_device *pdev)
>         input_free_polled_device(bdev->poll_dev);
>         iounmap(bdev->reg);
>         kfree(bdev);
> -       dev_set_drvdata(dev, NULL);
>
>         return 0;
>  }
> --
> 1.7.4.1
>



-- 
With warm regards,
Sachin
