From: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Subject: Re: [PATCH v1] HID: sony: Print reversed MAC address via %pMR
Date: Wed, 13 Dec 2017 02:22:15 +0000
Message-ID: <1DD62093774CEE42AFC16E785A1088049E247090@USCULXMSG13.am.sony.com>
References: <20171211130612.34715-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam01on0101.outbound.protection.outlook.com ([104.47.34.101]:45378
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752467AbdLMCWU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Dec 2017 21:22:20 -0500
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 12/11/2017 05:07 AM, Andy Shevchenko wrote:=0A=
> Reversed MAC addresses can be printed directly using %pMR specifier.=0A=
> =0A=
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0A=
> ---=0A=
>   drivers/hid/hid-sony.c | 10 ++--------=0A=
>   1 file changed, 2 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c=0A=
> index b9dc3ac4d4aa..138fd44d3c91 100644=0A=
> --- a/drivers/hid/hid-sony.c=0A=
> +++ b/drivers/hid/hid-sony.c=0A=
> @@ -2399,10 +2399,7 @@ static int sony_check_add(struct sony_sc *sc)=0A=
>   		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));=0A=
>   =0A=
>   		snprintf(sc->hdev->uniq, sizeof(sc->hdev->uniq),=0A=
> -			"%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",=0A=
> -			sc->mac_address[5], sc->mac_address[4],=0A=
> -			sc->mac_address[3], sc->mac_address[2],=0A=
> -			sc->mac_address[1], sc->mac_address[0]);=0A=
> +			 "%pMR", sc->mac_address);=0A=
>   	} else if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||=0A=
>   			(sc->quirks & NAVIGATION_CONTROLLER_USB)) {=0A=
>   		buf =3D kmalloc(SIXAXIS_REPORT_0xF2_SIZE, GFP_KERNEL);=0A=
> @@ -2432,10 +2429,7 @@ static int sony_check_add(struct sony_sc *sc)=0A=
>   			sc->mac_address[5-n] =3D buf[4+n];=0A=
>   =0A=
>   		snprintf(sc->hdev->uniq, sizeof(sc->hdev->uniq),=0A=
> -			"%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",=0A=
> -			sc->mac_address[5], sc->mac_address[4],=0A=
> -			sc->mac_address[3], sc->mac_address[2],=0A=
> -			sc->mac_address[1], sc->mac_address[0]);=0A=
> +			 "%pMR", sc->mac_address);=0A=
>   	} else {=0A=
>   		return 0;=0A=
>   	}=0A=
> =0A=
=0A=
Looks good and in a quick test seems to function.=0A=
=0A=
Acked-by: Roderick Colenbrander <roderick.colenbranderer@sony.com>=0A=
=0A=
=0A=
