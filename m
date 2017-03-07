From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 2/3] Input: add support for the STMicroelectronics
 FingerTip touchscreen
Date: Wed, 08 Mar 2017 08:41:00 +0900
Message-ID: <58BF450C.8070000@samsung.com>
References: <20170210021721.12218-1-andi.shyti@samsung.com>
 <CGME20170210021729epcas1p3e11cade2daa21d2dd23839975e29acb6@epcas1p3.samsung.com>
 <20170210021721.12218-3-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:32811 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756039AbdCGXpW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 18:45:22 -0500
In-reply-to: <20170210021721.12218-3-andi.shyti@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>

Hi,

On 2017년 02월 10일 11:17, Andi Shyti wrote:
> The stmfts (ST-Microelectronics FingerTip S) touchscreen device
> is a capacitive multi-touch controller mainly for mobile use.
> 
> It's connected through i2c bus at the address 0x49 and it
> interfaces with userspace through input event interface.
> 
> At the current state it provides a touchscreen multitouch
> functionality up to 10 fingers. Each finger is enumerated with a
> distinctive id (from 0 to 9).
> 
> If enabled the device can support single "touch" hovering, by
> providing three coordinates, x, y and distance.
> 
> It is possible to select the touchkey functionality which
> provides a basic two keys interface for "home" and "back" menu,
> typical in mobile phones.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/input/touchscreen/Kconfig  |  12 +
>  drivers/input/touchscreen/Makefile |   1 +
>  drivers/input/touchscreen/stmfts.c | 794 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 807 insertions(+)
>  create mode 100644 drivers/input/touchscreen/stmfts.c
> 

[snip]

> +static void stmfts_parse_event(struct stmfts_data *sdata, u8 event[])
> +{
> +	int ret;
> +	u8 id, t_id = 0;
> +	u16 x, y, z, maj, min, orientation, area;
> +
> +	id = event[0];
> +
> +	do {
> +		mutex_lock(&sdata->mutex);
> +		if (sdata->in_touch) {
> +			id = event[0] & STMFTS_MASK_EVENT_ID;
> +			t_id = (event[0] & STMFTS_MASK_TOUCH_ID) >> 4;
> +		} else {
> +			id = event[0];
> +			t_id = 0;
> +		}
> +
> +		switch (id) {
> +		case STMFTS_EV_NO_EVENT:
> +			break;
> +
> +		case STMFTS_EV_MULTI_TOUCH_ENTER:
> +		case STMFTS_EV_MULTI_TOUCH_LEAVE:
> +		case STMFTS_EV_MULTI_TOUCH_MOTION:
> +			if (id == STMFTS_EV_MULTI_TOUCH_ENTER) {
> +				if (!(sdata->in_touch++))
> +					input_mt_report_slot_state(
> +							sdata->input,
> +							MT_TOOL_FINGER, true);
> +			} else if (id == STMFTS_EV_MULTI_TOUCH_LEAVE) {
> +				if (!(--sdata->in_touch))
> +					input_mt_report_slot_state(
> +							sdata->input,
> +							MT_TOOL_FINGER, false);
> +			}
> +
> +			x = event[1] | ((event[2] & STMFTS_MASK_X_MSB) << 8);
> +			y = (event[2] >> 4) | (event[3] << 4);
> +
> +			maj = event[4];
> +			min = event[5];
> +			orientation = event[6];
> +			area = event[7];
> +
> +			input_mt_slot(sdata->input, t_id);
> +			input_report_abs(sdata->input, ABS_MT_POSITION_X, x);
> +			input_report_abs(sdata->input, ABS_MT_POSITION_Y, y);
> +			input_report_abs(sdata->input, ABS_MT_TOUCH_MAJOR, maj);
> +			input_report_abs(sdata->input, ABS_MT_TOUCH_MINOR, min);
> +			input_report_abs(sdata->input, ABS_MT_PRESSURE, area);
> +			input_report_abs(sdata->input, ABS_MT_ORIENTATION,
> +								orientation);
> +			input_sync(sdata->input);
> +

When I tested this patch on TM2 board, It looks like it is not well working.
So, I tried to check the input event by using the evtest tool.
But, the result don't show the proper ABS_MT_TRACKING_ID event.
[1] https://cgit.freedesktop.org/evtest/

According to the mutlti-touch-protocol.txt[2], there are two multi-touch protocol.
As far as I knew, this driver supports the Protocol B which needs
the ABS_MT_TRACKING_ID according to the multi-touch-protocol.txt[2].
[2] Documentation/input/mutlti-touch-protocol.txt
 
In our test, the ABS_MT_TRACKING_ID is showed only one time.
After pressing/releasing finger from touchscreen on first time,
there are no ABS_MT_TRACKING_ID information from second try with finger.

I guess that input_mt_report_slot_state() is not calling properly.


> +			break;
> +
> +		case STMFTS_EV_HOVER_ENTER:
> +		case STMFTS_EV_HOVER_LEAVE:
> +		case STMFTS_EV_HOVER_MOTION:
> +			x = (event[2] << 4) | (event[4] >> 4);
> +			y = (event[3] << 4) | (event[4] & STMFTS_MASK_Y_LSB);
> +			z = event[5];
> +			orientation = event[6] & STMFTS_MASK_Y_LSB;
> +
> +			input_report_abs(sdata->input, ABS_X, x);
> +			input_report_abs(sdata->input, ABS_Y, y);
> +			input_report_abs(sdata->input, ABS_DISTANCE, z);
> +			input_sync(sdata->input);
> +
> +			break;
> +


[snip]


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
