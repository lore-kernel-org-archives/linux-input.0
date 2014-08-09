From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: wacom - Fix compiler warning if !CONFIG_PM
Date: Sat, 9 Aug 2014 22:39:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1408092238290.15220@pobox.suse.cz>
References: <1407604023-7429-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44829 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbaHIUju (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 9 Aug 2014 16:39:50 -0400
In-Reply-To: <1407604023-7429-1-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Sat, 9 Aug 2014, Geert Uytterhoeven wrote:

> If CONFIG_PM is not set:
>=20
> drivers/hid/wacom_sys.c:1436: warning: =E2=80=98wacom_reset_resume=E2=
=80=99 defined but
> not used
>=20
> Protect the unused functions by #ifdef CONFIG_PM to fix this.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks Geert.

hid-wacom is in a sort of temporary mode of operation, being moved from=
=20
Input to HID driver.

Adding Benjamin and Dmitry to CC, as this will likely still go through=20
Dmitry's queue.

> ---
>  drivers/hid/wacom_sys.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 3e388ec31da8..f0db7eca9023 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1416,6 +1416,7 @@ static void wacom_remove(struct hid_device *hde=
v)
>  	kfree(wacom);
>  }
> =20
> +#ifdef CONFIG_PM
>  static int wacom_resume(struct hid_device *hdev)
>  {
>  	struct wacom *wacom =3D hid_get_drvdata(hdev);
> @@ -1436,6 +1437,7 @@ static int wacom_reset_resume(struct hid_device=
 *hdev)
>  {
>  	return wacom_resume(hdev);
>  }
> +#endif /* CONFIG_PM */
> =20
>  static struct hid_driver wacom_driver =3D {
>  	.name =3D		"wacom",
> --=20
> 1.9.1
>=20

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
