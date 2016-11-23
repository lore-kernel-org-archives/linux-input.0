From: Bastien Nocera <hadess@hadess.net>
Subject: Re: hig_magicmouse HID_BATTERY_QUIRK_IGNORE
Date: Wed, 23 Nov 2016 01:24:34 +0100
Message-ID: <1479860674.16940.0.camel@hadess.net>
References: <CAJxTCxxMvwdrLZnsMsOG4vLDNbYmtdGgAXLofUMLvPvoepTk7Q@mail.gmail.com>
         <1E169F84-8B4E-4E63-B9BD-213FBBC1B36E@holtmann.org>
         <CAJxTCxxN7=fjNFQ4BJPKfU0jHY=uAQNq_g3iN_0mYhSHdc28ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39609 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754243AbcKWAYj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 22 Nov 2016 19:24:39 -0500
In-Reply-To: <CAJxTCxxN7=fjNFQ4BJPKfU0jHY=uAQNq_g3iN_0mYhSHdc28ug@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?J=E9r=E9my?= Lal <kapouer@melix.org>, linux-input@vger.kernel.org

On Wed, 2016-11-23 at 00:00 +0100, Jérémy Lal wrote:
> Hi,
> i've been using this patch for a while, as a workaround for
> https://bugzilla.kernel.org/show_bug.cgi?id=103631
> (mouse freeze when battery reports).
> 
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -321,6 +321,9 @@
>  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
>    USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI),
>    HID_BATTERY_QUIRK_PERCENT | HID_BATTERY_QUIRK_FEATURE },
> +  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
> +    USB_DEVICE_ID_APPLE_MAGICMOUSE),
> +    HID_BATTERY_QUIRK_IGNORE },
>  { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
>    USB_DEVICE_ID_ELECOM_BM084),
>    HID_BATTERY_QUIRK_IGNORE },

Doesn't that also stop the mouse from reporting its battery status?
