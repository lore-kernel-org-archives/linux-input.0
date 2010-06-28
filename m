From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2] input: qt602240 - Add ATMEL QT602240 touchscreen driver
Date: Mon, 28 Jun 2010 09:37:08 +0200
Message-ID: <4C285124.1050201@euromail.se>
References: <1277430882-3685-1-git-send-email-jy0922.shim@samsung.com> <4C24B86E.1030407@euromail.se> <4C283048.1090601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:54471 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754602Ab0F1Hha (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 03:37:30 -0400
In-Reply-To: <4C283048.1090601@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

Joonyoung Shim wrote:
> On 6/25/2010 11:08 PM, Henrik Rydberg wrote:
>> Hi Joonyoung,
>>
>> some follow-up comments on the MT events.
>>
>>> +static void qt602240_input_report(struct qt602240_data *data, int single_id)
>>> +{
>>> +	struct qt602240_finger *finger = data->finger;
>>> +	struct input_dev *input_dev = data->input_dev;
>>> +	int finger_num = 0;
>>> +	int id;
>>> +
>>> +	for (id = 0; id < QT602240_MAX_FINGER; id++) {
>>> +		if (!finger[id].status)
>>> +			continue;
>>> +
>>> +		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
>>> +				finger[id].area);
>>> +
>>> +		if (finger[id].status == QT602240_RELEASE)
>>> +			finger[id].status = 0;
>>> +		else {
>>> +			input_report_abs(input_dev, ABS_MT_POSITION_X,
>>> +					finger[id].x);
>>> +			input_report_abs(input_dev, ABS_MT_POSITION_Y,
>>> +					finger[id].y);
>>> +			finger_num++;
>>> +		}
>>> +
>>> +		input_mt_sync(input_dev);
>>> +	}
>>> +
>>> +	input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
>>> +
>>> +	if (finger[single_id].status != QT602240_RELEASE) {
>>> +		input_report_abs(input_dev, ABS_X, finger[single_id].x);
>>> +		input_report_abs(input_dev, ABS_Y, finger[single_id].y);
>>> +	}
>>> +
>>> +	input_sync(input_dev);
>>> +}
>> The problem still persists here. I will try to explain in code form instead:
>>
>> for (id = 0; id < QT602240_MAX_FINGER; id++) {
>> 	if (!finger[id].status)
>> 		continue;
>>
>> 	input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
>> 		finger[id].status != QT602240_RELEASE ? finger[id].area : 0);
>> 	input_report_abs(input_dev, ABS_MT_POSITION_X,
>> 			finger[id].x);
>> 	input_report_abs(input_dev, ABS_MT_POSITION_Y,
>> 			finger[id].y);
> 
> Hmm, is it OK to report ABS_MT_POSITION_X/Y when releases?

Yes. The position should be the position where the finger left the surface. It
is different from the ABS_X/Y case simply because the type A protocol exchanges
data statelessly.

>> 	input_mt_sync(input_dev);
>>
>> 	if (finger[id].status == QT602240_RELEASE)
>> 		finger[id].status = 0;
>> 	else
>> 		finger_num++;
>> }
>>
>> Regarding the single_id, I can understand the need for it, but the logic for a
>> single touch is slightly confusing. If single_id is to be interpreted as the
>> contact currently being tracked as the single pointer, and that single_id
>> changes as the number of fingers on the pad is reduced, until there is only one
>> left, then it would still be clearer logically to do something like this:
>>
>> if (finger_num > 0) {
>> 	input_report_key(input_dev, BTN_TOUCH, 1);
>> 	input_report_abs(input_dev, ABS_X, finger[single_id].x);
>> 	input_report_abs(input_dev, ABS_Y, finger[single_id].y);
>> } else {
>> 	input_report_key(input_dev, BTN_TOUCH, 0);
>> }
>> input_sync(input_dev);
>>
>> Would it not?
>>
> 
> There is a case which fingers more than one are touched and current
> status of single_id finger is release, then this will report ABS_X/Y 
> events even if it is the release event.

I see. And you want BTN_TOUCH to follow the logic for the single touch? I think
that is the main issue here. We can have _one_ of the following definitions, but
not both:

1. input_report_key(input_dev, BTN_TOUCH, finger_num > 0);

2. input_report_key(input_dev, BTN_TOUCH,
                    finger[single_id].status != QT602240_RELEASE);

If you use the latter, there should be another event to denote the finger_num ==
0 case. This line at the end should do it:

if (finger_num == 0)
	input_mt_sync(input_dev);

Thanks,
Henrik

