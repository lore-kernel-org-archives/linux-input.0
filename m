From: =?UTF-8?Q?Matja=c5=be_Hegedi=c4=8d?= <matjaz.hegedic@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - add ASUS EeeBook X205TA special
 touchpad fw
Date: Tue, 7 Mar 2017 11:51:56 +0100
Message-ID: <5b8ea500-0269-b3c7-1a54-af6bfd18b640@gmail.com>
References: <1488679982-9825-1-git-send-email-matjaz.hegedic@gmail.com>
 <20170306195442.GC30488@dtor-ws> <00b601d29711$302c1800$90844800$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33557 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754844AbdCGKwk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 05:52:40 -0500
In-Reply-To: <00b601d29711$302c1800$90844800$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?B?6buD5LiW6bWsIOe2k+eQhg==?= <phoenix@emc.com.tw>, miller_wang@emc.com.tw

Hi Dmitry, KT!

On 2017-03-07 08:05, ¹ù±Rºa wrote:
> Hi Dmitry
>
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Tuesday, March 07, 2017 3:55 AM
> To: KT Liao
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Matjaz
> Hegedic
> Subject: Re: [PATCH] Input: elan_i2c - add ASUS EeeBook X205TA special
> touchpad fw
>
> On Sun, Mar 05, 2017 at 03:13:02AM +0100, Matjaz Hegedic wrote:
>> EeeBook X205TA is yet another ASUS device with a special touchpad
>> firmware that needs to be accounted for during initialization, or else
>> the touchpad will go into an invalid state upon suspend/resume.
>> Adding the appropriate ic_type and product_id check fixes the problem.
>
> KT, does this look reasonable? Are there more ASUS models that need such
> handling?
> [KT] : I just discuss it with FW team.
> We can't confirm it right now because it's an old product. And the solution
> focus on power-on issue, not suspend/resume.
> I will let you know once we figure it out.
>
> Our FW has modified, the issue should not happen on new models.
>
> Thanks		KT

As it is now, the touchpad will stop working upon resume, returning an
invalid id (and requires a cumbersome workaround of reloading the 
module). As the touchpad FW is opaque to me, the only way I could 
resolve the bug was through trial-and-error. Including the touchpad in 
the 'special fw' resolves the bug and the touchpad resumes without issue.

Now, even if the function is indeed used to resolve a different issue on 
other ASUS touchpads, I would argue that this is the most pragmatic way 
of resolving the problem on X205TA, X205TAW and F205TA (and possibly 
also X200HA & X206HA, though I don't have those to test).

It shouldn't affect any other models or touchpad products.

Thanks!

>>
>> Signed-off-by: Matjaz Hegedic <matjaz.hegedic@gmail.com>
>> ---
>>  drivers/input/mouse/elan_i2c_core.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/input/mouse/elan_i2c_core.c
>> b/drivers/input/mouse/elan_i2c_core.c
>> index 2c7d287..dde3ad7 100644
>> --- a/drivers/input/mouse/elan_i2c_core.c
>> +++ b/drivers/input/mouse/elan_i2c_core.c
>> @@ -218,17 +218,19 @@ static int elan_query_product(struct
>> elan_tp_data *data)
>>
>>  static int elan_check_ASUS_special_fw(struct elan_tp_data *data)  {
>> -	if (data->ic_type != 0x0E)
>> -		return false;
>> -
>> -	switch (data->product_id) {
>> -	case 0x05 ... 0x07:
>> -	case 0x09:
>> -	case 0x13:
>> -		return true;
>> -	default:
>> -		return false;
>> +	if (data->ic_type == 0x0E) {
>> +		switch (data->product_id) {
>> +		case 0x05 ... 0x07:
>> +		case 0x09:
>> +		case 0x13:
>> +			return true;
>> +		}
>>  	}
>> +	/* ASUS EeeBook X205TA */
>> +	else if (data->ic_type == 0x8 && data->product_id == 0x26)
>> +		return true;
>> +
>> +	return false;
>>  }
>>
>>  static int __elan_initialize(struct elan_tp_data *data)
>> --
>> 2.7.4
>>
>
> Thanks.
>
