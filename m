From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Fri, 25 Jun 2010 16:08:46 +0200
Message-ID: <4C24B86E.1030407@euromail.se>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h12.telenor.se ([62.127.194.5]:53977 "EHLO
	smtprelay-h12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab0FYOIx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jun 2010 10:08:53 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-h12.telenor.se (Postfix) with ESMTP id 94AA6C8AF
	for <linux-input@vger.kernel.org>; Fri, 25 Jun 2010 16:08:51 +0200 (CEST)
In-Reply-To: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Hi Joonyoung,

some follow-up comments on the MT events.

> +static void qt602240_input_report(struct qt602240_data *data, int single_id)
> +{
> +	struct qt602240_finger *finger = data->finger;
> +	struct input_dev *input_dev = data->input_dev;
> +	int finger_num = 0;
> +	int id;
> +
> +	for (id = 0; id < QT602240_MAX_FINGER; id++) {
> +		if (!finger[id].status)
> +			continue;
> +
> +		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
> +				finger[id].area);
> +
> +		if (finger[id].status == QT602240_RELEASE)
> +			finger[id].status = 0;
> +		else {
> +			input_report_abs(input_dev, ABS_MT_POSITION_X,
> +					finger[id].x);
> +			input_report_abs(input_dev, ABS_MT_POSITION_Y,
> +					finger[id].y);
> +			finger_num++;
> +		}
> +
> +		input_mt_sync(input_dev);
> +	}
> +
> +	input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
> +
> +	if (finger[single_id].status != QT602240_RELEASE) {
> +		input_report_abs(input_dev, ABS_X, finger[single_id].x);
> +		input_report_abs(input_dev, ABS_Y, finger[single_id].y);
> +	}
> +
> +	input_sync(input_dev);
> +}

The problem still persists here. I will try to explain in code form instead:

for (id = 0; id < QT602240_MAX_FINGER; id++) {
	if (!finger[id].status)
		continue;

	input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
		finger[id].status != QT602240_RELEASE ? finger[id].area : 0);
	input_report_abs(input_dev, ABS_MT_POSITION_X,
			finger[id].x);
	input_report_abs(input_dev, ABS_MT_POSITION_Y,
			finger[id].y);
	input_mt_sync(input_dev);

	if (finger[id].status == QT602240_RELEASE)
		finger[id].status = 0;
	else
		finger_num++;
}

Regarding the single_id, I can understand the need for it, but the logic for a
single touch is slightly confusing. If single_id is to be interpreted as the
contact currently being tracked as the single pointer, and that single_id
changes as the number of fingers on the pad is reduced, until there is only one
left, then it would still be clearer logically to do something like this:

if (finger_num > 0) {
	input_report_key(input_dev, BTN_TOUCH, 1);
	input_report_abs(input_dev, ABS_X, finger[single_id].x);
	input_report_abs(input_dev, ABS_Y, finger[single_id].y);
} else {
	input_report_key(input_dev, BTN_TOUCH, 0);
}
input_sync(input_dev);

Would it not?

Thanks,
Henrik
