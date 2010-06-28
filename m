From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Mon, 28 Jun 2010 17:17:53 +0900
Message-ID: <4C285AB1.7030301@samsung.com>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com>
 <4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com>
 <4C285124.1050201@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42968 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab0F1Its (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 04:49:48 -0400
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4P00BWTTPTL6D0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 28 Jun 2010 17:17:53 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4P00AE2TPTFC@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 28 Jun 2010 17:17:53 +0900 (KST)
In-reply-to: <4C285124.1050201@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

On 6/28/2010 4:37 PM, Henrik Rydberg wrote:
> Joonyoung Shim wrote:
>> On 6/25/2010 11:08 PM, Henrik Rydberg wrote:
>>> Hi Joonyoung,
>>>
>>> some follow-up comments on the MT events.
>>>
>>>> +static void qt602240_input_report(struct qt602240_data *data, int single_id)
>>>> +{
>>>> +	struct qt602240_finger *finger = data->finger;
>>>> +	struct input_dev *input_dev = data->input_dev;
>>>> +	int finger_num = 0;
>>>> +	int id;
>>>> +
>>>> +	for (id = 0; id < QT602240_MAX_FINGER; id++) {
>>>> +		if (!finger[id].status)
>>>> +			continue;
>>>> +
>>>> +		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
>>>> +				finger[id].area);
>>>> +
>>>> +		if (finger[id].status == QT602240_RELEASE)
>>>> +			finger[id].status = 0;
>>>> +		else {
>>>> +			input_report_abs(input_dev, ABS_MT_POSITION_X,
>>>> +					finger[id].x);
>>>> +			input_report_abs(input_dev, ABS_MT_POSITION_Y,
>>>> +					finger[id].y);
>>>> +			finger_num++;
>>>> +		}
>>>> +
>>>> +		input_mt_sync(input_dev);
>>>> +	}
>>>> +
>>>> +	input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
>>>> +
>>>> +	if (finger[single_id].status != QT602240_RELEASE) {
>>>> +		input_report_abs(input_dev, ABS_X, finger[single_id].x);
>>>> +		input_report_abs(input_dev, ABS_Y, finger[single_id].y);
>>>> +	}
>>>> +
>>>> +	input_sync(input_dev);
>>>> +}
>>> The problem still persists here. I will try to explain in code form instead:
>>>
>>> for (id = 0; id < QT602240_MAX_FINGER; id++) {
>>> 	if (!finger[id].status)
>>> 		continue;
>>>
>>> 	input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
>>> 		finger[id].status != QT602240_RELEASE ? finger[id].area : 0);
>>> 	input_report_abs(input_dev, ABS_MT_POSITION_X,
>>> 			finger[id].x);
>>> 	input_report_abs(input_dev, ABS_MT_POSITION_Y,
>>> 			finger[id].y);
>> Hmm, is it OK to report ABS_MT_POSITION_X/Y when releases?
> 
> Yes. The position should be the position where the finger left the surface. It
> is different from the ABS_X/Y case simply because the type A protocol exchanges
> data statelessly.
> 

I see, but i have something wondering at your document.

This is your patch of "Document the MT event slot protocol"

+Protocol Example A
+------------------
+
+Here is what a minimal event sequence for a two-contact touch would look
+like for a type A device:
+
+   ABS_MT_POSITION_X x[0]
+   ABS_MT_POSITION_Y y[0]
+   SYN_MT_REPORT
+   ABS_MT_POSITION_X x[1]
+   ABS_MT_POSITION_Y y[1]
+   SYN_MT_REPORT
+   SYN_REPORT

+The sequence after moving one of the contacts looks exactly the same; the
+raw data for all present contacts are sent between every synchronization
+with SYN_REPORT.

-Usage
------
+Here is the sequence after lifting the first contact:
+
+   ABS_MT_POSITION_X x[1]
+   ABS_MT_POSITION_Y y[1]
+   SYN_MT_REPORT
+   SYN_REPORT
+
+And here is the sequence after lifting the second contact:
+
+   SYN_MT_REPORT
+   SYN_REPORT
+

Here, there is no reporting for ABS_MT_POSITION_X/Y event, because that
is the last contact?
Then, the coordinates of the first contact are x[1] and y[1], right? If 
yes, it is some confusing, i think they are x[0] and y[0].

>>> 	input_mt_sync(input_dev);
>>>
>>> 	if (finger[id].status == QT602240_RELEASE)
>>> 		finger[id].status = 0;
>>> 	else
>>> 		finger_num++;
>>> }
>>>
>>> Regarding the single_id, I can understand the need for it, but the logic for a
>>> single touch is slightly confusing. If single_id is to be interpreted as the
>>> contact currently being tracked as the single pointer, and that single_id
>>> changes as the number of fingers on the pad is reduced, until there is only one
>>> left, then it would still be clearer logically to do something like this:
>>>
>>> if (finger_num > 0) {
>>> 	input_report_key(input_dev, BTN_TOUCH, 1);
>>> 	input_report_abs(input_dev, ABS_X, finger[single_id].x);
>>> 	input_report_abs(input_dev, ABS_Y, finger[single_id].y);
>>> } else {
>>> 	input_report_key(input_dev, BTN_TOUCH, 0);
>>> }
>>> input_sync(input_dev);
>>>
>>> Would it not?
>>>
>> There is a case which fingers more than one are touched and current
>> status of single_id finger is release, then this will report ABS_X/Y 
>> events even if it is the release event.
> 
> I see. And you want BTN_TOUCH to follow the logic for the single touch? I think
> that is the main issue here. We can have _one_ of the following definitions, but
> not both:
> 
> 1. input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
> 

OK, i will use this. This was original code.

> 2. input_report_key(input_dev, BTN_TOUCH,
>                     finger[single_id].status != QT602240_RELEASE);
> 
> If you use the latter, there should be another event to denote the finger_num ==
> 0 case. This line at the end should do it:
> 
> if (finger_num == 0)
> 	input_mt_sync(input_dev);
> 

I don't know why this needs?


Here, there are fixed codes. How about do you think?

static void qt602240_input_report(struct qt602240_data *data, int single_id)
{
	struct qt602240_finger *finger = data->finger;
	struct input_dev *input_dev = data->input_dev;
	int status = finger[single_id].status;
	int finger_num = 0;
	int id;

	for (id = 0; id < QT602240_MAX_FINGER; id++) {
		if (!finger[id].status)
			continue;

		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
				finger[id].status != QT602240_RELEASE ?
				finger[id].area : 0);
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

	input_report_key(input_dev, BTN_TOUCH, finger_num > 0);

	if (status != QT602240_RELEASE) {
		input_report_abs(input_dev, ABS_X, finger[single_id].x);
		input_report_abs(input_dev, ABS_Y, finger[single_id].y);
	}

	input_sync(input_dev);
}


Thanks.
