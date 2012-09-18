From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH] HID: wiimote: fix weight conversion error for values
 > 17kg
Date: Tue, 18 Sep 2012 12:53:30 +0200
Message-ID: <505852AA.5000907@butterbrot.org>
References: <alpine.DEB.2.02.1209172114000.3968@butterbrot> <alpine.LNX.2.00.1209181137250.31149@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:36870 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757996Ab2IRKxe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Sep 2012 06:53:34 -0400
In-Reply-To: <alpine.LNX.2.00.1209181137250.31149@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, dh.herrmann@googlemail.com

Thanks Jiri, and sorry for the noise :-)

On 18.09.2012 11:38, Jiri Kosina wrote:
> On Mon, 17 Sep 2012, Florian Echtler wrote:
>
>> Signed-Off-By: Florian Echtler <floe@butterbrot.org>
>> ---
>>   drivers/hid/hid-wiimote-ext.c |    3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
>> index fc98cc9..bc85bf2 100644
>> --- a/drivers/hid/hid-wiimote-ext.c
>> +++ b/drivers/hid/hid-wiimote-ext.c
>> @@ -585,7 +585,8 @@ static void handler_balance_board(struct wiimote_ext *ext,
>> const __u8 *payload)
>>   		} else {
>>   			tmp = val[i] - ext->calib[i][1];
>>   			tmp *= 1700;
>> -			tmp /= ext->calib[i][2] - ext->calib[i][1] + 1700;
>> +			tmp /= ext->calib[i][2] - ext->calib[i][1];
>> +			tmp += 1700;
>>   		}
>>   		val[i] = tmp;
>>   	}
>
> I am not sure how you managed to do it :) but there are stray whitespaces
> in the patch context.
>
> I have fixed it manually and applied, but please keep fixing that in mind
> for any future submissions.
>
> Thanks,
>


-- 
SENT FROM MY PDP-11
