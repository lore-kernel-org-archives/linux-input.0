From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: ignore digitizer usage Undefined (0x00)
Date: Tue, 13 Jul 2010 23:52:27 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.1007132351050.21712@twin.jikos.cz>
References: <20100527151808.GA484@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:39413 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab0GMVwa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jul 2010 17:52:30 -0400
In-Reply-To: <20100527151808.GA484@alittletooquiet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Forest Bond <forest@alittletooquiet.net>
Cc: linux-input@vger.kernel.org, Bjorn Behrendt <bbehrendt@msjvermont.org>

On Thu, 27 May 2010, Forest Bond wrote:

> SMART Technologies has recommended this change to fix a problem reported
> with SMART Board series interactive whiteboards.
> 
> A description of the device-specific symptom follows:
> 
>   When the board is connected my mouse bounces up to the top left corner.
> 
> Bjorn has tested this fix with model SB680.
> 
> Tested-by: Bjorn Behrendt <bbehrendt@msjvermont.org>
> Signed-off-by: Forest Bond <forest@alittletooquiet.net>
> ---
>  drivers/hid/hid-input.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 7a0d2e4..6b10e5a 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -301,6 +301,9 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  
>  	case HID_UP_DIGITIZER:
>  		switch (usage->hid & 0xff) {
> +		case 0x00: /* Undefined */
> +			goto ignore;
> +
>  		case 0x30: /* TipPressure */
>  			if (!test_bit(BTN_TOUCH, input->keybit)) {
>  				device->quirks |= HID_QUIRK_NOTOUCH;

Hi,

I have applied the patch as it makes sense per se.

Still, I'd be interested to know what is the device in question actually 
sending and what it has in its report descriptor. Does it indeed use 0x00 
code? For what reason?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

