From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: randconfig build error with next-20141219, in
 drivers/input/misc/regulator-haptic.c
Date: Sun, 21 Dec 2014 19:02:15 -0800
Message-ID: <20141222030215.GD30082@dtor-ws>
References: <CA+r1Zhh3u_JMnvvYaXD81ew--H_t9exuX-xvuNw8n=OPA-PWNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+r1Zhh3u_JMnvvYaXD81ew--H_t9exuX-xvuNw8n=OPA-PWNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Dec 19, 2014 at 09:13:02AM -0700, Jim Davis wrote:
> Building with the attached random configuration file,
>=20
> drivers/input/misc/regulator-haptic.c: In function =E2=80=98regulator=
_haptic_probe=E2=80=99:
> drivers/input/misc/regulator-haptic.c:184:2: error: implicit
> declaration of function =E2=80=98devm_regulator_get_exclusive=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>   haptic->regulator =3D devm_regulator_get_exclusive(&pdev->dev, "hap=
tic");
>   ^
> drivers/input/misc/regulator-haptic.c:184:20: warning: assignment mak=
es pointer
> from integer without a cast [enabled by default]
>   haptic->regulator =3D devm_regulator_get_exclusive(&pdev->dev, "hap=
tic");
>                     ^
> cc1: some warnings being treated as errors
> make[3]: *** [drivers/input/misc/regulator-haptic.o] Error 1

Thanks, I'll add the missing dependency on CONFIG_REGULATOR.

--=20
Dmitry
