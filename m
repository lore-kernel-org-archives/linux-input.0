From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] hid: sony: Drop invalid Sixaxis input reports
Date: Fri, 24 Jul 2015 15:00:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507241459580.1141@pobox.suse.cz>
References: <1437692476-12557-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:61666 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752284AbbGXNAU (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Fri, 24 Jul 2015 09:00:20 -0400
In-Reply-To: <1437692476-12557-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, simon@mungewell.org, virtuousfox@gmail.com

On Thu, 23 Jul 2015, Frank Praznik wrote:

> When connected via Bluetooth the sixaxis periodically sends reports with
> an ID of 1, the second byte 0xff and the rest zeroed.  These reports are
> not related to the controller state and must be dropped to avoid generating
> false input events.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  drivers/hid/hid-sony.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index ed2f008..beb2b02 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1270,6 +1270,17 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
>  	 * has to be BYTE_SWAPPED before passing up to joystick interface
>  	 */
>  	if ((sc->quirks & SIXAXIS_CONTROLLER) && rd[0] == 0x01 && size == 49) {
> +		/*
> +		 * When connected via Bluetooth the Sixaxis occasionally sends
> +		 * a report with the second byte 0xff and the rest zeroed.
> +		 *
> +		 * This report does not reflect the actual state of the
> +		 * controller must be ignored to avoid generating false input
> +		 * events.
> +		 */
> +		if (rd[1] == 0xff)
> +			return -EINVAL;
> +

Given that this is not a regression and given the current development 
phase, I've applied it to for-4.3/sony.

Thanks,

-- 
Jiri Kosina
SUSE Labs
