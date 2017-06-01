From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 6/7] HID: usbhid: remove custom locking from
 i2c_hid_open/close
Date: Thu, 1 Jun 2017 15:09:53 +0200
Message-ID: <20170601130953.GE1293@mail.corp.redhat.com>
References: <20170531205951.30852-1-dmitry.torokhov@gmail.com>
 <20170531205951.30852-7-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751076AbdFANJ7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 1 Jun 2017 09:09:59 -0400
Content-Disposition: inline
In-Reply-To: <20170531205951.30852-7-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

thanks for the series, it looks good at first sight. There is a nitpick
here, the subject should not be "i2c_hid_open/close" but
"usbhid_open/close" I guess.

Do you plan to send a v2 of the series to fix the greybus issues
reported by the kbuild bot or should we start reviewing carefully this
version?

Cheers,
Benjamin

On May 31 2017 or thereabouts, Dmitry Torokhov wrote:
> Now that HID core enforces serialization of transport driver open/close
> calls we can remove custom locking from usbhid driver.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/hid/usbhid/hid-core.c | 115 +++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index d927fe4ba592..76013eb5cb7f 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -70,8 +70,6 @@ MODULE_PARM_DESC(quirks, "Add/modify USB HID quirks by specifying "
>  /*
>   * Input submission and I/O error handler.
>   */
> -static DEFINE_MUTEX(hid_open_mut);
> -
>  static void hid_io_error(struct hid_device *hid);
>  static int hid_submit_out(struct hid_device *hid);
>  static int hid_submit_ctrl(struct hid_device *hid);
> @@ -680,50 +678,48 @@ static int hid_get_class_descriptor(struct usb_device *dev, int ifnum,
>  static int usbhid_open(struct hid_device *hid)
>  {
>  	struct usbhid_device *usbhid = hid->driver_data;
> -	int res = 0;
> -
> -	mutex_lock(&hid_open_mut);
> -	if (!hid->open++) {
> -		res = usb_autopm_get_interface(usbhid->intf);
> -		/* the device must be awake to reliably request remote wakeup */
> -		if (res < 0) {
> -			hid->open--;
> -			res = -EIO;
> -			goto done;
> -		}
> -		usbhid->intf->needs_remote_wakeup = 1;
> -		set_bit(HID_OPENED, &usbhid->iofl);
> -		set_bit(HID_IN_POLLING, &usbhid->iofl);
> -		set_bit(HID_RESUME_RUNNING, &usbhid->iofl);
> -		res = hid_start_in(hid);
> -		if (res) {
> -			if (res != -ENOSPC) {
> -				hid_io_error(hid);
> -				res = 0;
> -			} else {
> -				/* no use opening if resources are insufficient */
> -				hid->open--;
> -				clear_bit(HID_OPENED, &usbhid->iofl);
> -				if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL))
> -					clear_bit(HID_IN_POLLING, &usbhid->iofl);
> -				res = -EBUSY;
> -				usbhid->intf->needs_remote_wakeup = 0;
> -			}
> -		}
> -		usb_autopm_put_interface(usbhid->intf);
> +	int res;
>  
> -		/*
> -		 * In case events are generated while nobody was listening,
> -		 * some are released when the device is re-opened.
> -		 * Wait 50 msec for the queue to empty before allowing events
> -		 * to go through hid.
> -		 */
> -		if (res == 0 && !(hid->quirks & HID_QUIRK_ALWAYS_POLL))
> -			msleep(50);
> -		clear_bit(HID_RESUME_RUNNING, &usbhid->iofl);
> +	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
> +		return 0;
> +
> +	res = usb_autopm_get_interface(usbhid->intf);
> +	/* the device must be awake to reliably request remote wakeup */
> +	if (res < 0)
> +		return -EIO;
> +
> +	usbhid->intf->needs_remote_wakeup = 1;
> +
> +	set_bit(HID_RESUME_RUNNING, &usbhid->iofl);
> +	set_bit(HID_OPENED, &usbhid->iofl);
> +	set_bit(HID_IN_POLLING, &usbhid->iofl);
> +
> +	res = hid_start_in(hid);
> +	if (res) {
> +		if (res != -ENOSPC) {
> +			hid_io_error(hid);
> +			res = 0;
> +		} else {
> +			/* no use opening if resources are insufficient */
> +			res = -EBUSY;
> +			clear_bit(HID_OPENED, &usbhid->iofl);
> +			clear_bit(HID_IN_POLLING, &usbhid->iofl);
> +			usbhid->intf->needs_remote_wakeup = 0;
> +		}
>  	}
> -done:
> -	mutex_unlock(&hid_open_mut);
> +
> +	usb_autopm_put_interface(usbhid->intf);
> +
> +	/*
> +	 * In case events are generated while nobody was listening,
> +	 * some are released when the device is re-opened.
> +	 * Wait 50 msec for the queue to empty before allowing events
> +	 * to go through hid.
> +	 */
> +	if (res == 0)
> +		msleep(50);
> +
> +	clear_bit(HID_RESUME_RUNNING, &usbhid->iofl);
>  	return res;
>  }
>  
> @@ -731,27 +727,22 @@ static void usbhid_close(struct hid_device *hid)
>  {
>  	struct usbhid_device *usbhid = hid->driver_data;
>  
> -	mutex_lock(&hid_open_mut);
> +	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
> +		return;
>  
> -	/* protecting hid->open to make sure we don't restart
> -	 * data acquistion due to a resumption we no longer
> -	 * care about
> +	/*
> +	 * Make sure we don't restart data acquisition due to
> +	 * a resumption we no longer care about by avoiding racing
> +	 * with hid_start_in().
>  	 */
>  	spin_lock_irq(&usbhid->lock);
> -	if (!--hid->open) {
> -		if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL))
> -			clear_bit(HID_IN_POLLING, &usbhid->iofl);
> -		clear_bit(HID_OPENED, &usbhid->iofl);
> -		spin_unlock_irq(&usbhid->lock);
> -		hid_cancel_delayed_stuff(usbhid);
> -		if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL)) {
> -			usb_kill_urb(usbhid->urbin);
> -			usbhid->intf->needs_remote_wakeup = 0;
> -		}
> -	} else {
> -		spin_unlock_irq(&usbhid->lock);
> -	}
> -	mutex_unlock(&hid_open_mut);
> +	clear_bit(HID_IN_POLLING, &usbhid->iofl);
> +	clear_bit(HID_OPENED, &usbhid->iofl);
> +	spin_unlock_irq(&usbhid->lock);
> +
> +	hid_cancel_delayed_stuff(usbhid);
> +	usb_kill_urb(usbhid->urbin);
> +	usbhid->intf->needs_remote_wakeup = 0;
>  }
>  
>  /*
> -- 
> 2.13.0.506.g27d5fe0cd-goog
> 
