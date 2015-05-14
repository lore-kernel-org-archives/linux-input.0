From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: wacom: Allow wacom_{get,set}_report to retry on
 -EAGAIN
Date: Thu, 14 May 2015 10:21:32 -0400
Message-ID: <20150514142132.GC23647@mail.corp.redhat.com>
References: <1431120302-13691-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39210 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbbENOVf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2015 10:21:35 -0400
Content-Disposition: inline
In-Reply-To: <1431120302-13691-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, jono <lejono@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

Hi Jason,

On May 08 2015 or thereabouts, Jason Gerecke wrote:
> If we get an -EAGAIN error within either of the wacom_{get,set}_report
> functions, we should use one of our retries if available. Also, log an error
> if the functions fail so that we can be aware of what's going on.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
>  drivers/hid/wacom_sys.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 7abf52c..3cd74d9 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -35,7 +35,11 @@ static int wacom_get_report(struct hid_device *hdev, u8 type, u8 *buf,
>  	do {
>  		retval = hid_hw_raw_request(hdev, buf[0], buf, size, type,
>  				HID_REQ_GET_REPORT);
> -	} while ((retval == -ETIMEDOUT || retval == -EPIPE) && --retries);
> +	} while ((retval == -ETIMEDOUT || retval == -EPIPE || retval == -EAGAIN) && --retries);

I am not sure we should retry if the error is different than -EAGAIN.
TIMEDOUT might be possible but IMO, EPIPE means there is something wrong
and the retry will likely fail too.

> +
> +	if (retval < 0)
> +		dev_err(&hdev->dev, "wacom_get_report: ran out of retries "

nitpick but you could use "hid_err(hdev" instead of a plain dev_err.

> +			"(last error = %d)\n", retval);
>  
>  	return retval;
>  }
> @@ -48,7 +52,11 @@ static int wacom_set_report(struct hid_device *hdev, u8 type, u8 *buf,
>  	do {
>  		retval = hid_hw_raw_request(hdev, buf[0], buf, size, type,
>  				HID_REQ_SET_REPORT);
> -	} while ((retval == -ETIMEDOUT || retval == -EPIPE) && --retries);
> +	} while ((retval == -ETIMEDOUT || retval == -EPIPE || retval == -EAGAIN) && --retries);
> +
> +	if (retval < 0)
> +		dev_err(&hdev->dev, "wacom_set_report: ran out of retries "
> +			"(last error = %d)\n", retval);

dito

Cheers,
Benjamin

>  
>  	return retval;
>  }
> -- 
> 2.4.0
> 
