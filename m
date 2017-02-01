From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: don't apply generic settings to old devices
Date: Wed, 1 Feb 2017 10:15:22 -0800
Message-ID: <CANRwn3Tm3U3qHbXqrVfkyPkgPeDJsV3FOhWQWg0KvM+QiTpjcg@mail.gmail.com>
References: <1485819649-8057-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36358 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752938AbdBASPX (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Feb 2017 13:15:23 -0500
Received: by mail-vk0-f67.google.com with SMTP id n19so32347649vkd.3
        for <linux-input@vger.kernel.org>; Wed, 01 Feb 2017 10:15:23 -0800 (PST)
In-Reply-To: <1485819649-8057-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

Looks good to me!

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


On Mon, Jan 30, 2017 at 3:40 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Non-generic devices have numbered_buttons set for both pen and
> touch interfaces by default. The actual number of buttons on the
> interface is normally manually decided later, which is different
> from what those HID generic devices are processed, where number
> of buttons are directly retrieved from HID descriptors.
>
> This patch adds the missed HID_GENERIC check and moves the statement
> to wacom_setup_pad_input_capabilities since it's not a quirk anymore.
>
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
> ---
>  drivers/hid/wacom_wac.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 0884dc9..6477fcd 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2777,8 +2777,6 @@ void wacom_setup_device_quirks(struct wacom *wacom)
>         struct wacom_features *features =3D &wacom->wacom_wac.features;
>
>         /* The pen and pad share the same interface on most devices */
> -       if (features->numbered_buttons > 0)
> -               features->device_type |=3D WACOM_DEVICETYPE_PAD;
>         if (features->type =3D=3D GRAPHIRE_BT || features->type =3D=3D WA=
COM_G4 ||
>             features->type =3D=3D DTUS ||
>             (features->type >=3D INTUOS3S && features->type <=3D WACOM_MO=
)) {
> @@ -3288,6 +3286,9 @@ int wacom_setup_pad_input_capabilities(struct input=
_dev *input_dev,
>  {
>         struct wacom_features *features =3D &wacom_wac->features;
>
> +       if ((features->type =3D=3D HID_GENERIC) && features->numbered_but=
tons > 0)
> +               features->device_type |=3D WACOM_DEVICETYPE_PAD;
> +
>         if (!(features->device_type & WACOM_DEVICETYPE_PAD))
>                 return -ENODEV;
>
> --
> 2.7.4
>
