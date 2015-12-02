From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/7] HID: wacom: Move Intuos pad handling code into
 dedicated function
Date: Wed, 2 Dec 2015 16:21:41 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512021620100.32500@pobox.suse.cz>
References: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45115 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755407AbbLBPVo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Dec 2015 10:21:44 -0500
In-Reply-To: <1448932432-10115-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 30 Nov 2015, Jason Gerecke wrote:

> Begin slimming down the body of 'wacom_intuos_irq' by moving out its
> largest block of code to a dedicated 'wacom_intuos_pad' function.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
>  drivers/hid/wacom_wac.c | 482 +++++++++++++++++++++++++-----------------------
>  1 file changed, 247 insertions(+), 235 deletions(-)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 8b29949..c611ea5 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -446,6 +446,249 @@ static void wacom_intuos_schedule_prox_event(struct wacom_wac *wacom_wac)
>  	}
>  }
>  
> +static int wacom_intuos_pad(struct wacom_wac *wacom)
> +{
> +	struct wacom_features *features = &wacom->features;
> +	unsigned char *data = wacom->data;
> +	struct input_dev *input = wacom->pad_input;
> +
> +	/* pad packets. Works as a second tool and is always in prox */
> +	if (!(data[0] == WACOM_REPORT_INTUOSPAD || data[0] == WACOM_REPORT_INTUOS5PAD ||
> +	      data[0] == WACOM_REPORT_CINTIQPAD))
> +		return 0;
> +
> +	if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
> +		input_report_key(input, BTN_0, (data[2] & 0x01));
> +		input_report_key(input, BTN_1, (data[3] & 0x01));
> +		input_report_key(input, BTN_2, (data[3] & 0x02));
> +		input_report_key(input, BTN_3, (data[3] & 0x04));
> +		input_report_key(input, BTN_4, (data[3] & 0x08));
> +		input_report_key(input, BTN_5, (data[3] & 0x10));
> +		input_report_key(input, BTN_6, (data[3] & 0x20));
> +		if (data[1] & 0x80) {
> +			input_report_abs(input, ABS_WHEEL, (data[1] & 0x7f));
> +		} else {
> +			/* Out of proximity, clear wheel value. */
> +			input_report_abs(input, ABS_WHEEL, 0);
> +		}
> +		if (features->type != INTUOS4S) {
> +			input_report_key(input, BTN_7, (data[3] & 0x40));
> +			input_report_key(input, BTN_8, (data[3] & 0x80));
> +		}
> +		if (data[1] | (data[2] & 0x01) | data[3]) {
> +			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
> +		} else {
> +			input_report_abs(input, ABS_MISC, 0);
> +		}
> +	} else if (features->type == DTK) {
> +		input_report_key(input, BTN_0, (data[6] & 0x01));
> +		input_report_key(input, BTN_1, (data[6] & 0x02));
> +		input_report_key(input, BTN_2, (data[6] & 0x04));
> +		input_report_key(input, BTN_3, (data[6] & 0x08));
> +		input_report_key(input, BTN_4, (data[6] & 0x10));
> +		input_report_key(input, BTN_5, (data[6] & 0x20));
> +		if (data[6] & 0x3f) {
> +			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
> +		} else {
> +			input_report_abs(input, ABS_MISC, 0);
> +		}
> +	} else if (features->type == WACOM_13HD) {
> +		input_report_key(input, BTN_0, (data[3] & 0x01));
> +		input_report_key(input, BTN_1, (data[4] & 0x01));
> +		input_report_key(input, BTN_2, (data[4] & 0x02));
> +		input_report_key(input, BTN_3, (data[4] & 0x04));
> +		input_report_key(input, BTN_4, (data[4] & 0x08));
> +		input_report_key(input, BTN_5, (data[4] & 0x10));
> +		input_report_key(input, BTN_6, (data[4] & 0x20));
> +		input_report_key(input, BTN_7, (data[4] & 0x40));
> +		input_report_key(input, BTN_8, (data[4] & 0x80));
> +		if ((data[3] & 0x01) | data[4]) {
> +			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
> +		} else {
> +			input_report_abs(input, ABS_MISC, 0);
> +		}
> +	} else if (features->type == WACOM_24HD) {
> +		input_report_key(input, BTN_0, (data[6] & 0x01));
> +		input_report_key(input, BTN_1, (data[6] & 0x02));
> +		input_report_key(input, BTN_2, (data[6] & 0x04));
> +		input_report_key(input, BTN_3, (data[6] & 0x08));
> +		input_report_key(input, BTN_4, (data[6] & 0x10));
> +		input_report_key(input, BTN_5, (data[6] & 0x20));
> +		input_report_key(input, BTN_6, (data[6] & 0x40));
> +		input_report_key(input, BTN_7, (data[6] & 0x80));
> +		input_report_key(input, BTN_8, (data[8] & 0x01));
> +		input_report_key(input, BTN_9, (data[8] & 0x02));
> +		input_report_key(input, BTN_A, (data[8] & 0x04));
> +		input_report_key(input, BTN_B, (data[8] & 0x08));
> +		input_report_key(input, BTN_C, (data[8] & 0x10));
> +		input_report_key(input, BTN_X, (data[8] & 0x20));
> +		input_report_key(input, BTN_Y, (data[8] & 0x40));
> +		input_report_key(input, BTN_Z, (data[8] & 0x80));

I know that this code (and other instances of similar spaghetti) has been 
there before already and you are just moving it around, but isn't this the 
proper time to clean it up a bit?

Like change it to a for-loop that'd use BTN_ as an array index to compute 
the position in the data bitstream and call input_report_key()?

-- 
Jiri Kosina
SUSE Labs

