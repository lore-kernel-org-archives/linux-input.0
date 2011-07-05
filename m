From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 1/3 v2] Input: atmel_mxt_ts - Make wait-after-reset period
 compatible with all chips
Date: Tue, 05 Jul 2011 10:12:43 +0300
Message-ID: <4E12B96B.2050601@atmel.com>
References: <4E11B8C3.8010608@atmel.com> <4E1263C9.3010704@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:43395 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab1GEHNE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 03:13:04 -0400
In-Reply-To: <4E1263C9.3010704@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hello,

On 07/05/2011 04:07 AM, Joonyoung Shim wrote:
> Hi,
>=20
> On 2011-07-04 =EC=98=A4=ED=9B=84 9:57, Iiro Valkonen wrote:
>> The delay before the chip can be accessed after reset varies between=
 different
>> chips in maXTouch family. Waiting for 200ms and then monitoring the =
CHG (chip
>> is ready when the line is low) is guaranteed to work with all chips.
>=20
> I wonder 200ms waiting needs indeed, it is very long time.
> If monitoring the CHG line can detect the completion of reset,
> 200ms waiting can be removed?
>=20

Yes, 200ms is a bit longish. But it is what we need to guarantee correc=
t
functionality with all chips in all situations. I would prefer to see t=
hat
in the mainline version. Anyone worried about the delay could maybe adj=
ust
the value to suit his/her needs, for example with mXT224 you could get =
away with
using just 65ms, like in the original version. Another option would be =
to
check the family ID in the driver, and wait just long enough. Drawback =
with
that is that the driver (possibly) needs updating with every new chip. =
I'd
like to keep this simple & robust, wait 200ms which works for every cur=
rent
(and most likely with every upcoming) chip, and take the small delay pe=
nalty.

>> @@ -828,6 +829,12 @@ static int mxt_initialize(struct mxt_data *data=
)
>>       mxt_write_object(data, MXT_GEN_COMMAND,
>>               MXT_COMMAND_RESET, 1);
>>       msleep(MXT_RESET_TIME);
>> +    while ((reset_timeout++<=3D 100)&&  data->pdata->read_chg())
>=20
> If pdata->read_chg is NULL?
>=20

Hopefully it'll never be, but I'll add a check.

Thank you for the comments.

--=20
Iiro
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
