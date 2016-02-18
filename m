From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: corsair: fix mapping of non-keyboard usages
Date: Thu, 18 Feb 2016 09:12:53 +0100
Message-ID: <20160218081253.GL8577@mail.corp.redhat.com>
References: <20160216173824.GA23019@untxi.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33497 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965431AbcBRIM5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2016 03:12:57 -0500
Content-Disposition: inline
In-Reply-To: <20160216173824.GA23019@untxi.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?PT9VVEYtOD9xP0NsPUMzPUE5bWVudD0yMFZ1Y2hlbmVyPz0=?= <clement.vuchener@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Feb 16 2016 or thereabouts, =3D?UTF-8?q?Cl=3DC3=3DA9ment=3D20Vuchene=
r?=3D wrote:
> This fixes a bug where the Volume Up key was ignored because it uses =
the same usage code as G18. Special Corsair usage codes are in the keyb=
oard page, other pages should be left to the generic driver.
>=20
> Signed-off-by: Cl=C3=A9ment Vuchener <clement.vuchener@gmail.com>

Looks good to me.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/hid-corsair.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index 5855196..717704e 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c
> @@ -595,6 +595,9 @@ static int corsair_input_mapping(struct hid_devic=
e *dev,
>  {
>  	int gkey;
> =20
> +	if ((usage->hid & HID_USAGE_PAGE) !=3D HID_UP_KEYBOARD)
> +		return 0;
> +
>  	gkey =3D corsair_usage_to_gkey(usage->hid & HID_USAGE);
>  	if (gkey !=3D 0) {
>  		hid_map_usage_clear(input, usage, bit, max, EV_KEY,
> --=20
> 2.5.0
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
