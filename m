From: Pingbo Wen <pingbo.wen@linaro.org>
Subject: Re: [Y2038] [PATCH V2] hil_mlc: convert timeval to ktime_t
Date: Fri, 23 Oct 2015 20:32:50 +0800
Message-ID: <05CEA4E0-A8CF-42DA-89C3-F0968DE73CB4@linaro.org>
References: <46052377.96MapaKFAy@wuerfel> <1445592300-30894-1-git-send-email-pingbo.wen@linaro.org> <33014393.CcP7q7PhGq@wuerfel>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <33014393.CcP7q7PhGq@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


> =D4=DA 2015=C4=EA10=D4=C223=C8=D5=A3=AC17:55=A3=ACArnd Bergmann <arnd=
@arndb.de> =D0=B4=B5=C0=A3=BA
>=20
> On Friday 23 October 2015 17:24:59 WEN Pingbo wrote:
>> Using struct timeval will cause time overflow in 2038, replacing it =
with
>> ktime_t. And we don't need to handle sec and nsec separately.
>>=20
>=20
> This part looks good now, but as I commented in version 1, it should
> really be a separate patch rather than combined with the rest that
> is dealing with another use of timeval.

Ok, I will split it in next version.

>> -		do_gettimeofday(&tv);
>> -		tv.tv_usec +=3D USEC_PER_SEC * (tv.tv_sec - mlc->instart.tv_sec);
>> -		tv.tv_usec -=3D mlc->instart.tv_usec;
>> -		if (tv.tv_usec >=3D mlc->intimeout) goto sched;
>> -		tv.tv_usec =3D (mlc->intimeout - tv.tv_usec) * HZ / USEC_PER_SEC;
>> -		if (!tv.tv_usec) goto sched;
>> -		mod_timer(&hil_mlcs_kicker, jiffies + tv.tv_usec);
>> +		if (tmp.tv64 >=3D (mlc->intimeout * NSEC_PER_USEC))
>> +			goto sched;
>> +		tmp.tv64 =3D mlc->intimeout * NSEC_PER_USEC - tmp.tv64;
>> +		if (tmp.tv64 < NSEC_PER_USEC)
>> +			goto sched;
>> +		mod_timer(&hil_mlcs_kicker,
>> +				jiffies + nsecs_to_jiffies(tmp.tv64));
>> 		break;
>> 	sched:
>> 		tasklet_schedule(&hil_mlcs_tasklet);
>=20
> If I read this right, the code is executed one for each input event s=
uch
> as a keypress or mouse movement. In the latter case, doing nsecs_to_j=
iffies()
> here is actually a bit expensive, and I stil think it can be avoided
> by just using jiffies.
>=20
> For the (tmp.tv64 < NSEC_PER_USEC) part, did you just do that because
> I said this, or did you actually prove that it is required? I'm still
> confused about what the driver is trying to achieve here.

More explanation here:)
the judgement here is to prevent mod_timer with zero delta. I can not m=
ake sure whether the module
have nanosecond precise, so just keep same.

>=20
>> diff --git a/drivers/input/serio/hp_sdc_mlc.c b/drivers/input/serio/=
hp_sdc_mlc.c
>> index d50f067..0a27b89 100644
>> --- a/drivers/input/serio/hp_sdc_mlc.c
>> +++ b/drivers/input/serio/hp_sdc_mlc.c
>> @@ -149,7 +149,8 @@ static int hp_sdc_mlc_in(hil_mlc *mlc, suseconds=
_t timeout)
>>=20
>> 	/* Try to down the semaphore */
>> 	if (down_trylock(&mlc->isem)) {
>> -		struct timeval tv;
>> +		ktime_t tmp =3D ktime_sub(ktime_get(), mlc->instart);
>> +
>> 		if (priv->emtestmode) {
>> 			mlc->ipacket[0] =3D
>> 				HIL_ERR_INT | (mlc->opacket &
>=20
> Maybe give the variable a more useful name than 'tmp'?
>=20
> You could also remove the variable entirely if you slightly restructu=
re
> the condition below.

I see, thanks for point out.

Pingbo
