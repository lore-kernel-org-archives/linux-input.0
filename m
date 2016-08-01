From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] input/hid: Add a new Saitek mouse device ID (RAT 9)
Date: Mon, 1 Aug 2016 11:21:49 +0200
Message-ID: <20160801092149.GT19383@mail.corp.redhat.com>
References: <20160730115339.16542-1-mayeul@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54418 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbcHAJbp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Aug 2016 05:31:45 -0400
Content-Disposition: inline
In-Reply-To: <20160730115339.16542-1-mayeul@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mayeul Cantan <mayeul.cantan@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Mayeul,

On Jul 30 2016 or thereabouts, Mayeul Cantan wrote:
> From: Mayeul Cantan <mayeul.cantan@gmail.com>
> 
> The new device has 06a3:0cfa as identifiers, and the same quirks as the
> other RAT models. It needs this fix in order not to confuse the xorg server
> with its tristate button, which is reported as three different buttons, one
> of which is always on.
> This commit also fixes a small trailing whitespace issue in hid/hid-core.c
> 
> Signed-off-by: Mayeul Cantan <mayeul.cantan@gmail.com>
> ---
> This patch is quite trivial, I am using it as a mean to try the submission process.
> As such, please don't hesitate to make any comment on both the form and substance.

Substance looks good, and the form too :)

I have a few nitpicks (given that you asked for those).
But with them fixed or not, the patch is:

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

> Best regards,
> MC 
> 
>  drivers/hid/hid-core.c   | 3 ++-
>  drivers/hid/hid-ids.h    | 1 +
>  drivers/hid/hid-saitek.c | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 8ea3a26..f5b8fbf 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2030,6 +2030,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_PS1000) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7_OLD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT9) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT5) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9) },
> @@ -2289,7 +2290,7 @@ __ATTRIBUTE_GROUPS(hid_dev);
>  
>  static int hid_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> -	struct hid_device *hdev = to_hid_device(dev);	
> +	struct hid_device *hdev = to_hid_device(dev);

Usually, if the change is not related to the patch, it needs to be in
its own patch. The rational being that if we need to revert the patch,
the cleanups won't.

Here you are removing trailing whitespace, which is good but it's up to
Jiri to take it as it this or amend the patch I guess :)


>  
>  	if (add_uevent_var(env, "HID_ID=%04X:%08X:%08X",
>  			hdev->bus, hdev->vendor, hdev->product))
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 3eec09a1..6db4079 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -849,6 +849,7 @@
>  #define USB_DEVICE_ID_SAITEK_PS1000	0x0621
>  #define USB_DEVICE_ID_SAITEK_RAT7_OLD	0x0ccb
>  #define USB_DEVICE_ID_SAITEK_RAT7	0x0cd7
> +#define USB_DEVICE_ID_SAITEK_RAT9	0x0cfa

The ordering is weird here (not your fault though):
The initial was wrong in the first place (_SAITEK_RAT7/0x0cd7 then
_SAITEK_MMO7/0x0cd0). Then _SAITEK_RAT7_OLD was added, somewhat in a
better place (by looking at the PID), and then you have to add yours...

I think that's fine but at some point we will have to decide once for
all the ordering of this file :)

Cheers,
Benjamin


>  #define USB_DEVICE_ID_SAITEK_MMO7	0x0cd0
>  
>  #define USB_VENDOR_ID_SAMSUNG		0x0419
> diff --git a/drivers/hid/hid-saitek.c b/drivers/hid/hid-saitek.c
> index 2f84b26..39e6426 100644
> --- a/drivers/hid/hid-saitek.c
> +++ b/drivers/hid/hid-saitek.c
> @@ -183,6 +183,8 @@ static const struct hid_device_id saitek_devices[] = {
>  		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7),
>  		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT9),
> +		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MADCATZ, USB_DEVICE_ID_MADCATZ_RAT9),
>  		.driver_data = SAITEK_RELEASE_MODE_RAT7 },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7),
> -- 
> 2.9.0
> 
