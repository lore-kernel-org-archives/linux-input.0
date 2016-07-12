From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 25/27] HID: wacom: leds: fix ordering of LED banks
Date: Tue, 12 Jul 2016 11:52:45 +1000
Message-ID: <20160712015245.GB25180@jelly.local>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
 <1467729563-23318-26-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:57740 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbcGLBw5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 21:52:57 -0400
Content-Disposition: inline
In-Reply-To: <1467729563-23318-26-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Jul 05, 2016 at 04:39:21PM +0200, Benjamin Tissoires wrote:
> Historically, 21UX2 and 24HD have the select groups inverted
> (0 is the right LED bank, and 1 the left one).
> 
> This is not right, so fix that in the new LED API. For backward
> compatibility, we keep the wacom_led sysfs ABI stable. We don't
> need to care about luminance for these two devices as only the
> select sysfs file gets exported (brightness is not configurable).

For the archives:
unfortunately we can't do this, it breaks userspace, sort-of. Due to the
information we require about wacom tablets that isn't accessible from the
device we rely heavily on libwacom. libwacom already has calls to return the
led group based on the button index, changing the order means those values
are now incorrect. And since clients using libwacom don't necessarily have
access to the sysfs or know whether the underlying process uses the old or
new sysfs approach we can't hack around this either.

so we'll have to stick with the inverted ordering of led groups.

Cheers,
   Peter

> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/wacom_sys.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index b88896c..153e453 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -683,8 +683,10 @@ static int wacom_led_control(struct wacom *wacom)
>  		int led = wacom->led.groups[0].select | 0x4;
>  
>  		if (wacom->wacom_wac.features.type == WACOM_21UX2 ||
> -		    wacom->wacom_wac.features.type == WACOM_24HD)
> -			led |= (wacom->led.groups[1].select << 4) | 0x40;
> +		    wacom->wacom_wac.features.type == WACOM_24HD) {
> +			led <<= 4;
> +			led |= wacom->led.groups[1].select | 0x04;
> +		}
>  
>  		buf[0] = report_id;
>  		buf[1] = led;
> @@ -742,6 +744,19 @@ out:
>  	return retval;
>  }
>  
> +static inline int wacom_led_select_get_id(struct wacom *wacom, int set_id)
> +{
> +	/*
> +	 * Historically, 21UX2 and 24HD have the select groups inverted
> +	 * (0 is the right LED bank, and 1 the left one)
> +	 */
> +	if (wacom->wacom_wac.features.type == WACOM_21UX2 ||
> +	    wacom->wacom_wac.features.type == WACOM_24HD)
> +		return 1 - set_id;
> +
> +	return set_id;
> +}
> +
>  static ssize_t wacom_led_select_store(struct device *dev, int set_id,
>  				      const char *buf, size_t count)
>  {
> @@ -754,6 +769,8 @@ static ssize_t wacom_led_select_store(struct device *dev, int set_id,
>  	if (err)
>  		return err;
>  
> +	set_id = wacom_led_select_get_id(wacom, set_id);
> +
>  	mutex_lock(&wacom->lock);
>  
>  	wacom->led.groups[set_id].select = id & 0x3;
> @@ -775,8 +792,9 @@ static ssize_t wacom_led##SET_ID##_select_show(struct device *dev,	\
>  {									\
>  	struct hid_device *hdev = to_hid_device(dev);\
>  	struct wacom *wacom = hid_get_drvdata(hdev);			\
> +	int set_id = wacom_led_select_get_id(wacom, SET_ID);		\
>  	return scnprintf(buf, PAGE_SIZE, "%d\n",			\
> -			 wacom->led.groups[SET_ID].select);		\
> +			 wacom->led.groups[set_id].select);		\
>  }									\
>  static DEVICE_ATTR(status_led##SET_ID##_select, DEV_ATTR_RW_PERM,	\
>  		    wacom_led##SET_ID##_select_show,			\
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
