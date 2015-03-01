From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH v2 4/6] HID: uclogic: apply quirk NO_EMPTY_INPUT
Date: Sun, 01 Mar 2015 20:07:46 +0200
Message-ID: <54F35572.60103@gmail.com>
References: <1424977049-18648-1-git-send-email-benjamin.tissoires@redhat.com> <1424977049-18648-5-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34887 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbbCASHz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Mar 2015 13:07:55 -0500
In-Reply-To: <1424977049-18648-5-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 02/26/2015 08:57 PM, Benjamin Tissoires wrote:
> NO_EMPTY_INPUT is useful when MULTI_INPUT is set. It prevents to create
> empty input nodes that user space does not know what to do with.
>
> It does not seem to be required at the moment, this is just a preventive
> patch. This check is only made during the plug of the device, so it does
> not hurt to have it.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>
> New in v2
>
>   drivers/hid/hid-uclogic.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
> index 90e2612..ada8a94 100644
> --- a/drivers/hid/hid-uclogic.c
> +++ b/drivers/hid/hid-uclogic.c
> @@ -868,6 +868,7 @@ static int uclogic_probe(struct hid_device *hdev,
>   	 * than the pen, so use QUIRK_MULTI_INPUT for all tablets.
>   	 */
>   	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
> +	hdev->quirks |= HID_QUIRK_NO_EMPTY_INPUT;
>
>   	/* Allocate and assign driver data */
>   	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);

This seems safe and fine as a preventive.

Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>

Nick
