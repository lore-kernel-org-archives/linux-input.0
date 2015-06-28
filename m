From: Reyad Attiyat <reyad.attiyat@gmail.com>
Subject: Re: [PATCH] HID: microsoft: Add quirk for MS Surface Type/Touch cover
Date: Sun, 28 Jun 2015 18:32:30 -0500
Message-ID: <CA+BWVUQi84kDQBWidMT8RFXQLjHWZS_DF2PO=+otZmb-UCQUxQ@mail.gmail.com>
References: <1435298400-4919-1-git-send-email-reyad.attiyat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33704 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbbF1Xcu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jun 2015 19:32:50 -0400
In-Reply-To: <1435298400-4919-1-git-send-email-reyad.attiyat@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, Reyad Attiyat <reyad.attiyat@gmail.com>

This is missing a device ID I will need to resubmit

Sorry,
Reyad Attiyat

On Fri, Jun 26, 2015 at 1:00 AM, Reyad Attiyat <reyad.attiyat@gmail.com> wrote:
> The newer frimware on MS Surface 2 tablets causes the type and touch cover keyboards to timeout when waiting for reports.
>
> Signed-off-by: Reyad Attiyat <reyad.attiyat@gmail.com>
> ---
>  drivers/hid/usbhid/hid-quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 4696895e..19c6f74 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -87,6 +87,8 @@ static const struct hid_blacklist {
>         { USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C05A, HID_QUIRK_ALWAYS_POLL },
>         { USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C06A, HID_QUIRK_ALWAYS_POLL },
>         { USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
> +       { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_2, HID_QUIRK_NO_INIT_REPORTS },
> +       { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TOUCH_COVER_2, HID_QUIRK_NO_INIT_REPORTS },
>         { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
>         { USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP, HID_QUIRK_NO_INIT_REPORTS },
>         { USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
> --
> 2.4.1
>
