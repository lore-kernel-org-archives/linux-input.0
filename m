From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH 0/6] mfd: da9063: remove platform_data
Date: Mon, 18 Mar 2019 16:34:52 +0000
Message-ID: <VI1PR10MB23522C4EA0F730414CD14B56FE470@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Mark,

On 18 March 2019 15:48, Wolfram Sang wrote:

> To: linux-kernel@vger.kernel.org
> Subject: [PATCH 0/6] mfd: da9063: remove platform_data
>=20
> When working with this driver while debugging something else, I noticed t=
hat
> there are no in-kernel users of platform_data anymore. Removing the suppo=
rt
> simplifies the code and gets rid of quite some lines. The biggest refacto=
ring
> went to the regulator driver which could maybe benefit from more
> refactorization. However, there is no in-kernel user of that driver, so n=
o
> testing. I left it at this stage. I think the changes are still at a leve=
l
> where review and build-testing will give enough confidence.
>=20
> Besides the regulator thing, it was tested on a Renesas Lager board (R-Ca=
r H2).
> No regressions encountered. buildbot was happy, too.
>=20
> The patches are based on v5.1-rc1. I'd vote for all of them going through=
 the
> MFD tree. Looking forward to comments!
>=20
>    Wolfram

My regulator tests are currently broken, so I'm looking into it.
I'll read-through and test these patches as soon as I've solved the regress=
ions.

Regards,
Steve
