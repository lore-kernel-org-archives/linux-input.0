From: duson <dusonlin@emc.com.tw>
Subject: Re: [PATCH 5/5] Input: elan_i2c - Correct the x and y trace number.
Date: Tue, 21 Apr 2015 08:47:20 +0800
Message-ID: <D57B5549-A753-413D-BB03-47D553AFA41F@emc.com.tw>
References: <000401d0771f$4b7f9b90$e27ed2b0$@emc.com.tw> <20150415174752.GC27779@dtor-ws> <8C83F24C-D32F-459B-8D43-00974542AB3E@emc.com.tw>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:56696 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbbDUArg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2015 20:47:36 -0400
In-Reply-To: <8C83F24C-D32F-459B-8D43-00974542AB3E@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, =?utf-8?B?6buD5LiW6bWs?= <phoenix@emc.com.tw>

Hi Dmitry,

How about the description? Is it looks good for you?
Please let me know if you have any concern.

----------------------------------------------
Thank you,
ELAN Duson
=E2=9C=89 Email: dusonlin@emc.com.tw
----------------------------------------------





> duson <dusonlin@emc.com.tw> =E6=96=BC 2015=E5=B9=B44=E6=9C=8816=E6=97=
=A5 =E4=B8=8A=E5=8D=889:37 =E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> Hi Dmitry,
>=20
> I double check with our firmware team and the SPEC, it looks like the=
 subtract 1 just a misunderstanding.
> So, the correct should not subtract 1. For example, if the touchpad x=
 resolution is 2800 and x trace number is 20,
> the pitch size of x should be 2800/20 =3D 140, not 2800/19 =3D 147.36=
=2E=20
>=20
> ----------------------------------------------
> Thanks,
> ELAN Duson
> =E2=9C=89 Email: dusonlin@emc.com.tw
> ----------------------------------------------
>=20
>=20
>=20
>=20
>=20
>> Dmitry Torokhov <dmitry.torokhov@gmail.com> =E6=96=BC 2015=E5=B9=B44=
=E6=9C=8816=E6=97=A5 =E4=B8=8A=E5=8D=881:47 =E5=AF=AB=E9=81=93=EF=BC=9A
>>=20
>> On Wed, Apr 15, 2015 at 09:55:43AM +0800, DusonLin wrote:
>>> The trace number does not need to subtract 1 now.
>>=20
>> Could you provide a bit more of background for this change? Why don'=
t we
>> need to decrement the number returned by the firmware anymore? We ha=
ve
>> been running with the old numbers for many years...
>>=20
>> Thanks!
>>=20
>>>=20
>>> Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
>>> ---
>>> drivers/input/mouse/elan_i2c_i2c.c   |    4 ++--
>>> drivers/input/mouse/elan_i2c_smbus.c |    4 ++--
>>> 2 files changed, 4 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/drivers/input/mouse/elan_i2c_i2c.c
>>> b/drivers/input/mouse/elan_i2c_i2c.c
>>> index 029941f..550f905 100644
>>> --- a/drivers/input/mouse/elan_i2c_i2c.c
>>> +++ b/drivers/input/mouse/elan_i2c_i2c.c
>>> @@ -356,8 +356,8 @@ static int elan_i2c_get_num_traces(struct i2c_c=
lient
>>> *client,
>>> 		return error;
>>> 	}
>>>=20
>>> -	*x_traces =3D val[0] - 1;
>>> -	*y_traces =3D val[1] - 1;
>>> +	*x_traces =3D val[0];
>>> +	*y_traces =3D val[1];
>>>=20
>>> 	return 0;
>>> }
>>> diff --git a/drivers/input/mouse/elan_i2c_smbus.c
>>> b/drivers/input/mouse/elan_i2c_smbus.c
>>> index 06a2bcd..0b04151 100644
>>> --- a/drivers/input/mouse/elan_i2c_smbus.c
>>> +++ b/drivers/input/mouse/elan_i2c_smbus.c
>>> @@ -268,8 +268,8 @@ static int elan_smbus_get_num_traces(struct i2c=
_client
>>> *client,
>>> 		return error;
>>> 	}
>>>=20
>>> -	*x_traces =3D val[1] - 1;
>>> -	*y_traces =3D val[2] - 1;
>>> +	*x_traces =3D val[1];
>>> +	*y_traces =3D val[2];
>>>=20
>>> 	return 0;
>>> }
>>>=20
>>=20
>> --=20
>> Dmitry
>>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
