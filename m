From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/3] HID: Wacom: Use devm_kcalloc() in two functions
Date: Mon, 5 Jun 2017 08:29:57 -0700
Message-ID: <CANRwn3QbNn4EA-FDmz1jnFUgjJ0tH63MCwOGcTCodvFtaBeeAQ@mail.gmail.com>
References: <d126aeeb-f7e0-e54b-b874-61d776fe45cb@users.sourceforge.net> <d0224def-26ba-d33b-e9be-a6218259c8e4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36374 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFEP37 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Jun 2017 11:29:59 -0400
In-Reply-To: <d0224def-26ba-d33b-e9be-a6218259c8e4@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Linux Input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, LKML <linux-kernel@vger.kernel.org>, SF Markus Elfring <elfring@users.sourceforge.net>, kernel-janitors@vger.kernel.org

Going through old mail and noticed that these three patches seem to
have been overlooked (at least, I don't see them in Jiri's
branches...). For the set:

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....



On Tue, Apr 25, 2017 at 8:13 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 25 Apr 2017 16:06:08 +0200
>
> * Multiplications for the size determination of memory allocations
>   indicated that array data structures should be processed.
>   Thus use the corresponding function "devm_kcalloc".
>
>   This issue was detected by using the Coccinelle software.
>
> * Replace the specification of data structures by pointer dereferences
>   to make the corresponding size determination a bit safer according to
>   the Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/hid/wacom_sys.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0022c0dac88a..550faf8819ea 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1245,7 +1245,7 @@ static int wacom_led_groups_alloc_and_register_one(=
struct device *dev,
>         if (!devres_open_group(dev, &wacom->led.groups[group_id], GFP_KER=
NEL))
>                 return -ENOMEM;
>
> -       leds =3D devm_kzalloc(dev, sizeof(struct wacom_led) * count, GFP_=
KERNEL);
> +       leds =3D devm_kcalloc(dev, count, sizeof(*leds), GFP_KERNEL);
>         if (!leds) {
>                 error =3D -ENOMEM;
>                 goto err;
> @@ -1345,8 +1345,7 @@ static int wacom_led_groups_allocate(struct wacom *=
wacom, int count)
>         struct wacom_group_leds *groups;
>         int error;
>
> -       groups =3D devm_kzalloc(dev, sizeof(struct wacom_group_leds) * co=
unt,
> -                             GFP_KERNEL);
> +       groups =3D devm_kcalloc(dev, count, sizeof(*groups), GFP_KERNEL);
>         if (!groups)
>                 return -ENOMEM;
>
> --
> 2.12.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
