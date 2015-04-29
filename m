From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH 03/10] regulator: max77693: Use core code for charger's is_enabled
Date: Wed, 29 Apr 2015 20:08:04 +0900
Message-ID: <CAJKOXPf=3-DZDf79ngnBToGtyYT5M-yEN9sXN5=2-E9JBHOc+g@mail.gmail.com>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
	<1430305114-23598-4-git-send-email-k.kozlowski.k@gmail.com>
	<20150429110307.GG22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429110307.GG22845@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

2015-04-29 20:03 GMT+09:00 Mark Brown <broonie@kernel.org>:
> On Wed, Apr 29, 2015 at 07:58:28PM +0900, Krzysztof Kozlowski wrote:
>> The custom implementation of 'regulator_ops.is_enabled' callback for
>> charger regulator is exactly the same as regulator_is_enabled_regmap()
>> with 'enable_val' set.
>
> Applied, thanks.

Woo! That was fast... Thank you!

Best regards,
Krzysztof
