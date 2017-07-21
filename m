From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: usbhid: fix "always poll" quirk
Date: Fri, 21 Jul 2017 11:26:16 +0200
Message-ID: <20170721092616.GB11387@mail.corp.redhat.com>
References: <20170713001424.GA7990@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170713001424.GA7990@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Olof Johansson <olof@lixom.net>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Jul 12 2017 or thereabouts, Dmitry Torokhov wrote:
> Even though the IO for devices with "always poll" quirk is already running,
> we still need to set HID_OPENED bit in usbhid->iofl so the interrupt
> handler does not ignore the data coming from the device.
> 
> Reported-by: Olof Johansson <olof@lixom.net>
> Tested-by: Olof Johansson <olof@lixom.net>
> Fixes: e399396a6b0 ("HID: usbhid: remove custom locking from usbhid_open...")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

slightly reviewed and
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/usbhid/hid-core.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 76013eb5cb7f..c008847e0b20 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -680,18 +680,21 @@ static int usbhid_open(struct hid_device *hid)
>  	struct usbhid_device *usbhid = hid->driver_data;
>  	int res;
>  
> +	set_bit(HID_OPENED, &usbhid->iofl);
> +
>  	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
>  		return 0;
>  
>  	res = usb_autopm_get_interface(usbhid->intf);
>  	/* the device must be awake to reliably request remote wakeup */
> -	if (res < 0)
> +	if (res < 0) {
> +		clear_bit(HID_OPENED, &usbhid->iofl);
>  		return -EIO;
> +	}
>  
>  	usbhid->intf->needs_remote_wakeup = 1;
>  
>  	set_bit(HID_RESUME_RUNNING, &usbhid->iofl);
> -	set_bit(HID_OPENED, &usbhid->iofl);
>  	set_bit(HID_IN_POLLING, &usbhid->iofl);
>  
>  	res = hid_start_in(hid);
> @@ -727,19 +730,20 @@ static void usbhid_close(struct hid_device *hid)
>  {
>  	struct usbhid_device *usbhid = hid->driver_data;
>  
> -	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
> -		return;
> -
>  	/*
>  	 * Make sure we don't restart data acquisition due to
>  	 * a resumption we no longer care about by avoiding racing
>  	 * with hid_start_in().
>  	 */
>  	spin_lock_irq(&usbhid->lock);
> -	clear_bit(HID_IN_POLLING, &usbhid->iofl);
>  	clear_bit(HID_OPENED, &usbhid->iofl);
> +	if (!(hid->quirks & HID_QUIRK_ALWAYS_POLL))
> +		clear_bit(HID_IN_POLLING, &usbhid->iofl);
>  	spin_unlock_irq(&usbhid->lock);
>  
> +	if (hid->quirks & HID_QUIRK_ALWAYS_POLL)
> +		return;
> +
>  	hid_cancel_delayed_stuff(usbhid);
>  	usb_kill_urb(usbhid->urbin);
>  	usbhid->intf->needs_remote_wakeup = 0;
> -- 
> 2.13.2.932.g7449e964c-goog
> 
> 
> -- 
> Dmitry
