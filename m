From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Fix USB autosuspend on bcm5974
Date: Thu, 6 Oct 2011 15:38:35 -0700
Message-ID: <20111006223835.GA30738@core.coreip.homeip.net>
References: <1317936997-20438-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:52288 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759311Ab1JFWil (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 18:38:41 -0400
Received: by pzk1 with SMTP id 1so8070495pzk.1
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2011 15:38:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317936997-20438-1-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se

Hi Matthew,

On Thu, Oct 06, 2011 at 05:36:37PM -0400, Matthew Garrett wrote:
> The bcm5974 code takes a USB autosuspend reference on device open but
> only releases it if there's an error. Repeated opens will bump the count,

No, there won't be repeated opens as input core will not issue another
open unless everyone closes the device first (and then bcm5974_close
will drop the reference that is being held).

> which is clearly wrong. It's also unnecessary - the only part of the
> driver operation that is incompatible with autosuspend is the initial
> setup, and after that the device generates appropriate remote wakeups.
> Making the unreference unconditional fixes this.

... and makes counter unbalanced on close. If we change bcm5974_open()
as you are suggesting we need to adjust bcm5974_close() accordingly.

> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/input/mouse/bcm5974.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index 5ec617e..38d0286 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -764,8 +764,7 @@ static int bcm5974_open(struct input_dev *input)
>  
>  	mutex_unlock(&dev->pm_mutex);
>  
> -	if (error)
> -		usb_autopm_put_interface(dev->intf);
> +	usb_autopm_put_interface(dev->intf);
>  
>  	return error;
>  }

Thanks.

-- 
Dmitry
