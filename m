From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Mon, 28 Jun 2010 10:34:13 +0200
Message-ID: <4C285E85.6080008@euromail.se>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com> <4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com> <4C285124.1050201@euromail.se> <4C285AB1.7030301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:41586 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753184Ab0F1Ien (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 04:34:43 -0400
In-Reply-To: <4C285AB1.7030301@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Joonyoung Shim wrote:
[...]
> I see, but i have something wondering at your document.
> 
> This is your patch of "Document the MT event slot protocol"
> 
> +Protocol Example A
> +------------------
> +
> +Here is what a minimal event sequence for a two-contact touch would look
> +like for a type A device:
> +
> +   ABS_MT_POSITION_X x[0]
> +   ABS_MT_POSITION_Y y[0]
> +   SYN_MT_REPORT
> +   ABS_MT_POSITION_X x[1]
> +   ABS_MT_POSITION_Y y[1]
> +   SYN_MT_REPORT
> +   SYN_REPORT
> 
> +The sequence after moving one of the contacts looks exactly the same; the
> +raw data for all present contacts are sent between every synchronization
> +with SYN_REPORT.
> 
> -Usage
> ------
> +Here is the sequence after lifting the first contact:
> +
> +   ABS_MT_POSITION_X x[1]
> +   ABS_MT_POSITION_Y y[1]
> +   SYN_MT_REPORT
> +   SYN_REPORT
> +
> +And here is the sequence after lifting the second contact:
> +
> +   SYN_MT_REPORT
> +   SYN_REPORT
> +
> 
> Here, there is no reporting for ABS_MT_POSITION_X/Y event, because that
> is the last contact?
> Then, the coordinates of the first contact are x[1] and y[1], right? If 
> yes, it is some confusing, i think they are x[0] and y[0].

It is a bit confusing I agree, but the document is correct. The empty
input_mt_sync() is used when there is no data to report, no lifted fingers,
nothing. Just imagine a device which gets polled periodically.

[...]
>> I see. And you want BTN_TOUCH to follow the logic for the single touch? I think
>> that is the main issue here. We can have _one_ of the following definitions, but
>> not both:
>>
>> 1. input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
>>
> 
> OK, i will use this. This was original code.
> 
>> 2. input_report_key(input_dev, BTN_TOUCH,
>>                     finger[single_id].status != QT602240_RELEASE);
>>
>> If you use the latter, there should be another event to denote the finger_num ==
>> 0 case. This line at the end should do it:
>>
>> if (finger_num == 0)
>> 	input_mt_sync(input_dev);
>>
> 
> I don't know why this needs?

The general reason is the one given above. Since you are going with the first
option, it won't be needed.

> Here, there are fixed codes. How about do you think?
> 
> static void qt602240_input_report(struct qt602240_data *data, int single_id)
> {
> 	struct qt602240_finger *finger = data->finger;
> 	struct input_dev *input_dev = data->input_dev;
> 	int status = finger[single_id].status;
> 	int finger_num = 0;
> 	int id;
> 
> 	for (id = 0; id < QT602240_MAX_FINGER; id++) {
> 		if (!finger[id].status)
> 			continue;
> 
> 		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
> 				finger[id].status != QT602240_RELEASE ?
> 				finger[id].area : 0);
> 		input_report_abs(input_dev, ABS_MT_POSITION_X,
> 				finger[id].x);
> 		input_report_abs(input_dev, ABS_MT_POSITION_Y,
> 				finger[id].y);
> 		input_mt_sync(input_dev);
> 
> 		if (finger[id].status == QT602240_RELEASE)
> 			finger[id].status = 0;
> 		else
> 			finger_num++;
> 	}
> 
> 	input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
> 
> 	if (status != QT602240_RELEASE) {
> 		input_report_abs(input_dev, ABS_X, finger[single_id].x);
> 		input_report_abs(input_dev, ABS_Y, finger[single_id].y);
> 	}
> 
> 	input_sync(input_dev);
> }
> 
> 
> Thanks.

This looks like it will work.

Thanks,
Henrik
