From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re:[v1.1,1/3] driver: input :touchscreen : add Raydium crc touch function
Date: Fri,  8 Jul 2016 07:36:45 -0700
Message-ID: <1467988605-44480-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <1467909479-43471-1-git-send-email-jeffrey.lin@rad-ic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33749 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802AbcGHOhq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2016 10:37:46 -0400
In-Reply-To: <1467909479-43471-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, groeck@chromium.org, robh@kernel.org
Cc: jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, jason.yeh@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

>This is not offset, this is size, or length, of CRC.
I'll change namming as RM_CONTACT_CRC_SIZE

>> @@ -798,33 +803,54 @@ static void raydium_mt_event(struct raydium_data *ts)
>>  		input_mt_slot(ts->input, i);
>>  		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, state);
>>  
>> -		if (!state)
>> -			continue;
>> -
>> -		input_report_abs(ts->input, ABS_MT_POSITION_X,
>> +		if (state == 0x01) {

>Why we need this change? How is it related to CRC? Do you intent to
>report contact as active but not emit any position data of state is
>neither 0 nor 1?
This is no relationship with CRC, just want to make sure report points as state equal to 1.
Okay, I'll update to another patch.

>>  static irqreturn_t raydium_i2c_irq(int irq, void *_dev)
>>  {
>>  	struct raydium_data *ts = _dev;
>> +	int error;
>>  
>> -	if (ts->boot_mode != RAYDIUM_TS_BLDR)
>> -		raydium_mt_event(ts);
>> +	if (ts->boot_mode == RAYDIUM_TS_MAIN) {
>> +		error = raydium_i2c_read_message(ts->client, ts->data_bank_addr,
>> +				 ts->report_data, ts->pkg_size);
>> +		if (!error)
>> +			raydium_i2c_event(ts);
>> +	}
>
>This chunk seems to belong to some other patch.

Yes, I'll remove them. 

Thanks.

Jeffrey
