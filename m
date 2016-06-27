From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2] Revert "HID: multitouch: enable palm rejection if
 device implements confidence usage"
Date: Mon, 27 Jun 2016 10:55:42 -0700
Message-ID: <2407f04d-4658-c3d5-1434-5e548f2063e0@kernel.org>
References: <1466670690-77458-1-git-send-email-allen_hung@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32922 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbcF0Rzp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2016 13:55:45 -0400
In-Reply-To: <1466670690-77458-1-git-send-email-allen_hung@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Allen Hung <allen_hung@dell.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 06/23/2016 01:31 AM, Allen Hung wrote:
> This reverts commit 25a84db15b3f ("HID: multitouch: enable palm rejection
> if device implements confidence usage")
>
> The commit enables palm rejection for Win8 Precision Touchpad devices but
> the quirk MT_QUIRK_VALID_IS_CONFIDENCE it is using is not working very
> properly. This quirk is originally designed for some WIn7 touchscreens. Use
> of this for a Win8 Precision Touchpad will cause unexpected pointer jumping
> problem.
>
> Signed-off-by: Allen Hung <allen_hung@dell.com>
> ---
>  drivers/hid/hid-multitouch.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 95b7d61..4ef7006 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -502,11 +502,6 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  			mt_store_field(usage, td, hi);
>  			return 1;
>  		case HID_DG_CONFIDENCE:
> -			if (cls->name == MT_CLS_WIN_8 &&
> -				field->application == HID_DG_TOUCHPAD) {
> -				cls->quirks &= ~MT_QUIRK_ALWAYS_VALID;
> -				cls->quirks |= MT_QUIRK_VALID_IS_CONFIDENCE;
> -			}
>  			mt_store_field(usage, td, hi);
>  			return 1;
>  		case HID_DG_TIPSWITCH:
>

This and patch 2 are:

Tested-by: Andy Lutomirski <luto@kernel.org> # XPS 13 9350, BIOS 1.4.3

(And I'm curious why 1.4.3 seems to have been pulled.  Might it have 
been this issue?  For better or for worse, I upgraded in the narrow 
window in which it was available on Dell's website.)

--Andy
