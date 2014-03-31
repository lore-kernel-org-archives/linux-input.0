From: andrea <mariofutire@gmail.com>
Subject: Re: [PATCH v3 2/8] HID: sony: Set the quriks flag for Bluetooth controllers
Date: Mon, 31 Mar 2014 20:14:55 +0100
Message-ID: <5339BEAF.20409@googlemail.com>
References: <1394890882-2039-1-git-send-email-frank.praznik@oh.rr.com> <1394890882-2039-3-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:55632 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999AbaCaTPA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Mar 2014 15:15:00 -0400
Received: by mail-we0-f176.google.com with SMTP id x48so5297306wes.35
        for <linux-input@vger.kernel.org>; Mon, 31 Mar 2014 12:14:59 -0700 (PDT)
In-Reply-To: <1394890882-2039-3-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org
Cc: jkosina@suse.cz

On 15/03/14 13:41, Frank Praznik wrote:
> The Sixaxis and DualShock 4 want HID output reports sent on the control
> endpoint when connected via Bluetooth.  Set the
> HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP flag for these devices so hidraw write()
> works properly.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  drivers/hid/hid-sony.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 4c445a0..908de27 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1632,11 +1632,21 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		sc->worker_initialized = 1;
>  		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
>  	} else if (sc->quirks & SIXAXIS_CONTROLLER_BT) {
> +		/*
> +		 * The Sixaxis wants output reports sent on the ctrl endpoint
> +		 * when connected via Bluetooth.
> +		 */
> +		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
>  		ret = sixaxis_set_operational_bt(hdev);
>  		sc->worker_initialized = 1;
>  		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
>  	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
>  		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
> +			/*
> +			 * The DualShock 4 wants output reports sent on the ctrl
> +			 * endpoint when connected via Bluetooth.
> +			 */
> +			hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
>  			ret = dualshock4_set_operational_bt(hdev);
>  			if (ret < 0) {
>  				hid_err(hdev, "failed to set the Dualshock 4 operational mode\n");
> 

I am simply a user of a Sixaxis via Bluetooth and it would be super to have this patch applied and
merged in 3.15
We always need to modify the BT stack in the vanilla kernel using an old hack Frank proposed.

This would make things a lot simpler and less painful.

I don't know about the other 7, but this one would get my vote (if I had one...)

Andrea

