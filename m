From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] HID: Ignore D-WAV/eGalax devices handled by usbtouchscreen
Date: Wed, 07 Nov 2012 15:29:16 +0400
Message-ID: <509A460C.8000401@mvista.com>
References: <20121106184122.GT12501@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60015 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab2KGLae (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Nov 2012 06:30:34 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so1185885lbo.19
        for <linux-input@vger.kernel.org>; Wed, 07 Nov 2012 03:30:33 -0800 (PST)
In-Reply-To: <20121106184122.GT12501@alittletooquiet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Forest Bond <forest@alittletooquiet.net>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Ritz <daniel.ritz@gmx.ch>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Hello.

On 06-11-2012 22:41, Forest Bond wrote:

> From: Forest Bond <forest.bond@rapidrollout.com>

> Previously, both usbhid and usbtouchscreen would bind to D-WAV devices
> with class HID and protocol None, so they would be claimed by whichever
> driver was loaded first.  Some of these devices do in fact work with
> usbhid, but not all of them do.  OTOH they all work with usbtouchscreen
> as of commit 037a833ed05a86d01ea27a2c32043b86c549be1b ("Input:
> usbtouchscreen - initialize eGalax devices").  So we ignore them in
> usbhid to prevent getting in the way of usbtouchscreen and claiming an
> interface that we may not be able to do anything useful with.

> Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
> ---
>   drivers/hid/hid-core.c |   11 ++++++++++-
>   drivers/hid/hid-ids.h  |    1 +
>   2 files changed, 11 insertions(+), 1 deletions(-)

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index f4109fd..f2d614e 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2188,7 +2188,16 @@ static bool hid_ignore(struct hid_device *hdev)
>   		if (hdev->product == USB_DEVICE_ID_JESS_YUREX &&
>   				hdev->type == HID_TYPE_USBNONE)
>   			return true;
> -	break;
> +		break;
> +	case USB_VENDOR_ID_DWAV:
> +		/* These are handled by usbtouchscreen. hdev->type is probably
> +		 * HID_TYPE_USBNONE, but we say !HID_TYPE_USBMOUSE to match
> +		 * usbtouchscreen. */

    Note that the preferred style of multi-line comments is this, according to 
CodingStyle:

/*
  * bla
  * bla
  */

WBR, Sergei

