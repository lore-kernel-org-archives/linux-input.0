From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] Input: bcm5974.c initialize raw_w, raw_x and raw_y before
 it get used
Date: Sun, 13 Sep 2009 13:39:21 +0200
Message-ID: <4AACD9E9.4000702@bitmath.org>
References: <1252775770.3687.7.camel@ht.satnam>	 <4AAC2DBE.9040303@bitmath.org> <1252830690.3440.5.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([195.47.247.206]:58119 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbZIMLj0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Sep 2009 07:39:26 -0400
In-Reply-To: <1252830690.3440.5.camel@ht.satnam>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org

Jaswinder Singh Rajput wrote:
> On Sun, 2009-09-13 at 01:24 +0200, Henrik Rydberg wrote:
>> Jaswinder Singh Rajput wrote:
>>> raw_w, raw_x and raw_y is used uninitialized for !raw_n
>> Thanks for the heads up, but actually not, since !raw_n also implies
>> !(ptest > PRESSURE_LOW).
>>
>=20
> Then can we move 'if (ptest > PRESSURE_LOW && origin)' stuff to 'if
> (raw_n)'. If not then my patch is correct.

Yes, that's it, thanks. So this patch ought to solve the warning cleanl=
y:

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm597=
4.c
index 2d8fc0b..3b598de 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -345,21 +345,22 @@ static int report_tp_state(struct bcm5974 *dev, i=
nt size)
 		/* set the integrated button if applicable */
 		if (c->tp_type =3D=3D TYPE2)
 			ibt =3D raw2int(dev->tp_data[BUTTON_TYPE2]);
-	}

-	/* while tracking finger still valid, count all fingers */
-	if (ptest > PRESSURE_LOW && origin) {
-		abs_p =3D ptest;
-		abs_w =3D int2bound(&c->w, raw_w);
-		abs_x =3D int2bound(&c->x, raw_x - c->x.devmin);
-		abs_y =3D int2bound(&c->y, c->y.devmax - raw_y);
-		while (raw_n--) {
-			ptest =3D int2bound(&c->p, raw2int(f->force_major));
-			if (ptest > PRESSURE_LOW)
-				nmax++;
-			if (ptest > PRESSURE_HIGH)
-				nmin++;
-			f++;
+		/* while tracking finger still valid, count all fingers */
+		if (ptest > PRESSURE_LOW && origin) {
+			abs_p =3D ptest;
+			abs_w =3D int2bound(&c->w, raw_w);
+			abs_x =3D int2bound(&c->x, raw_x - c->x.devmin);
+			abs_y =3D int2bound(&c->y, c->y.devmax - raw_y);
+			while (raw_n--) {
+				ptest =3D int2bound(&c->p,
+						  raw2int(f->force_major));
+				if (ptest > PRESSURE_LOW)
+					nmax++;
+				if (ptest > PRESSURE_HIGH)
+					nmin++;
+				f++;
+			}
 		}
 	}

>=20
>>> This also fixed these compilation warnings :
>>>
>>>  CC [M]  drivers/input/mouse/bcm5974.o
>>> drivers/input/mouse/bcm5974.c: In function =E2=80=98report_tp_state=
=E2=80=99:
>>> drivers/input/mouse/bcm5974.c:319: warning: =E2=80=98raw_y=E2=80=99=
 may be used uninitialized in this function
>>> drivers/input/mouse/bcm5974.c:319: warning: =E2=80=98raw_x=E2=80=99=
 may be used uninitialized in this function
>>> drivers/input/mouse/bcm5974.c:319: warning: =E2=80=98raw_w=E2=80=99=
 may be used uninitialized in this function
>>>
>>> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
>>> ---
>>>  drivers/input/mouse/bcm5974.c |    3 ++-
>>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bc=
m5974.c
>>> index 2d8fc0b..171f345 100644
>>> --- a/drivers/input/mouse/bcm5974.c
>>> +++ b/drivers/input/mouse/bcm5974.c
>>> @@ -345,7 +345,8 @@ static int report_tp_state(struct bcm5974 *dev,=
 int size)
>>>  		/* set the integrated button if applicable */
>>>  		if (c->tp_type =3D=3D TYPE2)
>>>  			ibt =3D raw2int(dev->tp_data[BUTTON_TYPE2]);
>>> -	}
>>> +	} else
>>> +		raw_w =3D raw_x =3D raw_y =3D 0;
>>> =20
>>>  	/* while tracking finger still valid, count all fingers */
>>>  	if (ptest > PRESSURE_LOW && origin) {
>> I would prefer treating raw_p on the same footing here, completing t=
he set of
>> non-obviously initialized variables. It might also make sense to uti=
lize the
>> same initialization technique already used in the code, thus:
>>
>=20
> No, then you are wasting cpu cycles and doing double initialization f=
or
> some cases.
>=20
>> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm=
5974.c
>> index 2d8fc0b..2f85876 100644
>> --- a/drivers/input/mouse/bcm5974.c
>> +++ b/drivers/input/mouse/bcm5974.c
>> @@ -316,7 +316,7 @@ static int report_tp_state(struct bcm5974 *dev, =
int size)
>>  	const struct bcm5974_config *c =3D &dev->cfg;
>>  	const struct tp_finger *f;
>>  	struct input_dev *input =3D dev->input;
>> -	int raw_p, raw_w, raw_x, raw_y, raw_n;
>> +	int raw_p =3D 0, raw_w =3D 0, raw_x =3D 0, raw_y =3D 0, raw_n;
>>  	int ptest =3D 0, origin =3D 0, ibt =3D 0, nmin =3D 0, nmax =3D 0;
>>  	int abs_p =3D 0, abs_w =3D 0, abs_x =3D 0, abs_y =3D 0;
>>
>>
>> I wonder how many cpu cycles in the world are spent making compilers=
 happy.
>>
>=20
> It is not compiler mistake it is programming/logic mistakes. We shoul=
d
> be thankful to compiler to pointing mistakes made by us.

The uninitialized-variable warnings have certainly proved their value m=
any times
over. I was merely reflecting over the fact that the enclosing space of=
 all such
errors could be made smaller by deduction at compile time.

Cheers,
Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
