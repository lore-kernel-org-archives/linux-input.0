From: =?UTF-8?B?Q2h1bmctWWloIFdhbmcgKOeOi+W0h+aHvyk=?=
	<cywang@google.com>
Subject: Re: [PATCH] Input: psmouse - retry getid command in psmouse_probe()
Date: Mon, 18 Feb 2013 16:21:34 +0800
Message-ID: <CAM2ehZYL+JwLu-1f3aR-2SDoyfLhv7Grw14PWzUWLLQLtxfwzw@mail.gmail.com>
References: <1351678279-32615-1-git-send-email-cywang@chromium.org> <CAM2ehZbMyNP_AhP-9TmCC5-bw9mqd7yunTy3NETEqRX1bX5oYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:34317 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab3BRIVz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Feb 2013 03:21:55 -0500
Received: by mail-ee0-f44.google.com with SMTP id l10so2761682eei.31
        for <linux-input@vger.kernel.org>; Mon, 18 Feb 2013 00:21:54 -0800 (PST)
In-Reply-To: <CAM2ehZbMyNP_AhP-9TmCC5-bw9mqd7yunTy3NETEqRX1bX5oYg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Andrew de los Reyes <adlr@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tai-hwa Liang <avatar@sentelic.com>, Rusty Russell <rusty@rustcorp.com.au>, Paul Fox <pgf@laptop.org>, Chung-yih Wang <cywang@chromium.org>, linux-kernel@vger.kernel.org

Hi Dmitry and other maintainers,

  Not sure if you have any comment on the patch? As this patch tries
to help some platforms (especially for lenovo's machines) to rescan
the touchpad device after resuming from suspend if the first probe
fails.

Thanks,
Chung-yih

On Mon, Feb 18, 2013 at 4:17 PM, Chung-Yih Wang (=E7=8E=8B=E5=B4=87=E6=87=
=BF)
<cywang@chromium.org> wrote:
> Hi Dmitry and other maintainers,
>
>   Not sure if you have any comment on the patch? As this patch tries =
to help
> some platforms (especially for lenovo's machines) to rescan the touch=
pad
> device after resuming from suspend if the first probe fails.
>
> Thanks,
> Chung-yih
>
>
> On Wed, Oct 31, 2012 at 6:11 PM, Chung-yih Wang <cywang@chromium.org>=
 wrote:
>>
>> As the synaptics device may not respond to the first command in
>> psmouse_probe
>> when a machine is booting up, the patch gives a second probe if the =
first
>> one fails.
>>
>> Signed-off-by: Chung-yih Wang <cywang@chromium.org>
>> ---
>>  drivers/input/mouse/psmouse-base.c |   13 +++++++++++--
>>  1 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/mouse/psmouse-base.c
>> b/drivers/input/mouse/psmouse-base.c
>> index 22fe254..c4fc5ad 100644
>> --- a/drivers/input/mouse/psmouse-base.c
>> +++ b/drivers/input/mouse/psmouse-base.c
>> @@ -1053,8 +1053,17 @@ static int psmouse_probe(struct psmouse *psmo=
use)
>>   */
>>
>>         param[0] =3D 0xa5;
>> -       if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
>> -               return -1;
>> +       if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID)) {
>> +               /*
>> +                * Reprobe the device if it did not respond to the G=
ETID
>> +                * command. Before retry, additional dummy command i=
s sent
>> +                * to clear the 'RESEND' response if exists.
>> +                */
>> +               psmouse_warn(psmouse, "GETID probe failed,
>> retrying...\n");
>> +               ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSCALE11);
>> +               if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
>> +                       return -1;
>> +       }
>>
>>         if (param[0] !=3D 0x00 && param[0] !=3D 0x03 &&
>>             param[0] !=3D 0x04 && param[0] !=3D 0xff)
>> --
>> 1.7.7.3
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
