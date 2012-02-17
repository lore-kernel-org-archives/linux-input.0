From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] HID: wacom: Force new name for Wacom Intuos4 WL PTK-540WL
Date: Fri, 17 Feb 2012 12:51:02 -0600
Message-ID: <CAGzDe_ZAni9Jtu4RrwmuRSOPFGxFz93JWw_VhzwieT2JJ-K8Hw@mail.gmail.com>
References: <1329500830-16767-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51790 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752390Ab2BQSvD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Feb 2012 13:51:03 -0500
In-Reply-To: <1329500830-16767-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: jkosina@suse.cz, pinglinux@gmail.com, peter.hutterer@who-t.net, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 17, 2012 at 11:47 AM, Przemo Firszt <przemo@firszt.eu> wrot=
e:
> The name reported by Inutos4 WL connected by bluetooth is "PTK-540WL"=
 and
> to make it consistent with other Wacom devices it has to be converted=
 to
> "Wacom Intuos4 WL". It also makes userland applications aware that it=
's
> a Wacom device.
>
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> ---

Its worth noting this aligns naming of device to same used when this
device is plugged into USB port and controlled by USB wacom driver;
and thus helps align userland logic to route to apps like
xf86-input-wacom.

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

> =A0drivers/hid/hid-wacom.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index acab74c..0621047 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -518,6 +518,7 @@ static int wacom_probe(struct hid_device *hdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_poke(hdev, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(hdev->name, "%s", "Wacom Intuos=
4 WL");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wdata->features =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_set_features(hdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> --
> 1.7.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
