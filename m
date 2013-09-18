From: Oskar Andero <oskar.andero@sonymobile.com>
Subject: Re: [PATCH v2] input: don't call input_dev_release_keys() in resume
Date: Wed, 18 Sep 2013 11:10:08 +0200
Message-ID: <20130918091008.GA23288@caracas.corpusers.net>
References: <1374754154-7990-1-git-send-email-oskar.andero@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:15230 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751625Ab3IRJUN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Sep 2013 05:20:13 -0400
Content-Disposition: inline
In-Reply-To: <1374754154-7990-1-git-send-email-oskar.andero@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: =?iso-8859-1?Q?Andersson=2C_Bj=F6rn?= <Bjorn.Andersson@sonymobile.com>, "Lekanovic, Radovan" <Radovan.Lekanovic@sonymobile.com>, "Makarov, Aleksej" <Aleksej.Makarov@sonymobile.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hii Dmitry,

On 14:09 Thu 25 Jul     , Oskar Andero wrote:
> From: Aleksej Makarov <aleksej.makarov@sonymobile.com>
> 
> When waking up the platform by pressing a specific key, sending a
> release on that key makes it impossible to react on the event in
> user-space. This is fixed by moving the input_reset_device() call to
> resume instead.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Radovan Lekanovic <radovan.lekanovic@sonymobile.com>
> Signed-off-by: Aleksej Makarov <aleksej.makarov@sonymobile.com>
> Signed-off-by: Oskar Andero <oskar.andero@sonymobile.com>
> ---
>  drivers/input/input.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index c044699..ee3ff16 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1676,22 +1676,13 @@ static int input_dev_suspend(struct device *dev)
>  {
>  	struct input_dev *input_dev = to_input_dev(dev);
>  
> -	mutex_lock(&input_dev->mutex);
> -
> -	if (input_dev->users)
> -		input_dev_toggle(input_dev, false);
> -
> -	mutex_unlock(&input_dev->mutex);
> +	input_reset_device(input_dev);
>  
>  	return 0;
>  }
>  
>  static int input_dev_resume(struct device *dev)
>  {
> -	struct input_dev *input_dev = to_input_dev(dev);
> -
> -	input_reset_device(input_dev);
> -
>  	return 0;
>  }

Sorry for bugging you with this patch again! I realize that changes to
input.c is sensitive since it's a central part of the subsystem.
However, the problem of reading input events after wake-up remains.

Does the patch make sense or do you see any potential risks with it?

Thanks,
 Oskar
