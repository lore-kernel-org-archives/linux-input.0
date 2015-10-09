From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] input: rotary-encoder: Introduce new
 'steps-per-period' property
Date: Fri, 9 Oct 2015 08:57:11 -0500
Message-ID: <CAL_Jsq+Ckr3xkKkG=RpfiRS7LZb4YwxL3gdFY7rZprn+sWRRyg@mail.gmail.com>
References: <1444398416-3073-1-git-send-email-ezequiel@vanguardiasur.com.ar> <1444398416-3073-3-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36365 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbbJIN5b (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2015 09:57:31 -0400
In-Reply-To: <1444398416-3073-3-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <zonque@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, ariel@vanguardiasur.com.ar

On Fri, Oct 9, 2015 at 8:46 AM, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> This commit deprecates the 'half-period' property and introduces
> a new property 'steps-per-period'. This property specifies the
> number of steps (stable states) produced by the rotary encoder
> for each GPIO period.
>
> Such a property is required to accurately describe all kinds of
> rotary-encoders devices.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Acked-by: Rob Herring <robh@kernel.org>

Are there any in tree dts's using the deprecated property? If so,
please update them.

Rob

> ---
>  Documentation/devicetree/bindings/input/rotary-encoder.txt | 9 +++++++++
>  Documentation/input/rotary-encoder.txt                     | 8 ++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index 331549593ed5..5715ad70d28e 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -14,7 +14,16 @@ Optional properties:
>    device, hence no steps need to be passed.
>  - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
>    greater than the specified steps or smaller than 0. For absolute axis only.
> +- rotary-encoder,steps-per-period: Number of steps (stable states) per period.
> +  The values have the following meaning:
> +  1: Full-period mode (default)
> +  2: Half-period mode
> +  4: Quarter-period mode
> +
> +Deprecated properties:
>  - rotary-encoder,half-period: Makes the driver work on half-period mode.
> +  This property is deprecated. Instead, a 'steps-per-period ' value should
> +  be used, such as "rotary-encoder,steps-per-period = <2>".
>
>  See Documentation/input/rotary-encoder.txt for more information.
>
> diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
> index 5737e3590adb..00acf88e4064 100644
> --- a/Documentation/input/rotary-encoder.txt
> +++ b/Documentation/input/rotary-encoder.txt
> @@ -9,8 +9,9 @@ peripherals with two wires. The outputs are phase-shifted by 90 degrees
>  and by triggering on falling and rising edges, the turn direction can
>  be determined.
>
> -Some encoders have both outputs low in stable states, whereas others also have
> -a stable state with both outputs high (half-period mode).
> +Some encoders have both outputs low in stable states, others also have
> +a stable state with both outputs high (half-period mode) and some have
> +a stable state in all steps (quarter-period mode).
>
>  The phase diagram of these two outputs look like this:
>
> @@ -32,6 +33,9 @@ The phase diagram of these two outputs look like this:
>                  |<-->|
>                   one step (half-period mode)
>
> +                |<>|
> +                 one step (quarter-period mode)
> +
>  For more information, please see
>         https://en.wikipedia.org/wiki/Rotary_encoder
>
> --
> 2.5.2
>
