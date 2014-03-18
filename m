From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 4/4] mfd: max8997: move regmap handling to function
 drivers
Date: Tue, 18 Mar 2014 08:50:39 +0000
Message-ID: <20140318085039.GF25478@lee--X1>
References: <1394703532-494-1-git-send-email-r.baldyga@samsung.com>
 <1394703532-494-5-git-send-email-r.baldyga@samsung.com>
 <532191E6.6080108@samsung.com>
 <20140313125504.GA10356@lee--X1>
 <20140313140901.GW366@sirena.org.uk>
 <5322E653.90107@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5322E653.90107@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, sameo@linux.intel.com, myungjoo.ham@samsung.com, dmitry.torokhov@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com
List-Id: linux-input@vger.kernel.org

> >>> Is it necessary? If previous mfd driver has various i2c line, pre=
vious mfd driver
> >>> initialize regmap/i2c setting on mfd driver.
> >>> I'm not sure that regmap/i2c setting code move from mfd driver to=
 each driver.
> >>>
> >>> Dear Lee Jones,
> >>> I need your opinion about moving regmap/i2c code from mfd driver =
to each driver.
> >=20
> >> I'd rather take advice from Mark on this one.
> >=20
> > I don't really case that much; I'm having a hard time seeing it as
> > particularly useful to do the refactoring but if it makes people
> > happy...  Keeping things in the core would help promote reusability=
 I
> > guess but I'm not sure that's likely to actually happen with this s=
ort
> > of driver/device.
>=20
> If you think it's not needed, you can ignore this patch. I prepared i=
t
> due to Dmitry Torokhov suggestion. If you think it's useless it doesn=
't
> make me unhappy :)

Ignored, thanks. ;)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
