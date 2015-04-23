From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input - synaptics: pin 3 touches when the firmware
 reports 3 fingers
Date: Thu, 23 Apr 2015 09:38:18 -0700
Message-ID: <20150423163818.GC34808@dtor-ws>
References: <1429717509-27396-1-git-send-email-benjamin.tissoires@redhat.com>
 <1429717509-27396-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35065 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966390AbbDWQiX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2015 12:38:23 -0400
Content-Disposition: inline
In-Reply-To: <1429717509-27396-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 22, 2015 at 11:45:09AM -0400, Benjamin Tissoires wrote:
> Synaptics PS/2 touchpad can send only 2 touches in a report. They can
> detect 4 or 5 and this information is valuable.
> 
> In commit 63c4fda3c0bb ("Input: synaptics - allocate 3 slots to keep
> stability in image sensors"), we allocate 3 slots, but we still continue
> to report the 2 available fingers. That means that the client sees 2 used
> slots while there is a total of 3 fingers advertised by BTN_TOOL_TRIPLETAP.
> 
> For old kernels this is not a problem because max_slots was 2 and libinput/
> xorg-synaptics knew how to deal with that. Now that max_slot is 3, the
> clients ignore BTN_TOOL_TRIPLETAP and count the actual used slots (so 2).
> It then gets confused when receiving the BTN_TOOL_TRIPLETAP and DOUBLETAP
> information, and goes wild.
> 
> We can pin the 3 slots until we get a total number of fingers below 2.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1212230

Benjamin, I do not quite like it. It seems that original patch was not
quite right and we are adding more workarounds.

Synaptics can only track 2 contacts, correct? Why 2 slots to track them
is not enough?

> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/input/mouse/synaptics.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 630af73..c69b308 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -935,6 +935,14 @@ static void synaptics_report_mt_data(struct psmouse *psmouse,
>  		input_report_abs(dev, ABS_MT_PRESSURE, hw[i]->z);
>  	}
>  
> +	/* keep (slot count <= num_fingers) by pinning all slots */
> +	if (num_fingers >= 3) {
> +		for (i = 0; i < 3; i++) {
> +			input_mt_slot(dev, i);
> +			input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
> +		}
> +	}
> +
>  	input_mt_drop_unused(dev);
>  
>  	/* Don't use active slot count to generate BTN_TOOL events. */
> -- 
> 2.1.0
> 

-- 
Dmitry
