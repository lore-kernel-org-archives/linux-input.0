From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH v6 09/22] mfd: ab8500: Use power_supply_*() API
 for accessing function attrs
Date: Thu, 12 Mar 2015 09:01:56 +0000
Message-ID: <20150312090156.GB3314@x1>
References: <1426146260-30081-1-git-send-email-k.kozlowski@samsung.com>
 <1426146260-30081-10-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:45383 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbbCLJCD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2015 05:02:03 -0400
Received: by wesu56 with SMTP id u56so14729418wes.12
        for <linux-input@vger.kernel.org>; Thu, 12 Mar 2015 02:02:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1426146260-30081-10-git-send-email-k.kozlowski@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

On Thu, 12 Mar 2015, Krzysztof Kozlowski wrote:

> Replace direct calls to power supply function attributes with wrapper=
s.
> Wrappers provide safe access in case of unregistering the power
> supply (e.g. by removing the driver). Replace:
>  - get_property -> power_supply_get_property
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/mfd/ab8500-sysctrl.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Has the infrastructure for these been merged yet?

I.e. Can I just take them?

> diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctr=
l.c
> index cfff0b643f1b..d4a4b24be7c6 100644
> --- a/drivers/mfd/ab8500-sysctrl.c
> +++ b/drivers/mfd/ab8500-sysctrl.c
> @@ -49,7 +49,8 @@ static void ab8500_power_off(void)
>  		if (!psy)
>  			continue;
> =20
> -		ret =3D psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &val);
> +		ret =3D power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
> +				&val);
> =20
>  		if (!ret && val.intval) {
>  			charger_present =3D true;
> @@ -63,8 +64,8 @@ static void ab8500_power_off(void)
>  	/* Check if battery is known */
>  	psy =3D power_supply_get_by_name("ab8500_btemp");
>  	if (psy) {
> -		ret =3D psy->get_property(psy, POWER_SUPPLY_PROP_TECHNOLOGY,
> -					&val);
> +		ret =3D power_supply_get_property(psy,
> +				POWER_SUPPLY_PROP_TECHNOLOGY, &val);
>  		if (!ret && val.intval !=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN) {
>  			printk(KERN_INFO
>  			       "Charger \"%s\" is connected with known battery."

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
