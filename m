From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 2/4] Input: atmel_mxt_ts - Support 12bit resolution
Date: Fri, 01 Apr 2011 16:39:23 +0300
Message-ID: <4D95D58B.2030003@atmel.com>
References: <1299487335-24139-1-git-send-email-jy0922.shim@samsung.com> <1299487335-24139-2-git-send-email-jy0922.shim@samsung.com> <4D94850C.1020301@atmel.com> <4D956C64.6000906@samsung.com> <4D95A1BF.6070100@atmel.com> <4D95A813.2080709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:31564 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518Ab1DANjy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Apr 2011 09:39:54 -0400
In-Reply-To: <4D95A813.2080709@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

On 04/01/2011 01:25 PM, Joonyoung Shim wrote:
> On 2011-04-01 =EC=98=A4=ED=9B=84 6:58, Iiro Valkonen wrote:
>> Hi,
>>
>> On 04/01/2011 09:10 AM, Joonyoung Shim wrote:
>>>>> @@ -837,6 +847,17 @@ static int mxt_initialize(struct mxt_data *d=
ata)
>>>>>           return 0;
>>>>>    }
>>>>>
>>>>> +static void mxt_calc_resolution(struct mxt_data *data)
>>>>> +{
>>>>> +       if (data->pdata->orient&   MXT_XY_SWITCH) {
>>>>> +               data->x_size =3D data->pdata->y_size;
>>>>> +               data->y_size =3D data->pdata->x_size;
>>>>> +       } else {
>>>>> +               data->x_size =3D data->pdata->x_size;
>>>>> +               data->y_size =3D data->pdata->y_size;
>>>>> +       }
>>>>> +}
>>>>> +
>>>>
>>>> What's the reason for this? If we have set the x/y switch in the c=
onfig, then
>>>> we probably want to swap the axes. Or is this axis swap something =
that should be
>>>> done on upper layers? Even so, then we shouldn't have the MXT_XY_S=
WITCH bit set
>>>> in the config, and we could just say "data->x_max_value =3D data->=
pdata->xsize - 1"
>>>> (and same for y) in the probe function. We wouldn't need Touch ori=
ent bit defines
>>>> either.
>>>>
>>>
>>> If we set XY_SWITCH for special purpose then the axis is swapped an=
d
>>> driver will report also coordinates out of max value.
>>>
>>
>> Right, of course.
>>
>=20
> I mean it is the reason to add above codes, i think driver should
> consider a case MXT_XY_SWITCH is setted.

Yes, I agree, the above code is fine. I was thinking that the x & y res=
olution
would also get swapped. But that's not the case, and this mxt_calc_reso=
lution
function is correct the way you originally wrote it.

BR,

--=20
Iiro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
