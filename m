From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH v2 2/9] mfd: max77693: Store I2C device type as enum and
 add default unknown
Date: Wed, 27 May 2015 20:13:04 +0900
Message-ID: <CAJKOXPchv7hqcsE5pDB-_PJknfTqLYUOdNbP=6ExUD_gdRoa3w@mail.gmail.com>
References: <1432446213-4886-1-git-send-email-k.kozlowski.k@gmail.com>
	<1432446213-4886-3-git-send-email-k.kozlowski.k@gmail.com>
	<20150527102334.GD11677@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150527102334.GD11677@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

2015-05-27 19:23 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
> On Sun, 24 May 2015, Krzysztof Kozlowski wrote:
>
>> Store the device type (obtained from i2c_device_id) as an enum and add a
>> default type of unknown to distinguish from case when this is not set
>> at all.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>> ---
>>  include/linux/mfd/max77693-private.h | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> Applied, thanks.

Thanks.

I was thinking about merging everything through one tree because of
the dependency (successive patches depend on previous) but I don't
mind choosing different strategy. However if you picked this one maybe
you can also apply the patch 1/9:
mfd/extcon: max77693: Remove unused extern declarations and max77693_dev members

It already got ack from Chanwoo.

Other patches depend on these so either everything will go through
your tree or you will prepare an immutable branch for e.g. Mark (as
everything is around regulator drivers).

Anyway I need some input from Mark about the patches 4, 5 and 9. Rest
of them already have his ack.

Best regards,
Krzysztof
