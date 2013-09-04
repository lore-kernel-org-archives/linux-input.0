From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 06/14] HID: pantherlord: validate output report details
Date: Wed, 4 Sep 2013 11:58:44 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309041158330.3684@pobox.suse.cz>
References: <alpine.LNX.2.00.1308282218580.22181@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47962 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934478Ab3IDJ6r (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 05:58:47 -0400
In-Reply-To: <alpine.LNX.2.00.1308282218580.22181@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>

On Wed, 28 Aug 2013, Jiri Kosina wrote:

> From: Kees Cook <keescook@chromium.org>
> 
> A HID device could send a malicious output report that would cause the
> pantherlord HID driver to write beyond the output report allocation
> during initialization, causing a heap overflow:
> 
> [  310.939483] usb 1-1: New USB device found, idVendor=0e8f, idProduct=0003
> ...
> [  315.980774] BUG kmalloc-192 (Tainted: G        W   ): Redzone overwritten
> 
> CVE-2013-2892

Applying this one, thanks.

> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@kernel.org
> ---
>  drivers/hid/hid-pl.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
> index d29112f..2dcd7d9 100644
> --- a/drivers/hid/hid-pl.c
> +++ b/drivers/hid/hid-pl.c
> @@ -132,8 +132,14 @@ static int plff_init(struct hid_device *hid)
>  			strong = &report->field[0]->value[2];
>  			weak = &report->field[0]->value[3];
>  			debug("detected single-field device");
> -		} else if (report->maxfield >= 4 && report->field[0]->maxusage == 1 &&
> -				report->field[0]->usage[0].hid == (HID_UP_LED | 0x43)) {
> +		} else if (report->field[0]->maxusage == 1 &&
> +			   report->field[0]->usage[0].hid ==
> +				(HID_UP_LED | 0x43) &&
> +			   report->maxfield >= 4 &&
> +			   report->field[0]->report_count >= 1 &&
> +			   report->field[1]->report_count >= 1 &&
> +			   report->field[2]->report_count >= 1 &&
> +			   report->field[3]->report_count >= 1) {
>  			report->field[0]->value[0] = 0x00;
>  			report->field[1]->value[0] = 0x00;
>  			strong = &report->field[2]->value[0];

-- 
Jiri Kosina
SUSE Labs
