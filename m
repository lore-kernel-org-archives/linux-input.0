From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH v2 6/6] HID: uclogic: actually invert the in-range bit
 for huion tablets only
Date: Sat, 28 Feb 2015 15:59:25 +0200
Message-ID: <54F1C9BD.2070805@gmail.com>
References: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com> <1424977049-18648-7-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:46002 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbB1N7d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2015 08:59:33 -0500
In-Reply-To: <1424977049-18648-7-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 02/26/2015 08:57 PM, Benjamin Tissoires wrote:
> This hack is only needed for Huion tablets. It does not seem to have
> any effect on the other tablets handled by this device right now, but
> it's better to check for the product id sooner than discovering that
> we have messed up one tablet later.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>
> New in v2
>
>   drivers/hid/hid-uclogic.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> index f44e72b..5f5c16e 100644
> --- a/drivers/hid/hid-uclogic.c
> +++ b/drivers/hid/hid-uclogic.c
> @@ -930,7 +930,8 @@ static int uclogic_raw_event(struct hid_device *hdev, struct hid_report *report,
>   	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
>
>   	/* If this is a pen input report */
> -	if (intf->cur_altsetting->desc.bInterfaceNumber == 0 &&
> +	if (hdev->product == USB_DEVICE_ID_HUION_TABLET &&
> +	    intf->cur_altsetting->desc.bInterfaceNumber == 0 &&
>   	    report->type == HID_INPUT_REPORT &&
>   	    report->id == 0x07 && size >= 2)
>   		/* Invert the in-range bit */

Right, I completely forgot about this. That's why it's important to put these
things out for testing.

However, this should be inverted not just for Huion tablets, but rather for
all "enabled" tablets. The UC-Logic TWHA60 v3 inverts that bit as well when
enabled, IIRC. We can filter enabled tablets by drvdata->rdesc != NULL, or add
an explicit flag.

Nick
