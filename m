From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH 0/6] mfd: da9063: remove platform_data
Date: Fri, 29 Mar 2019 11:28:19 +0000
Message-ID: <VI1PR10MB23529DC9BBD619A8BCD7D363FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <VI1PR10MB235256E1840C1E594ECDC0A5FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR10MB235256E1840C1E594ECDC0A5FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Wolfram Sang' <wsa+renesas@sang-engineering.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Caveat.

On 29 March 2019 11:02 Steve Twiss, wrote:

> Subject: RE: [PATCH 0/6] mfd: da9063: remove platform_data
>=20
 [...]
>=20
> I've acked-by and tested-by for all the patches now. Apologies because it=
 took
> such a long time to get around to looking at this.
>=20
> (For my benefit) I regression tested against v5.0 and v5.1-rc1, ok.

These were tested with two extra patches that are not in vanilla v5.0 or v5=
.1.-rc1.

One is in discussion and one is applied to linux-next,=20
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git=
/commit/?id=3D70b464918e5331e488058870fcc6821d54c4e541

E-mail threads are here:

https://lore.kernel.org/lkml/20190318163132.1BB633FBA2@swsrvapps-01.diasemi=
.com/
https://lore.kernel.org/lkml/20190320120604.7D99B3FBE9@swsrvapps-01.diasemi=
.com/

Regards,
Steve
