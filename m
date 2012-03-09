From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/5] HID: multitouch: add support for eGalax 0x722a
Date: Fri, 9 Mar 2012 13:29:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203091329030.18356@pobox.suse.cz>
References: <1331053026-21272-1-git-send-email-benjamin.tissoires@gmail.com> <1331053026-21272-2-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59439 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755075Ab2CIM3L (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Mar 2012 07:29:11 -0500
In-Reply-To: <1331053026-21272-2-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 6 Mar 2012, benjamin.tissoires wrote:

> From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> ---
>  drivers/hid/hid-ids.h        |    1 +
>  drivers/hid/hid-multitouch.c |    3 +++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 6656516..e1fada2 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -240,6 +240,7 @@
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207	0x7207
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C	0x720c
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
> +#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A	0x722A
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E	0x725e
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262	0x7262
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_726B	0x726b
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 0eda37f..019de83 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -797,6 +797,9 @@ static const struct hid_device_id mt_devices[] = {
>  	{ .driver_data = MT_CLS_EGALAX_SERIAL,
>  		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>  			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224) },
> +	{ .driver_data = MT_CLS_EGALAX_SERIAL,
> +		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A) },
>  	{ .driver_data = MT_CLS_EGALAX,
>  		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>  			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_726B) },

Applied.

-- 
Jiri Kosina
SUSE Labs
