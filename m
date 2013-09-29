From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/1] Input: rotary-encoder: Add 'stepped' irq handler
Date: Sun, 29 Sep 2013 12:40:41 +0200
Message-ID: <524803A9.5090708@gmail.com>
References: <1380392798-23345-1-git-send-email-ezequiel@vanguardiasur.com.ar> <1380392798-23345-2-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:33731 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3I2Kko (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Sep 2013 06:40:44 -0400
Received: by mail-bk0-f43.google.com with SMTP id mz13so1558113bkb.2
        for <linux-input@vger.kernel.org>; Sun, 29 Sep 2013 03:40:43 -0700 (PDT)
In-Reply-To: <1380392798-23345-2-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Ezequiel,

On 28.09.2013 20:26, Ezequiel Garcia wrote:
> Some rotary-encoder devices (such as those with detents) are capable
> of producing a stable event on each step. This commit adds support
> for this case, by implementing a new interruption handler.
> 
> The handler needs only detect the direction of the turn and generate
> an event according to this detection.
> 

> +static irqreturn_t rotary_encoder_stepped_irq(int irq, void *dev_id)
> +{
> +	struct rotary_encoder *encoder = dev_id;
> +	int state, sum;
> +
> +	state = rotary_encoder_get_state(encoder->pdata);
> +
> +	/*
> +	 * We encode the previous and the current state,
> +	 * in the 'sum' variable and then use a table
> +	 * to decide the direction of the turn.
> +	 */
> +	sum = (encoder->last_stable << 2) + state;
> +	switch (sum) {
> +	case 0b1101:
> +	case 0b0100:
> +	case 0b0010:
> +	case 0b1011:

Binary constants are frowned upon, please avoid them in the kernel.
checkpatch.pl should have warned you about them as well.

> diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
> index 3f594dc..499f6f7 100644
> --- a/include/linux/rotary_encoder.h
> +++ b/include/linux/rotary_encoder.h
> @@ -11,6 +11,7 @@ struct rotary_encoder_platform_data {
>  	bool relative_axis;
>  	bool rollover;
>  	bool half_period;
> +	bool on_each_step;

Care to add a DT binding for this property as well?


Other than that, this looks good to me, but I can't test it due to the
lack of hardware.


Thanks,
Daniel

