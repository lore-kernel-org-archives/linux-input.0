From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: usbhid: extend polling interval configuration to
 joysticks
Date: Tue, 28 Feb 2017 18:06:25 +0100
Message-ID: <20170228170625.GB7064@mail.corp.redhat.com>
References: <1488050847-6250-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbdB1RHR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 12:07:17 -0500
Content-Disposition: inline
In-Reply-To: <1488050847-6250-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: jikos@kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Feb 25 2017 or thereabouts, Tobias Jakobi wrote:
> For mouse devices we can currently change the polling interval
> via usbhid.mousepoll. Implement the same thing for joysticks, so
> users can reduce input latency this way.
> 
> This has been tested with a Logitech RumblePad 2 with jspoll=2,
> resulting in a polling rate of 500Hz (verified with evhz).
> 
> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> ---

Looks good to me.

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  Documentation/kernel-parameters.txt |  3 +++
>  drivers/hid/usbhid/hid-core.c       | 18 +++++++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 922dec8..928ce2c 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -4260,6 +4260,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  	usbhid.mousepoll=
>  			[USBHID] The interval which mice are to be polled at.
>  
> +	usbhid.jspoll=
> +			[USBHID] The interval which joysticks are to be polled at.
> +
>  	usb-storage.delay_use=
>  			[UMS] The delay in seconds before a new device is
>  			scanned for Logical Units (default 1).
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index ae83af6..f7a692f 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -53,6 +53,10 @@ static unsigned int hid_mousepoll_interval;
>  module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
>  MODULE_PARM_DESC(mousepoll, "Polling interval of mice");
>  
> +static unsigned int hid_jspoll_interval;
> +module_param_named(jspoll, hid_jspoll_interval, uint, 0644);
> +MODULE_PARM_DESC(jspoll, "Polling interval of joysticks");
> +
>  static unsigned int ignoreled;
>  module_param_named(ignoreled, ignoreled, uint, 0644);
>  MODULE_PARM_DESC(ignoreled, "Autosuspend with active leds");
> @@ -1082,9 +1086,17 @@ static int usbhid_start(struct hid_device *hid)
>  			       hid->name, endpoint->bInterval, interval);
>  		}
>  
> -		/* Change the polling interval of mice. */
> -		if (hid->collection->usage == HID_GD_MOUSE && hid_mousepoll_interval > 0)
> -			interval = hid_mousepoll_interval;
> +		/* Change the polling interval of mice and joysticks. */
> +		switch (hid->collection->usage) {
> +		case HID_GD_MOUSE:
> +			if (hid_mousepoll_interval > 0)
> +				interval = hid_mousepoll_interval;
> +			break;
> +		case HID_GD_JOYSTICK:
> +			if (hid_jspoll_interval > 0)
> +				interval = hid_jspoll_interval;
> +			break;
> +		}
>  
>  		ret = -ENOMEM;
>  		if (usb_endpoint_dir_in(endpoint)) {
> -- 
> 2.7.3
> 
