From: Oskar Andero <oskar.andero@sonymobile.com>
Subject: Re: [PATCH] input: don't call input_dev_release_keys() in resume
Date: Thu, 4 Apr 2013 16:57:02 +0200
Message-ID: <20130404145702.GE2481@caracas.corpusers.net>
References: <1362664882-16194-1-git-send-email-oskar.andero@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:13370 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762538Ab3DDO5F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 4 Apr 2013 10:57:05 -0400
Content-Disposition: inline
In-Reply-To: <1362664882-16194-1-git-send-email-oskar.andero@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "Makarov, Aleksej" <Aleksej.Makarov@sonymobile.com>, Radovan Lekanovic <radovan.lekanovic@sonymobile.com>

On 15:01 Thu 07 Mar     , oskar.andero@sonymobile.com wrote:
> From: Aleksej Makarov <aleksej.makarov@sonymobile.com>
> 
> When waking up the platform by pressing a specific key, sending a
> release on that key makes it impossible to react on the event in
> user-space.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Radovan Lekanovic <radovan.lekanovic@sonymobile.com>
> Signed-off-by: Aleksej Makarov <aleksej.makarov@sonymobile.com>
> Signed-off-by: Oskar Andero <oskar.andero@sonymobile.com>
> ---
>  drivers/input/input.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index c044699..61ce19f 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1690,7 +1690,10 @@ static int input_dev_resume(struct device *dev)
>  {
>  	struct input_dev *input_dev = to_input_dev(dev);
>  
> -	input_reset_device(input_dev);
> +	mutex_lock(&input_dev->mutex);
> +	if (input_dev->users)
> +		input_dev_toggle(input_dev, true);
> +	mutex_unlock(&input_dev->mutex);
>  
>  	return 0;
>  }
> -- 
> 1.7.8.6
> 

Ping. Any input on the patch above?

-Oskar
