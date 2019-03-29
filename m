From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH 2/6] input: da9063_onkey: remove platform_data support
Date: Fri, 29 Mar 2019 10:58:00 +0000
Message-ID: <VI1PR10MB2352701871983EF8677C5CB8FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190318154759.21978-3-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

On 18 March 2019 15:48, Wolfram Sang wrote:

> Subject: [PATCH 2/6] input: da9063_onkey: remove platform_data support
>=20
> There are no in-kernel users anymore, so remove this outdated interface.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/input/misc/da9063_onkey.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Thanks!
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
