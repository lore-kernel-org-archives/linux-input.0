From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 5/6] HID: Add the HIDIOCGRAWCLIENTADDR ioctl to the hidraw documentation
Date: Fri, 31 Jan 2014 14:17:19 -0500
Message-ID: <CAN+gG=GikyEeRQnPxACG9GFRZfqPam9qeDgEX6YMjy44VNcSNg@mail.gmail.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
	<1391189573-2591-6-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:63096 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499AbaAaTRV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 14:17:21 -0500
Received: by mail-lb0-f173.google.com with SMTP id y6so3801742lbh.32
        for <linux-input@vger.kernel.org>; Fri, 31 Jan 2014 11:17:20 -0800 (PST)
In-Reply-To: <1391189573-2591-6-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

On Fri, Jan 31, 2014 at 12:32 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> Add the HIDIOCGRAWCLIENTADDR ioctl to the hidraw documentation.

This one should be squashed with the previous one (same reason in 1/6)

>
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  Documentation/hid/hidraw.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/hid/hidraw.txt b/Documentation/hid/hidraw.txt
> index 029e6cb..737fd1f 100644
> --- a/Documentation/hid/hidraw.txt
> +++ b/Documentation/hid/hidraw.txt
> @@ -93,6 +93,11 @@ For USB devices, the string contains the physical path to the device (the
>  USB controller, hubs, ports, etc).  For Bluetooth devices, the string
>  contains the hardware (MAC) address of the device.
>
> +HIDIOCGRAWCLIENTADDR(len): Get Client Address
> +This ioctl returns a string representing the client address of the device.
> +For Bluetooth devices, the string contains the hardware (MAC) address of the
> +device.  For USB devices, the returned string is always 00:00:00:00:00:00.
> +
>  HIDIOCSFEATURE(len): Send a Feature Report
>  This ioctl will send a feature report to the device.  Per the HID
>  specification, feature reports are always sent using the control endpoint.
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
