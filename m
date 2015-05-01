From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/3] HID: wacom: Do not add suffix to name of devices
 with an unknown type
Date: Fri, 1 May 2015 16:35:12 -0400
Message-ID: <20150501203512.GB10988@mail.corp.redhat.com>
References: <1430441515-30122-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51055 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbbEAUfT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 May 2015 16:35:19 -0400
Content-Disposition: inline
In-Reply-To: <1430441515-30122-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

Hi Jason,

On Apr 30 2015 or thereabouts, Jason Gerecke wrote:
> The naming logic currently assumes that all devices will be a pen, finger,
> or pad. Though this has historically been the case, the new HID_GENERIC
> catch-all may cause us to probe devices with Wacom's 056A VID which aren't
> any of these types (e.g. the "Cintiq 24HDT Monitor Control"). This patch
> updates the logic so that no suffix will be added to the device name if
> the device type is unknown.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---

I am not sure we need to split 2/3 & 3/3. But either way is fine.
I checked against a Bamboo PAD, Intuos Pro and a Bamboo Pen&Touch,
and everything seems to be fine.

The whole series is:

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/wacom_sys.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 9c57ac0..222baf5 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1440,12 +1440,15 @@ static void wacom_update_name(struct wacom *wacom)
>  	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
>  		"%s Pad", wacom_wac->name);
>  
> -	if (features->device_type != BTN_TOOL_FINGER)
> +	if (features->device_type == BTN_TOOL_PEN) {
>  		strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
> -	else if (features->touch_max)
> -		strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
> -	else
> -		strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
> +	}
> +	else if (features->device_type == BTN_TOOL_FINGER) {
> +		if (features->touch_max)
> +			strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
> +		else
> +			strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
> +	}
>  }
>  
>  static int wacom_probe(struct hid_device *hdev,
> -- 
> 2.3.5
> 
