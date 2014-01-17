From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom - add support for DTU-1031
Date: Thu, 16 Jan 2014 16:34:19 -0800
Message-ID: <20140117003419.GD837@core.coreip.homeip.net>
References: <1389907779-12125-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33743 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbaAQAeW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jan 2014 19:34:22 -0500
Received: by mail-pa0-f49.google.com with SMTP id hz1so3383892pad.36
        for <linux-input@vger.kernel.org>; Thu, 16 Jan 2014 16:34:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389907779-12125-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Hi Ping,

On Thu, Jan 16, 2014 at 01:29:39PM -0800, Ping Cheng wrote:
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/input/tablet/wacom_wac.c | 80 +++++++++++++++++++++++++++++++++++++++-
>  drivers/input/tablet/wacom_wac.h |  6 ++-
>  2 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 0bcc7a6..fed2f04 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -210,6 +210,70 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
>  	return 1;
>  }
>  
> +static int wacom_dtus_irq(struct wacom_wac *wacom)
> +{
> +	char *data = wacom->data;
> +	struct input_dev *input = wacom->input;
> +	unsigned short prox, pressure = 0;
> +	int retval = 0;
> +
> +	if (data[0] != WACOM_REPORT_DTUS && data[0] != WACOM_REPORT_DTUSPAD) {
> +		dev_dbg(input->dev.parent,
> +		"%s: received unknown report #%d", __func__, data[0]);
> +		goto exit;
> +	}
> +
> +	if (data[0] == WACOM_REPORT_DTUSPAD) {
> +		input_report_key(input, BTN_0, (data[1] & 0x01));
> +		input_report_key(input, BTN_1, (data[1] & 0x02));
> +		input_report_key(input, BTN_2, (data[1] & 0x04));
> +		input_report_key(input, BTN_3, (data[1] & 0x08));
> +		if (data[1] & 0x0f) {
> +			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
> +		} else {
> +			input_report_abs(input, ABS_MISC, 0);
> +		}
> +		/* serial number is required when expresskeys are
> +		 * reported through pen interface.
> +		 */
> +		input_event(input, EV_MSC, MSC_SERIAL, 0xf0);
> +		retval = 1;
> +		goto exit;

Let's not abuse gotos. This seems like perfect candidate for
"if/else if/else" construct.

> +	}
> +
> +	prox = data[1] & 0x80;
> +	if (prox) {
> +		switch ((data[1] >> 3) & 3) {
> +		case 1: /* Rubber */
> +			wacom->tool[0] = BTN_TOOL_RUBBER;
> +			wacom->id[0] = ERASER_DEVICE_ID;
> +			break;
> +
> +		case 2: /* Pen */
> +			wacom->tool[0] = BTN_TOOL_PEN;
> +			wacom->id[0] = STYLUS_DEVICE_ID;
> +			break;
> +		}
> +	}
> +
> +	input_report_key(input, BTN_STYLUS, data[1] & 0x20);
> +	input_report_key(input, BTN_STYLUS2, data[1] & 0x40);
> +	input_report_abs(input, ABS_X, be16_to_cpup((__be16 *)&data[3]));
> +	input_report_abs(input, ABS_Y, be16_to_cpup((__be16 *)&data[5]));

I am pretty sure this is not aligned on word boundary so you need to use
get_unaligned_be16() here.

Thanks.

-- 
Dmitry
