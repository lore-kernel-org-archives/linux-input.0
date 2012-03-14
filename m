From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 03/20] Input: atmel_mxt_ts - verify object size in mxt_write_object
Date: Wed, 14 Mar 2012 10:13:46 +0800
Message-ID: <CAGS+omCFPeYRZ=e9fRHSHVYXc3Bxr65qqPVzztwMShNxw=jr7A@mail.gmail.com>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
 <1331640263-18935-4-git-send-email-djkurtz@chromium.org> <4F5FF563.7080308@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63010 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030293Ab2CNCOH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 22:14:07 -0400
Received: by iagz16 with SMTP id z16so1618030iag.19
        for <linux-input@vger.kernel.org>; Tue, 13 Mar 2012 19:14:06 -0700 (PDT)
In-Reply-To: <4F5FF563.7080308@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

On Wed, Mar 14, 2012 at 9:33 AM, Joonyoung Shim <jy0922.shim@samsung.co=
m> wrote:
>
> On 03/13/2012 09:04 PM, Daniel Kurtz wrote:
>>
>> Don't allow writing past the length of an object.
>>
>> Signed-off-by: Daniel Kurtz<djkurtz@chromium.org>
>> ---
>> =A0drivers/input/touchscreen/atmel_mxt_ts.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
>> b/drivers/input/touchscreen/atmel_mxt_ts.c
>> index 0d4d492..e18c698 100644
>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> @@ -506,7 +506,7 @@ static int mxt_write_object(struct mxt_data *dat=
a,
>> =A0 =A0 =A0 =A0u16 reg;
>>
>> =A0 =A0 =A0 =A0object =3D mxt_get_object(data, type);
>> - =A0 =A0 =A0 if (!object)
>> + =A0 =A0 =A0 if (!object || offset>=3D object->size)
>
>
> The object->size is actual object size - 1.
>
> + =A0 =A0 =A0 if (!object || offset> =A0object->size)
>

Whoops.  Good catch.  Will move this patch after patch 08, which fixes
the object size.

>
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>
>> =A0 =A0 =A0 =A0reg =3D object->start_address;
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
