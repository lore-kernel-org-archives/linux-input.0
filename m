From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 2/3] input: rotary-encoder: Introduce new
 'steps-per-period' property
Date: Fri, 9 Oct 2015 11:13:29 -0300
Message-ID: <CAAEAJfBjWc7Gi5mv2XjxQVw2WhD0PhafR6X4GnZ=nJ1q30ECxA@mail.gmail.com>
References: <1444398416-3073-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<1444398416-3073-3-git-send-email-ezequiel@vanguardiasur.com.ar>
	<CAL_Jsq+Ckr3xkKkG=RpfiRS7LZb4YwxL3gdFY7rZprn+sWRRyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33931 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859AbbJIONa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2015 10:13:30 -0400
Received: by wicfx3 with SMTP id fx3so72365648wic.1
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2015 07:13:29 -0700 (PDT)
In-Reply-To: <CAL_Jsq+Ckr3xkKkG=RpfiRS7LZb4YwxL3gdFY7rZprn+sWRRyg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <zonque@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

On 9 October 2015 at 10:57, Rob Herring <robh@kernel.org> wrote:
> On Fri, Oct 9, 2015 at 8:46 AM, Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
>> This commit deprecates the 'half-period' property and introduces
>> a new property 'steps-per-period'. This property specifies the
>> number of steps (stable states) produced by the rotary encoder
>> for each GPIO period.
>>
>> Such a property is required to accurately describe all kinds of
>> rotary-encoders devices.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>
> Acked-by: Rob Herring <robh@kernel.org>
>
> Are there any in tree dts's using the deprecated property? If so,
> please update them.
>

Nope, no dts's using it.

Thanks,
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
