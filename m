From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 4/4] Input: atmel_mxt_ts - Convert to MT protocol B
Date: Fri, 11 Mar 2011 15:41:16 +0900
Message-ID: <4D79C40C.7010706@samsung.com>
References: <1299488069-24291-1-git-send-email-jy0922.shim@samsung.com>
 <20110310111040.GA2595@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33340 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab1CKGue (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 01:50:34 -0500
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHV005IJRWSCVC0@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Fri, 11 Mar 2011 15:41:16 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHV00IMBRWS9Z@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Fri, 11 Mar 2011 15:41:16 +0900 (KST)
In-reply-to: <20110310111040.GA2595@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, iiro.valkonen@atmel.com, kyungmin.park@samsung.com

On 2011-03-10 =EC=98=A4=ED=9B=84 8:10, Henrik Rydberg wrote:
> Hi Joonyoung,
>
>> Atmel touchscreen chips can use MT protocol B because they can assig=
n
>> unique id to ABS_MT_TRACKING_ID from finger id provided by hardware.
>>
>> Signed-off-by: Joonyoung Shim<jy0922.shim@samsung.com>
>
> Thanks for making this change. Please see comments inline.
>

Hi, Henrik.

I missed your MT protocol B API changes.
I will resend modified patch.

Thanks for your review.

>> ---
>>   drivers/input/touchscreen/atmel_mxt_ts.c |   37 ++++++++++++++++++=
++---------
>>   1 files changed, 25 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/inpu=
t/touchscreen/atmel_mxt_ts.c
>> index fd1fda5..7da71d9 100644
>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> @@ -203,6 +203,7 @@
>>
>>   /* Touchscreen absolute values */
>>   #define MXT_MAX_AREA		0xff
>> +#define MXT_MAX_TRACKING_ID	0xff
>
> Instead, include<linux/input/mt.h>
>
>>   #define MXT_MAX_FINGER		10
>>
>> @@ -238,6 +239,7 @@ struct mxt_finger {
>>   	int x;
>>   	int y;
>>   	int area;
>> +	int trkid;
>
> The tracking id is now handled in the input core, so it can be droppe=
d here.
>
>>   };
>>
>>   /* Each client has this additional data */
>> @@ -504,19 +506,19 @@ static void mxt_input_report(struct mxt_data *=
data, int single_id)
>>   		if (!finger[id].status)
>>   			continue;
>>
>> -		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
>> -				finger[id].status !=3D MXT_RELEASE ?
>> -				finger[id].area : 0);
>> -		input_report_abs(input_dev, ABS_MT_POSITION_X,
>> -				finger[id].x);
>> -		input_report_abs(input_dev, ABS_MT_POSITION_Y,
>> -				finger[id].y);
>> -		input_mt_sync(input_dev);
>> -
>> -		if (finger[id].status =3D=3D MXT_RELEASE)
>> -			finger[id].status =3D 0;
>> -		else
>> +		input_mt_slot(input_dev, id);
>> +		input_report_abs(input_dev, ABS_MT_TRACKING_ID,
>> +				finger[id].trkid);
>
> Replace the line above with (possibly using a temp variable instead)
>
> input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, finger[id].stat=
us !=3D MXT_RELEASE);
>
>
>> +		if (finger[id].status !=3D MXT_RELEASE) {
>
>>   			finger_num++;
>> +			input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
>> +					finger[id].area);
>> +			input_report_abs(input_dev, ABS_MT_POSITION_X,
>> +					finger[id].x);
>> +			input_report_abs(input_dev, ABS_MT_POSITION_Y,
>> +					finger[id].y);
>> +		} else
>> +			finger[id].status =3D 0;
>>   	}
>>
>>   	input_report_key(input_dev, BTN_TOUCH, finger_num>  0);
>> @@ -538,6 +540,7 @@ static void mxt_input_touchevent(struct mxt_data=
 *data,
>>   	int x;
>>   	int y;
>>   	int area;
>> +	static int trkid;
>
> drop
>
>>
>>   	/* Check the touch is present on the screen */
>>   	if (!(status&  MXT_DETECT)) {
>> @@ -545,6 +548,7 @@ static void mxt_input_touchevent(struct mxt_data=
 *data,
>>   			dev_dbg(dev, "[%d] released\n", id);
>>
>>   			finger[id].status =3D MXT_RELEASE;
>> +			finger[id].trkid =3D -1;
>
> drop
>
>>   			mxt_input_report(data, id);
>>   		}
>>   		return;
>> @@ -572,6 +576,8 @@ static void mxt_input_touchevent(struct mxt_data=
 *data,
>>   	finger[id].x =3D x;
>>   	finger[id].y =3D y;
>>   	finger[id].area =3D area;
>> +	if (finger[id].trkid<  0)
>> +		finger[id].trkid =3D trkid++&  MXT_MAX_TRACKING_ID;
>
> drop
>
>>
>>   	mxt_input_report(data, id);
>>   }
>> @@ -790,8 +796,12 @@ static int mxt_initialize(struct mxt_data *data=
)
>>   	struct i2c_client *client =3D data->client;
>>   	struct mxt_info *info =3D&data->info;
>>   	int error;
>> +	int i;
>
> drop
>
>>   	u8 val;
>>
>> +	for (i =3D 0; i<  MXT_MAX_FINGER; i++)
>> +		data->finger[i].trkid =3D -1;
>> +
>
> drop
>
>>   	error =3D mxt_get_info(data);
>>   	if (error)
>>   		return error;
>> @@ -1091,6 +1101,9 @@ static int __devinit mxt_probe(struct i2c_clie=
nt *client,
>>   			     0, data->y_size, 0, 0);
>>
>>   	/* For multi touch */
>> +	input_mt_create_slots(input_dev, MXT_MAX_FINGER);
>> +	input_set_abs_params(input_dev, ABS_MT_TRACKING_ID,
>> +			     0, MXT_MAX_TRACKING_ID, 0, 0);
>
> Replace with
>
> input_mt_init_slots(input_dev, MXT_MAX_FINGER);
>
>>   	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
>>   			     0, MXT_MAX_AREA, 0, 0);
>>   	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
>> --
>> 1.7.0.4
>
> Thanks,
> Henrik
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
