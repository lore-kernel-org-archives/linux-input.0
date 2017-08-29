From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: leds: Don't try to control the EKR's
 read-only LEDs
Date: Tue, 29 Aug 2017 09:24:21 -0700
Message-ID: <CANRwn3T1R2cdirpjju3bHeR0uiEzTgL2DnGdEsr1PrC=dKnivA@mail.gmail.com>
References: <1503954939-23470-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:32943 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbdH2QYW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Aug 2017 12:24:22 -0400
In-Reply-To: <1503954939-23470-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "stable # 4 . 9" <stable@vger.kernel.org>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>

On Mon, Aug 28, 2017 at 2:15 PM, Aaron Armstrong Skomra
<skomra@gmail.com> wrote:
>
> Commit a50aac7193f1 introduces 'led.groups' and adds EKR support
> for these groups. However, unlike the other devices with LEDs,
> the EKR's LEDs are read-only and we shouldn't attempt to control
> them in wacom_led_control().
>
> See bug: https://sourceforge.net/p/linuxwacom/bugs/342/
>
> Fixes: a50aac7193f1 ("HID: wacom: leds: dynamically allocate LED groups")
> Cc: stable <stable@vger.kernel.org>     # 4.9
> Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Looks good to me:
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>
> ---
>  drivers/hid/wacom_sys.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 838c1ebfffa9..db1f64dcb9ba 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -766,6 +766,9 @@ static int wacom_led_control(struct wacom *wacom)
>         if (!wacom->led.groups)
>                 return -ENOTSUPP;
>
> +       if (wacom->wacom_wac.features.type =3D=3D REMOTE)
> +               return -ENOTSUPP;
> +
>         if (wacom->wacom_wac.pid) { /* wireless connected */
>                 report_id =3D WAC_CMD_WL_LED_CONTROL;
>                 buf_size =3D 13;
> --
> 2.7.4
>
