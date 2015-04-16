From: duson <dusonlin@emc.com.tw>
Subject: Re: [PATCH 5/5] Input: elan_i2c - Correct the x and y trace number.
Date: Thu, 16 Apr 2015 09:37:51 +0800
Message-ID: <8C83F24C-D32F-459B-8D43-00974542AB3E@emc.com.tw>
References: <000401d0771f$4b7f9b90$e27ed2b0$@emc.com.tw> <20150415174752.GC27779@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150415174752.GC27779@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, =?utf-8?B?6buD5LiW6bWs?= <phoenix@emc.com.tw>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

I double check with our firmware team and the SPEC, it looks like the s=
ubtract 1 just a misunderstanding.
So, the correct should not subtract 1. For example, if the touchpad x r=
esolution is 2800 and x trace number is 20,
the pitch size of x should be 2800/20 =3D 140, not 2800/19 =3D 147.36.=20

----------------------------------------------
Thanks,
ELAN Duson
=E2=9C=89 Email: dusonlin@emc.com.tw
----------------------------------------------





> Dmitry Torokhov <dmitry.torokhov@gmail.com> =E6=96=BC 2015=E5=B9=B44=E6=
=9C=8816=E6=97=A5 =E4=B8=8A=E5=8D=881:47 =E5=AF=AB=E9=81=93=EF=BC=9A
>=20
> On Wed, Apr 15, 2015 at 09:55:43AM +0800, DusonLin wrote:
>> The trace number does not need to subtract 1 now.
>=20
> Could you provide a bit more of background for this change? Why don't=
 we
> need to decrement the number returned by the firmware anymore? We hav=
e
> been running with the old numbers for many years...
>=20
> Thanks!
>=20
>>=20
>> Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
>> ---
>> drivers/input/mouse/elan_i2c_i2c.c   |    4 ++--
>> drivers/input/mouse/elan_i2c_smbus.c |    4 ++--
>> 2 files changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/input/mouse/elan_i2c_i2c.c
>> b/drivers/input/mouse/elan_i2c_i2c.c
>> index 029941f..550f905 100644
>> --- a/drivers/input/mouse/elan_i2c_i2c.c
>> +++ b/drivers/input/mouse/elan_i2c_i2c.c
>> @@ -356,8 +356,8 @@ static int elan_i2c_get_num_traces(struct i2c_cl=
ient
>> *client,
>> 		return error;
>> 	}
>>=20
>> -	*x_traces =3D val[0] - 1;
>> -	*y_traces =3D val[1] - 1;
>> +	*x_traces =3D val[0];
>> +	*y_traces =3D val[1];
>>=20
>> 	return 0;
>> }
>> diff --git a/drivers/input/mouse/elan_i2c_smbus.c
>> b/drivers/input/mouse/elan_i2c_smbus.c
>> index 06a2bcd..0b04151 100644
>> --- a/drivers/input/mouse/elan_i2c_smbus.c
>> +++ b/drivers/input/mouse/elan_i2c_smbus.c
>> @@ -268,8 +268,8 @@ static int elan_smbus_get_num_traces(struct i2c_=
client
>> *client,
>> 		return error;
>> 	}
>>=20
>> -	*x_traces =3D val[1] - 1;
>> -	*y_traces =3D val[2] - 1;
>> +	*x_traces =3D val[1];
>> +	*y_traces =3D val[2];
>>=20
>> 	return 0;
>> }
>>=20
>=20
> --=20
> Dmitry
>=20
