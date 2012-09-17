From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH] HID: picolcd_core: Remove setting hdev->claimed before
 calling hid_hw_start()
Date: Mon, 17 Sep 2012 18:34:36 +0200
Message-ID: <20120917183436.780d6261@neptune.home>
References: <1347574536.8974.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:46358 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab2IQQfc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 12:35:32 -0400
In-Reply-To: <1347574536.8974.8.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Fri, 14 September 2012 Axel Lin <axel.lin@gmail.com> wrote:
> Current implementation of hid_hw_start() allows connect_mask to be 0.
> Setting hdev->claimed =3D HID_CLAIMED_INPUT before calling hid_hw_sta=
rt() is not
> necessary. Remove it.
>=20
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-By: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

This same change was applied to 3.6 but got lost while applying my
patches on 3.6rc.

I will what else (of 3.5 -> 3.6 changes) might have been lost while app=
lying
driver code split.

Thanks for spotting.

Bruno


> ---
>  drivers/hid/hid-picolcd_core.c |    4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd=
_core.c
> index 8c9ec1f..e30e703 100644
> --- a/drivers/hid/hid-picolcd_core.c
> +++ b/drivers/hid/hid-picolcd_core.c
> @@ -583,11 +583,7 @@ static int picolcd_probe(struct hid_device *hdev=
,
>  		goto err_cleanup_data;
>  	}
> =20
> -	/* We don't use hidinput but hid_hw_start() fails if nothing is
> -	 * claimed. So spoof claimed input. */
> -	hdev->claimed =3D HID_CLAIMED_INPUT;
>  	error =3D hid_hw_start(hdev, 0);
> -	hdev->claimed =3D 0;
>  	if (error) {
>  		hid_err(hdev, "hardware start failed\n");
>  		goto err_cleanup_data;
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
