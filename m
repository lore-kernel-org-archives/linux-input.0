From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Add Atmel AT42QT1070 driver
Date: Sun, 13 Mar 2011 00:48:37 -0800
Message-ID: <20110313084837.GI31566@core.coreip.homeip.net>
References: <1299575978-16134-1>
 <1299655137-2671-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:34438 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767Ab1CMIsm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Mar 2011 04:48:42 -0400
Received: by pxi2 with SMTP id 2so1085950pxi.10
        for <linux-input@vger.kernel.org>; Sun, 13 Mar 2011 00:48:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299655137-2671-1-git-send-email-voice.shen@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: voice <voice.shen@atmel.com>
Cc: linux-input@vger.kernel.org, mohan1234@gmail.com, jm.lin@atmel.com

Hi Shen,

On Wed, Mar 09, 2011 at 03:18:57PM +0800, voice wrote:
> +
> +/* AT42QT1070 support up to 7 keys */
> +static unsigned char qt1070_key2code[] = {

This should be const.

> +	KEY_0, KEY_1, KEY_2, KEY_3,
> +	KEY_4, KEY_5, KEY_6,
> +};


> +
> +struct qt1070_data {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	unsigned char keycodes[ARRAY_SIZE(qt1070_key2code)];

This should be unsigned short since we have key values above 255.

> +
> +static int qt1070_read_key(struct qt1070_data *data)
> +{
> +	struct i2c_client *client = data->client;
> +	struct input_dev *input = data->input;
> +	u8 new_key, old_key, keyval;
> +	int ret, i, mask;
> +
> +	/* Read the detected status register, using to clear interrupt */
> +	ret = qt1070_read(client, DET_STATUS);
> +
> +	/* Read which key changed */
> +	ret = qt1070_read(client, KEY_STATUS);
> +	old_key = data->key;
> +	data->key = new_key = ret;
> +
> +	mask = 0x01;
> +	for (i = 0; i < ARRAY_SIZE(qt1070_key2code); i++) {
> +		keyval = new_key & mask;
> +		if ((old_key & mask) != keyval)
> +			input_report_key(input, data->keycodes[i], keyval);
> +		mask <<= 1;
> +	}
> +	input_sync(input);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t qt1070_interrupt(int irq, void *dev_id)
> +{
> +	struct qt1070_data *data = dev_id;
> +	int ret;
> +
> +	ret = qt1070_read_key(data);

I'd fold qt1070_read_key into qt1070_interrupt.

> +
> +	if (client->irq) {

The driver is completely unusable without irq, I'd recommend simply
refusing to bind if irq is not supplied.

Otherwise looks very good.

Thanks.

-- 
Dmitry
