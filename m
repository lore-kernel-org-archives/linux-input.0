From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 4/4] HID: usbhid: use to_usb_device
Date: Mon, 28 Dec 2015 13:14:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512281313420.9922@cbobk.fhfr.pm>
References: <41e4a06ba4bb1f35c195c7ea66071953600ca930.1450876612.git.geliangtang@163.com> <639acbe1bd1388d007c88b80041807c2d8f48bf2.1450876612.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34726 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbbL1MOH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Dec 2015 07:14:07 -0500
In-Reply-To: <639acbe1bd1388d007c88b80041807c2d8f48bf2.1450876612.git.geliangtang@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 23 Dec 2015, Geliang Tang wrote:

> Use to_usb_device() instead of open-coding it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  drivers/hid/usbhid/usbhid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
> index 807922b..fa47d66 100644
> --- a/drivers/hid/usbhid/usbhid.h
> +++ b/drivers/hid/usbhid/usbhid.h
> @@ -96,7 +96,7 @@ struct usbhid_device {
>  };
>  
>  #define	hid_to_usb_dev(hid_dev) \
> -	container_of(hid_dev->dev.parent->parent, struct usb_device, dev)
> +	to_usb_device(hid_dev->dev.parent->parent)

Applied to hid.git#for-4.5/upstream.

-- 
Jiri Kosina
SUSE Labs

