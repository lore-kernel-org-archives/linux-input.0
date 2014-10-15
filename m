From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH] Input: misc: max77693-haptic - fix active state check in
 disable()
Date: Wed, 15 Oct 2014 13:34:31 +0900
Message-ID: <543DF957.3040907@samsung.com>
References: <1413342978-30349-1-git-send-email-jaewon02.kim@samsung.com>
 <543DF56B.2080009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44775 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbaJOEed (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2014 00:34:33 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NDG008XOY1JP080@mailout3.samsung.com> for
 linux-input@vger.kernel.org; Wed, 15 Oct 2014 13:34:31 +0900 (KST)
In-reply-to: <543DF56B.2080009@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Chanwoo,


2014=EB=85=84 10=EC=9B=94 15=EC=9D=BC 13:17=EC=97=90 Chanwoo Choi =EC=9D=
=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> Hi Jaewon,
>
> I think you better to use ':' instead of '-'.
> - before: Input: misc: max77693-haptic -
> - after : Input: misc: max77693-haptic:
I refer past log message.
I think '-' is input driver style.

>
> On 10/15/2014 12:16 PM, Jaewon Kim wrote:
>> In order to avoid duplicated execution, max77693_haptic_disable()
>> check disable state. But it was reversed. this patch fix it.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   drivers/input/misc/max77693-haptic.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/mi=
sc/max77693-haptic.c
>> index d605db4..7b1fde9 100644
>> --- a/drivers/input/misc/max77693-haptic.c
>> +++ b/drivers/input/misc/max77693-haptic.c
>> @@ -152,7 +152,7 @@ static void max77693_haptic_disable(struct max77=
693_haptic *haptic)
>>   {
>>   	int error;
>>  =20
>> -	if (haptic->enabled)
>> +	if (!haptic->enabled)
>>   		return;
>>  =20
>>   	error =3D max77693_haptic_configure(haptic, false);
>>
> If you modify patch name, Looks good to me.
>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>
> Thanks,
> Chanwoo Choi
>

Thanks,
Jaewon Kim
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
