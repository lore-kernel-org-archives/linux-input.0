From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Fri, 26 Jun 2015 12:32:14 -0700
Message-ID: <20150626193214.GA26161@kroah.com>
References: <1435346647-29473-1-git-send-email-teg@jklm.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40541 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbbFZTcP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Jun 2015 15:32:15 -0400
Content-Disposition: inline
In-Reply-To: <1435346647-29473-1-git-send-email-teg@jklm.no>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tom Gundersen <teg@jklm.no>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Fri, Jun 26, 2015 at 09:24:07PM +0200, Tom Gundersen wrote:
> This policy used to be unconditionally applied by udev, but there
> is no reason to make userspace be involved in this and in the future
> udev will not be doing it by default.
> 
> See: <https://github.com/systemd/systemd/pull/353>.
> 
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> 
> Hi,
> 
> I don't have the right hardware for this, so it has only been compile-tested.
> I'm therefore sending it as an RFC only. Mainly I want to bring it to people's
> attention that it would be great to get this feature into the kernel as we want
> to drop it from udev.
> 
> Cheers,
> 
> Tom
> 
>  drivers/hid/usbhid/hid-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index bfbe1be..af80700 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1358,6 +1358,9 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
>  	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
>  	spin_lock_init(&usbhid->lock);
>  
> +	if (dev->removable == USB_DEVICE_FIXED)
> +		usb_enable_autosuspend(dev);
> +

As this duplicates what udev has been doing for a while now, we should
be safe here.

thanks for the patch.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
