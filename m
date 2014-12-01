From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH 1/2] Input: add regulator haptic driver
Date: Mon, 01 Dec 2014 10:30:07 +0900
Message-ID: <547BC49F.8040402@samsung.com>
References: <1416490300-28865-1-git-send-email-jaewon02.kim@samsung.com>
 <1416490300-28865-2-git-send-email-jaewon02.kim@samsung.com>
 <20141128125051.GA3643@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20141128125051.GA3643@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Hyunhee Kim <hyunhee.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

Hi Mark,

2014=EB=85=84 11=EC=9B=94 28=EC=9D=BC 21:50=EC=97=90 Mark Brown =EC=9D=B4=
(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> On Thu, Nov 20, 2014 at 10:31:39PM +0900, Jaewon Kim wrote:
>
>> +	haptic->regulator =3D devm_regulator_get(&pdev->dev, "haptic");
>> +	if (IS_ERR(haptic->regulator)) {
>> +		dev_err(&pdev->dev, "failed to get regulator\n");
>> +		return PTR_ERR(haptic->regulator);
>> +	}
> This needs to be _get_exclusive() - the driver will be broken if
> something else shares the regualtor since it relies on both enabling =
and
> disabling the regulator and on setting the voltage for effects.  It's
> not like a power supply where leaving the device powered when it coul=
d
> be off is going to have no effect, if the power is left on then the
> haptic motor will continue to operate.

Thanks to review my patch.

Haptic regulator has to only be used in this driver.
So, it is right to change like your advice.
I will fix next version.

Thanks
Jaewon Kim.
