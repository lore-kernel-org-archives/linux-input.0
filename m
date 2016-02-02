From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2 0/3] Input: rotary-encoder - use more than two gpios
Date: Tue, 2 Feb 2016 14:14:49 +0100
Message-ID: <56B0ABC9.10107@zonque.org>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <56B09C27.8070009@zonque.org> <20160202125602.GW13664@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:35411 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365AbcBBNOw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Feb 2016 08:14:52 -0500
In-Reply-To: <20160202125602.GW13664@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, devicetree@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On 02/02/2016 01:56 PM, Uwe Kleine-K=C3=B6nig wrote:
> Hello Daniel,
>=20
> On Tue, Feb 02, 2016 at 01:08:07PM +0100, Daniel Mack wrote:
>> On 02/02/2016 11:24 AM, Uwe Kleine-K=C3=B6nig wrote:
>>> Some time ago I sent a v1 of this, now after testing the changes mo=
re
>>> deeply patch 3 changed a bit. The old series started with
>>>
>>> 	Date: Wed,  2 Dec 2015 11:07:11 +0100
>>> 	From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>>> 	Subject: [PATCH RFC 0/3] input: rotary_encoder: use more than two =
gpios as input
>>> 	Message-Id: <1449050834-31779-1-git-send-email-u.kleine-koenig@pen=
gutronix.de>
>>>
>>> The two first patches are just preparation for the third patch.
>>>
>>> There is an obvious improvement that allows detection of quick chan=
ges
>>> more reliably with >2 gpios, but I didn't implement this yet. (With=
 4
>>> GPIOs you can distinguish a counter clockwise movement of three sta=
tes
>>> from a clock wise movement of a single state. Still the patch is us=
eful
>>> as it makes these devices work at all.
>>>
>>> My test device looks as follows:
>>>
>>>         rotary@0 {
>>>                 compatible =3D "rotary-encoder";
>>>                 gpios =3D <&gpio4 12 GPIO_ACTIVE_HIGH>, <&gpio4 11 =
GPIO_ACTIVE_HIGH>, <&gpio4 10 GPIO_ACTIVE_HIGH>, <&gpio4 9 GPIO_ACTIVE_=
HIGH>;
>>>
>>>                 rotary-encoder,steps =3D <16>;
>>> 		rotary-encoder,steps-per-period =3D <16>;
>>>         };
>>>
>>> While Daniel Mack and Rojhalat Ibrahim agreed that this device is a=
n
>>> absolute encoder and should be supported by a simpler logic, I stil=
l
>>> consider it worthwhile to get these patches in as a first step. Als=
o the
>>> binding looks right, so IMHO the comments shouldn't stop this serie=
s
>>> from going in.
>>
>> I still don't understand why this is implemented that way, rather th=
an
>> going for a much simpler logic of interpretation that also allows us=
ers
>> to read out the absolute position.
>>
>> The code to read the value would be really just as simple as reading=
 all
>> GPIOs and or-ing their values into the result, and skip the state
>> machine completely. This code would be active if a new attribute
>> (something like 'rotary-encoder,hardware-absolute') is set, or even
>> implicitly, when more than 2 GPIOs are specified.
>>
>> Is there any reason for not doing that?
>=20
> Currently the reason is lack of time. And when implementing
> rotary-encoder,hardware-absolute something similar would be the resul=
t
> for the relative reporting anyhow. So the problem is only that I don'=
t
> have absolute support yet, but the patches as is would be the base fo=
r
> that anyhow.

Because you would support relative support for such 4-pin encoders as
well? I would have thought that absolute encoders would report absolute
values only, but I guess you have a point here. Just to make sure we're
on the same page: For more than 2 GPIOs, and an absent
"rotary-encoder,relative-axis", the driver would switch to a mode in
which it bypasses the state machine, right?

If you're planning to implement that eventually, I'm fine with the
patches for now :)

Dmitry, if you are apply them, feel free to add my

  Acked-by: Daniel Mack <daniel@zonque.org>

to all 3 of them.


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
