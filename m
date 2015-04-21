From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 3/3] Input: adp5589-keys: fix event count mask
Date: Tue, 21 Apr 2015 16:36:44 +0200
Message-ID: <5536607C.4010404@analog.com>
References: <1429626090-29022-1-git-send-email-guido@vanguardiasur.com.ar>
 <1429626090-29022-4-git-send-email-guido@vanguardiasur.com.ar>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0070.outbound.protection.outlook.com ([65.55.169.70]:18256
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751106AbbDUPNN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Apr 2015 11:13:13 -0400
In-Reply-To: <1429626090-29022-4-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?R3VpZG8gTWFydMOtbmV6?= <guido@vanguardiasur.com.ar>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, =?UTF-8?B?RXplcXVpZWwgR2FyY8Ot?= =?UTF-8?B?YQ==?= <ezequiel@vanguardiasur.com.ar>

On 04/21/2015 04:21 PM, Guido Mart=C3=ADnez wrote:
> The event mask was specified as 0xF (4 bits) when in reality is 0x1F =
(5
> bits) in order to be capable of representing all FIFO length values f=
rom
> 0 to 16.
>
> This caused a problem: when the keypad reported 16 pending events the
> driver took it as 0, and did nothing. This in turn caused the keypad =
to
> re-issue the interrupt over and over again.
>
> Fixes: 9d2e173644bb ('Input: ADP5589 - new driver for I2C Keypad Deco=
der and I/O Expander')
> Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>   drivers/input/keyboard/adp5589-keys.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/ke=
yboard/adp5589-keys.c
> index 8709a7f..0419a7a 100644
> --- a/drivers/input/keyboard/adp5589-keys.c
> +++ b/drivers/input/keyboard/adp5589-keys.c
> @@ -180,7 +180,7 @@
>   #define LOGIC2_STAT	(1 << 7)	/* ADP5589 only */
>   #define LOGIC1_STAT	(1 << 6)
>   #define LOCK_STAT	(1 << 5)	/* ADP5589 only */
> -#define KEC		0xF
> +#define KEC		0x1F
>  =20
>   /* PIN_CONFIG_D Register */
>   #define C4_EXTEND_CFG	(1 << 6)	/* RESET2 */


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
