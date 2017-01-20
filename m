From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] Input: add STMicroelectronics FingerTip touchscreen driver
Date: Fri, 20 Jan 2017 07:22:59 -0600
Message-ID: <CAL_JsqJf789JUt3UHDLO0=7Hm9KXRjYuzj0awPoQsfpN9EDeig@mail.gmail.com>
References: <20170117135441.31450-1-andi.shyti@samsung.com>
 <CGME20170117135456epcas5p2e303f0c5fa642b43fde543d5d6098dc2@epcas5p2.samsung.com>
 <20170117135441.31450-2-andi.shyti@samsung.com> <20170119181912.lzlcc5zbtue2ojp4@rob-hp-laptop>
 <20170120001914.him3d6j2fota547l@jack.zhora.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170120001914.him3d6j2fota547l@jack.zhora.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: Andi Shyti <andi.shyti@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 19, 2017 at 6:19 PM, Andi Shyti <andi@etezian.org> wrote:
> Hi Rob,
>
>> > +- compatible               : must be "st,stmfts"
>>
>> Seems too generic. Is this a single device?
>
> the device is precisely called ST-Microelectronics FingerTip S
> (stmfts). There are variants, but they all have the same name and
> same datasheet.

Okay, then it is fine.

>
> Maybe I can be more specific in the description, sometimes I
> omitted the 'S'.
>
> Andi
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
