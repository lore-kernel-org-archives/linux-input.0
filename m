From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Mon, 24 Feb 2014 17:14:52 +0000
Message-ID: <a79091da-a072-4f76-83ce-a956ef9c37a2@email.android.com>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <52CEA4AA.8050503@free-electrons.com> <201401100955.45885.jbe@pengutronix.de> <201402241416.24270.jbe@pengutronix.de> <20140224142658.GD4436@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140224142658.GD4436-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org



On February 24, 2014 2:26:58 PM GMT+00:00, Alexandre Belloni <alexandre=
=2Ebelloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>Hi Juergen,
>
>On 24/02/2014 at 14:16:24 +0100, Juergen Beisert wrote :
>> Hi Alexandre,
>>=20
>> > While I don't have much experience with the TS part of the code bu=
t
>I
>> > can investigate if you don't have any idea.
>>=20
>> can you please test the following patch?
>> After releasing the touchscreen the internal state machine was left
>in a
>> wrong state.
>>=20
>
>This seems to solve the issue. You can send the patch with my
>Tested-by.
>
>It is probably worth trying to get it in 3.14.
Definitely. There is time.
>
>Thanks !
>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>b/drivers/staging/iio/adc/mxs-lradc.c
>> index e2dd783..558a76c 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -698,6 +698,7 @@ static void mxs_lradc_finish_touch_event(struct
>mxs_lradc *lradc, bool valid)
>>         }
>>=20
>>         /* if it is released, wait for the next touch via IRQ */
>> +       lradc->cur_plate =3D LRADC_TOUCH;
>>         mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ,
>LRADC_CTRL1);
>>         mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
>LRADC_CTRL1);
>>  }
>>=20
>> Regards,
>> Juergen
>>=20
>> --=20
>> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Juergen Beisert =C2=
=A0 =C2=A0 =C2=A0
>=C2=A0 =C2=A0 =C2=A0 |
>> Linux Solutions for Science and Industry =C2=A0 =C2=A0 =C2=A0| Phone=
:
>+49-5121-206917-5128 |
>> Peiner Str. 6-8, 31137 Hildesheim, Germany =C2=A0 =C2=A0| Fax: =C2=A0
>+49-5121-206917-5555 |
>> Amtsgericht Hildesheim, HRA 2686 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|
>http://www.pengutronix.de/ =C2=A0|

--=20
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
