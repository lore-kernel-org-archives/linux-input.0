From: simon@mungewell.org
Subject: Re: [PATCH] hid: sony: Drop invalid Sixaxis input reports
Date: Thu, 23 Jul 2015 19:12:54 -0400
Message-ID: <6b978394fa9d4646cc3aff9f1f2a5ee0.squirrel@mungewell.org>
References: <1437692476-12557-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:44991 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbbGWXM4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 19:12:56 -0400
In-Reply-To: <1437692476-12557-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, virtuousfox@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

> When connected via Bluetooth the sixaxis periodically sends reports with
> an ID of 1, the second byte 0xff and the rest zeroed.  These reports are
> not related to the controller state and must be dropped to avoid
> generating false input events.

These 'problem reports' were reported (*) over the on Bluetooth list, and
appear in both the HID and the HCI streams (suggesting that they are
really sent from device). They are not seen on the USB connection.

Dropping them in 'raw_event()' seems a sensible approach,
Simon.

* http://www.spinics.net/lists/linux-bluetooth/msg63028.html


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
> @@ -1270,6 +1270,17 @@ static int sony_raw_event(struct hid_device *hdev,
> struct hid_report *report,
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
>  		swap(rd[41], rd[42]);
>  		swap(rd[43], rd[44]);
>  		swap(rd[45], rd[46]);
> --
> 2.4.3
>
>

