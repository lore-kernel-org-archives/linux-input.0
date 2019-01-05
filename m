From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: rotaty-encoder - Add DT binding document
Date: Sat, 5 Jan 2019 17:11:32 -0600
Message-ID: <CAKdAkRR80M4R4bWPu4smPD5=KPWanL+EFPvDUYLNrHaFQfApPw@mail.gmail.com>
References: <20190105202659.20198-1-nazgul33@gmail.com> <20190105202659.20198-3-nazgul33@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105202659.20198-3-nazgul33@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Donghoon Han <nazgul33@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Daniel Mack <daniel@caiaq.de>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Jan 5, 2019 at 2:27 PM Donghoon Han <nazgul33@gmail.com> wrote:
>
> Add DT binding document for rotary-encoder, keycode options.
>
> Signed-off-by: Donghoon Han <nazgul33@gmail.com>
> ---
>  .../devicetree/bindings/input/rotary-encoder.txt     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index f99fe5cdeaec..113640079de3 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -12,6 +12,10 @@ Optional properties:
>  - rotary-encoder,relative-axis: register a relative axis rather than an
>    absolute one. Relative axis will only generate +1/-1 events on the input
>    device, hence no steps need to be passed.
> +- rotary-encoder,relative-keys : generate pair of key events. This setting
> +  behaves just like relative-axis, generating key events. keycode[2]
> +  corresponds -1/1 events.
> +- rotary-encoder,relative-keycodes : keycodes for relative-keys
>  - rotary-encoder,rollover: Automatic rollover when the rotary value becomes
>    greater than the specified steps or smaller than 0. For absolute axis only.
>  - rotary-encoder,steps-per-period: Number of steps (stable states) per period.
> @@ -48,3 +52,11 @@ Example:
>                         rotary-encoder,encoding = "binary";
>                         rotary-encoder,rollover;
>                 };
> +
> +               rotary@2 {
> +                       compatible = "rotary-encoder";
> +                       gpios = <&gpio 21 0>, <&gpio 22 0>;
> +                       rotary-encoder,relative-keys;
> +                       rotary-encoder,relative-keycode = <103>, <108>;
> +                       rotary-encoder,steps-per-period = <2>;

Do you need steps for keys? They weren't required for the relative axis mode.

Thanks.

-- 
Dmitry
