From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Tue, 26 Jul 2011 17:47:58 +0800
Message-ID: <4E2E8D4E.8070803@cn.fujitsu.com>
References: <1311672354-15453-1-git-send-email-jiejing.zhang@freescale.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:57042 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab1GZJtD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2011 05:49:03 -0400
In-Reply-To: <1311672354-15453-1-git-send-email-jiejing.zhang@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, kzjeef@gmail.com

On 07/26/2011 05:25 PM, Zhang Jiejing wrote:
> this patch adds EETI eGalax serial multi touch controller driver.
>
> EETI eGalax serial touch screen controller is a I2C based multiple
> capacitive touch screen controller, it can supports 5 touch events maximum.
>
> Signed-off-by: Zhang Jiejing<jiejing.zhang@freescale.com>
> ---
>   drivers/input/touchscreen/Kconfig     |   10 +
>   drivers/input/touchscreen/Makefile    |    1 +
>   drivers/input/touchscreen/egalax_ts.c |  314 +++++++++++++++++++++++++++++++++
>   3 files changed, 325 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/input/touchscreen/egalax_ts.c
>

> +
> +	if (down) {
> +		/* since egalax only report one of multi touch event,
> +		 * so we need record pervious event with different id
> +		 * and report them.*/
> +		events[id].valid = valid;
> +		events[id].status = down;
> +		events[id].x = x;
> +		events[id].y = y;
> +
> +		for (i = 0; i<  MAX_SUPPORT_POINTS; i++) {
> +			if (!events[i].valid)
> +				continue;
> +			dev_dbg(&client->dev, "report id:%d valid:%d x:%d y:%d",
> +				i, valid, x, y);
> +
> +			input_report_abs(input_dev,
> +					 ABS_MT_TRACKING_ID, i);
> +			input_report_abs(input_dev,
> +					 ABS_MT_TOUCH_MAJOR, 1);
> +			input_report_abs(input_dev,
> +					 ABS_MT_POSITION_X, events[i].x);
> +			input_report_abs(input_dev,
> +					 ABS_MT_POSITION_Y, events[i].y);
> +			input_mt_sync(input_dev);
> +		}
> +	} else {
> +		dev_dbg(&client->dev, "release id:%d\n", id);
> +		events[id].valid = 0;
> +		events[id].status = 0;
> +		input_report_abs(input_dev, ABS_MT_TRACKING_ID, id);
> +		input_event(input_dev, EV_ABS, ABS_MT_TOUCH_MAJOR, 0);
> +		input_mt_sync(input_dev);
> +	}
> +
> +	input_sync(input_dev);
need re-sync here ?

> +	data->client = client;
> +	data->input_dev = input_dev;
> +	/* controller may be in sleep, wake it up. */
> +	egalax_wake_up_device(client);
> +	ret = egalax_firmware_version(client);
> +	if (ret<  0) {
> +		dev_err(&client->dev,
> +			"egalax_ts: failed to read firmware version\n");
> +		ret = -EIO;
> +		goto err_free_dev;
> +	}
> +
> +	input_dev->name = "EETI eGalax Touch Screen";
> +	input_dev->phys = "I2C",
> +	input_dev->id.bustype = BUS_I2C;
> +	input_dev->dev.parent =&client->dev;
> +
> +	__set_bit(EV_ABS, input_dev->evbit);
> +	__set_bit(EV_KEY, input_dev->evbit);
> +	__set_bit(BTN_TOUCH, input_dev->keybit);
> +	__set_bit(ABS_X, input_dev->absbit);
> +	__set_bit(ABS_Y, input_dev->absbit);
> +	input_set_abs_params(input_dev, ABS_X, 0, 32767, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, 32767, 0, 0);
make 32767 to macro here ?

-- 
Thanks
Best Regards
Wanlong Gao
