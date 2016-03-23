From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] Input: rotary_encoder - support binary encoding of states
Date: Tue, 22 Mar 2016 19:47:06 -0500
Message-ID: <CAL_Jsq++0hPVuqZERsfGRM20F+2rzFUz2CDOR1Kioj0uOaskDQ@mail.gmail.com>
References: <1458680914-4533-1-git-send-email-u.kleine-koenig@pengutronix.de> <CAAEAJfDAg9aW62O8zNG3cGf207_azZYFja8jUgf+5xDAtzfbyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45191 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbcCWAra convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2016 20:47:30 -0400
In-Reply-To: <CAAEAJfDAg9aW62O8zNG3cGf207_azZYFja8jUgf+5xDAtzfbyg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Daniel Mack <daniel@zonque.org>, Rojhalat Ibrahim <imr@rtschenk.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On Tue, Mar 22, 2016 at 5:50 PM, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> (Adding DT people)
>
> On 22 March 2016 at 18:08, Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
>> A plain binary encoding has some downsides compared to the usual Gra=
y
>> encoding, but that doesn't stop hardware engineers to eventually use=
 it.
>> So implement support for this encoding in the rotary encoder driver.
>>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de=
>
>> ---
>> Hello,
>>
>> an alternative to define this difference in the device tree is to us=
e
>> something like:
>>
>>         rotary-encoder,encoding =3D "binary";
>>
>> or
>>
>>         rotary-encoder,encoding =3D <ROTARY_ENCODER_ENCODING_BINARY>=
;
>>
>> instead of a property
>>
>>         rotary-encoder,encoding-binary;
>>
>> . While the two first solutions make it obvious that there can only =
be
>> one encoding, they IMHO look ugly, so I went for the property withou=
t
>> value. What do you think?
>>
>
> Yes, picking something like:
>
>   rotary-encoder,encoding =3D "binary";
>
> emphasizing the fact that only one encoding will be used,
> will work better, scaling well if we need to introduce some
> "foobar" encoding.

=46ine, but "rotary-encoder" is not a vendor I've ever heard of. Just
"encoding" is sufficient.

Rob
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
