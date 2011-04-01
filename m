From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 2/4] Input: atmel_mxt_ts - Support 12bit resolution
Date: Fri, 01 Apr 2011 19:25:23 +0900
Message-ID: <4D95A813.2080709@samsung.com>
References: <1299487335-24139-1-git-send-email-jy0922.shim@samsung.com>
 <1299487335-24139-2-git-send-email-jy0922.shim@samsung.com>
 <4D94850C.1020301@atmel.com> <4D956C64.6000906@samsung.com>
 <4D95A1BF.6070100@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:56524 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755322Ab1DAKZ0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Apr 2011 06:25:26 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LIY0011CYAAQT60@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Fri, 01 Apr 2011 19:25:22 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LIY003MYYAAB5@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Fri, 01 Apr 2011 19:25:22 +0900 (KST)
In-reply-to: <4D95A1BF.6070100@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kyungmin.park@samsung.com

On 2011-04-01 =EC=98=A4=ED=9B=84 6:58, Iiro Valkonen wrote:
> Hi,
>
> On 04/01/2011 09:10 AM, Joonyoung Shim wrote:
>>>> @@ -837,6 +847,17 @@ static int mxt_initialize(struct mxt_data *da=
ta)
>>>>           return 0;
>>>>    }
>>>>
>>>> +static void mxt_calc_resolution(struct mxt_data *data)
>>>> +{
>>>> +       if (data->pdata->orient&   MXT_XY_SWITCH) {
>>>> +               data->x_size =3D data->pdata->y_size;
>>>> +               data->y_size =3D data->pdata->x_size;
>>>> +       } else {
>>>> +               data->x_size =3D data->pdata->x_size;
>>>> +               data->y_size =3D data->pdata->y_size;
>>>> +       }
>>>> +}
>>>> +
>>>
>>> What's the reason for this? If we have set the x/y switch in the co=
nfig, then
>>> we probably want to swap the axes. Or is this axis swap something t=
hat should be
>>> done on upper layers? Even so, then we shouldn't have the MXT_XY_SW=
ITCH bit set
>>> in the config, and we could just say "data->x_max_value =3D data->p=
data->xsize - 1"
>>> (and same for y) in the probe function. We wouldn't need Touch orie=
nt bit defines
>>> either.
>>>
>>
>> If we set XY_SWITCH for special purpose then the axis is swapped and
>> driver will report also coordinates out of max value.
>>
>
> Right, of course.
>

I mean it is the reason to add above codes, i think driver should
consider a case MXT_XY_SWITCH is setted.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
