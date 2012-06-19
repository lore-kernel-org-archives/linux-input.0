From: Yufeng Shen <miletus@google.com>
Subject: Re: [PATCH 14/22 v4] Input: atmel_mxt_ts - don't re-read matrix after
 applying pdata
Date: Tue, 19 Jun 2012 11:12:02 -0400
Message-ID: <CAPDwgkNj1kEHeKsgV+3MOGnVPj++X44qXrTxR0QEsMK+AwvXSw@mail.gmail.com>
References: <1339992522-22073-1-git-send-email-djkurtz@chromium.org>
	<1339992522-22073-15-git-send-email-djkurtz@chromium.org>
	<4FDF4345.40508@itdev.co.uk>
	<CAPDwgkMATDg5_FyJhR2aDCOzHu9DQbxzPHMn7MCC8KmBsS2bhg@mail.gmail.com>
	<4FE053BD.2090605@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56653 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab2FSPMD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jun 2012 11:12:03 -0400
Received: by wibhn6 with SMTP id hn6so3386757wib.1
        for <linux-input@vger.kernel.org>; Tue, 19 Jun 2012 08:12:02 -0700 (PDT)
In-Reply-To: <4FE053BD.2090605@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, Iiro Valkonen <iiro.valkonen@atmel.com>, Benson Leung <bleung@chromium.org>, Olof Johansson <olofj@chromium.org>, linux-kernel@vger.kernel.org, "Bowens, Alan" <Alan.Bowens@atmel.com>

On Tue, Jun 19, 2012 at 6:26 AM, Nick Dyer <nick.dyer@itdev.co.uk> wrot=
e:
> Yufeng Shen wrote:
>> On Mon, Jun 18, 2012 at 11:03 AM, Nick Dyer <nick.dyer@itdev.co.uk> =
wrote:
>>> Daniel Kurtz wrote:
>>>> The matrix x/y size in the Info ID Block represents the number of =
x/y
>>>> trace lines on the device. =A0There is no need to re-read them aft=
er
>>>> applying pdata config, since pdata only configures the object tabl=
e
>>>> etnries. =A0The matrix size read from the ID can only be updated b=
y a
>>>> firmware update.
>>>
>>> This isn't correct. For example, mXT224 can be configured as 16x14,=
 17x13,
>>> 18x12, etc. This only takes effect when the chip is reset, which is=
 why it
>>> is necessary to re-read them after applying the config.
>>
>> so look at structure mxt_info
>>
>> =A0struct mxt_info {
>> =A0 =A0 =A0 =A0 =A0 u8 family_id;
>> =A0 =A0 =A0 =A0 =A0 u8 variant_id;
>> =A0 =A0 =A0 =A0 =A0 u8 version;
>> =A0 =A0 =A0 =A0 =A0 u8 build;
>> =A0 =A0 =A0 =A0 =A0 u8 matrix_xsize;
>> =A0 =A0 =A0 =A0 =A0 u8 matrix_ysize;
>> =A0 =A0 =A0 =A0 =A0 u8 object_num;
>> };
>>
>> I think it is meant to be corresponding to Information Block of the
>> device, of which
>> the matrix_xsize and matrix_ysize mean "The size of the matrix the
>> device supports",
>> which should be fixed for a certain chip.
>
> As I said, it's not fixed, there is a mode setting (T28 byte 2) which
> alters the matrix size. This is documented in the protocol guide, if =
you
> have it.
>
> You can also verify this if you want: change mode setting, backup, re=
set,
> and read the information block, you'll see the matrix size changes. I=
've
> just checked that myself on an mXT224.
>

Ah, you are correct. I was looking at the wrong protocol guide. mXT224(=
E) does
have the mode setting option.

> I also asked the guys at Atmel that I work with, and they confirm tha=
t this
> behaviour is as designed.
>
>> The configurable matrix size is in T9 XSIZE/YSIZE, which, if ever
>> needed to be read back,
>> probably read back into something other than mxt_info struct.
>
> The position of the touchscreen within the matrix is a separate
> configurable setting, you're confusing the two.
>
> cheers
>
> --
> Nick Dyer
> Software Engineer, ITDev Ltd
> Hardware and Software Development Consultancy
> Website: http://www.itdev.co.uk
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
