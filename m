From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 2/2] hid: sony: Save and restore controller state on
 suspend and resume
Date: Mon, 9 Nov 2015 15:03:18 +0100
Message-ID: <20151109150318.c348fa1870b03f2dccd87514@ao2.it>
References: <1446909130-9168-1-git-send-email-frank.praznik@gmail.com>
	<1446909130-9168-3-git-send-email-frank.praznik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:14476 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbbKIOD3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Nov 2015 09:03:29 -0500
In-Reply-To: <1446909130-9168-3-git-send-email-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On Sat,  7 Nov 2015 10:12:10 -0500
Frank Praznik <frank.praznik@gmail.com> wrote:

> On hardware which provides standby power for charging devices the state
> of the LEDs and force-feedback on controllers can persist even when the
> system is in standby.  Additionally, the state of the controllers on resume
> may be different from the state they were in at the time when they were
> suspended (ie. LEDs remain off on resume).  This implements the suspend and
> resume callbacks which saves and clears the state of the LEDs on suspend
> and restores it on resume.  Force-feedback is stopped on suspend but
> automatically restored on resume until a new event is received to avoid
> potentially damaging hardware.
> 
> Signed-off-by: Frank Praznik <frank.praznik@gmail.com>

Acked-by: Antonio Ospite <ao2@ao2.it>

> ---
>  drivers/hid/hid-sony.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index b84b2ce..4eff8f7 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1044,6 +1044,7 @@ struct sony_sc {
>  	__u8 battery_charging;
>  	__u8 battery_capacity;
>  	__u8 led_state[MAX_LEDS];
> +	__u8 resume_led_state[MAX_LEDS];
>  	__u8 led_delay_on[MAX_LEDS];
>  	__u8 led_delay_off[MAX_LEDS];
>  	__u8 led_count;
> @@ -2427,6 +2428,48 @@ static void sony_remove(struct hid_device *hdev)
>  	hid_hw_stop(hdev);
>  }
>  
> +#ifdef CONFIG_PM
> +
> +static int sony_suspend(struct hid_device *hdev, pm_message_t message)
> +{
> +	/*
> +	 * On suspend save the current LED state,
> +	 * stop running force-feedback and blank the LEDS.
> +         */
> +	if (SONY_LED_SUPPORT || SONY_FF_SUPPORT) {
> +		struct sony_sc *sc = hid_get_drvdata(hdev);
> +
> +#ifdef CONFIG_SONY_FF
> +		sc->left = sc->right = 0;
> +#endif
> +
> +		memcpy(sc->resume_led_state, sc->led_state,
> +			sizeof(sc->resume_led_state));
> +		memset(sc->led_state, 0, sizeof(sc->led_state));
> +
> +		sony_send_output_report(sc);
> +	}
> +
> +	return 0;
> +}
> +
> +static int sony_resume(struct hid_device *hdev)
> +{
> +	/* Restore the state of controller LEDs on resume */
> +	if (SONY_LED_SUPPORT) {
> +		struct sony_sc *sc = hid_get_drvdata(hdev);
> +
> +		memcpy(sc->led_state, sc->resume_led_state,
> +			sizeof(sc->led_state));
> +
> +		sony_set_leds(sc);
> +	}
> +
> +	return 0;
> +}
> +
> +#endif
> +
>  static const struct hid_device_id sony_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
>  		.driver_data = SIXAXIS_CONTROLLER_USB },
> @@ -2476,7 +2519,13 @@ static struct hid_driver sony_driver = {
>  	.probe            = sony_probe,
>  	.remove           = sony_remove,
>  	.report_fixup     = sony_report_fixup,
> -	.raw_event        = sony_raw_event
> +	.raw_event        = sony_raw_event,
> +
> +#ifdef CONFIG_PM
> +	.suspend          = sony_suspend,
> +	.resume	          = sony_resume,
> +	.reset_resume     = sony_resume,
> +#endif
>  };
>  
>  static int __init sony_init(void)
> -- 
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
