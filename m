From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: input: Fix TransducerSerialNumber implementation
Date: Tue, 28 Oct 2014 11:31:29 -0700
Message-ID: <CANRwn3QbH-Jt4L7W-qOikX_JaeKs-vu_5XeK8TgzowyXLh_=qg@mail.gmail.com>
References: <6B3C86448604A642A31AAD3F8C07EA7724F0B8CD@Exchange1.wacom.com>
	<1411495768-5956-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:59132 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaJ1Sbb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2014 14:31:31 -0400
Received: by mail-la0-f45.google.com with SMTP id gm9so1194600lab.18
        for <linux-input@vger.kernel.org>; Tue, 28 Oct 2014 11:31:29 -0700 (PDT)
In-Reply-To: <1411495768-5956-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jkosina@suse.cz" <jkosina@suse.cz>, "pinglinux@gmail.com" <pinglinux@gmail.com>
Cc: Jason Gerecke <jason.gerecke@wacom.com>

On Tue, Sep 23, 2014 at 11:09 AM, Jason Gerecke <killertofu@gmail.com> =
wrote:
> The commit which introduced TransducerSerialNumber (368c966) is missi=
ng
> two crucial implementation details. Firstly, the commit does not set =
the
> type/code/bit/max fields as expected later down the code which can ca=
use
> the driver to crash when a tablet with this usage is connected. Secon=
dly,
> the call to 'set_bit' causes MSC_PULSELED to be sent instead of the
> expected MSC_SERIAL. This commit addreses both issues.
>
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
>  drivers/hid/hid-input.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 2619f7f..cb1b3fa 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -689,7 +689,10 @@ static void hidinput_configure_usage(struct hid_=
input *hidinput, struct hid_fiel
>                         break;
>
>                 case 0x5b: /* TransducerSerialNumber */
> -                       set_bit(MSC_SERIAL, input->mscbit);
> +                       usage->type =3D EV_MSC;
> +                       usage->code =3D MSC_SERIAL;
> +                       bit =3D input->mscbit;
> +                       max =3D MSC_MAX;
>                         break;
>
>                 default:  goto unknown;
> --
> 2.1.0
>

This patch still seems to be in limbo. Anyone (Ping? Benjamin?) care
to provide an ACK or review?

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
