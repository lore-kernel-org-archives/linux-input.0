From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: Re: [PATCH v2 4/4] leds: no longer use unnamed gpios
Date: Thu, 22 Jan 2015 10:37:46 +0100
Message-ID: <54C0C4EA.5020404@ultimaker.com>
References: <1421876028-22799-1-git-send-email-o.schinagl@ultimaker.com> <1421876028-22799-5-git-send-email-o.schinagl@ultimaker.com> <2355733.gZvsF3iKWH@pcimr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <2355733.gZvsF3iKWH@pcimr>
Sender: linux-gpio-owner@vger.kernel.org
To: Rojhalat Ibrahim <imr@rtschenk.de>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Olliver Schinagl <oliver@schinagl.nl>, Robin Gong <b38343@freescale.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Grant Likely <grant.likely@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Alexander Shiyan <shc_work@mail.ru>, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hey Rojhalat,

On 22-01-15 10:32, Rojhalat Ibrahim wrote:
> On Wednesday 21 January 2015 22:33:48 Olliver Schinagl wrote:
>> From: Olliver Schinagl <oliver@schinagl.nl>
>>
>> The gpio document says we should not use unnamed bindings for gpios.
>> This patch uses the 'led-' prefix to the gpios and updates code and
>> documents. Because the devm_get_gpiod_from_child() falls back to usi=
ng
>> old-style unnamed gpios, we can update the code first, and update
>> dts files as time allows.
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Where does devm_get_gpiod_from_child() fall back "to using old-style
> unnamed gpios"?
Your absolutly right, I accidentally forgot a patch that was supposed t=
o=20
get squashed into this patchset. The idea is to do the same as in=20
gpio-keys-polled.c. I'll make sure it sits in v3 of the set! My appolog=
ies!

Olliver
>
> After applying this patch the leds defined in my devicetree do not
> work anymore.
>
>     Rojhalat
>
>
>

--=20
Met vriendelijke groeten, Kind regards, =E4=B8=8E=E4=BA=B2=E5=88=87=E7=9A=
=84=E9=97=AE=E5=80=99

Olliver Schinagl
Research & Development
Ultimaker B.V.
http://www.ultimaker.com

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
