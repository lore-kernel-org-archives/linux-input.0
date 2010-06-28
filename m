From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Mon, 28 Jun 2010 14:16:56 +0900
Message-ID: <4C283048.1090601@samsung.com>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com>
 <4C24B86E.1030407@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:56517 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab0F1FQ7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 01:16:59 -0400
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4P00A5LLC9P9C0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Mon, 28 Jun 2010 14:16:57 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4P005LOLC8SI@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 28 Jun 2010 14:16:56 +0900 (KST)
In-reply-to: <4C24B86E.1030407@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

On 6/25/2010 11:08 PM, Henrik Rydberg wrote:
> Hi Joonyoung,
> 
> some follow-up comments on the MT events.
> 
>> +static void qt602240_input_report(struct qt602240_data *data, int single_id)
>> +{
>> +	struct qt602240_finger *finger = data->finger;
>> +	struct input_dev *input_dev = data->input_dev;
>> +	int finger_num = 0;
>> +	int id;
>> +
>> +	for (id = 0; id < QT602240_MAX_FINGER; id++) {
>> +		if (!finger[id].status)
>> +			continue;
>> +
>> +		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
>> +				finger[id].area);
>> +
>> +		if (finger[id].status == QT602240_RELEASE)
>> +			finger[id].status = 0;
>> +		else {
>> +			input_report_abs(input_dev, ABS_MT_POSITION_X,
>> +					finger[id].x);
>> +			input_report_abs(input_dev, ABS_MT_POSITION_Y,
>> +					finger[id].y);
>> +			finger_num++;
>> +		}
>> +
>> +		input_mt_sync(input_dev);
>> +	}
>> +
>> +	input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
>> +
>> +	if (finger[single_id].status != QT602240_RELEASE) {
>> +		input_report_abs(input_dev, ABS_X, finger[single_id].x);
>> +		input_report_abs(input_dev, ABS_Y, finger[single_id].y);
>> +	}
>> +
>> +	input_sync(input_dev);
>> +}
> 
> The problem still persists here. I will try to explain in code form instead:
> 
> for (id = 0; id < QT602240_MAX_FINGER; id++) {
> 	if (!finger[id].status)
> 		continue;
> 
> 	input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
> 		finger[id].status != QT602240_RELEASE ? finger[id].area : 0);
> 	input_report_abs(input_dev, ABS_MT_POSITION_X,
> 			finger[id].x);
> 	input_report_abs(input_dev, ABS_MT_POSITION_Y,
> 			finger[id].y);

Hmm, is it OK to report ABS_MT_POSITION_X/Y when releases?

> 	input_mt_sync(input_dev);
> 
> 	if (finger[id].status == QT602240_RELEASE)
> 		finger[id].status = 0;
> 	else
> 		finger_num++;
> }
> 
> Regarding the single_id, I can understand the need for it, but the logic for a
> single touch is slightly confusing. If single_id is to be interpreted as the
> contact currently being tracked as the single pointer, and that single_id
> changes as the number of fingers on the pad is reduced, until there is only one
> left, then it would still be clearer logically to do something like this:
> 
> if (finger_num > 0) {
> 	input_report_key(input_dev, BTN_TOUCH, 1);
> 	input_report_abs(input_dev, ABS_X, finger[single_id].x);
> 	input_report_abs(input_dev, ABS_Y, finger[single_id].y);
> } else {
> 	input_report_key(input_dev, BTN_TOUCH, 0);
> }
> input_sync(input_dev);
> 
> Would it not?
> 

There is a case which fingers more than one are touched and current
status of single_id finger is release, then this will report ABS_X/Y 
events even if it is the release event.

How about codes like this? :

+       int status = finger[single_id].status;

[snip]

+       if (finger_num > 0) {
+               if (status != QT602240_RELEASE) {
+                       input_report_key(input_dev, BTN_TOUCH, 1);
+                       input_report_abs(input_dev, ABS_X, finger[single_id].x);
+                       input_report_abs(input_dev, ABS_Y, finger[single_id].y);
+               }
+       } else
+               input_report_key(input_dev, BTN_TOUCH, 0);
