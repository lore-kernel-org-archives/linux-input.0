From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] Input: rotary_encoder - support binary encoding of states
Date: Wed, 23 Mar 2016 14:06:22 +0100
Message-ID: <56F294CE.8060008@zonque.org>
References: <1458680914-4533-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAAEAJfDAg9aW62O8zNG3cGf207_azZYFja8jUgf+5xDAtzfbyg@mail.gmail.com>
 <CAL_Jsq++0hPVuqZERsfGRM20F+2rzFUz2CDOR1Kioj0uOaskDQ@mail.gmail.com>
 <20160323064930.GJ6191@pengutronix.de>
 <CAL_JsqKumK8eAF+AFnR0r7V9tDECSPSv33qE_jZZE4Dz5jUyWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:35381 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753448AbcCWNOR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Mar 2016 09:14:17 -0400
In-Reply-To: <CAL_JsqKumK8eAF+AFnR0r7V9tDECSPSv33qE_jZZE4Dz5jUyWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Rojhalat Ibrahim <imr@rtschenk.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On 03/23/2016 01:46 PM, Rob Herring wrote:
> On Wed, Mar 23, 2016 at 1:49 AM, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:

>>> Fine, but "rotary-encoder" is not a vendor I've ever heard of. Just
>>> "encoding" is sufficient.
>>
>> I picked that to be consistent with rotary-encoder,steps and other
>> already existing properties documented in
>> Documentation/devicetree/bindings/input/rotary-encoder.txt.
>=20
> Uggg.

IIRC, the discussion back then concluded that there should be no
properties without prefixes except for properties that are really
generic, which wasn't an applicable argument for those of this driver.
Then again, this goes back many years, and the rules might have changed=
=2E

>> Should the prefix be dropped for these, too (with compat code)?
>=20
> On one hand, there's only one user of one property in the kernel, but
> I'd guess there are others in the wild. Probably not worth carrying
> both, so I guess just leave this for consistency.

Wasn't there a general agreement to *not* provide guarantees on the
stability of TD bindings, in order to be able to refactor and unify
them? Sorry, I haven't followed the discussion around all that for a
while, so I'm just asking out of curiosity.

As far as I'm concerned, I could live with any kind of such change and
notify the users I know of personally so they can follow up. But I don'=
t
know about others of course.


Thanks,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
