From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v6 5/9] extcon: max8997: Fix handling error code of
 regmap_irq_get_virq()
Date: Tue, 10 May 2016 10:23:45 +0900
Message-ID: <57313821.4050309@samsung.com>
References: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-1-git-send-email-k.kozlowski@samsung.com>
 <1462519636-3250-4-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44073 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbcEJBXu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 May 2016 21:23:50 -0400
In-reply-to: <1462519636-3250-4-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, rtc-linux@googlegroups.com
Cc: r.baldyga@hackerion.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Krzysztof,

On 2016=EB=85=84 05=EC=9B=94 06=EC=9D=BC 16:27, Krzysztof Kozlowski wro=
te:
> The regmap_irq_get_virq() can return negative ERRNO, so its result
> should not be stored in unsigned int because error would be ignored.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/extcon/extcon-max8997.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-=
max8997.c
> index 68754ac2c8ea..0afa3e8b5dc3 100644
> --- a/drivers/extcon/extcon-max8997.c
> +++ b/drivers/extcon/extcon-max8997.c
> @@ -660,11 +660,11 @@ static int max8997_muic_probe(struct platform_d=
evice *pdev)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(muic_irqs); i++) {
>  		struct max8997_muic_irq *muic_irq =3D &muic_irqs[i];
> -		unsigned int virq =3D 0;
> +		int virq =3D 0;
> =20
>  		virq =3D regmap_irq_get_virq(max8997->irq_data_muic,
>  					muic_irq->irq);
> -		if (!virq) {
> +		if (virq <=3D 0) {
>  			ret =3D -EINVAL;
>  			goto err_irq;
>  		}
>=20

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
