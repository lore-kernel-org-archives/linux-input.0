From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/5] qt602240_ts: fix wrong sizeof in object table
 allocation
Date: Thu, 18 Nov 2010 20:30:31 +0900
Message-ID: <4CE50E57.6070507@samsung.com>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
 <20101116204150.28796.21244.stgit@localhost6.localdomain6>
 <4CE50B09.2020507@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:29116 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab0KRLbU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 06:31:20 -0500
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LC200BFMVYVA4D0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 20:30:31 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LC2004E0VYVRG@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 20:30:31 +0900 (KST)
In-reply-to: <4CE50B09.2020507@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Leech <christopher.leech@linux.intel.com>
Cc: linux-input@vger.kernel.org

On 2010-11-18 =EC=98=A4=ED=9B=84 8:16, Joonyoung Shim wrote:
> Hi, Chris.
>
> On 2010-11-17 =EC=98=A4=EC=A0=84 5:41, Chris Leech wrote:
>> The kcalloc call for the object table is using sizeof(struct
>> qt602240_data)
>> when it should be using sizeof(struct qt6602240_object), resulting i=
n
>> a larger
>> allocation than is required.
>>
>> Signed-off-by: Chris Leech<christopher.leech@linux.intel.com>
>
> Acked-by: Joonyoung Shim <jy0922@samsung.com>

Wrong e-mail address.

Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>

>
> Thanks.
>
>> ---
>> drivers/input/touchscreen/qt602240_ts.c | 2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/qt602240_ts.c
>> b/drivers/input/touchscreen/qt602240_ts.c
>> index 66b26ad..0b92c9d 100644
>> --- a/drivers/input/touchscreen/qt602240_ts.c
>> +++ b/drivers/input/touchscreen/qt602240_ts.c
>> @@ -969,7 +969,7 @@ static int qt602240_initialize(struct
>> qt602240_data *data)
>> return error;
>>
>> data->object_table =3D kcalloc(info->object_num,
>> - sizeof(struct qt602240_data),
>> + sizeof(struct qt602240_object),
>> GFP_KERNEL);
>> if (!data->object_table) {
>> dev_err(&client->dev, "Failed to allocate memory\n");
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
