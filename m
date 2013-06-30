From: Stephan Raue <stephan@openelec.tv>
Subject: Re: [RFC] hid/sony: add autorepeat for PS3 remotes
Date: Sun, 30 Jun 2013 08:33:07 +0200
Message-ID: <51CFD123.2000502@openelec.tv>
References: <1372386523.28740.8.camel@haswell.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail05.solnet.ch ([212.101.4.139]:22776 "EHLO mail05.solnet.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab3F3GlF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jun 2013 02:41:05 -0400
In-Reply-To: <1372386523.28740.8.camel@haswell.thedillows.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Dillow <dave@thedillows.org>
Cc: linux-input@vger.kernel.org

Hi David,

many thanks for this fast and great patch, it works nice. Hope it will 
be included in kernel very soon :-)

thanks much

Stephan

Am 28.06.2013 04:28, schrieb David Dillow:
> Some applications using the PS3 remote would like to have autorepeat
> from the device. Use the input subsystem's software emulation to provide
> this capability, and enable those that don't need it to turn it off.
> ---
> I'm not sure this is the correct approach, or if it is even appropriate
> for a remote to do autorepeat. However, the media/rc subsystem does do
> it by default, and it's been requested by users, so there is at least
> some demand.
>
> This compiled against the hid-sony driver with the PS3 remote changes
> merged, but I have done no testing of it. If the approach seems
> reasonable, I'll try to test it when the MythTV is idle.
>
>   drivers/hid/hid-sony.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index ecbc749..0bbcd07 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -274,6 +274,24 @@ static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
>   	return 1;
>   }
>   
> +static int ps3remote_setup_repeat(struct hid_device *hdev)
> +{
> +	struct hid_input *hidinput = list_first_entry(&hdev->inputs,
> +						      struct hid_input, list);
> +	struct input_dev *input = hidinput->input;
> +
> +	/*
> +	 * Set up autorepeat defaults per the remote control subsystem;
> +	 * this must be done after hid_hw_start(), as having these non-zero
> +	 * at the time of input_register_device() tells the input system that
> +	 * the hardware does the autorepeat, and the PS3 remote does not.
> +	 */
> +	set_bit(EV_REP, input->evbit);
> +	input->rep[REP_DELAY]  = 500;
> +	input->rep[REP_PERIOD] = 125;
> +
> +	return 0;
> +}
>   
>   /* Sony Vaio VGX has wrongly mouse pointer declared as constant */
>   static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
> @@ -659,6 +677,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   		ret = sixaxis_set_operational_bt(hdev);
>   	else if (sc->quirks & BUZZ_CONTROLLER)
>   		ret = buzz_init(hdev);
> +	else if (sc->quirks & PS3REMOTE)
> +		ret = ps3remote_setup_repeat(hdev);
>   	else
>   		ret = 0;
>   
>
>

