From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v3] serio: add support for PS2Mult multiplexer protocol
Date: Fri, 8 Oct 2010 12:50:34 +0400
Message-ID: <AANLkTinBLr6ETMxBzDCZog9qLPRwUsutS=QaKDQC-sA7@mail.gmail.com>
References: <1285260285-660-1-git-send-email-dbaryshkov@gmail.com>
	<AANLkTimt+RZGp0C-X44JMR_4GJgFMfzN6b1V42A7NAnY@mail.gmail.com>
	<20100930062547.GF5260@core.coreip.homeip.net>
	<AANLkTimZxi8V9SLFQ8N-oSDTSt+7PjLNPt=H=Ja2mpr9@mail.gmail.com>
	<20101007163606.GA24406@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44828 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab0JHIue convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Oct 2010 04:50:34 -0400
Received: by qyk1 with SMTP id 1so58764qyk.19
        for <linux-input@vger.kernel.org>; Fri, 08 Oct 2010 01:50:34 -0700 (PDT)
In-Reply-To: <20101007163606.GA24406@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello,

On Thu, Oct 7, 2010 at 8:36 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Oct 07, 2010 at 07:19:57PM +0400, Dmitry Eremin-Solenikov wro=
te:
>> Hello,
>>
>> On Thu, Sep 30, 2010 at 10:25 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Wed, Sep 29, 2010 at 04:45:53PM +0400, Dmitry Eremin-Solenikov =
wrote:
>> >> On Thu, Sep 23, 2010 at 8:44 PM, Dmitry Eremin-Solenikov
>> >> <dbaryshkov@gmail.com> wrote:
>> >> > PS2Mult is a simple serial protocol used for multiplexing sever=
al PS/2 streams
>> >> > into one serial data stream. It's used e.g. on TQM85xx serie of=
 boards.
>> >> >
>> >> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> >> > ---
>> >> >
>> >> > It actually depends on "serio: multiple children" patch. I'm no=
t resending it
>> >> > as you were the originator of the latest version of the patch.
>> >>
>> >> So, what about this version of patch?
>> >>
>> >
>> > Looks better but I think you also need ->start() to make sure you =
do not
>> > try to deliver events too early. Does the following still work for=
 you?
>>
>> Sorry for the delay. Crashes w/o the attached patch.
>>
>
> Ah, I see, however what I actually wanted is to create ports before h=
and
> and handle any errors that might arise and then enable the device and
> register child ports.
>
> If you apply the patch below instead of yours does it still work?

It won't work, as we don't set psm->ports[i].serio before ps2mult_serio=
_start()

>
> Thanks.
>
> --
> Dmitry
>
> Input: ps2mult - don't register ports twice
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> =A0drivers/input/serio/ps2mult.c | =A0 11 ++++++-----
> =A01 files changed, 6 insertions(+), 5 deletions(-)
>
>
> diff --git a/drivers/input/serio/ps2mult.c b/drivers/input/serio/ps2m=
ult.c
> index 3664398..52b58de 100644
> --- a/drivers/input/serio/ps2mult.c
> +++ b/drivers/input/serio/ps2mult.c
> @@ -144,9 +144,6 @@ static int ps2mult_create_port(struct ps2mult *ps=
m, int i)
> =A0 =A0 =A0 =A0serio->parent =3D psm->mx_serio;
> =A0 =A0 =A0 =A0serio->port_data =3D &psm->ports[i];
>
> - =A0 =A0 =A0 serio_register_port(serio);
> - =A0 =A0 =A0 dev_info(&serio->dev, "%s port at %s\n", serio->name, m=
x_serio->phys);
> -
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -196,8 +193,12 @@ static int ps2mult_connect(struct serio *serio, =
struct serio_driver *drv)
>
> =A0 =A0 =A0 =A0ps2mult_reset(psm);
>
> - =A0 =A0 =A0 for (i =3D 0; i < =A0PS2MULT_NUM_PORTS; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 serio_register_port(psm->ports[i].serio=
);
> + =A0 =A0 =A0 for (i =3D 0; i < =A0PS2MULT_NUM_PORTS; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct serio *s =3D psm->ports[i].serio=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&serio->dev, "%s port at %s\n"=
, s->name, serio->phys);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serio_register_port(s);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return 0;
>
>



--=20
With best wishes
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
