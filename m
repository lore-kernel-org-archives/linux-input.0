From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] Input: add ST1232 touchscreen controller driver.
Date: Tue, 14 Dec 2010 10:47:26 +0100
Message-ID: <4D073D2E.5040107@euromail.se>
References: <1292301289-12931-1-git-send-email-chinyeow.sim.xt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:43312 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751399Ab0LNJsR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Dec 2010 04:48:17 -0500
In-Reply-To: <1292301289-12931-1-git-send-email-chinyeow.sim.xt@renesas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chinyeow.sim.xt@renesas.com
Cc: tsoni@codeaurora.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi Tony,

Thanks for the resubmission. Indeed, the driver looks a lot better now.

> +
> +static void st1232_ts_work_func(struct work_struct *work)
> +{
> +	int i, ret;
> +	struct i2c_msg msg[2];
> +	uint8_t start_reg;
> +	uint8_t buf[10];
> +	struct st1232_ts_data *ts =
> +		container_of(work, struct st1232_ts_data, work.work);
> +	uint16_t x[MAX_FINGERS], y[MAX_FINGERS];
> +	uint8_t t[MAX_FINGERS];
> +	uint8_t is_valid[MAX_FINGERS];


A lot of stack variables here - maybe there is something more that can be broken
out of the main function?

> +
> +	/* read touchscreen data from ST1232 */
> +	msg[0].addr = ts->client->addr;
> +	msg[0].flags = 0;
> +	msg[0].len = 1;
> +	msg[0].buf = &start_reg;
> +	start_reg = 0x10;
> +
> +	msg[1].addr = ts->client->addr;
> +	msg[1].flags = I2C_M_RD;
> +	msg[1].len = sizeof(buf);
> +	msg[1].buf = buf;
> +
> +	ret = i2c_transfer(ts->client->adapter, msg, 2);
> +	if (ret < 0)
> +		goto done;
> +
> +	/* get valid bit */
> +	is_valid[XY0] = buf[2] >> 7;
> +	is_valid[XY1] = buf[5] >> 7;
> +
> +	/* get xy coordinate */
> +	if (is_valid[XY0]) {
> +		x[XY0] = ((buf[2] & 0x0070) << 4) | buf[3];
> +		y[XY0] = ((buf[2] & 0x0007) << 8) | buf[4];
> +		t[XY0] = buf[8];
> +	}
> +
> +	if (is_valid[XY1]) {
> +		x[XY1] = ((buf[5] & 0x0070) << 4) | buf[6];
> +		y[XY1] = ((buf[5] & 0x0007) << 8) | buf[7];
> +		t[XY1] = buf[9];
> +	}


Populating the x, y, and t variables looks like a candidate for a separate function.

> +
> +	/* multi touch protocol */
> +	for (i = 0; i < MAX_FINGERS; i++) {
> +		if (!is_valid[i]) {
> +			input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0);


The type A protocol carries no state, so the above actually means nothing
without a position (and without the input_mt_sync). Ensuring t[i] is zero in
this code path would let you drop the test altogether, and also ensure that the
input_mt_syncs are sent properly.

> +			continue;
> +		}
> +
> +		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, t[i]);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_X, x[i]);
> +		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, y[i]);
> +		input_mt_sync(ts->input_dev);
> +		}
> +
> +	/* EV_SYN */
> +	input_sync(ts->input_dev);
> +
> +done:
> +	enable_irq(ts->client->irq);
> +
> +	return;
> +}
> +


Thanks,
Henrik

