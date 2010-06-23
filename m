From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Wed, 23 Jun 2010 22:06:49 +0200
Message-ID: <4C226959.3020806@euromail.se>
References: <1277298967-22596-1-git-send-email-jy0922.shim@samsung.com> <20100623173438.GB11512@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:40363 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750966Ab0FWUHO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jun 2010 16:07:14 -0400
In-Reply-To: <20100623173438.GB11512@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Hi Joonyoung,
[...]
>> +static void qt602240_input_read(struct qt602240_data *data)
>> +{
>> +	struct qt602240_message message;
>> +	struct qt602240_object *object;
>> +	struct device *dev = &data->client->dev;
>> +	struct input_dev *input_dev = data->input_dev;
>> +	u8 reportid;
>> +	u8 max_reportid;
>> +	u8 min_reportid;
>> +
>> +repeat:
>> +	if (qt602240_read_message(data, &message)) {
>> +		dev_err(dev, "Failed to read message\n");
>> +		return;
>> +	}
>> +
>> +	reportid = message.reportid;
>> +
>> +	/* Check it remains the message to process */
>> +	if (reportid == 0xff)
>> +		return;
>> +
>> +	/* whether reportid is thing of QT602240_TOUCH_MULTI */
>> +	object = qt602240_get_object(data, QT602240_TOUCH_MULTI);
>> +	if (!object)
>> +		return;
>> +
>> +	max_reportid = object->max_reportid;
>> +	min_reportid = max_reportid - object->num_report_ids + 1;
>> +
>> +	if ((reportid >= min_reportid) && (reportid <= max_reportid)) {
>> +		u8 id;
>> +		u8 status;
>> +		int x;
>> +		int y;
>> +		int area;
>> +		int finger_num = 0;
>> +
>> +		id = reportid - min_reportid;
>> +		status = message.message[0];
>> +
>> +		/* Check the touch is present on the screen */
>> +		if (!(status & QT602240_DETECT))
>> +			goto release;
>> +
>> +		/* Check only AMP detection */
>> +		if (!(status & (QT602240_PRESS | QT602240_MOVE)))
>> +			goto repeat;
>> +
>> +		x = (message.message[1] << 2) |
>> +			((message.message[3] & ~0x3f) >> 6);
>> +		y = (message.message[2] << 2) |
>> +			((message.message[3] & ~0xf3) >> 2);
>> +		area = message.message[4];
>> +
>> +		dev_dbg(dev, "[%d] %s x: %d, y: %d, area: %d\n", id,
>> +				status & QT602240_MOVE ?  "moved" : "pressed",
>> +				x, y, area);
>> +
>> +		data->finger[id].status = status & QT602240_MOVE ?
>> +			QT602240_MOVE : QT602240_PRESS;
>> +		data->finger[id].x = x;
>> +		data->finger[id].y = y;
>> +		data->finger[id].area = area;
>> +
>> +		input_report_key(input_dev, BTN_TOUCH, 1);
>> +		input_report_abs(input_dev, ABS_X, x);
>> +		input_report_abs(input_dev, ABS_Y, y);
>> +
>> +		goto mt_report;
>> +
>> +release:
>> +		if (status & QT602240_RELEASE) {
>> +			dev_dbg(dev, "[%d] released\n", id);
>> +
>> +			data->finger[id].status = QT602240_RELEASE;
>> +			data->finger[id].area = 0;
>> +		}
>> +
>> +mt_report:
>> +		for (id = 0; id < QT602240_MAX_FINGER; id++) {
>> +			if (!data->finger[id].status)
>> +				continue;
>> +
>> +			input_report_abs(input_dev, ABS_MT_TRACKING_ID, id);
>> +			input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
>> +					data->finger[id].area);
>> +
>> +			if (data->finger[id].status == QT602240_RELEASE)
>> +				data->finger[id].status = 0;
>> +			else {
>> +				input_report_abs(input_dev, ABS_MT_POSITION_X,
>> +						data->finger[id].x);
>> +				input_report_abs(input_dev, ABS_MT_POSITION_Y,
>> +						data->finger[id].y);
>> +				finger_num++;
>> +			}

The finger[id].status is checked twice in this block, is there any particular
reason for it? Either way, reporting only a part of the finger properties before
input_mt_sync() is wrong. Perhaps one can move the second test up together with
the first one?

>> +
>> +			input_mt_sync(input_dev);
>> +		}
>> +
>> +		if (!finger_num)
>> +			input_report_key(input_dev, BTN_TOUCH, 0);

The lines above can be combined with the first BTN_TOUCH instance to something
like this:

	input_report_key(input_dev, BTN_TOUCH, finger_num > 0);

The input core will not emit the key unless it actually changes.

>> +		input_sync(input_dev);
>> +	} else {
>> +		qt602240_dump_message(dev, &message);
>> +		qt602240_check_config_error(data, &message, reportid);
>> +	}
>> +
>> +	goto repeat;
[...]
>> +	__set_bit(EV_ABS, input_dev->evbit);
>> +	__set_bit(EV_KEY, input_dev->evbit);
>> +	__set_bit(BTN_TOUCH, input_dev->keybit);
>> +
>> +	/* For single touch */
>> +	input_set_abs_params(input_dev, ABS_X, 0, QT602240_MAX_XC, 0,
>> +			0);
>> +	input_set_abs_params(input_dev, ABS_Y, 0, QT602240_MAX_YC, 0,
>> +			0);
>> +
>> +	/* For multi touch */
>> +	input_set_abs_params(input_dev, ABS_MT_TRACKING_ID, 0,
>> +			QT602240_MAX_ID, 0, 0);

What is a normal value for QT602240_MAX_ID? Is it modified every time there is a
new touch?

>> +	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0,
>> +			QT602240_MAX_AREA, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
>> +			QT602240_MAX_XC, 0, 0);
>> +	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
>> +			QT602240_MAX_YC, 0, 0);
>> +
>> +	input_set_drvdata(input_dev, data);
[...]

In general, I think the functions of this driver are too long. Splitting them up
might do good.

Thanks!
Henrik

