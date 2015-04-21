From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 2/3] Input: adp5589-keys: fix pull mask setting
Date: Tue, 21 Apr 2015 16:35:20 +0200
Message-ID: <55366028.2010105@analog.com>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
 <1429626090-29022-3-git-send-email-guido@vanguardiasur.com.ar>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0086.outbound.protection.outlook.com ([207.46.100.86]:16416
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751086AbbDUOyx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 10:54:53 -0400
In-Reply-To: <1429626090-29022-3-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?R3VpZG8gTWFydMOtbmV6?= <guido@vanguardiasur.com.ar>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, =?UTF-8?B?RXplcXVpZWwgR2FyY8Ot?= =?UTF-8?B?YQ==?= <ezequiel@vanguardiasur.com.ar>

On 04/21/2015 04:21 PM, Guido Mart=C3=ADnez wrote:
> The pull mask is created by looping each row (column) and building an
> 8-bit integer with the configuration. It is written byte-by-byte, whe=
n
> we reach the end of the rows (columns) or we're at the 3rd line (whic=
h
> finishes the first byte, since each pin is 2bits on the mask).
>
> However, this only works if we have at most 8 pins (2 bytes), which i=
s
> not the case for the ADP5589. So, write the byte at each boundary (ev=
ery
> 4 rows/columns).
>
> Fixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad Deco=
der and I/O Expander')
> Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>   drivers/input/keyboard/adp5589-keys.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/ke=
yboard/adp5589-keys.c
> index 19edd2d..8709a7f 100644
> --- a/drivers/input/keyboard/adp5589-keys.c
> +++ b/drivers/input/keyboard/adp5589-keys.c
> @@ -729,7 +729,7 @@ static int adp5589_setup(struct adp5589_kpad *kpa=
d)
>  =20
>   		pull_mask |=3D val << (2 * (i & 0x3));
>  =20
> -		if (i =3D=3D 3 || i =3D=3D kpad->var->max_row_num) {
> +		if (i % 4 =3D=3D 3 || i =3D=3D kpad->var->max_row_num) {
>   			ret |=3D adp5589_write(client, reg(ADP5585_RPULL_CONFIG_A)
>   					     + (i >> 2), pull_mask);
>   			pull_mask =3D 0;
> @@ -749,7 +749,7 @@ static int adp5589_setup(struct adp5589_kpad *kpa=
d)
>  =20
>   		pull_mask |=3D val << (2 * (i & 0x3));
>  =20
> -		if (i =3D=3D 3 || i =3D=3D kpad->var->max_col_num) {
> +		if (i % 4 =3D=3D 3 || i =3D=3D kpad->var->max_col_num) {
>   			ret |=3D adp5589_write(client,
>   					     reg(ADP5585_RPULL_CONFIG_C) +
>   					     (i >> 2), pull_mask);


--=20
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
