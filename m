From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH 0/6] mfd: da9063: remove platform_data
Date: Fri, 29 Mar 2019 11:02:25 +0000
Message-ID: <VI1PR10MB235256E1840C1E594ECDC0A5FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 18 March 2019 15:48 Wolfram Sang wrote:

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

I've acked-by and tested-by for all the patches now. Apologies because it t=
ook
such a long time to get around to looking at this.

(For my benefit) I regression tested against v5.0 and v5.1-rc1, ok.

Thanks,
Steve
